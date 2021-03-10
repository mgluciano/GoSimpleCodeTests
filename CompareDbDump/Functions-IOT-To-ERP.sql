
CREATE FUNCTION beta.pick_get_order_by_sales_4wk_avg(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title character varying, plan_qty integer)
    LANGUAGE plpgsql ROWS 10000
    AS $$
/*
Purpose - return INM order for the next sale period which is the time between the deliveries of this pick and the next pick
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  plan_qty: order quantity for the above fc_title for the next sale period
*/
begin
	return query
		select q.kiosk_id, q.route_date_time, q.sku_group_id, q.fc_title, cast(ceiling(q.plan_qty/a.weeks_with_sales) as integer)
			from inm.pick_get_order_by_sales_4wks_availability(start_ts, end_ts) a
			join inm.pick_get_order_by_sales_4wk(start_ts, end_ts) q
			on a.kiosk_id = q.kiosk_id;
end;
$$;
CREATE FUNCTION pantry.fn_kiosk_status_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  last_kiosk_status_time BIGINT;
  status_is_newer BOOLEAN;
BEGIN
  SELECT time from pantry.last_kiosk_status WHERE kiosk_id = new.kiosk_id
         INTO last_kiosk_status_time;
  status_is_newer =  (last_kiosk_status_time is null) or new.time > last_kiosk_status_time;
  IF status_is_newer
    THEN
      INSERT INTO pantry.last_kiosk_status
        (kiosk_id, kiosk_temperature, kit_temperature, power, battery_level, rfid_0, rfid_1, rfid_2, rfid_3, rfid_4,
         rfid_5, rfid_6, rfid_7, time, modem_signal_percentage, modem_signal_type, ip, temperature_tags,
         kiosk_temperature_source, kiosk_temperature_count, app_uptime, system_uptime, is_locked,
         num_payment_messages_pending_sync)
        VALUES (NEW.kiosk_id, NEW.kiosk_temperature, NEW.kit_temperature, NEW.power, NEW.battery_level, NEW.rfid_0,
                NEW.rfid_1, NEW.rfid_2, NEW.rfid_3, NEW.rfid_4, NEW.rfid_5, NEW.rfid_6, NEW.rfid_7, NEW.time,
                NEW.modem_signal_percentage, NEW.modem_signal_type, NEW.ip, NEW.temperature_tags,
                NEW.kiosk_temperature_source, NEW.kiosk_temperature_count, NEW.app_uptime, NEW.system_uptime,
                NEW.is_locked, NEW.num_payment_messages_pending_sync)
        ON conflict (kiosk_id) DO
        UPDATE
        SET
          kiosk_id = excluded.kiosk_id,
          kiosk_temperature = excluded.kiosk_temperature,
          kit_temperature = excluded.kit_temperature,
          power = excluded.power,
          battery_level = excluded.battery_level,
          rfid_0 = excluded.rfid_0,
          rfid_1 = excluded.rfid_1,
          rfid_2 = excluded.rfid_2,
          rfid_3 = excluded.rfid_3,
          rfid_4 = excluded.rfid_4,
          rfid_5 = excluded.rfid_5,
          rfid_6 = excluded.rfid_6,
          rfid_7 = excluded.rfid_7,
          time = excluded.time,
          modem_signal_percentage = excluded.modem_signal_percentage,
          modem_signal_type = excluded.modem_signal_type,
          ip = excluded.ip,
          temperature_tags = excluded.temperature_tags,
          kiosk_temperature_source = excluded.kiosk_temperature_source,
          kiosk_temperature_count = excluded.kiosk_temperature_count,
          app_uptime = excluded.app_uptime,
          system_uptime = excluded.system_uptime,
          is_locked = excluded.is_locked,
          num_payment_messages_pending_sync = excluded.num_payment_messages_pending_sync;
  END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION public.checkpoint(receiving_start timestamp without time zone, receiving_stop timestamp without time zone, location_id bigint) RETURNS TABLE(product_source character varying, vendor character varying, sku bigint, product_name character varying, item_count bigint, receiving_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN query 
    	SELECT o.source,
			o.vendor,
			l.product_id,
			o.title,
    		count(l.epc),
    		to_timestamp(max(l.time_updated)) at TIME zone 'US/Pacific'
		FROM pantry.label l
		JOIN pantry.product o ON l.product_id = o.id
		WHERE to_timestamp(l.time_updated) at TIME zone 'US/Pacific' between receiving_start AND receiving_stop
    		AND kiosk_id = location_id
		GROUP BY o.source, o.vendor, l.product_id, o.title;
END; $$;
ALTER FUNCTION public.checkpoint(receiving_start timestamp without time zone, receiving_stop timestamp without time zone, location_id bigint) OWNER TO dbservice;
CREATE FUNCTION public.date_round(base_date timestamp with time zone, round_interval interval) RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT TO_TIMESTAMP((EXTRACT(epoch FROM $1)::INTEGER + EXTRACT(epoch FROM $2)::INTEGER / 2)
                     / EXTRACT(epoch FROM $2)::INTEGER * EXTRACT(epoch FROM $2)::INTEGER)
$_$;
ALTER FUNCTION public.date_round(base_date timestamp with time zone, round_interval interval) OWNER TO dbservice;
CREATE FUNCTION public.div(numeric, numeric) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT CASE WHEN ($2::float > 0.0) THEN ($1::float / $2::float) ELSE (0.0::float) END
$_$;
ALTER FUNCTION public.div(numeric, numeric) OWNER TO dbservice;
CREATE FUNCTION public.dowhour(timestamp with time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$
 SELECT ((1+extract(DOW FROM $1))*100 + extract(hour from $1))::int
$_$;
ALTER FUNCTION public.dowhour(timestamp with time zone) OWNER TO dbservice;
CREATE FUNCTION public.epoch_round(bigint, round_interval interval) RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT TO_TIMESTAMP((EXTRACT(epoch FROM to_timestamp($1))::INTEGER + EXTRACT(epoch FROM $2)::INTEGER / 2)
                / EXTRACT(epoch FROM $2)::INTEGER * EXTRACT(epoch FROM $2)::INTEGER)
$_$;
ALTER FUNCTION public.epoch_round(bigint, round_interval interval) OWNER TO dbservice;
CREATE FUNCTION public.f_nr_stockout_minutes(ts timestamp with time zone, kiosk_restock_ts timestamp with time zone, hour_start timestamp with time zone, hour_end timestamp with time zone) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
case when kiosk_restock_ts is not null
    and (
      ts between hour_start and hour_end
      or kiosk_restock_ts between hour_start and hour_end
      or (
        hour_start > ts
        and hour_end < kiosk_restock_ts
      )
    )
  then 
    return ((3600.0 -
    (extract(epoch from greatest(hour_start, ts)) - extract(epoch from hour_start)) -
    (extract(epoch from hour_end) - extract(epoch from least(hour_end, kiosk_restock_ts))))) / 60.0;
  when kiosk_restock_ts is null and date_trunc('hour', ts) <= hour_start
  then
    return (3600.0 - (extract(epoch from greatest(hour_start, ts)) - extract(epoch from hour_start))) / 60.0;
  else
    return 0.0;
  end case;
end
$$;
CREATE FUNCTION rptg.non_byte_losses(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_updated timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/*
The following query is used to get non byte kiosks losses.SEE ENG-1272. Unlike byte looses that
is = free kiosk losses, non byte kiosks losses = all non byte kiosks losses.
*/
SELECT epc_ as epc,
    kiosk_id_ as kiosk_id,
    product_id_ as product_id,
    time_updated_ as time_updated,
    cost_ as cost,
    price_ as price
    FROM rptg.losses(beginning_date, ending_date) gl
    WHERE kiosk_campus_id_ != 87
    AND product_campus_id_ != 87;
 END;
$$;
CREATE FUNCTION beta.pick_get_delivery_schedule_optimo(target_date date) RETURNS TABLE(driver_name character varying, route_date_time timestamp with time zone, kiosk_id integer, kiosk_title character varying, address character varying, delivery_order integer)
    LANGUAGE plpgsql
    AS $$
	declare latest_import_ts timestamp;
	declare plan_window_start timestamp;
	declare plan_window_stop timestamp;
/*
Purpose: return INM delivery schedule for a pick window.
Input
	target_date: pick_date
Return
	Data to generate the drivers sheets
*/
begin
	select max(import_ts) from mixalot.inm_data into latest_import_ts;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Start'
		into plan_window_start;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Stop'
		into plan_window_stop;
	return query
		select rs.driver_name, rs.route_date_time, location_number kiosk_id, k.title kiosk_title, k.address, rs.stop_number delivery_order
			from mixalot.route_stop rs join pantry.kiosk k on rs.location_number = k.id
			where rs.route_date_time between plan_window_start and plan_window_stop;
end;
$$;
CREATE FUNCTION mixalot.backup_pick_allocation(target_pick_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare today_date date;
begin
  delete from mixalot_backup.pick_inventory where pick_date = target_pick_date;
  insert into mixalot_backup.pick_inventory select * from mixalot.pick_inventory
  	where pick_date = target_pick_date;
  delete from mixalot_backup.pick_demand where pick_date = target_pick_date;
  insert into mixalot_backup.pick_demand select * from mixalot.pick_demand
  	where pick_date = target_pick_date;
  delete from mixalot_backup.pick_allocation where pick_date = target_pick_date;
  insert into mixalot_backup.pick_allocation select * from mixalot.pick_allocation
  	where pick_date = target_pick_date;
delete from mixalot_backup.pick_substitution where pick_date = target_pick_date;
  insert into mixalot_backup.pick_substitution select * from mixalot.pick_substitution
	where pick_date = target_pick_date;
delete from mixalot_backup.pick_route where pick_date = target_pick_date;
  insert into mixalot_backup.pick_route select * from mixalot.pick_route
	where pick_date = target_pick_date;
end;
$$;
CREATE FUNCTION mixalot.pick_get_summary(target_date date) RETURNS TABLE(property text, name text, value text)
    LANGUAGE plpgsql
    AS $$
declare pick_tickets_generated integer;
declare ticket integer ARRAY;
declare demand integer ARRAY;
declare allocation integer ARRAY;
declare property text;
declare name text;
declare value text;
declare total integer;
declare result_row record;
declare kiosks_added text;
declare kiosks_removed text;
begin
	FOR i IN 0..2 LOOP
 		select count(*) from inm.pick_route where pick_date = target_date - 7*i  into total;
		ticket[i+1] = total; -- convert to one-based index
		select sum(qty) from inm.pick_demand where pick_date = target_date - 7*i into total;
		demand[i+1] = total;
		select sum(qty) from inm.pick_allocation where pick_date = target_date - 7*i into total;
		allocation[i+1] = total;
   	END LOOP;
	select array_to_string(array_agg(cast (kiosk_id as varchar) order by kiosk_id), ',') from inm.pick_route 
		where pick_date = target_date and kiosk_id not in
			(select kiosk_id from inm.pick_route where pick_date = target_date - 7)
	into kiosks_added;
	select array_to_string(array_agg(cast (kiosk_id as varchar) order by kiosk_id), ',') from inm.pick_route 
		where pick_date = target_date - 7  and kiosk_id not in
			(select kiosk_id from inm.pick_route where pick_date = target_date)
	into kiosks_removed;
	property = 'stats';
	name = 'pick tickets today/ -7 days/ -14 days: ';
	value = ticket[1] || '/' || ticket[2] || '/' || ticket[3];
	return query select property, name, value;
	property = 'stats';
	name = 'demand qty today/ -7 days/ -14 days: ';
	value = demand[1] || '/' || demand[2] || '/' || demand[3];
	return query select property, name, value;
	property = 'stats';
	name = 'allocation qty today/ -7 days/ -14 days: ';
	value = allocation[1] || '/' || allocation[2] || '/' || allocation[3];
	return query select property, name, value;
	property = 'stats';
	name = 'kiosks added';
	value = kiosks_added;
	return query select property, name, value;
	property = 'stats';
	name = 'kiosks removed';
	value = kiosks_removed;
	return query select property, name, value;
	property = 'stats';
	name = 'allocation summary';
	value = 'allocation: ' || allocation[1] || ', demand: ' || demand[1] || ', allocation percentage: ' ||  cast(100*demand[1]/allocation[1] as integer);
	return query select property, name, value;
end
$$;
CREATE FUNCTION pantry.fn_audit_global_attribute_def() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
   IF (TG_OP = 'INSERT') THEN
       INSERT INTO pantry.history_global_attribute_def(key,value,time_modified,action)
       VALUES(NEW.key,NEW.default_value, now(),'INSERT');
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       INSERT INTO pantry.history_global_attribute_def(key,value,time_modified,action)
       VALUES(NEW.key,NEW.default_value,now(),'UPDATE');
       RETURN NEW;
   ELSEIF (TG_OP = 'DELETE') THEN
       INSERT INTO pantry.history_global_attribute_def(key,value,time_modified,action)
       VALUES(OLD.key,OLD.default_value,now(),'DELETE');
       RETURN OLD;
   END IF;
   RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$$;
CREATE FUNCTION rptg.byte_sales(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, order_id character varying, kiosk_id bigint, product_id bigint, time_bought timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/*
The following query is used to get all non free kiosks and free kiosks sales. SEE
ENG-708. Byte kiosks sales = non free kiosks sale + free kiosk sales + free kiosk losses.
*/
SELECT epc_ as epc,
    order_id_ as order_id,
    kiosk_id_ as kiosk_id,
    product_id_ as product_id,
    time_bought_ as time_bought,
    cost_ as cost,
    price_ as price
    FROM (SELECT epc_,
        order_id_,
        kiosk_id_,
        product_id_,
        time_bought_,
        cost_,
        price_
        FROM rptg.sales(beginning_date, ending_date)  gs
        JOIN pantry.kiosk k
        ON gs.kiosk_id_ = k.id
        WHERE subsidy_info = '100%'
        AND enable_reporting_ = 1
        AND kiosk_campus_id_ = 87
        AND product_campus_id_ = 87
    UNION ALL
    SELECT epc_,
        NULL as order_id_,
        kiosk_id_,
        product_id_,
        time_updated_ as time_bought_,
        cost_ ,
        price_
        FROM rptg.losses(beginning_date, ending_date)  gl
        JOIN pantry.kiosk k
        ON gl.kiosk_id_ = k.id
        WHERE subsidy_info = '100%'
        AND enable_reporting_ = 1
        AND kiosk_campus_id_ = 87
        AND product_campus_id_ = 87
    UNION ALL
    SELECT epc_,
        order_id_,
        kiosk_id_,
        product_id_,
        time_bought_,
        cost_,
        price_
        FROM rptg.sales(beginning_date, ending_date)  gs
        JOIN pantry.kiosk k
        ON gs.kiosk_id_ = k.id
        WHERE subsidy_info != '100%'
        AND enable_reporting_ = 1
        AND kiosk_campus_id_ = 87
        AND product_campus_id_ = 87
    ) as all_kiosk_sale;
END;
$$;
CREATE FUNCTION pantry.fn_product_stats_by_kiosk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        IF NEW.timestamp IS NULL THEN				
                NEW.timestamp = EXTRACT(epoch FROM NOW());
        END IF;
RETURN NEW;		
END;
$$;
CREATE FUNCTION public.monthly_infographic_data(yyyy_mm text) RETURNS TABLE(record_type text, customer_or_kiosk text, kiosks text, transactions bigint, unique_users bigint, vendors_supported bigint, salads_eaten bigint)
    LANGUAGE sql STABLE
    AS $$
SELECT * FROM (
   SELECT 'customer' as record_type,
          client_name AS customer_or_kiosk,
          string_agg(distinct(kiosk_title), '; ') AS kiosks,
          count(distinct(order_id)) AS transactions,
   	  count(distinct(card_hash)) AS unique_users,
	  count(distinct(product_vendor)) AS vendors_supported,
	  sum(if(product_title ilike '%salad%',1,0)) AS salads_eaten
     FROM byte_epcssold
    WHERE ts BETWEEN cast(yyyy_mm AS timestamp) and cast(yyyy_mm AS timestamp) + interval '1' month
 GROUP BY customer_or_kiosk
UNION ALL
   SELECT 'kiosk' as record_type,
          kiosk_title||' (KID '||kiosk_id||')' AS customer_or_kiosk,
          string_agg(distinct(kiosk_title), '; ') AS kiosks,
          count(distinct(order_id)) AS transactions,
   	  count(distinct(card_hash)) AS unique_users,
	  count(distinct(product_vendor)) AS vendors_supported,
	  sum(if(product_title ilike '%salad%',1,0)) AS salads_eaten
     FROM byte_epcssold
    WHERE ts BETWEEN cast(yyyy_mm AS timestamp) and cast(yyyy_mm AS timestamp) + interval '1' month
 GROUP BY customer_or_kiosk
) t ORDER BY record_type, customer_or_kiosk;
$$;
CREATE FUNCTION beta.compare_pick_vs_delivery_by_sku(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(route_date date, driver_name character varying, restocker text, product_id integer, pick_qty integer, restock_qty integer, discrepancy integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity above product_id restocked between target_date and the following delivery date_time for the kiosk
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	set timezone to 'US/Pacific';
	return query
		select allocation.route_date, allocation.driver_name, restock.restocker, allocation.sku_id, cast(sum(allocation.total) as integer), 
			cast(sum(restock.total) as integer), cast(sum(allocation.total) - sum(restock.total) as integer)
			from (select a.route_date, route.driver_name, a.sku_id, sum(a.qty) total
				  from inm.pick_allocation a 
					left join inm.pick_route route
					on a.route_date = route.route_date and a.kiosk_id = route.kiosk_id
				  	group by 1,2,3) allocation
			left join 
				(select to_timestamp(l.time_created)::date restock_date, r.restocker, l.product_id, count(*) total
					from pantry.label l
				 	left join 
					(select distinct to_timestamp(created)::date route_date, o.kiosk_id, first_name || ' ' || last_name restocker from pantry.order o
						where order_id like 'RE%' and to_timestamp(created)::date between start_date and end_date + 1 order by 1,2) r
				 	on to_timestamp(l.time_created)::date = r.route_date and l.kiosk_id = r.kiosk_id
				 	group by 1,2,3) restock
					on restock.restock_date = allocation.route_date and restock.product_id = allocation.sku_id and restock.restocker = allocation.driver_name
			where allocation.route_date between start_date and end_date
		group by 1, 2, 3,4;
end;
$$;
CREATE FUNCTION beta.compare_pick_vs_delivery_v3(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, restocker text, product_id integer, pick_qty integer, restock_qty integer, discrepancy integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity of above product_id for the same route_date
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	set timezone to 'US/Pacific';
	return query
		select a.kiosk_id, a.route_date, r.restocker, a.sku_id, cast(sum(a.qty) as integer), 
			coalesce(cast(sum(l.total) as integer), 0), cast(coalesce(sum(l.total), 0) - sum(a.qty) as integer)
			from inm.pick_allocation a 
			left join 
				(select to_timestamp(time_created)::date restock_date, pantry.label.kiosk_id, pantry.label.product_id, count(*) total
					from pantry.label group by 1,2,3) l
					on a.route_date = l.restock_date and a.kiosk_id=l.kiosk_id and a.sku_id = l.product_id
			left join 
					(select distinct to_timestamp(created)::date route_date, o.kiosk_id, first_name || ' ' || last_name restocker from pantry.order o
						where order_id like 'RE%' and to_timestamp(created)::date between start_date and end_date + 1 order by 1,2) r
					on r.route_date = a.route_date and r.kiosk_id = a.kiosk_id
			where a.route_date between start_date and end_date
		group by 1, 2, 3, 4;
end;
$$;
CREATE FUNCTION inm.get_all_pull_list(given_kiosk_id integer) RETURNS TABLE(category character varying, kiosk_id_ bigint, kiosk_title_ character varying, product_id_ bigint, product_tile_ character varying, epc character varying)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT *
    FROM inm.get_spoilage_pull_list(given_kiosk_id)
 UNION ALL
 SELECT *
    FROM inm.get_performance_pull_list(given_kiosk_id);
        END;
$$;
CREATE FUNCTION inm_backup.pick_get_delivery_schedule(target_date date) RETURNS TABLE(driver_name character varying, route_date_time timestamp with time zone, kiosk_id integer, kiosk_title character varying, address character varying, delivery_order integer)
    LANGUAGE plpgsql
    AS $$
	declare latest_import_ts timestamp;
	declare plan_window_start timestamp;
	declare plan_window_stop timestamp;
/*
Purpose: return INM delivery schedule for a pick window.
Input
	target_date: pick_date
Return
	Data to generate the drivers sheets
*/
begin
	return query
		select * from inm.pick_get_delivery_schedule_optimo(target_date);
end;
$$;
CREATE FUNCTION pantry.fn_order_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN 
   PERFORM pantry.fn_ro_order_set_order(NEW.order_id);		
  RETURN NEW; 
END; 
$$;
CREATE FUNCTION beta.sku_pick_order(target_ts timestamp with time zone) RETURNS TABLE(sku_id integer, pick_order integer)
    LANGUAGE plpgsql
    AS $$
declare latest_import_ts timestamp with time zone;
/*
Purpose: return a sku pick_order for the most recent import data for a given date
*/
begin
	select max(import_ts) from mixalot.inm_data
		where import_ts <= target_ts and data_type = 'Warehouse SKU Inventory'
		into latest_import_ts;
	return query
		select distinct product_id, d.sort_order
		  from mixalot.inm_data d
		  where import_ts = latest_import_ts and data_type = 'Warehouse SKU Inventory'
	  	and qty > 0;	
end;
$$;
CREATE FUNCTION fnrenames.fn_kiosk_audit_log_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO pantry.kiosk_audit_log (
    kiosk_id, archived, enable_reporting, enable_monitoring
) VALUES (
    NEW.id, NEW.archived, NEW.enable_reporting, NEW.enable_monitoring
);
RETURN NEW;
END;
$$;
CREATE FUNCTION mixalot.pick_get_gsheets_plan_demand(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, fc_title text, week_qty integer, plan_qty integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM plan demand from gsheets for a pick window.
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_qty: demand based on once a week delivery
  plan_qty: demand based on time to next delivery
*/
declare latest_import_ts_for_pick_window timestamp with time zone;
begin	
	select max(import_ts) from mixalot.inm_data
		where import_ts >= start_ts::date
		into latest_import_ts_for_pick_window;
	return query
		select pk.kiosk_id, pk.route_date_time, inm.fc_title, inm.qty, 
			cast(ceiling(1.4 * inm.qty * days_to_next_delivery/7) as integer)
			  from mixalot.pick_get_plan_kiosks(start_ts, end_ts) pk
			join mixalot.inm_data inm
			on pk.kiosk_id = inm.kiosk_id
			and inm.data_type = 'Plan Demand'
			and inm.import_ts = latest_import_ts_for_pick_window;
end;
$$;
CREATE FUNCTION mixalot.pick_get_plan_demand(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, plan_qty integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM plan demand for a pick window.
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_qty: demand based on once a week delivery
  plan_qty: demand based on time to next delivery
*/
declare latest_import_ts_for_pick_window timestamp with time zone;
begin
	select max(import_ts) from mixalot.inm_data i
		where import_ts::date = start_ts::date
		into latest_import_ts_for_pick_window;
	return query
		select pk.kiosk_id, pk.route_date_time, sga.id, inm.fc_title, least(inm.qty, sga.maximum_kiosk_qty) plan_qty
			  from mixalot.plan_kiosk(start_ts, end_ts) pk
			join mixalot.inm_data inm
				on pk.kiosk_id = inm.kiosk_id
					and inm.data_type = 'Plan Demand'					
					and inm.import_ts = latest_import_ts_for_pick_window
			join mixalot.sku_group_attribute sga
				on sga.title = inm.fc_title;		
end;
$$;
CREATE FUNCTION pantry.fn_label_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF OLD.order_id IS NOT NULL THEN
      SELECT pantry.fn_add_to_watch(OLD.id, OLD.order_id);
    END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION pantry.fn_order_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF (NEW.kiosk_id <> OLD.kiosk_id OR NEW.kiosk_title <> OLD.kiosk_title 
    OR NEW.created <> OLD.created OR NEW.state <> OLD.state 
    OR NEW.archived <> OLD.archived 
    OR NEW.amount_list_price IS DISTINCT FROM OLD.amount_list_price) THEN
      PERFORM pantry.fn_ro_order_set_order(NEW.order_id);
    END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION pantry.fn_spoilage_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        IF NEW.timestamp IS NULL THEN				
                NEW.timestamp = EXTRACT(epoch FROM NOW());
        END IF;
RETURN NEW;		
END;
$$;
CREATE FUNCTION inm.pick_get_plan_kiosk_bringg(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, driver_name character varying, location_name character varying, next_delivery_ts timestamp with time zone, time_to_next_delivery interval, days_to_next_delivery double precision, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM plan kiosks for a pick window.
*/
begin
	return query
		select ds.kiosk_id, ds.route_date_time, ds.driver_name, k.title, ps.next_delivery_ts,
		ps.next_delivery_ts - ds.route_date_time as time_to_next_delivery,		
		  case 
		  	when ps.next_delivery_ts - ds.route_date_time between interval '12 hours' and interval '24 hours' then 1
			else extract(day from ps.next_delivery_ts - ds.route_date_time)
			end as days_to_next_delivery,
		  row_number() over (order by ds.route_date_time asc) as delivery_order
		from
		(select t.kiosk_id, t.route_date_time, t.driver_name from
			(select cast(kid as integer) as kiosk_id, rs.route_date_time, rs.driver_name,
				rank() over (partition by kid, rs.route_date_time order by rs.route_date_time) as r
				from bringg.order rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan winddow start
			 	and rs.status <> 7
				) t
				where r = 1) ds
		left join 
		(select t.kiosk_id, t.route_date_time next_delivery_ts from
			(select cast(kid as integer) as kiosk_id, rs.route_date_time,
				rank() over (partition by kid order by rs.route_date_time) as r
				from bringg.order rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan window start
			 	and rs.status <> 7
				) t
				where r = 2) ps
			on ds.kiosk_id = ps.kiosk_id
			join pantry.kiosk k on ds.kiosk_id = k.id
			where ds.route_date_time between plan_window_start and plan_window_stop
			and k.campus_id= 87;	
end;
$$;
CREATE FUNCTION inm_backup.pick_get_plan_kiosk_bringg(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, driver_name character varying, location_name character varying, next_delivery_ts timestamp with time zone, time_to_next_delivery interval, days_to_next_delivery double precision, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM plan kiosks for a pick window.
*/
begin
	return query
		select ds.kiosk_id, ds.route_date_time, ds.driver_name, k.title, ps.next_delivery_ts,
		ps.next_delivery_ts - ds.route_date_time as time_to_next_delivery,		
		  case 
		  	when ps.next_delivery_ts - ds.route_date_time between interval '12 hours' and interval '24 hours' then 1
			else extract(day from ps.next_delivery_ts - ds.route_date_time)
			end as days_to_next_delivery,
		  row_number() over (order by ds.route_date_time asc) as delivery_order
		from
		(select t.kiosk_id, t.route_date_time, t.driver_name from
			(select cast(kid as integer) as kiosk_id, rs.route_date_time, rs.driver_name,
				rank() over (partition by kid, rs.route_date_time order by rs.route_date_time) as r
				from bringg.order rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan winddow start
			 	and rs.status <> 7
				) t
				where r = 1) ds
		left join 
		(select t.kiosk_id, t.route_date_time next_delivery_ts from
			(select cast(kid as integer) as kiosk_id, rs.route_date_time,
				rank() over (partition by kid order by rs.route_date_time) as r
				from bringg.order rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan window start
			 	and rs.status <> 7
				) t
				where r = 2) ps
			on ds.kiosk_id = ps.kiosk_id
			join pantry.kiosk k on ds.kiosk_id = k.id
			where ds.route_date_time between plan_window_start and plan_window_stop
			and k.campus_id= 87;	
end;
$$;
CREATE FUNCTION inm_beta.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sales_ratio numeric)
    LANGUAGE plpgsql ROWS 10000
    AS $$
  /*
  Purpose - return INM the ratio of the next sale period(time between the deliveries of this pick and the next pick) vs sales for the week using 12 week history
  Input -
    start_ts: plan window start date time with time zone
    end_ts: plan window end date time with time zone
  Return -
    kiosk_id: together with route_date_time is unique for the plan window
    route_date_time: route starting date time
    fc_title: sku group name
    plan_qty: order quantity for the above fc_title for the next sale period
  */
begin
  return query
    select scheduled_kiosks.kiosk_id, scheduled_kiosks.route_date_time, coalesce(existing_kiosk_with_sales_ratio.ratio, 1.0/3.0)
    from inm.pick_get_plan_kiosk(start_ts, end_ts) scheduled_kiosks -- all the kiosks on route
           left join -- kiosks with sales history
      (
        select whole_12_weeks.kiosk_id, whole_12_weeks.route_date_time,
               case when whole_12_weeks.qty < 5 then 1.0/3.0 -- new kiosk, assume period sale is 1/3 of total week
                    else cast(period_12_weeks.qty as decimal)/cast(whole_12_weeks.qty as decimal)
                 end ratio
        from
          (select pk.kiosk_id, pk.route_date_time, count(*) qty
           from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
                  join pantry.label l on pk.kiosk_id=l.kiosk_id
           where l.status in ('sold')
             and to_timestamp(l.time_updated) between
               pk.next_delivery_ts - interval '91 days'
             and pk.next_delivery_ts - interval '7 days'
           group by 1, 2
          ) whole_12_weeks
            join
            (
              select pk.kiosk_id, pk.route_date_time, count(*) qty
              from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
                     join pantry.label l on pk.kiosk_id=l.kiosk_id
              where l.status in ('sold') and
                (
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '7 days' + interval '4 hours' and pk.next_delivery_ts - interval '7 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '14 days'  + interval '4 hours' and pk.next_delivery_ts - interval '14 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '21 days'  + interval '4 hours' and pk.next_delivery_ts - interval '21 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '28 days'  + interval '4 hours' and pk.next_delivery_ts - interval '28 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '35 days' + interval '4 hours' and pk.next_delivery_ts - interval '35 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '42 days' + interval '4 hours' and pk.next_delivery_ts - interval '42 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '49 days' + interval '4 hours' and pk.next_delivery_ts - interval '49 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '56 days' + interval '4 hours' and pk.next_delivery_ts - interval '56 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '63 days' + interval '4 hours' and pk.next_delivery_ts - interval '63 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '70 days' + interval '4 hours' and pk.next_delivery_ts - interval '70 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '77 days' + interval '4 hours' and pk.next_delivery_ts - interval '77 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between pk.route_date_time - interval '84 days' + interval '4 hours' and pk.next_delivery_ts - interval '84 days'  + interval '4 hours'
                  )
              group by 1, 2
            ) period_12_weeks
          on whole_12_weeks.kiosk_id = period_12_weeks.kiosk_id
      ) existing_kiosk_with_sales_ratio
                     on scheduled_kiosks.kiosk_id = existing_kiosk_with_sales_ratio.kiosk_id and scheduled_kiosks.route_date_time = existing_kiosk_with_sales_ratio.route_date_time;
end;
$$;
CREATE FUNCTION inm_test.pick_get_plan_demand(allocation_factor numeric, start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, fc_title text, week_qty integer, plan_qty integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM plan demand for a pick window.
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_qty: demand based on once a week delivery
  plan_qty: demand based on time to next delivery
*/
declare latest_import_ts_for_pick_window timestamp with time zone;
begin
	select max(import_ts) from mixalot.inm_data i
		where import_ts::date = start_ts::date and data_type = 'Par Unconstrained wo Min' -- make sure import contain this data_type
		into latest_import_ts_for_pick_window;
	return query
		select pk.kiosk_id, pk.route_date_time, inm.fc_title, inm.qty week_qty,
			least(cast(greatest(ceiling(allocation_factor * inm.qty * coalesce(days_to_next_delivery, 3)/7) + sga.minimum_kiosk_qty - coalesce(inv.count, 0),
								  sga.minimum_kiosk_qty - inv.count, /* ensure minimum quantity */
							   	  0) /* change negative demand to 0 */
					   as integer), sga.maximum_kiosk_qty) plan_qty
			  from mixalot.plan_kiosk(start_ts, end_ts) pk
			join mixalot.inm_data inm
				on pk.kiosk_id = inm.kiosk_id
					and inm.data_type = 'Par Unconstrained wo Min'					
					and inm.import_ts = latest_import_ts_for_pick_window
			join mixalot.sku_group_attribute sga
				on sga.title = inm.fc_title
 			left join mixalot.inm_kiosk_projected_stock inv
 				on inm.kiosk_id = inv.kiosk_id and inm.fc_title = inv.fc_title;
end;
$$;
CREATE FUNCTION public.pickpack(receiving_start timestamp without time zone, receiving_stop timestamp without time zone, location_id bigint) RETURNS TABLE(product_source character varying, vendor character varying, sku bigint, product_name character varying, item_count bigint, receiving_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN query 
    	SELECT o.source,
			o.vendor,
			l.product_id,
			o.title,
    		count(l.epc),
    		to_timestamp(max(l.time_created)) at time zone 'US/Pacific'
		FROM pantry.label l
		JOIN pantry.product o on l.product_id = o.id
		WHERE to_timestamp(l.time_created) at time zone 'US/Pacific' between receiving_start and receiving_stop
    		and kiosk_id = location_id
		GROUP BY o.source, o.vendor, l.product_id, o.title;
END; $$;
ALTER FUNCTION public.pickpack(receiving_start timestamp without time zone, receiving_stop timestamp without time zone, location_id bigint) OWNER TO dbservice;
CREATE FUNCTION public.receiving(receiving_start timestamp without time zone DEFAULT '2017-11-01 00:00:00'::timestamp without time zone, receiving_stop timestamp without time zone DEFAULT '2017-11-01 23:59:59'::timestamp without time zone) RETURNS TABLE(product_source character varying, vendor character varying, sku bigint, product_name character varying, item_count bigint, receiving_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN query 
    	SELECT o.source,
			o.vendor,
			l.product_id,
			o.title,
    		count(l.epc),
    		to_timestamp(max(l.time_created)) at time zone 'US/Pacific'
		FROM pantry.label l
		JOIN pantry.product o on l.product_id = o.id
		WHERE to_timestamp(l.time_created) at time zone 'US/Pacific' between receiving_start and receiving_stop
    		and kiosk_id = 790
		GROUP BY o.source, o.vendor, l.product_id, o.title;
END; $$;
ALTER FUNCTION public.receiving(receiving_start timestamp without time zone, receiving_stop timestamp without time zone) OWNER TO dbservice;
CREATE FUNCTION public.set_sequence_val_max(schema_name name, table_name name DEFAULT NULL::name, raise_notice boolean DEFAULT false) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    row_data RECORD;
    sql_code TEXT;
BEGIN
    IF ((SELECT COUNT(*) FROM pg_namespace WHERE nspname = schema_name) = 0) THEN
        RAISE EXCEPTION 'The schema "%" does not exist', schema_name;
    END IF;
    FOR sql_code IN
        SELECT 'SELECT SETVAL(' ||quote_literal(N.nspname || '.' || S.relname)|| ', MAX(' ||quote_ident(C.attname)|| ') ) FROM ' || quote_ident(N.nspname) || '.' || quote_ident(T.relname)|| ';' AS sql_code
            FROM pg_class AS S
            INNER JOIN pg_depend AS D ON S.oid = D.objid
            INNER JOIN pg_class AS T ON D.refobjid = T.oid
            INNER JOIN pg_attribute AS C ON D.refobjid = C.attrelid AND D.refobjsubid = C.attnum
            INNER JOIN pg_namespace N ON N.oid = S.relnamespace
            WHERE S.relkind = 'S' AND N.nspname = schema_name AND (table_name IS NULL OR T.relname = table_name)
            ORDER BY S.relname
    LOOP
        IF (raise_notice) THEN
            RAISE NOTICE 'sql_code: %', sql_code;
        END IF;
        EXECUTE sql_code;
    END LOOP;
END;
$$;
CREATE FUNCTION rptg.pick_audit(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, restocker text, product_id integer, pick_qty integer, restock_qty integer, discrepancy integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. 
	Note: add feature: if end_date not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity of above product_id for the same route_date
	discrepancy: restock_qty - pick_quantity for target_date  
*/
begin
	if end_date is null
		then end_date = start_date;
	end if;
	return query
		select a.kiosk_id, a.route_date, r.restocker, a.sku_id, cast(sum(a.qty) as integer), 
			coalesce(cast(sum(l.total) as integer), 0), cast(coalesce(sum(l.total), 0) - sum(a.qty) as integer)
			from inm.pick_allocation a 
			left join 
				(select to_timestamp(time_created)::date restock_date, pantry.label.kiosk_id, pantry.label.product_id, count(*) total
					from pantry.label group by 1,2,3) l
					on a.route_date = l.restock_date and a.kiosk_id=l.kiosk_id and a.sku_id = l.product_id
			left join 
					(select distinct to_timestamp(created)::date route_date, o.kiosk_id, first_name || ' ' || last_name restocker from pantry.order o
						where order_id like 'RE%' and to_timestamp(created)::date between start_date and end_date + 1 order by 1,2) r
					on r.route_date = a.route_date and r.kiosk_id = a.kiosk_id
			where a.route_date between start_date and end_date
		group by 1, 2, 3, 4;
end;
$$;
CREATE FUNCTION inm.allocation_ratio_by_sku_group_test(target_date date) RETURNS TABLE(sku_group character varying, order_total bigint, allocation_total bigint, allocation_percentage integer)
    LANGUAGE plpgsql
    AS $$
begin
	return query
		select a.fc_title, o.order_total, a.allocation_total,  cast(100*a.allocation_total/cast(o.order_total as decimal) as integer) allocation_percentage
			from
				(select pick_date, sku_group_id, sum(qty) order_total
				from inm.pick_demand
				group by 1,2) o
			left join
				(select pick_date, sgs.fc_title, sgs.sku_group_id, sum(qty) allocation_total
				from inm.pick_allocation a
				join inm.view_sku_sku_group sgs
				on a.sku_id = sgs.product_id
				group by 1,2,3)a
				on a.pick_date = o.pick_date and o.sku_group_id = a.sku_group_id;
end
$$;
CREATE FUNCTION public.make_odd_or_even_sequence(table_name text, sequence_field_name text, odd_or_even text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
  sequence_name text;
  max_id integer;
begin
  if odd_or_even not in ('odd', 'even')
  then return 'error: last param has to be either `odd` or `even`';
  end if;
  execute concat('select max(', sequence_field_name, ') from ', table_name) into max_id;
  select pg_get_serial_sequence(table_name, sequence_field_name) into sequence_name;
  execute 'alter sequence ' || sequence_name || ' increment by 2';
  case odd_or_even
    when 'odd' then
      return setval(sequence_name, max_id + mod(max_id + 1, 2));
    when 'even' then
      return setval(sequence_name, max_id + mod(max_id, 2));
    end case;
end;
$$;
CREATE FUNCTION rptg.sales(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, order_id_ character varying, kiosk_id_ bigint, product_id_ bigint, time_bought_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/*
SALE QUERY From Art's logic: see ENG-834
For a given time window W1 (e.g. from beginning_date through ending_date) and an extended time
window W2, with W1 being a subset of W2 (e.g. W1 +1 and -1 month from beginning_date through
ending_date)
Sale: count of unique epc’s which have at least one sale label record within W1.
A sale label record has an order id which does not start with RE and has a sold status.
For a sale label record to be within time window W1, the order creation time needs to be within W1.
*/
    SELECT unique_epcs.epc as epc_,
        order_id as order_id_,
        kiosk_id as kiosk_id_,
        product_id as product_id_,
        to_timestamp(all_epc_data.time_bought) as time_bought_,
        cost as cost_,
        price as price_,
        kiosk_campus_id as kiosk_campus_id_,
        product_campus_id as product_campus_id_,
        enable_reporting as enable_reporting_
        FROM(SELECT epc,
            max(created) as time_bought
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
            JOIN pantry.order o
            ON o.order_id = l.order_id
            AND to_timestamp(created)::date >= beginning_date
            AND to_timestamp(created)::date <= ending_date
            AND l.status = 'sold'
            AND l.order_id NOT LIKE 'RE%'
            AND l.order_id IS NOT NULL
            GROUP BY epc
        ) as unique_epcs
        /*
        This subquery is used to get the order_id, time the order was created, price and cost
        values for the distinct EPCs we selected in the subquery above.
        */
        LEFT JOIN (SELECT epc,
            l.product_id,
            l.order_id,
            o.created as time_bought,
            COALESCE(l.cost, ph.cost, p.cost,0) as cost,
            COALESCE(ph.price, l.price, p.price,0) as price,
            l.kiosk_id,
            k.campus_id as kiosk_campus_id,
            p.campus_id as product_campus_id,
            k.enable_reporting
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
            JOIN pantry.order o
            ON o.order_id = l.order_id
            AND to_timestamp(created)::date >= beginning_date
            AND to_timestamp(created)::date <= ending_date
            LEFT JOIN pantry.product_history ph ON ph.product_id = p.id
            AND o.created >= ph.start_time AND (ph.end_time IS NULL OR o.created <
            ph.end_time)
            AND l.status = 'sold'
            AND l.order_id NOT LIKE 'RE%'
            AND l.order_id IS NOT NULL
        ) as all_epc_data
        ON unique_epcs.epc = all_epc_data.epc
        AND unique_epcs.time_bought = all_epc_data.time_bought;
 END;
$$;
CREATE FUNCTION beta.bringg_vs_optimo_delta(start_date date, end_date date) RETURNS TABLE(bringg_kid integer, bringg_task_id bigint, bringg_ts timestamp with time zone, optimo_ts timestamp with time zone, optimo_kid integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
start_date: first pick date to consider
end_date: last pick date to consider
Output - 
difference between Bringg and Optimo routes
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
set timezone to 'US/Pacific';
return query
select cast(b.kid as integer) b_kid, b.task_id, b.route_date_time b_ts, o.route_date_time o_ts, o.location_number o_kid
from bringg.order b 
full outer join mixalot.route_stop o
on cast(b.kid as integer) = o.location_number and b.route_date_time::date = o.route_date_time::date and  o.location_number <> -1
where (b.route_date_time::date between start_date and end_date or o.route_date_time::date between start_date and end_date)
and (o.route_date_time is null or b.route_date_time is null)
order by coalesce(b.route_date_time, o.route_date_time);
end;
$$;
CREATE FUNCTION inm_beta.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_demand_qty numeric, plan_demand_qty numeric, plan_order_qty numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM order based on sales ratio for pick sales period (time between deliveries)
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_demand_qty: demand based on once a week delivery (without minimum)
  plan_demand_qty: demand based on sales ratio for pick sales period (without minimum)
  plan_order_qty: order based on sales ratio for pick sales period
*/
begin
	return query
		select sr.kiosk_id, sr.route_date_time, sgc.sku_group_id, dwbv.fc_title, dwbv.demand_weekly as week_demand_qty, 
			cast(1.4 * sr.sales_ratio * dwbv.demand_weekly as numeric (8,2)) plan_demand_qty,
			case 
				when dwbv.demand_weekly = 0 or ksms.scale = 0.0 then 0 
				else
					ceiling(
						least(greatest(least(1.4 * sr.sales_ratio * dwbv.demand_weekly, dwbv.demand_weekly) + sgc.min_qty - coalesce(inv.count, 0),
											  0) /* change negative demand to 0 */
								   , sgc.max_qty))
			end as plan_order_qty -- end case
			from inm_beta.pick_get_sales_period_ratio(start_ts, end_ts) sr
				join inm_beta.pick_get_demand_weekly_by_velocity() dwbv
					on sr.kiosk_id = dwbv.kiosk_id 											
				join inm_beta.sku_group_control sgc
					on sgc.sku_group_id = dwbv.sku_group_id			
				left join mixalot.inm_kiosk_projected_stock inv
					on dwbv.kiosk_id = inv.kiosk_id and dwbv.fc_title = inv.fc_title
				left join inm_beta.kiosk_sku_group_manual_scale ksms
					on sr.kiosk_id = ksms.kiosk_id and sgc.sku_group_id = ksms.sku_group_id;				
	end;
$$;
CREATE FUNCTION pantry.fn_card_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN 
 	UPDATE pantry.ro_order 
	SET    customer_full_name = concat_ws(' ', coalesce(trim(NEW.first_name), o.payment_system), coalesce(trim(NEW.last_name), substring(NEW.number, -8)))
	FROM pantry.order o 
	WHERE pantry.ro_order.order_id = o.order_id AND o.card_hash = NEW.hash;
  RETURN NEW; 
END; 
$$;
CREATE FUNCTION beta.compare_pick_vs_delivery_ignore_null(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, restocker text, product_id integer, pick_qty integer, restock_qty integer, discrepancy integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity above product_id restocked between target_date and the following delivery date_time for the kiosk
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	set timezone to 'US/Pacific';
	return query
		select a.kiosk_id, a.route_date, r.restocker, a.sku_id, cast(sum(a.qty) as integer), 
			cast(sum(l.total) as integer), cast(sum(a.qty) - sum(l.total) as integer)
			from inm.pick_allocation a 
			left join 
				(select to_timestamp(time_created)::date restock_date, pantry.label.kiosk_id, pantry.label.product_id, count(*) total
					from pantry.label group by 1,2,3) l
					on a.route_date = l.restock_date and a.kiosk_id=l.kiosk_id and a.sku_id = l.product_id
			left join 
					(select distinct to_timestamp(created)::date route_date, o.kiosk_id, first_name || ' ' || last_name restocker from pantry.order o
						where order_id like 'RE%' and to_timestamp(created)::date between start_date and end_date + 1 order by 1,2) r
					on r.route_date = a.route_date and r.kiosk_id = a.kiosk_id
			where a.route_date between start_date and end_date
		group by 1, 2, 3, 4;
end;
$$;
CREATE FUNCTION beta.compare_pick_vs_delivery_test(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, kiosk_title character varying, driver_name character varying, restocker text, product_id integer, pick_qty bigint, restock_qty bigint, discrepancy bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity above product_id restocked between target_date and the following delivery date_time for the kiosk
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	set timezone to 'US/Pacific';
	if end_date is null
		then end_date = start_date;
	end if;
	for target_date in select * from generate_series(start_date, end_date, interval '1 days') loop
		pick_window_start = cast(target_date as timestamp with time zone) + interval '13 hours';
		pick_window_end = pick_window_start + interval '22 hours';
		return query
			select
				a.kiosk_id, a.route_date, k.title, d.driver_name, r.restocker, a.sku_id, a.pick_qty, coalesce(rs.restock_qty, 0) restock_qty, coalesce(rs.restock_qty, 0) - a.pick_qty discrepancy
				from
					(select t1.kiosk_id, t1.route_date_time, t1.next_delivery_ts, t1.driver_name from inm.pick_get_plan_kiosk(pick_window_start, pick_window_end) t1) d
					join
					(select t2.kiosk_id, t2.route_date, t2.sku_id, sum(t2.qty) pick_qty
						from inm.pick_allocation t2
						where pick_date = target_date
						group by 1,2,3) a
					on d.kiosk_id = a.kiosk_id and d.route_date_time::date = a.route_date
				left join
					(select t3.kiosk_id, to_timestamp(time_added)::date restock_date, t3.product_id, count(*) restock_qty
					  from pantry.label t3
					  where to_timestamp(time_added) between pick_window_start and pick_window_start + interval '2 days' -- optimize to a safe upper limit of 2 days
					  group by 1,2,3) rs
					on a.kiosk_id = rs.kiosk_id and a.route_date = rs.restock_date and a.sku_id = rs.product_id -- now match exactly restock_date to route_date
				left join 
					(select distinct to_timestamp(created)::date route_date, o.kiosk_id, first_name || ' ' || last_name restocker from pantry.order o
						where order_id like 'RE%' and to_timestamp(created)::date between target_date and target_date + 1 order by 1,2) r
					on r.route_date = a.route_date and r.kiosk_id = a.kiosk_id
				join pantry.kiosk k on a.kiosk_id = k.id and k.campus_id = 87
				order by a.kiosk_id;
		end loop;
end;
$$;
CREATE FUNCTION inm.allocation_ratio_by_sku_group(target_date date) RETURNS TABLE(sku_group character varying, warehouse_qty bigint, order_total bigint, allocation_total bigint, allocation_percentage integer)
    LANGUAGE plpgsql
    AS $$
begin
	return query
		select a.fc_title, inv.total , o.order_total, a.allocation_total,  cast(100*a.allocation_total/cast(o.order_total as decimal) as integer) allocation_percentage
			from
				(select pick_date, sku_group_id, sum(qty) order_total
				from inm.pick_demand
				group by 1,2) o
			left join
				(select pick_date, sgs.fc_title, sgs.sku_group_id, sum(qty) allocation_total
				from inm.pick_allocation a
				join inm.view_sku_sku_group sgs
				on a.sku_id = sgs.product_id
				group by 1,2,3)a
				on a.pick_date = o.pick_date and o.sku_group_id = a.sku_group_id
			left join
				(select sgs.fc_title, sum(qty) total 
				 	from mixalot.inm_data i
				 		join inm.view_sku_sku_group sgs
							on i.product_id = sgs.product_id
					where import_ts = (select max(import_ts) from mixalot.inm_data 
									   where import_ts::date = target_date) and data_type = 'Warehouse SKU Inventory'
				 	group by 1				 
					) inv
				on a.fc_title = inv.fc_title
			where a.pick_date = target_date;
end
$$;
CREATE FUNCTION inm_test.test_demand(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, fc_title text, week_qty integer, plan_qty integer, loopback_start_ts timestamp with time zone, loopback_end_ts timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM plan demand for a pick window.
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_qty: demand based on once a week delivery
  plan_qty: demand based on time to next delivery
*/
declare latest_import_ts_for_pick_window timestamp with time zone;
begin	
	select max(import_ts) from mixalot.inm_data
		where import_ts >= start_ts::date
		into latest_import_ts_for_pick_window;
	return query
		select pk.kiosk_id, pk.route_date_time, demand.fc_title, demand.qty week_qty,
			demand.qty/2 plan_qty, -- test
			start_ts, end_ts
			  from mixalot.plan_kiosk(start_ts, end_ts) pk
			join (select d.kiosk_id, d.route_date, cast(s.title as text) fc_title, d.qty qty
					from mixalot.pick_demand d join mixalot.sku_group_def s on d.sku_group_id = s.id
					where pick_date = latest_import_ts_for_pick_window::date
					) demand
 				on pk.kiosk_id = demand.kiosk_id and pk.route_date_time::date = demand.route_date;
end;
$$;
CREATE FUNCTION pantry.fn_campus_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN 
   INSERT INTO pantry.group_campus (group_id, campus_id)
    VALUES(1, NEW.id);		
  RETURN NEW; 
END; 
$$;
CREATE FUNCTION beta.compare_pick_vs_delivery_v2(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, product_id integer, pick_qty integer, restock_qty integer, discrepancy integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity above product_id restocked between target_date and the following delivery date_time for the kiosk
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	set timezone to 'US/Pacific';
	return query
		select a.kiosk_id, a.route_date, a.sku_id, cast(sum(a.qty) as integer), cast(sum(l.total) as integer), cast(sum(a.qty) - sum(l.total) as integer)
			from inm.pick_allocation a 
			left join 
				(select to_timestamp(time_created)::date restock_date, pantry.label.kiosk_id, pantry.label.product_id, count(*) total
					from pantry.label group by 1,2,3) l
					on a.route_date = l.restock_date and a.kiosk_id=l.kiosk_id and a.sku_id = l.product_id
			where a.route_date between start_date and end_date
		group by 1, 2, 3;
end;
$$;
CREATE FUNCTION inm.sync_restriction_by_property(kiosk_id integer, restriction character varying) RETURNS TABLE(status character varying)
    LANGUAGE plpgsql ROWS 10
    AS $$
begin
	return query
		select 
		    'Ok';
end
$$;
CREATE FUNCTION inm_beta.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_qty integer, plan_qty integer)
    LANGUAGE plpgsql ROWS 10000
    AS $$
/*
Purpose - return INM order for the next sale period which is the time between the deliveries of this pick and the next pick
Comment - Why go through this function and not call pick_get_order_with_velocity(start_date, end_date) directly? There are 2 reasons:
	1. We can replace pick_get_order_with_velocity with a newer fucntion here and not having to change the client code to test the new function.
	2. pick_get_order_with_velocity returns richer data that can be used for troubleshooting which is not necessary for production.
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  plan_qty: order quantity for the above fc_title for the next sale period
*/
begin
	return query
		select ov.kiosk_id, ov.route_date_time, ov.sku_group_id, ov.fc_title, cast(ov.week_demand_qty as integer), cast(ov.plan_order_qty as integer) from inm_beta.pick_get_order_with_velocity(start_ts, end_ts) ov;
end;
$$;
CREATE FUNCTION inm_test.pick_inventory_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  begin
  	new.route_date = new.pick_date;
  	return new;
  end;
$$;
CREATE FUNCTION pantry.fn_audit_kiosk_device() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
   IF (TG_OP = 'INSERT') THEN
       INSERT INTO pantry.history_kiosk_device(kiosk_id,payload,time_modified,action)
       VALUES(NEW.kiosk_id, NEW.payload, now(),'INSERT');
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       INSERT INTO pantry.history_kiosk_device(kiosk_id,payload,time_modified,action)
       VALUES(NEW.kiosk_id, NEW.payload, now(),'UPDATE');
       RETURN NEW;
   ELSEIF (TG_OP = 'DELETE') THEN
       INSERT INTO pantry.history_kiosk_device(kiosk_id,payload,time_modified,action)
       VALUES(OLD.kiosk_id, OLD.payload, now(),'DELETE');
       RETURN OLD;
   END IF;
   RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$$;
CREATE FUNCTION util.fix_orders_using_request_log() RETURNS TABLE(count_orders_affected integer)
    LANGUAGE plpgsql
    AS $$
/*
Address issues of specific kiosk not sending /item requests to our backend, thus voiding orders.
To fix these orders, first use function extract_request_log_epc_order to extract epc orders and save
them to request_log_epc_order.
Then run this function to fix those orders.
*/
declare count_orders_affected integer;
begin
  update pantry.label l
     set order_id = p.order_id
     from test.request_log_epc_order p
     where p.epc = l.epc;
  select count(*)
    from pantry.order o
      join test.request_log_epc_order rleo on o.order_id = rleo.order_id
      where o.state = 'Voided'
      into count_orders_affected;
  update pantry.order o
    set state = 'PriceFinalized'
    from test.request_log_epc_order rleo
    where o.order_id = rleo.order_id and o.state = 'Voided';
  return query
    select count_orders_affected;
end;
$$;
CREATE FUNCTION inm_beta.pick_get_demand_weekly_by_velocity() RETURNS TABLE(kiosk_id bigint, sku_group_id integer, fc_title text, demand_weekly numeric, kc_start_level numeric, kc_min_level numeric, kc_scale numeric, kc_manual_multiplier numeric, sgc_default_level numeric, sgc_scale numeric, ksms_scale numeric, ws_live bigint, velocity_demand numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM weekly demand by velocity
*/
begin
	return query
		select cast(kc.kiosk_id as bigint) , sg.id, cast(sg.fc_title as text),
			cast(
				case when coalesce(dwwom.ws_live, 0) < 4
				then greatest(
					coalesce (demand_weekly_wo_min, 0),
					kc.start_level * sgc.default_level * coalesce(ksms.scale, 1.0) * kc.manual_multiplier * sgc.scale
					)
				else greatest(
					coalesce (demand_weekly_wo_min, 0),
					kc.min_level * sgc.default_level * coalesce(ksms.scale, 1.0) * kc.scale * kc.manual_multiplier * sgc.scale
					)
				end as decimal(4,2)) as wk_demand,
				kc.start_level, kc.min_level, kc.scale, kc.manual_multiplier, sgc.default_level, sgc.scale, coalesce(ksms.scale, 1.0) , coalesce(dwwom.ws_live, 0),
				dwwom.demand_weekly_wo_min
			from inm.sku_group sg
				cross join inm.kiosk_control kc
				left join inm.kiosk_sku_group_manual_scale ksms on ksms.kiosk_id=kc.kiosk_id and ksms.sku_group_id=sg.id
				left join inm.sku_group_control sgc on sgc.sku_group_id = sg.id
				left join inm.pick_get_demand_weekly_wo_min() dwwom on dwwom.kiosk_id = kc.kiosk_id and dwwom.sku_group = sg.fc_title;
end;
$$;
CREATE FUNCTION inm_test.compare_pick_vs_delivery(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, kiosk_title character varying, product_id integer, pick_qty bigint, restock_qty bigint, discrepancy bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity above product_id restocked between target_date and the following delivery date_time for the kiosk
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	if end_date is null
		then end_date = start_date;
	end if;
	for target_date in select * from generate_series(start_date, end_date, interval '1 days') loop
		pick_window_start = cast(target_date as timestamp with time zone) + interval '13 hours';
		pick_window_end = pick_window_start + interval '22 hours';
		return query
			select
				a.kiosk_id, a.route_date, k.title, a.sku_id, a.pick_qty, rs.restock_qty, coalesce(rs.restock_qty, 0) - a.pick_qty discrepancy
				from
					(select t1.kiosk_id, t1.route_date_time, t1.next_delivery_ts from inm.pick_get_plan_kiosk(pick_window_start, pick_window_end) t1) d
				join
					(select t2.kiosk_id, t2.route_date, t2.sku_id, sum(t2.qty) pick_qty
						from inm.pick_allocation t2
						where pick_date = target_date
						group by 1,2,3) a
					on d.kiosk_id = a.kiosk_id and d.route_date_time::date = a.route_date
				left join
					(select t3.kiosk_id, to_timestamp(time_added)::date restock_date, t3.product_id, count(*) restock_qty
					  from pantry.label t3
					  where to_timestamp(time_added) between pick_window_start and cast(pick_window_start as timestamp) + interval '2 days' -- limit to potential pick time frame
					  group by 1,2,3 having count(*) >= 1) rs
				on a.kiosk_id = rs.kiosk_id and a.route_date = rs.restock_date and a.sku_id = rs.product_id
				join pantry.kiosk k on a.kiosk_id = k.id
				order by a.kiosk_id;
		end loop;
end;
$$;
CREATE FUNCTION inm_test.pick_get_plan_demand_w_manual(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_qty integer, plan_qty integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM plan demand for a pick window.
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_qty: demand based on once a week delivery
  plan_qty: demand based on time to next delivery
*/
declare latest_import_ts_for_pick_window timestamp with time zone;
begin
	select max(import_ts) from mixalot.inm_data i
		where import_ts::date = start_ts::date and data_type = 'Par Unconstrained wo Min' -- make sure import contain this data_type
		into latest_import_ts_for_pick_window;
	return query
		select pk.kiosk_id, pk.route_date_time, sga.id, inm.fc_title, inm.qty week_qty,
			case 
				when inm.qty = 0 then 0
				else 	
					least(cast(greatest(ceiling(1.8 * inm.qty * coalesce(days_to_next_delivery, 3)/7) + sga.minimum_kiosk_qty - coalesce(inv.count, 0),
										  sga.minimum_kiosk_qty - inv.count, /* ensure minimum quantity */
										  0) /* change negative demand to 0 */
							   as integer), sga.maximum_kiosk_qty) 
			end as plan_qty -- case
			  from mixalot.plan_kiosk(start_ts, end_ts) pk
			join mixalot.inm_data inm
				on pk.kiosk_id = inm.kiosk_id
					and inm.data_type = 'Par Unconstrained wo Min'					
					and inm.import_ts = latest_import_ts_for_pick_window
			join mixalot.sku_group_attribute sga
				on sga.title = inm.fc_title
 			left join mixalot.inm_kiosk_projected_stock inv
 				on inm.kiosk_id = inv.kiosk_id and inm.fc_title = inv.fc_title;
end;
$$;
CREATE FUNCTION public.hex_to_int(hexval character varying) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    result  int;
BEGIN
    EXECUTE 'SELECT x''' || hexval || '''::int' INTO result;
    RETURN result;
END;
$$;
CREATE FUNCTION fnrenames.fn_kiosk_audit_log_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF (
 NEW.archived != OLD.archived
 OR
 NEW.enable_reporting != OLD.enable_reporting
 OR
 NEW.enable_monitoring != OLD.enable_monitoring
) THEN
 INSERT INTO pantry.kiosk_audit_log (
    kiosk_id, archived, enable_reporting, enable_monitoring
 ) VALUES (
    OLD.id, NEW.archived, NEW.enable_reporting, NEW.enable_monitoring
);
END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION inm_beta.pick_get_demand_weekly_wo_min() RETURNS TABLE(kiosk_id bigint, sku_group character varying, sample_size bigint, dt_avg numeric, dt_std numeric, w_departure_time numeric, preference numeric, pref_total numeric, ws_avg numeric, ws_std numeric, ws_live bigint, demand_weekly_wo_min numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM weekly demand without min by velocity
*/
begin
	return query
			select *,
	round((t7.preference/t7.pref_total)*(t7.ws_avg+t7.ws_std), 2) as demand_weekly_wo_min
from (
	select t4.kiosk_id,
		t4.sku_group,
		t4.sample_size,
		t4.dt_avg,
		t4.dt_std,
		t4.w_departure_time,
		t4.preference,
		sum(t4.preference) over (partition by t4.kiosk_id) as pref_total,
		t6.ws_avg,
		t6.ws_std,
		t6.ws_live
	from (
		select t3.kiosk_id, 
			t3.sku_group, 
			count(t3.purchase_index) as sample_size,
			round((avg(t3.departure_time))::numeric, 2) as dt_avg,
			coalesce(round((stddev(t3.departure_time))::numeric, 2), 0) as dt_std,
			round(sum(t3.departure_time*t3.w)/sum(t3.w)::numeric, 2) as w_departure_time,
			least(round(1.00/(sum(t3.departure_time*t3.w)/sum(t3.w))::numeric, 2), 0.20) as preference
		from (
			select *,
				greatest(coalesce(round((t2.time_sold - greatest(t2.last_sale, t2.time_stocked))::numeric/3600, 2), 50.00), 1.00) as departure_time,
				0 as qty_sold,
				1 as w
			from (
				select *,
					lag(t1.time_sold, 1) over (partition by t1.kiosk_id, t1.sku_group order by t1.time_sold) as last_sale,
					lag(t1.purchase_index, 1) over (partition by t1.kiosk_id, t1.sku_group order by t1.time_sold) as last_purchase_index
				from (
					select k.kiosk_id,
						p.sku_group,
						l.time_stocked,
						l.time_sold,
						l.purchase_index
					from (
						select k.id as kiosk_id
						from pantry.kiosk k
						where k.campus_id=87
							and k.archived=0
							and k.enable_reporting=1
					) k
					cross join (
						select distinct fc_title as sku_group
						from pantry.product p
						where p.campus_id=87
							and p.archived=0
							and p.fc_title is not null
							and p.fc_title!='N/A'
						order by p.fc_title asc
					) p
					left outer join (
						select l.kiosk_id as kiosk_id,
							p.fc_title as sku_group,
							l.time_created as time_stocked, 
							l.time_updated as time_sold,
							row_number() over (partition by l.kiosk_id order by l.time_updated) as purchase_index
						from pantry.label l
							join pantry.product p on l.product_id=p.id
						where l.kiosk_id is not null
							and l.status='sold'
							and to_timestamp(l.time_updated) at time zone 'US/Pacific' > date_trunc('week', current_timestamp) - interval '24 weeks'
							and p.campus_id=87
							and p.archived=0
							and p.fc_title is not null
					) l on k.kiosk_id=l.kiosk_id and p.sku_group=l.sku_group
					order by k.kiosk_id, p.sku_group, l.purchase_index
				) t1
			) t2
		) t3
		group by t3.kiosk_id, t3.sku_group
	) t4
	join 
	(select t5.kiosk_id, round(avg(units_sold), 2) ws_avg, round(stddev(units_sold), 2) ws_std, count(units_sold) ws_live
		from (
			SELECT concat(kk.kiosk_id::character varying(4), ' ', kk.woy) AS key,
				kk.kiosk_id,
				kk.woy,
				ss.units_sold
			FROM (
				SELECT k.id AS kiosk_id,
					generate_series(1, 52) AS woy
				FROM pantry.kiosk k
				WHERE k.campus_id = 87 AND k.archived = 0 AND k.enable_reporting = 1 AND k.enable_monitoring = 1) kk
			LEFT JOIN ( 
				SELECT s.kiosk_id,
					date_part('week'::text, s.ts) AS woy,
					count(*) AS units_sold
				FROM byte_epcssold_3months s
				GROUP BY s.kiosk_id, (date_part('week'::text, s.ts))) ss ON kk.kiosk_id = ss.kiosk_id AND kk.woy::double precision = ss.woy
			ORDER BY ss.kiosk_id, ss.woy) t5
		group by t5.kiosk_id
		order by t5.kiosk_id asc
	) t6 on t4.kiosk_id=t6.kiosk_id) t7;
end;
$$;
CREATE FUNCTION inm_beta.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, fc_title character varying, qty integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return projected stock for plan kiosks for a pick window.
*/
begin
	return query
		select pk.kiosk_id, kps.fc_title, cast(kps.count as integer) from inm_beta.pick_get_plan_kiosk(plan_window_start, plan_window_stop) pk			
		left join inm_beta.kiosk_projected_stock kps on pk.kiosk_id = kps.kiosk_id
			where kps.fc_title is not null;
end;
$$;
CREATE FUNCTION pantry.fn_ro_order_set_order(orderid character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$ 
BEGIN 
  INSERT INTO pantry.ro_order 
              ( 
                          order_id, 
                          campus_id, 
                          kiosk_id, 
                          kiosk_title, 
                          created, 
                          state, 
                          customer_full_name, 
                          archived 
              ) 
  SELECT    o.order_id, 
            k.campus_id, 
            o.kiosk_id, 
            o.kiosk_title, 
            o.created, 
            o.state, 
            concat_ws(' ', coalesce(trim(c.first_name), o.payment_system), coalesce(trim(c.last_name), substring(c.NUMBER, -8))) customer_full_name,
            cast( 
            CASE 
                      WHEN( 
                                          k.archived = 1 
                                OR        o.archived = 1) THEN 1::bigint 
                      ELSE 0::                                    bigint 
            END AS                                                bigint) 
  FROM      pantry.ORDER o 
  left join pantry.kiosk k 
  ON        k.id = o.kiosk_id 
  left join pantry.card c 
  ON        c.hash = o.card_hash 
  WHERE     o.order_id = orderid
  LIMIT 1
  ON conflict (order_id) DO 
  UPDATE 
  SET    campus_id = excluded.campus_id, 
         kiosk_id = excluded.kiosk_id, 
         kiosk_title = excluded.kiosk_title, 
         created = excluded.created, 
         state = excluded.state, 
         customer_full_name = excluded.customer_full_name;
PERFORM pantry.fn_ro_order_update_full_price(orderId);                                                                                                                                                                                                                                 
END
$$;
CREATE FUNCTION util.extract_request_log_epc_order(target_kiosk_id integer, report_start timestamp without time zone, report_end timestamp without time zone) RETURNS TABLE(epc character varying, order_id text, ts timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
/*
Extract epc, order_id from mixalot.request_log for a kiosk for a period and store the result in
table request_log_sold_epc to be used by function fix_orders_using_request_log
to fix incorrectly voided orders due to kiosk sync issue.
*/
begin
  create table if not exists test.request_log_sold_epc(
    id serial,
    epc varchar(24) not null,
    order_id text,
    kiosk_id bigint,
    direction varchar(16) not null,
    reason text,
    ts timestamp not null
  );
  create table if not exists test.request_log_epc_order(
    epc varchar(24) not null,
    order_id text,
    ts timestamp not null
  );
  truncate test.request_log_sold_epc;
  insert into test.request_log_sold_epc(epc, order_id, kiosk_id, direction, reason, ts)
    select out_epc.epc, out_epc.order_id, out_epc.kiosk_id, out_epc.direction, out_epc.reason, out_epc.ts
    from (
           select request_body_json::json ->> 'epc' as epc,
                  request_body_json::json ->> 'order_id' as order_id,
                  nullif(regexp_replace(request_body_json::json ->> 'order_id', '[A-Za-z]+[0-9]*', '', 'g'),
                         '')::int kiosk_id,
                  request_body_json::json ->> 'direction' as direction,
                  request_body_json::json ->> 'reason' as reason,
                  start_ts ts,
                  rank() over (partition by request_body_json::json ->> 'order_id',
                        request_body_json::json ->> 'epc' order by start_ts desc) as r
           from mixalot.request_log
           where start_ts between report_start and report_end
             and endpoint in ('/item')
             and request_body_json::json ->> 'direction' = 'out'
             and request_body_json::json ->> 'order_id' is not null
             and request_body_json::json ->> 'order_id' like target_kiosk_id || '%'
         ) out_epc
    where out_epc.r = 1;
  truncate test.request_log_epc_order;
  insert into test.request_log_epc_order
    select tsp.epc, tsp.order_id, tsp.ts
      from (
             select distinct on(epc) test.request_log_sold_epc.*
             from test.request_log_sold_epc
             order by epc, ts desc
           ) tsp
      where reason = 'add_to_order';
  return query
    select * from test.request_log_epc_order;
end;
$$;
CREATE FUNCTION inm.get_performance_pull_list(given_kiosk_id integer) RETURNS TABLE(category character varying, kiosk_id_ integer, kiosk_title_ character varying, product_id_ integer, product_tile_ character varying, epc character varying)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        /* This query is used to identify skus that do not sell well in a given kiosk. A poor
        performing sku meets the following criteria
          1. Qualifier - SKU has been present in the kiosk for 4 weeks (28 days)(not consecutive).
          2. Spoilage >= 30% of sales over 3 of the past 6 weeks.
          3. No sales in past 2 weeks when the item was available (there has to be a least one
          SKU present in the kiosk every single day of those 2 weeks) OR  less than 50% of sku fleet
           average (by month).
         SEE ENG-555
        This query takes less than a minute to run for 1 kiosk and 7 minutes to run for all kiosks
        */
        SELECT 'LOW PERFORMANCE'::varchar as category,
            SKU_performance_qualifiers.kid as kiosk_id_,
            SKU_performance_qualifiers.k_title as kiosk_title_,
            SKU_performance_qualifiers.pid as product_id_,
            SKU_performance_qualifiers.p_title as product_tile_,
            (SKU_performance_qualifiers.epc)::varchar as epc
            /* The following subquery selects all kiosk/sku combination that qualify to be analyzed
            for poor performance. A kiosk/sku combination qualifies to be analyzed for poor
            performance if a given sku has been present in a given kiosk for 28 days (4 weeks) non
            consecutively.
            */
            FROM (SELECT *
                FROM (SELECT kiosk_id as kid,
                product_id as pid,
                k_title,
                p_title,
                sum(status) as number_of_days_in_kiosk
                    /* List of all date/kiosk/sku combination and whether the given sku has been
                    seen by the given kiosk on a given day*/
                    FROM (SELECT kiosk_id,
                        product_id,
                        date::date,
                        k.title as k_title,
                        p.title as p_title,
                        CASE WHEN count(*) > 0 THEN 1 else 0 END as status
                        FROM inventory_history ih
                        JOIN pantry.kiosk k
                        ON ih.kiosk_id = k.id
                        JOIN pantry.product p
                        ON ih.product_id = p.id
                        WHERE k.campus_id = 87
                        AND p.campus_id = 87
                        AND k.enable_reporting = 1
                        AND k.id = given_kiosk_id
                        AND k.archived = 0
                        AND p.archived = 0
                        GROUP BY kiosk_id, product_id, date, p.title, k.title
                    ) as sku_kiosk_status_per_day
                    GROUP BY kiosk_id, product_id, k_title, p_title
                ) as sum_days_product_in_kiosk
                JOIN (SELECT kiosk_id,
                        product_id,
                        l.epc
                        FROM pantry.label l
                        JOIN pantry.kiosk k on k.id  = l.kiosk_id
                        JOIN pantry.product p on p.id  = l.product_id
                        WHERE status = 'ok'
                        AND k.enable_reporting = 1
                        AND p.campus_id = 87
                        AND k.id = given_kiosk_id
                    ) as in_kiosk
                    ON sum_days_product_in_kiosk.kid = in_kiosk.kiosk_id
                    AND sum_days_product_in_kiosk.pid = in_kiosk.product_id
                WHERE number_of_days_in_kiosk >= 28
            ) as SKU_performance_qualifiers
            /* The following is set up to analyze if a given sku in a given kiosk has a spoilage % (
            (spoilage/sales)* 100) >= 30% over 3 of the past 6 weeks. To set this up, we will get a
            weekly spoilage for each sku per kiosk. We will then use LAG() OVER (PARTITION BY)
            in order to have all weeks spoilage values in one row. The row containing all
            spoilage values will be the 6th row of each kiosk/sku combination (week_rank = 6) */
            LEFT JOIN (SELECT week_rank,
                kid,
                k_title,
                pid,
                p_title,
                COALESCE(lag(second_week_spoilage) OVER (PARTITION BY kid, pid ORDER BY week_rank), 0)
                    as first_week_spoilage,
                second_week_spoilage,
                third_week_spoilage,
                fourth_week_spoilage,
                fifth_week_spoilage,
                spoilage_percent as sixth_week_spoilage
                FROM (SELECT *
                    FROM (SELECT *,
                        lag(third_week_spoilage) OVER (Partition by kid, pid ORDER BY week_rank)
                            as second_week_spoilage
                        FROM (SELECT *,
                            lag(fourth_week_spoilage) OVER (Partition by kid, pid ORDER BY week_rank)
                                as third_week_spoilage
                            FROM (SELECT *,
                                lag(fifth_week_spoilage) OVER (Partition by kid, pid ORDER BY week_rank)
                                    as fourth_week_spoilage
                                FROM (SELECT week,
                                    week_rank,
                                    kid,
                                    k_title,
                                    pid,
                                    p_title,
                                    spoilage_percent ,
                                    lag(spoilage_percent) OVER (Partition by kid, pid ORDER BY week_rank)
                                        as fifth_week_spoilage
                                    FROM (SELECT all_weeks_kiosks_products.week,
                                        all_weeks_kiosks_products.week_rank,
                                        all_weeks_kiosks_products.kid,
                                        all_weeks_kiosks_products.k_title,
                                        all_weeks_kiosks_products.pid,
                                        all_weeks_kiosks_products.p_title,
                                        COALESCE(total_spoilage, 0) as spoilage,
                                        COALESCE(total_sales, 0) as total_sales,
                                        COALESCE(ROUND(100.0 * (COALESCE(total_spoilage, 0)/
                                            NULLIF(COALESCE(total_sales, 0),0)),2),0) as spoilage_percent
                                        FROM (SELECT week_and_rank.week,
                                            kid,
                                            k_title,
                                            pid,
                                            p_title,
                                            week_and_rank.week_rank
                                            FROM (SELECT week,
                                                rank() OVER (ORDER BY week) as week_rank
                                                FROM (SELECT distinct(EXTRACT('week' FROM dd)) as week
                                                FROM generate_series( (NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER -6)::date
                                                    - INTERVAL '6 weeks' , (NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER -6)::date,
                                                    '1 day'::interval) dd
                                                ) as weeks
                                                GROUP BY week
                                            ) as week_and_rank
                                            CROSS JOIN (SELECT k.id as kid,
                                                k.title as k_title,
                                                p.id as pid,
                                                p.title as p_title
                                                FROM pantry.kiosk k
                                                CROSS JOIN
                                                pantry.product p
                                                WHERE k.campus_id = 87
                                                AND p.campus_id = 87
                                                AND k.enable_reporting = 1
                                                AND k.id = given_kiosk_id
                                                AND k.archived = 0
                                                AND p.archived = 0
                                            ) as kiosk_and_product
                                        ) as all_weeks_kiosks_products
                                        LEFT JOIN (SELECT EXTRACT('week' FROM to_timestamp(created)::date)
                                                as week,
                                        l.kiosk_id,
                                        l.product_id,
                                        sum(l.price) as total_sales
                                        FROM byte_tickets bt
                                        JOIN pantry.label l
                                        ON bt.order_id = l.order_id
                                        WHERE to_timestamp(created)::date>= (NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER
                                            -6)::date - INTERVAL '6 weeks'
                                        AND to_timestamp(created)::date <= (NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER
                                            -7)::date
                                        GROUP BY l.kiosk_id, l.product_id, EXTRACT('week' FROM to_timestamp(created)::date)
                                        ) as sales_per_week
                                        ON all_weeks_kiosks_products.kid = sales_per_week.kiosk_id
                                        AND all_weeks_kiosks_products.pid = sales_per_week.product_id
                                        AND all_weeks_kiosks_products.week = sales_per_week.week
                                        LEFT JOIN (SELECT EXTRACT('week' FROM date::date) as week,
                                        kiosk_id,
                                        product_id,
                                        sum(cost) as total_spoilage
                                        FROM byte_spoilage
                                        WHERE date::date>= (NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER -6)::date
                                            - INTERVAL '6 weeks'
                                        AND date::date <= (NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER -7)::date
                                        GROUP BY kiosk_id, product_id, EXTRACT('week' FROM date::date)
                                        ) as spoilage_per_week
                                        ON all_weeks_kiosks_products.kid = spoilage_per_week.kiosk_id
                                        AND all_weeks_kiosks_products.pid = spoilage_per_week.product_id
                                        AND all_weeks_kiosks_products.week = spoilage_per_week.week
                                    ) as spoilage_percent_per_week
                                ) as lag_second_spoilage
                            ) as lag_third_spoilage
                        ) as lag_fourth_spoilage
                    ) as lag_fifth_spoilage
                ) as lag_sixth_spoilage
            WHERE week_rank = 6
            ) as spoilage_per_week
            ON SKU_performance_qualifiers.kid = spoilage_per_week.kid
            AND SKU_performance_qualifiers.pid = spoilage_per_week.pid
            /* The following subquery is set up to analyze if a sku's total sales in a given kiosk last
            month is less than 50% of the sku's entire fleet average. To do this, we need a sku's average
            sale across the entire fleet last month, and the sku's total sale in a given kiosk last month
            */
            LEFT JOIN (SELECT kiosk_and_product.kid,
                kiosk_and_product.pid,
                COALESCE(avg_sku_sales.avg_sales_across_all_fleet, 0)/ 2 as fifty_percent_avg_sales_across_all_fleet,
                COALESCE(avg_sku_sales.avg_sales_across_all_fleet, 0) as avg_sales_across_all_fleet,
                COALESCE(sum_kiosk_sales_per_kiosk.sales_per_kiosk, 0) as sales_per_kiosk
                FROM (SELECT k.id as kid,
                    k.title as k_title,
                    p.id as pid,
                    p.title as p_title
                    FROM pantry.kiosk k
                    CROSS JOIN
                    pantry.product p
                    WHERE k.campus_id = 87
                    AND p.campus_id = 87
                    AND k.enable_reporting = 1
                    AND k.id = given_kiosk_id
                    AND k.archived = 0
                    AND p.archived = 0
                ) as kiosk_and_product
                LEFT JOIN (SELECT product_id,
                    avg(sales_per_kiosk) as avg_sales_across_all_fleet
                    FROM (SELECT product_id,
                        bt.kiosk_id,
                        count(*) as sales_per_kiosk
                        FROM byte_tickets bt
                        JOIN pantry.label l
                        ON bt.order_id = l.order_id
                        WHERE to_timestamp(bt.created)::date >= now()::date - interval '1 month'
                        GROUP BY product_id, bt.kiosk_id
                    ) as sum_sales_per_kiosk_last_month
                    GROUP BY product_id
                ) as avg_sku_sales
                ON avg_sku_sales.product_id = kiosk_and_product.pid
                LEFT JOIN (SELECT product_id ,
                    bt.kiosk_id,
                    count(*) as sales_per_kiosk
                    FROM byte_tickets bt
                    JOIN pantry.label l
                    ON bt.order_id = l.order_id
                    WHERE to_timestamp(bt.created)::date >= now()::date - interval '1 month'
                    GROUP BY product_id, bt.kiosk_id
                ) as sum_kiosk_sales_per_kiosk
                ON kiosk_and_product.pid = sum_kiosk_sales_per_kiosk.product_id
                AND kiosk_and_product.kid = sum_kiosk_sales_per_kiosk.kiosk_id
            ) as low_sales
            ON  SKU_performance_qualifiers.kid = low_sales.kid
            AND SKU_performance_qualifiers.pid = low_sales.pid
            /*The following subquery is used to determine if there were no sku sales in the last 2
            consecutive weeks when the sku was available. This means that we need to look for the last 14
            consecutive days where a given sku was in a given kiosk during all days of those 14
            consecutive days.
            */
            LEFT JOIN (SELECT get_date.kiosk_id,
                get_date.k_title,
                get_date.product_id,
                get_date.p_title,
                get_date.date as last_date_with_previous_14_consecutive_item_present,
                COALESCE(total_price, 0) as total_price_last_consecutive_14_days
                FROM (SELECT kiosk_id,
                    k_title,
                    product_id,
                    p_title,
                    max(date) as date
                    FROM (SELECT kiosk_id,
                        k_title,
                        product_id,
                        p_title,
                        number_in_fridge_consecutively,
                        date
                        FROM (SELECT *,
                            /* We use rank() OVER (PARTITION BY) as a way to determine when a sku has been
                            in a kiosk consecutively. It will tell how many days a sku has
                            been in a kiosk for consecutive days.
                            I used the method described in
                            https://stackoverflow.com/questions/47654348/postgres-rank-based-on-consecutive-values
                            */
                            rank() OVER (PARTITION BY kiosk_id, product_id, days_passed_since_last_present,
                                rank_2 - rank_1 ORDER BY date) as number_in_fridge_consecutively
                            FROM (SELECT *
                                FROM (SELECT *,
                                    rank() OVER (PARTITION BY kiosk_id, product_id, days_passed_since_last_present
                                        ORDER BY date::date) as rank_1,
                                    rank() OVER (PARTITION BY kiosk_id, product_id ORDER BY date::date) as rank_2
                                    /* Get all dates where a sku was present in a kiosk,
                                    and how many days has passed since that same sku was present in
                                    that same kiosk
                                    */
                                    FROM (SELECT ih.kiosk_id,
                                        k.title as k_title,
                                        ih.product_id,
                                        p.title as p_title,
                                        CASE WHEN count(*) > 0 THEN 1 else 0 END as status,
                                        ih.date::date,
                                        ih.date::date - lag(ih.date::date) OVER (PARTITION BY ih.kiosk_id, ih.product_id
                                            ORDER BY ih.date::date) as days_passed_since_last_present
                                        FROM inventory_history ih
                                        JOIN pantry.kiosk k
                                        ON ih.kiosk_id = k.id
                                        JOIN pantry.product p
                                        ON ih.product_id = p.id
                                        WHERE k.campus_id = 87
                                        AND p.campus_id = 87
                                        AND k.enable_reporting = 1
                                        AND k.id = given_kiosk_id
                                        AND p.archived = 0
                                        AND k.archived = 0
                                        GROUP BY ih.kiosk_id, ih.product_id, ih.date, p.title, k.title
                                    ) as get_days_passed_since_last_present
                                ) as set_up_for_ranking_part_1
                                /* Before we do the ranking, we need to get rid of any rows that are not
                                consecutive in days. Those are found where rank_1 = 1. Not doing so will
                                result in inaccurate ranking */
                                WHERE rank_1 !=1
                            ) set_up_for_ranking_part_2
                        ) as ranking
                         WHERE number_in_fridge_consecutively >= 14
                    ) as consecutive_for_2_weeks_max_date
                    GROUP BY kiosk_id,  k_title, product_id,  p_title
                )  as get_date
                LEFT JOIN (SELECT p1.date,
                    p1.kiosk_id,
                    p1.product_id,
                    SUM(p2.price) total_price
                    FROM (SELECT to_timestamp(bt.created)::date as date,
                    l.kiosk_id,
                    l.product_id,
                    sum(l.price) as price
                    FROM byte_tickets bt
                    JOIN pantry.label l
                    ON bt.order_id = l.order_id
                    GROUP BY l.kiosk_id, l.product_id, to_timestamp(bt.created)::date
                ) as p1
                    INNER JOIN (SELECT to_timestamp(bt.created)::date as date,
                    l.kiosk_id,
                    l.product_id,
                    sum(l.price) as price
                    FROM byte_tickets bt
                    JOIN pantry.label l
                    ON bt.order_id = l.order_id
                    GROUP BY l.kiosk_id, l.product_id, to_timestamp(bt.created)::date
                ) as p2
                ON p1.kiosk_id = p2.kiosk_id
                AND p1.product_id = p2.product_id
                AND p2.date BETWEEN (p1.date - INTERVAL '14 DAY') AND p1.date
                 GROUP BY p1.kiosk_id, p1.product_id, p1.date
                 ORDER BY p1.kiosk_id, p1.date
             )sales on get_date.date = sales.date
                AND get_date.kiosk_id = sales.kiosk_id
                AND get_date.product_id = sales.product_id
            ) as no_sales_last_2_weeks
            ON SKU_performance_qualifiers.kid = no_sales_last_2_weeks.kiosk_id
            AND SKU_performance_qualifiers.pid = no_sales_last_2_weeks.product_id
            WHERE (
                ( fifty_percent_avg_sales_across_all_fleet > sales_per_kiosk)
                OR
                (total_price_last_consecutive_14_days = 0)
            )
            /* Where Spoilage >= 30% of sales over 3 of the past 6 weeks. I used the combination calculator
            found on https://www.mathsisfun.com/combinatorics/combinations-permutations-calculator.html
            to generate all week_spoilage combinations.*/
            AND ((first_week_spoilage >= 30 AND second_week_spoilage >= 30 AND third_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND second_week_spoilage >= 30 AND fourth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND second_week_spoilage >= 30 AND fifth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND second_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND third_week_spoilage >= 30 AND fourth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND third_week_spoilage >= 30 AND fifth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND third_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND fourth_week_spoilage >= 30 AND fifth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND fourth_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (first_week_spoilage >= 30 AND fifth_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (second_week_spoilage >= 30 AND third_week_spoilage >= 30 AND fourth_week_spoilage >= 30) OR
                (second_week_spoilage >= 30 AND third_week_spoilage >= 30 AND fifth_week_spoilage >= 30) OR
                (second_week_spoilage >= 30 AND third_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (second_week_spoilage >= 30 AND fourth_week_spoilage >= 30 AND fifth_week_spoilage >= 30) OR
                (second_week_spoilage >= 30 AND fourth_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (second_week_spoilage >= 30 AND fifth_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (third_week_spoilage >= 30 AND fourth_week_spoilage >= 30 AND fifth_week_spoilage >= 30) OR
                (third_week_spoilage >= 30 AND fourth_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (third_week_spoilage >= 30 AND fifth_week_spoilage >= 30 AND sixth_week_spoilage >= 30) OR
                (fourth_week_spoilage >= 30 AND fifth_week_spoilage >= 30 AND sixth_week_spoilage >=30)
            );
    END;
$$;
CREATE FUNCTION inm.pick_get_delivery_schedule_optimo(target_date date) RETURNS TABLE(driver_name character varying, route_date_time timestamp with time zone, kiosk_id integer, kiosk_title character varying, address character varying, delivery_order integer)
    LANGUAGE plpgsql
    AS $$
	declare latest_import_ts timestamp;
	declare plan_window_start timestamp;
	declare plan_window_stop timestamp;
/*
Purpose: return INM delivery schedule for a pick window.
Input
	target_date: pick_date
Return
	Data to generate the drivers sheets
*/
begin
	select max(import_ts) from mixalot.inm_data into latest_import_ts;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Start'
		into plan_window_start;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Stop'
		into plan_window_stop;
	return query
		select rs.driver_name, rs.route_date_time, location_number kiosk_id, k.title kiosk_title, k.address, rs.stop_number delivery_order
			from mixalot.route_stop rs join pantry.kiosk k on rs.location_number = k.id
			where rs.route_date_time between plan_window_start and plan_window_stop;
end;
$$;
CREATE FUNCTION inm_test.pick_get_order_with_sales_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_demand_qty integer, plan_demand_qty numeric, plan_order_qty numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM order based on sales ratio for pick sales period (time between deliveries)
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_demand_qty: demand based on once a week delivery (without minimum)
  plan_demand_qty: demand based on sales ratio for pick sales period (without minimum)
  plan_order_qty: order based on sales ratio for pick sales period
*/
declare latest_import_ts_for_pick_window timestamp with time zone;
begin
	select max(import_ts) from mixalot.inm_data i
		where import_ts::date = start_ts::date and data_type = 'Par Unconstrained wo Min' -- make sure import contain this data_type
		into latest_import_ts_for_pick_window;
	return query
		select sr.kiosk_id, sr.route_date_time, sga.id, inm.fc_title, inm.qty week_demand_qty, 
			cast(1.4 * sr.sales_ratio * inm.qty as numeric (8,2)) plan_demand_qty,
			case 
				when inm.qty = 0 then 0 -- restricted item
				else
					least(
						least(greatest(ceiling(1.4 * sr.sales_ratio * inm.qty) + sga.minimum_kiosk_qty - coalesce(inv.count, 0),
											  0) /* change negative demand to 0 */
								   , sga.maximum_kiosk_qty),
						inm.qty)
			end as plan_order_qty -- end case
			from inm.pick_get_sales_period_ratio(start_ts, end_ts) sr
				join mixalot.inm_data inm
					on sr.kiosk_id = inm.kiosk_id
						and inm.data_type = 'Par Unconstrained wo Min'					
						and inm.import_ts = latest_import_ts_for_pick_window						
				join inm.sku_group_attribute sga
					on sga.title = inm.fc_title			
				left join mixalot.inm_kiosk_projected_stock inv
					on inm.kiosk_id = inv.kiosk_id and inm.fc_title = inv.fc_title;
	end;
$$;
CREATE FUNCTION pantry.fn_discount_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 BEGIN
        INSERT INTO pantry.discount_history (kiosk_id, product_id, value, start_time, end_time, discount_id)
    VALUES(NEW.kiosk_id, NEW.product_id, NEW.value,  EXTRACT(epoch FROM NOW()) , NULL, NEW.id);
RETURN NEW;
END;
$$;
CREATE FUNCTION pantry.kiosk_guardrails_ssl_cert_bytetech_co() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  min_app_version text = '4.4.4';
begin
  if
    (tg_op = 'INSERT' or (tg_op = 'UPDATE' and old.server_url is distinct from new.server_url))
    and new.app_vname is not null
    and public.is_older_software_version(new.app_vname::text, min_app_version)
    and trim(new.server_url) ilike '%.bytetech.co'
  then new.server_url = null;
  end if;
  return new;
end;
$$;
CREATE FUNCTION mixalot.pick_inventory_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  begin
  	new.route_date = new.pick_date;
  	return new;
  end;
  $$;
ALTER FUNCTION mixalot.pick_inventory_insert() OWNER TO dbservice;
CREATE FUNCTION mixalot.pick_summary(target_date date) RETURNS TABLE(property text, name text, value text)
    LANGUAGE plpgsql
    AS $$
declare pick_tickets_generated integer;
declare ticket integer ARRAY;
declare demand integer ARRAY;
declare allocation integer ARRAY;
declare property text;
declare name text;
declare value text;
declare total integer;
declare result_row record;
declare kiosks_added text;
declare kiosks_removed text;
begin
	FOR i IN 0..2 LOOP
 		select count(*) from inm.pick_route where pick_date = target_date - 7*i  into total;
		ticket[i+1] = total; -- convert to one-based index
		select sum(qty) from inm.pick_demand where pick_date = target_date - 7*i into total;
		demand[i+1] = total;
		select sum(qty) from inm.pick_allocation where pick_date = target_date - 7*i into total;
		allocation[i+1] = total;
   	END LOOP;
	select array_to_string(array_agg(cast (kiosk_id as varchar) order by kiosk_id), ',') from inm.pick_route 
		where pick_date = target_date and kiosk_id not in
			(select kiosk_id from inm.pick_route where pick_date = target_date - 7)
	into kiosks_added;
	select array_to_string(array_agg(cast (kiosk_id as varchar) order by kiosk_id), ',') from inm.pick_route 
		where pick_date = target_date - 7  and kiosk_id not in
			(select kiosk_id from inm.pick_route where pick_date = target_date)
	into kiosks_removed;
	property = 'stats';
	name = 'pick tickets today/ -7 days/ -14 days: ';
	value = ticket[1] || '/' || ticket[2] || '/' || ticket[3];
	return query select property, name, value;
	property = 'stats';
	name = 'demand qty today/ -7 days/ -14 days: ';
	value = demand[1] || '/' || demand[2] || '/' || demand[3];
	return query select property, name, value;
	property = 'stats';
	name = 'allocation qty today/ -7 days/ -14 days: ';
	value = allocation[1] || '/' || allocation[2] || '/' || allocation[3];
	return query select property, name, value;
	property = 'stats';
	name = 'kiosks added';
	value = kiosks_added;
	return query select property, name, value;
	property = 'stats';
	name = 'kiosks removed';
	value = kiosks_removed;
	return query select property, name, value;
end
$$;
CREATE FUNCTION pantry.fn_label_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN
   IF NEW.order_id is NOT NULL THEN 
   	PERFORM pantry.fn_add_to_watch(NEW.id, NEW.order_id);		
   END IF;	
  RETURN NEW; 
END; 
$$;
CREATE FUNCTION pantry.fn_product_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.price <> OLD.price OR NEW.cost <> OLD.cost THEN
		UPDATE pantry.product_history SET end_time = EXTRACT(epoch FROM NOW()) WHERE product_id = OLD.id AND end_time IS NULL;
		INSERT INTO pantry.product_history (price, cost, start_time, end_time, product_id, campus_id)
		VALUES(NEW.price, NEW.cost, EXTRACT(epoch FROM NOW()) + 1, NULL, NEW.id, NEW.campus_id);
    END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION inm_beta.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, driver_name character varying, location_name character varying, next_delivery_ts timestamp with time zone, time_to_next_delivery interval, days_to_next_delivery double precision, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM plan kiosks for a pick window.
*/
begin
	return query
		select ds.kiosk_id, ds.route_date_time, ds.driver_name, ds.location_name, ps.next_delivery_ts,
		ps.next_delivery_ts - ds.route_date_time as time_to_next_delivery,		
		  case 
		  	when ps.next_delivery_ts - ds.route_date_time between interval '12 hours' and interval '24 hours' then 1
			else extract(day from ps.next_delivery_ts - ds.route_date_time)
			end as days_to_next_delivery,
		  row_number() over (order by ds.route_date_time asc) as delivery_order
		from
		(select t.kiosk_id, t.route_date_time, t.driver_name, t.location_name from
			(select location_number as kiosk_id, rs.route_date_time, rs.driver_name, rs.location_name,
				rank() over (partition by location_number, rs.route_date_time order by rs.route_date_time) as r
				from mixalot.route_stop rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan winddow start
				and location_number > 0) t
				where r = 1) ds
		left join 
		(select t.kiosk_id, t.route_date_time next_delivery_ts from
			(select location_number as kiosk_id, rs.route_date_time,
				rank() over (partition by location_number order by rs.route_date_time) as r
				from mixalot.route_stop rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan window start
				and location_number > 0) t
				where r = 2) ps
			on ds.kiosk_id = ps.kiosk_id
			join pantry.kiosk k on ds.kiosk_id = k.id
			where ds.route_date_time between plan_window_start and plan_window_stop
			and k.campus_id= 87;	
end;
$$;
CREATE FUNCTION inm_beta.pick_get_plan_kiosk_disabled_product(pick_date date) RETURNS TABLE(kiosk_id bigint, product_id integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return disabled products for kiosks on the pick for a pick date.
*/
begin
	return query
		select dp.kiosk_id, dp.product_id
		from inm.pick_get_plan_kiosk(pick_date) pk
			join inm.kiosk_product_disabled dp on pk.kiosk_id = dp.kiosk_id;
end;
$$;
CREATE FUNCTION pantry.fn_ro_order_update_full_price(orderid character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE pantry.ro_order
    SET
      real_full_price = (
        SELECT                   
                        CASE WHEN (o.state <> 'NonTrans')
                          THEN
                                  COALESCE(SUM(l.price), 0)
                          ELSE
                                  0
                          END
        FROM pantry.label l
          JOIN pantry.order o ON o.order_id = l.order_id
        WHERE l.order_id = orderId
                GROUP BY o.state  
      ),
      full_price = (
        SELECT                   
                        CASE WHEN (o.state <> 'NonTrans')
                          THEN
                                  COALESCE(SUM(l.price), 0)
                          ELSE
                                  0
                          END
        FROM pantry.label l
          JOIN pantry.order o ON o.order_id = l.order_id
          JOIN pantry.kiosk k ON k.id = o.kiosk_id
          JOIN pantry.product p ON p.id = l.product_id
          JOIN pantry.group_campus gc1 ON gc1.campus_id = k.campus_id AND gc1.owner = 1
          JOIN pantry.group_campus gc2 ON gc2.campus_id = p.campus_id AND gc2.owner = 1
        WHERE l.order_id = orderId
              AND gc1.group_id = gc2.group_id
                GROUP BY o.state  
      ),
      time_updated = (SELECT date_part('epoch',CURRENT_TIMESTAMP)::int)
    WHERE ro_order.order_id = orderId;
END
$$;
CREATE FUNCTION pantry.fn_audit_kiosk_service_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
   IF (TG_OP = 'INSERT') THEN
       INSERT INTO pantry.history_kiosk_service_version(kiosk_id,service,version,time_modified,action)
       VALUES(NEW.kiosk_id, NEW.service, NEW.version, now(),'INSERT');
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       INSERT INTO pantry.history_kiosk_service_version(kiosk_id,service,version,time_modified,action)
       VALUES(NEW.kiosk_id, NEW.service, NEW.version, now(),'UPDATE');
       RETURN NEW;
   ELSEIF (TG_OP = 'DELETE') THEN
       INSERT INTO pantry.history_kiosk_service_version(kiosk_id,service,version,time_modified,action)
       VALUES(OLD.kiosk_id, OLD.service, OLD.version, now(),'DELETE');
       RETURN OLD;
   END IF;
   RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$$;
CREATE FUNCTION pantry.get_permissions(a integer) RETURNS TABLE(role_id integer, permission character varying, api character varying, isfrontend integer)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY SELECT h.role_id, h.permission, h.api, h.isFrontend FROM pantry.HIERARCHY(a, 1) h; 
END;
$$;
CREATE FUNCTION beta.pick_get_order_by_sales_4wks_availability(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, weeks_with_sales smallint)
    LANGUAGE plpgsql ROWS 10000
    AS $$
/*
Purpose - return sales data availability for the last 4 weeks
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  week_count: 0-4 which indicates the number of weeks sales data is available
*/
begin
	return query
		select weeks_available.kiosk_id, cast(sum(available) as smallint)
		from
			(
			select wk_minus_1.kiosk_id,
				case when count(*) >= 1 then 1 else 0 end as available from
				(select pk.kiosk_id, count(*)
					from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '7 days' and pk.next_delivery_ts - interval '7 days'
					group by 1) wk_minus_1
					group by 1
			union all 
			select wk_minus_2.kiosk_id,
				case when count(*) >= 1 then 1 else 0 end as available from
				(select pk.kiosk_id, count(*)
					from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '14 days' and pk.next_delivery_ts - interval '14 days'
					group by 1) wk_minus_2
					group by 1
			union all
			select wk_minus_3.kiosk_id,
				case when count(*) >= 1 then 1 else 0 end as available from
				(select pk.kiosk_id, count(*)
					from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '21 days' and pk.next_delivery_ts - interval '21 days'
					group by 1) wk_minus_3
					group by 1
			union all	
			select wk_minus_4.kiosk_id,
				case when count(*) >= 1 then 1 else 0 end as available from
				(select pk.kiosk_id, count(*)
					from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '28 days' and pk.next_delivery_ts - interval '28 days'
					group by 1) wk_minus_4
					group by 1
			) weeks_available
			group by 1;
	end;
$$;
CREATE FUNCTION beta.test_insert(n integer, m integer, OUT submitted_data integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/*
Purpose - Submit a pick with task_option controlling how to deal with conflict.
Input -
  target_date: pick date
  overwrite: 0 or 1. If 1, overwrite old pick.
  timeout_seconds: minimum amount of time the task can be in status = "started" before it's considered timed out 
Return -
  submitted_status:
  	submitted - pick submitted.
	started - a pick already in progress for target date.
	ready - a completed pick already existed (and overwrite=0)
*/
begin
	insert into beta.test(n) values (n+m);
	submitted_data = n+m;
end;
$$;
CREATE FUNCTION mixalot.pick_demand_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	new.route_date = new.pick_date;
	return new;
end;
$$;
CREATE FUNCTION pantry.fn_audit_campus_attribute() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
   IF (TG_OP = 'INSERT') THEN
       INSERT INTO pantry.history_campus_attribute(campus_id,gad_id,value,time_modified,action)
       VALUES(NEW.campus_id, NEW.key_id, NEW.value, now(),'INSERT');
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       INSERT INTO pantry.history_campus_attribute(campus_id,gad_id,value,time_modified,action)
       VALUES(NEW.campus_id, NEW.key_id, NEW.value, now(),'UPDATE');
       RETURN NEW;
   ELSEIF (TG_OP = 'DELETE') THEN
       INSERT INTO pantry.history_campus_attribute(campus_id,gad_id,value,time_modified,action)
       VALUES(OLD.campus_id, OLD.key_id, OLD.value, now(),'DELETE');
       RETURN OLD;
   END IF;
   RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$$;
CREATE FUNCTION public.path_check(VARIADIC kiosk_path text[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	i TEXT;
BEGIN
	FOREACH i IN ARRAY kiosk_path
LOOP 
	RAISE NOTICE '%', i;
END LOOP;
END; $$;
ALTER FUNCTION public.path_check(VARIADIC kiosk_path text[]) OWNER TO dbservice;
CREATE FUNCTION public.path_check_1_2_3(receiving_start timestamp without time zone, receiving_stop timestamp without time zone) RETURNS TABLE(epc character varying, stops_count bigint, receiving_date timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
DECLARE
	receiving BIGINT := 522;
	pickpack BIGINT := 523;
	spoilage BIGINT := 524;
BEGIN
	RETURN query
		SELECT *
		FROM 
			(SELECT x.epc, 
    			sum(x.stop_count) AS stops_count, 
    			max(x.time_created) AS time_created
			FROM 
        		(SELECT l.epc,
            		1 AS stop_count,
            		to_timestamp(max(l.time_created)) at TIME zone 'US/Pacific' AS time_created
        		FROM pantry.label l
        		JOIN pantry.product o ON l.product_id = o.id
       			WHERE to_timestamp(l.time_created) at TIME zone 'US/Pacific' between receiving_start AND receiving_stop
           			AND kiosk_id = receiving
       			GROUP BY l.epc
    			UNION
    			SELECT l.epc,
        			1 AS stop_count,
        			to_timestamp(max(l.time_created)) at TIME zone 'US/Pacific' AS time_created
    			FROM pantry.label l
    			JOIN pantry.product o ON l.product_id = o.id
    			WHERE to_timestamp(l.time_created) at TIME zone 'US/Pacific' between receiving_start AND receiving_stop
        			AND kiosk_id = pickpack
    			GROUP BY l.epc
    			UNION
    			SELECT l.epc,
        			1 AS stop_count,
        			to_timestamp(max(l.time_created)) at TIME zone 'US/Pacific' AS time_created
    			FROM pantry.label l
    			JOIN pantry.product o ON l.product_id = o.id
    			WHERE to_timestamp(l.time_created) at TIME zone 'US/Pacific' between receiving_start AND receiving_stop
        			AND kiosk_id != receiving
        			AND kiosk_id != pickpack
					AND kiosk_id != spoilage
    			GROUP BY l.epc) AS x
    		GROUP BY x.epc) as y
		WHERE y.stops_count = 3;
END; $$;
ALTER FUNCTION public.path_check_1_2_3(receiving_start timestamp without time zone, receiving_stop timestamp without time zone) OWNER TO dbservice;
CREATE FUNCTION public.pct(numeric, numeric) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$
 SELECT if( $1::float + $2::float > 0.0, 100.0 * $1::float / ($1::float + $2::float), 0.0::float)
$_$;
ALTER FUNCTION public.pct(numeric, numeric) OWNER TO dbservice;
CREATE FUNCTION public.pick_get_next_delivery(target_date date) RETURNS TABLE(kiosk_id integer, delivery_ts timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
begin
	return query
		select location_number, schedule_at from
		(select location_number, schedule_at , rank() over (PARTITION BY location_number order by schedule_at) as num
			from mixalot.route_stop where location_number <> -1) ds
		where num = 1;
end;
$$;
CREATE FUNCTION public.user_retention_by_month(n integer) RETURNS TABLE(month timestamp with time zone, num_consumers bigint, repeat_consumers bigint, num_tickets bigint, sum_amount_list_price numeric, sum_amount_paid numeric, num_repeat_tickets bigint, sum_repeat_amount_list_price numeric, sum_repeat_amount_paid numeric, frac_users_retained numeric, frac_tickets_retained numeric, frac_listprice_retained numeric, frac_amountpaid_retained numeric, old_month timestamp with time zone, old_num_consumers bigint, old_repeat_consumers bigint, old_num_tickets bigint, old_sum_amount_list_price numeric, old_sum_amount_paid numeric)
    LANGUAGE sql STABLE
    AS $$
  WITH consumer_stats AS (
     SELECT consumer_id
           ,month
           ,count(*) AS num_tickets
           ,sum(amount_list_price)::numeric(10,2) AS sum_amount_list_price
           ,sum(amount_paid)::numeric(10,2) AS sum_amount_paid
           ,lag(month, n) OVER (PARTITION BY consumer_id ORDER BY month)
            = month - (n * interval '1 month') OR NULL AS repeat_transaction
     FROM   user_retention_tickets
     GROUP  BY 1, 2
  ), stats AS (
     SELECT month
           ,count(*) AS num_consumers
           ,count(repeat_transaction) AS repeat_consumers
           ,sum(num_tickets)::bigint AS num_tickets
           ,sum(sum_amount_list_price)::numeric(10,2) AS sum_amount_list_price
           ,sum(sum_amount_paid)::numeric(10,2) AS sum_amount_paid
           ,sum(if(repeat_transaction,num_tickets::bigint,0::bigint))::bigint AS num_repeat_tickets
           ,sum(if(repeat_transaction,sum_amount_list_price,0::numeric(10,2)))::numeric(10,2) AS sum_repeat_amount_list_price
           ,sum(if(repeat_transaction,sum_amount_paid,0::numeric(10,2)))::numeric(10,2) AS sum_repeat_amount_paid
     FROM   consumer_stats
     GROUP  BY 1
     ORDER  BY 1
  )
  SELECT t1.*, (t1.repeat_consumers::float / t2.num_consumers)::numeric(10,4) as frac_users_retained,
         (t1.num_repeat_tickets::float / t2.num_tickets)::numeric(10,4) as frac_tickets_retained,
         (t1.sum_repeat_amount_list_price::float / t2.sum_amount_list_price)::numeric(10,4) as frac_listprice_retained,
         (t1.sum_repeat_amount_paid::float / t2.sum_amount_paid)::numeric(10,4) as frac_amountpaid_retained,
         t2.month as old_month, t2.num_consumers as old_num_consumers, t2.repeat_consumers as old_repeat_consumers,
         t2.num_tickets as old_num_tickets, t2.sum_amount_list_price as old_sum_amount_list_price, t2.sum_amount_paid as old_sum_amount_paid
    FROM stats t1 LEFT OUTER JOIN stats t2 ON (t1.month - n * interval '1 month') = t2.month
$$;
CREATE FUNCTION fnrenames.fn_ro_order_update_full_price(orderid character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    orderid varchar(135);
BEGIN
UPDATE pantry.ro_order
SET
    real_full_price = rt.rfp, full_price = ft.fp, created = rt.tc
FROM (
    SELECT
        CASE WHEN (o.state <> 'NonTrans')
            THEN
                COALESCE(SUM(l.price), 0)
            ELSE
                0
            END AS rfp,
            o.order_id,
            date_part('epoch', CURRENT_TIMESTAMP)::int as tc
    FROM pantry.label l
    JOIN pantry.order o ON o.order_id = l.order_id
    WHERE l.order_id = orderid
    GROUP BY o.order_id
) rt JOIN (
    SELECT
        CASE WHEN (o.state <> 'NonTrans')
            THEN
                COALESCE(SUM(l.price), 0)
            ELSE
                0
            END AS fp,
        o.order_id
    FROM pantry.label l
    JOIN pantry.order o ON o.order_id = l.order_id
    JOIN pantry.kiosk k ON k.id = o.kiosk_id
    JOIN pantry.product p ON p.id = l.product_id
    JOIN pantry.group_campus gc1 ON gc1.campus_id = k.campus_id AND gc1.owner = 1
    JOIN pantry.group_campus gc2 ON gc2.campus_id = p.campus_id AND gc2.owner = 1
    WHERE l.order_id = orderid
    AND gc1.group_id = gc2.group_id
    GROUP BY o.order_id
) ft ON rt.order_id = ft.order_id
WHERE ro_order.order_id = orderid;
END
$$;
CREATE FUNCTION inm_backup.pick_get_order_with_sales_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_demand_qty integer, plan_demand_qty numeric, plan_order_qty numeric)
    LANGUAGE plpgsql
    AS $$
  /*
  Purpose - return INM order based on sales ratio for pick sales period (time between deliveries)
  Input -
    start_ts: plan window start date time with time zone
    end_ts: plan window end date time with time zone
  Return -
    kiosk_id: together with route_date_time is unique for the plan window
    route_date_time: route starting date time
    fc_title: sku group name
    week_demand_qty: demand based on once a week delivery (without minimum)
    plan_demand_qty: demand based on sales ratio for pick sales period (without minimum)
    plan_order_qty: order based on sales ratio for pick sales period
  */
declare latest_import_ts_for_pick_window timestamp with time zone;
begin
  select max(import_ts) from mixalot.inm_data i
  where import_ts::date = start_ts::date and data_type = 'Par Unconstrained wo Min' -- make sure import contain this data_type
    into latest_import_ts_for_pick_window;
  return query
    select sr.kiosk_id, sr.route_date_time, sga.id, inm.fc_title, inm.qty week_demand_qty,
           cast(1.52 * sr.sales_ratio * inm.qty as numeric (8,2)) plan_demand_qty,
           case
             when inm.qty = 0 then 0
             else
               least(
                   least(greatest(ceiling(1.52 * sr.sales_ratio * inm.qty) + sga.minimum_kiosk_qty - coalesce(inv.count, 0),
                                  0) /* change negative demand to 0 */
                     , sga.maximum_kiosk_qty),
                   inm.qty)
             end as plan_order_qty -- end case
    from inm.pick_get_sales_period_ratio(start_ts, end_ts) sr
           join mixalot.inm_data inm
                on sr.kiosk_id = inm.kiosk_id
                  and inm.data_type = 'Par Unconstrained wo Min'
                  and inm.import_ts = latest_import_ts_for_pick_window
           join inm.sku_group_attribute sga
                on sga.title = inm.fc_title
           left join mixalot.inm_kiosk_projected_stock inv
                     on inm.kiosk_id = inv.kiosk_id and inm.fc_title = inv.fc_title;
end;
$$;
CREATE FUNCTION pantry.key_loc_lookup(param_kiosk_id bigint, key_name character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    gad_val varchar;
    campus_val varchar;
    kiosk_val varchar;
    lookup_campus_id int;
BEGIN
  select campus_id from pantry.kiosk where id = param_kiosk_id into lookup_campus_id;
  select subquery.gad, subquery.campus, subquery.kiosk  from
(
    SELECT
           gad.default_value AS gad,
           ca.value AS campus,
           ka.value  AS kiosk
    FROM pantry.global_attribute_def gad
             LEFT JOIN pantry.campus_attribute ca ON gad.id = ca.key_id and ca.campus_id = lookup_campus_id
             LEFT JOIN pantry.kiosk_attribute ka ON gad.id = ka.key_id and ka.kiosk_id = param_kiosk_id
    WHERE gad.key = key_name
) subquery into gad_val, campus_val, kiosk_val;
IF kiosk_val is not null THEN
  return 'kiosk';
ELSIF campus_val is not null THEN
    return 'campus';
ELSEIF gad_val is not null THEN
    return 'gad';
ELSE
    return 'none';
END IF;
END
$$;
CREATE FUNCTION public.user_retention_by_week(n integer) RETURNS TABLE(week timestamp with time zone, num_consumers bigint, repeat_consumers bigint, num_tickets bigint, sum_amount_list_price numeric, sum_amount_paid numeric, num_repeat_tickets bigint, sum_repeat_amount_list_price numeric, sum_repeat_amount_paid numeric, frac_users_retained numeric, frac_tickets_retained numeric, frac_listprice_retained numeric, frac_amountpaid_retained numeric, old_week timestamp with time zone, old_num_consumers bigint, old_repeat_consumers bigint, old_num_tickets bigint, old_sum_amount_list_price numeric, old_sum_amount_paid numeric)
    LANGUAGE sql STABLE
    AS $$
  WITH consumer_stats AS (
     SELECT consumer_id
           ,week
           ,count(*) AS num_tickets
           ,sum(amount_list_price)::numeric(10,2) AS sum_amount_list_price
           ,sum(amount_paid)::numeric(10,2) AS sum_amount_paid
           ,lag(week, n) OVER (PARTITION BY consumer_id ORDER BY week)
            = week - (n * 7 * interval '1 day') OR NULL AS repeat_transaction
     FROM   user_retention_tickets
     GROUP  BY 1, 2
  ), stats AS (
     SELECT week
           ,count(*) AS num_consumers
           ,count(repeat_transaction) AS repeat_consumers
           ,sum(num_tickets)::bigint AS num_tickets
           ,sum(sum_amount_list_price)::numeric(10,2) AS sum_amount_list_price
           ,sum(sum_amount_paid)::numeric(10,2) AS sum_amount_paid
           ,sum(if(repeat_transaction,num_tickets::bigint,0::bigint))::bigint AS num_repeat_tickets
           ,sum(if(repeat_transaction,sum_amount_list_price,0::numeric(10,2)))::numeric(10,2) AS sum_repeat_amount_list_price
           ,sum(if(repeat_transaction,sum_amount_paid,0::numeric(10,2)))::numeric(10,2) AS sum_repeat_amount_paid
     FROM   consumer_stats
     GROUP  BY 1
     ORDER  BY 1
  )
  SELECT t1.*, (t1.repeat_consumers::float / t2.num_consumers)::numeric(10,4) as frac_users_retained,
         (t1.num_repeat_tickets::float / t2.num_tickets)::numeric(10,4) as frac_tickets_retained,
         (t1.sum_repeat_amount_list_price::float / t2.sum_amount_list_price)::numeric(10,4) as frac_listprice_retained,
         (t1.sum_repeat_amount_paid::float / t2.sum_amount_paid)::numeric(10,4) as frac_amountpaid_retained,
         t2.week as old_week, t2.num_consumers as old_num_consumers, t2.repeat_consumers as old_repeat_consumers,
         t2.num_tickets as old_num_tickets, t2.sum_amount_list_price as old_sum_amount_list_price, t2.sum_amount_paid as old_sum_amount_paid
    FROM stats t1 LEFT OUTER JOIN stats t2 ON (t1.week - n * 7 * interval '1 day') = t2.week
$$;
CREATE FUNCTION mixalot.pick_allocation_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	new.route_date = new.pick_date;
	return new;
end;
$$;
CREATE FUNCTION inm_test.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sales_ratio numeric)
    LANGUAGE plpgsql ROWS 10000
    AS $$
/*
Purpose - return INM the ratio of the next sale period(time between the deliveries of this pick and the next pick) vs sales for the week
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  plan_qty: order quantity for the above fc_title for the next sale period
*/
begin	
	return query
		select scheduled_kiosks.kiosk_id, scheduled_kiosks.route_date_time, coalesce(existing_kiosk_with_sales_ratio.ratio, 1.0/3.0)
			from inm.pick_get_plan_kiosk(start_ts, end_ts) scheduled_kiosks
				left join
					(
					select whole_4_weeks.kiosk_id, whole_4_weeks.route_date_time, 
						case when whole_4_weeks.qty < 5 then 1.0/3.0 -- new kiosk, assume period sale is 1/3 of total week
							else cast(period_4_weeks.qty as decimal)/cast(whole_4_weeks.qty as decimal)
							end ratio		
					from
						(select pk.kiosk_id, pk.route_date_time, count(*) qty 
							from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
								join pantry.label l on pk.kiosk_id=l.kiosk_id
								where l.status in ('out', 'sold')
									and to_timestamp(l.time_updated) between
										pk.next_delivery_ts - interval '35 days'
										and pk.next_delivery_ts - interval '7 days'
							group by 1, 2
						 ) whole_4_weeks
						join 
						(
						select pk.kiosk_id, pk.route_date_time, count(*) qty
							from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
								join pantry.label l on pk.kiosk_id=l.kiosk_id
								where l.status in ('out', 'sold') and 
									(to_timestamp(l.time_updated) between pk.route_date_time - interval '7 days' + interval '4 hours' and pk.next_delivery_ts - interval '7 days'  + interval '4 hours' or
									 to_timestamp(l.time_updated) between pk.route_date_time - interval '14 days'  + interval '4 hours' and pk.next_delivery_ts - interval '14 days'  + interval '4 hours' or
									 to_timestamp(l.time_updated) between pk.route_date_time - interval '21 days'  + interval '4 hours' and pk.next_delivery_ts - interval '21 days'  + interval '4 hours' or
									 to_timestamp(l.time_updated) between pk.route_date_time - interval '28 days'  + interval '4 hours' and pk.next_delivery_ts - interval '28 days' + interval '4 hours')
								group by 1, 2
							) period_4_weeks
						on whole_4_weeks.kiosk_id = period_4_weeks.kiosk_id
					 ) existing_kiosk_with_sales_ratio
				on scheduled_kiosks.kiosk_id = existing_kiosk_with_sales_ratio.kiosk_id and scheduled_kiosks.route_date_time = existing_kiosk_with_sales_ratio.route_date_time;
	end;
$$;
CREATE FUNCTION beta.get_label_stats_v0(start_date date, end_date date, product_list integer[]) RETURNS TABLE(label_epc character varying, label_total bigint, label_order_total bigint, label_order_sold_total bigint, history_total bigint, history_unique_order_total bigint, history_unique_kid_total bigint, history_min_ts timestamp without time zone, history_max_ts timestamp without time zone, history_last_kid bigint, spoilage_total bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: compute label stats
Input: 
	start_date, end_date of label created
	list of kiosks
Return
	stats
*/
begin
	return query
		select t0.epc, coalesce(t1.label_total, 0), coalesce(t2.label_order_total, 0), coalesce(t3.label_order_sold_total, 0), coalesce(t4.history_total, 0),
		coalesce(t5.history_unique_order_total, 0), coalesce(t6.history_unique_kid_total, 0),
		cast(t7.history_min_ts as timestamp), cast(t7.history_max_ts as timestamp), coalesce(t8.history_last_kid, 0), coalesce(t9.spoilage_total, 0)
		from
			(select distinct epc
				from pantry.label l
			 		join pantry.kiosk k on l.kiosk_id = k.id and k.campus_id = 87
				where to_timestamp(time_added) between start_date and end_date
					and product_id in (select unnest(product_list))
			)t0
		left join 
			(
			select epc, count(*) label_total 
				from pantry.label
				where to_timestamp(time_added) between start_date and end_date
			 	group by epc
			)t1 on t0.epc = t1.epc
		left join 
			(
			select epc, count(*) label_order_total 
				from pantry.label
				where to_timestamp(time_added) between start_date and end_date
				and order_id is not null 
			 	group by epc
			)t2 on t0.epc = t2.epc
		left join 
			(
			select epc, count(*) label_order_sold_total 
				from pantry.label
				where to_timestamp(time_added) between start_date and end_date
				and order_id is not null and status='sold'
			 	group by epc
			)t3 on t0.epc = t3.epc
		left join
			(select h.epc, count(*) history_total 
			 	from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
				join pantry.history h on l.epc = h.epc
				group by h.epc
			)t4  on t0.epc = t4.epc
		left join
			(select h.epc, count(distinct h.order_id) history_unique_order_total 
			 	from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
				join pantry.history h on l.epc = h.epc and h.order_id is not null
				group by h.epc
			)t5 on t0.epc = t5.epc
		left join
			(select h.epc, count(distinct h.kiosk_id) history_unique_kid_total 
				from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
				join pantry.history h on l.epc = h.epc and h.kiosk_id is not null
				group by h.epc
			)t6 on t0.epc = t6.epc
		left join
		(select h.epc, min(to_timestamp(time)) history_min_ts, max(to_timestamp(time)) history_max_ts
			from 
				(select distinct epc
					from pantry.label
					where to_timestamp(time_added) between start_date and end_date
				) l
			join pantry.history h on l.epc = h.epc
		 	group by h.epc
		)t7 on t0.epc = t7.epc
		left join
			(select h_disctinct_last_kid.epc, h_disctinct_last_kid.kiosk_id history_last_kid
				from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
					join 
					(select distinct epc, kiosk_id
					 from
						(select epc, kiosk_id, to_timestamp(time) ts,
								rank() over (partition by epc order by time desc) r
						from pantry.history
						where kiosk_id is not null
						) h_last_kid) h_disctinct_last_kid
					on l.epc = h_disctinct_last_kid.epc
			)t8 on t0.epc = t8.epc
		left join
		(select s.epc, count(*) spoilage_total
			from
				(select distinct epc
					from pantry.label
					where to_timestamp(time_added) between start_date and end_date
				) l
				join pantry.spoilage s on l.epc = s.epc
				group by s.epc
		)t9 on t0.epc = t9.epc;
end;
$$;
CREATE FUNCTION inm_backup.pick_get_demand_weekly_by_velocity() RETURNS TABLE(kiosk_id bigint, sku_group_id integer, fc_title text, demand_weekly numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM weekly demand by velocity
*/
begin
	return query
		select dwwom.kiosk_id , sg.id, cast(sg.fc_title as text),
			cast(
				case when ws_live < 4
				then greatest(
					coalesce (demand_weekly_wo_min, 0),
					kc.start_level * sgc.default_level * coalesce(ksms.scale, 1.0) * kc.manual_multiplier * sgc.scale
					)
				else greatest(
					coalesce (demand_weekly_wo_min, 0),
					kc.min_level * sgc.default_level * coalesce(ksms.scale, 1.0) * kc.scale * kc.manual_multiplier * sgc.scale
					)
				end as decimal(4,2)) as wk_demand
			from  inm.pick_get_demand_weekly_wo_min() dwwom
				  left join inm.kiosk_control kc on dwwom.kiosk_id = kc.kiosk_id
				  left join inm.sku_group sg on dwwom.sku_group = sg.fc_title
				  left join inm.sku_group_control sgc on sgc.sku_group_id = sg.id
				  left join inm.kiosk_sku_group_manual_scale ksms on ksms.kiosk_id = dwwom.kiosk_id and ksms.sku_group_id = sg.id;
end;
$$;
CREATE FUNCTION inm_test.pick_check_restriction(_pick_date date) RETURNS TABLE(kiosk_id integer, product_id integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return restricted products found in allocation
*/
begin
	return query
		select a.kiosk_id, a.sku_id
			from (select * from inm_test.pick_allocation a where a.pick_date = _pick_date) a
				join inm.kiosk_product_disabled d on a.kiosk_id = d.kiosk_id and a.sku_id = d.product_id;
end;
$$;
CREATE FUNCTION public.shelf_life_bucket(integer) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT CASE WHEN ($1 <= 10) THEN ($1::text)
              WHEN ($1 <= 14) THEN ('11-14')
              WHEN ($1 <= 21) THEN ('15-21')
              ELSE ('21+') END
$_$;
ALTER FUNCTION public.shelf_life_bucket(integer) OWNER TO dbservice;
CREATE FUNCTION public.stockout_hours(text, text) RETURNS double precision
    LANGUAGE plperl IMMUTABLE
    AS $$
 return 10.5;
$$;
CREATE FUNCTION mixalot.pick_ticket(target_date date) RETURNS TABLE(pick_station bigint, vendor character varying, item_code bigint, item_name character varying, site_code bigint, site_name character varying, proposed_supply integer, total_pick_qty bigint, total_pick_sku integer, driver_name character varying, route_date date, route_time time without time zone, route_date_time timestamp without time zone, route_number character varying, restrictions text, address character varying, pull_date date, delivery_order integer, pick_order integer)
    LANGUAGE plpgsql
    AS $$
	declare latest_import_ts timestamp;
	declare plan_window_start timestamp;
	declare plan_window_stop timestamp;
begin
	select max(import_ts) from mixalot.inm_data into latest_import_ts;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Start'
		into plan_window_start;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Stop'
		into plan_window_stop;
	if target_date is null
		then target_date = plan_window_start::date;
	end if;
	return query
		select 
				p.pick_station, p.vendor, p.id, p.title ItemName,
				k.id sitecode, k.title sitename, a.qty proposed_supply, 
				sum(a.qty) over(partition by k.id, route.route_date) total_pick_qty,
				-1 total_pick_sku, 
				route.driver_name DriverName, route.route_date RouteDate, route.route_time RouteTime,
				route.route_date + route.route_time route_date_time, route.route_number,
				r.restrictions,
				k.address,
				pd.pull_date,
				cast(route.delivery_order as integer),
				spo.pick_order
			from mixalot.pick_allocation a 
				left join pantry.kiosk k on a.kiosk_id = k.id
				left join mixalot.inm_kiosk_restriction_list r on k.id = r.kiosk_id
				join pantry.product p on a.sku_id = p.id
				join mixalot.pick_route route on a.route_date=route.route_date and a.kiosk_id = route.kiosk_id
				left join mixalot.pull_date(plan_window_start, plan_window_stop) pd on a.kiosk_id = pd.kiosk_id
				left join mixalot.sku_pick_order(latest_import_ts) spo on p.id = spo.sku_id
			where k.campus_id = 87
			and a.pick_date = target_date;
end
$$;
CREATE FUNCTION mixalot.sku_pick_order(target_ts timestamp with time zone) RETURNS TABLE(sku_id integer, pick_order integer)
    LANGUAGE plpgsql
    AS $$
declare latest_import_ts timestamp with time zone;
/*
Purpose: return a sku pick_order for the most recent import data for a given date
*/
begin
	select max(import_ts) from mixalot.inm_data
		where import_ts <= target_ts and data_type = 'Warehouse SKU Inventory'
		into latest_import_ts;
	return query
		select distinct product_id, d.sort_order
		  from mixalot.inm_data d
		  where import_ts = latest_import_ts and data_type = 'Warehouse SKU Inventory';	
end;
$$;
CREATE FUNCTION pantry.hierarchy(givenid integer, initial integer) RETURNS TABLE(role_id integer, permission character varying, api character varying, isfrontend integer)
    LANGUAGE plpgsql
    AS $$ 
    DECLARE next_id INT;
    DECLARE cur1 REFCURSOR;
    DECLARE cur2 REFCURSOR;
BEGIN
    IF initial=1 THEN
 DROP TABLE IF EXISTS OUT_TEMP;
        CREATE TEMPORARY TABLE OUT_TEMP (role_id int, permission varchar(255), api varchar(255), isFrontend int);
    END IF;
    IF GivenID IS NULL then
        OPEN cur2 FOR SELECT id FROM pantry.role;
        LOOP
            FETCH cur2 INTO next_id;
     EXIT WHEN NOT FOUND;
            PERFORM pantry.Hierarchy(next_id, -1);
        END LOOP;
        CLOSE cur2;
    ELSE
        INSERT INTO OUT_TEMP(role_id, permission, api, isFrontend) (SELECT null, p.permission, p.api, p."isFrontend" FROM pantry.permission_mapping pm JOIN pantry.permission p ON p.id =pm.permission_id WHERE pm.role_id = GivenID);
        OPEN cur1 FOR SELECT rm.role_id FROM pantry.role_mapping rm WHERE parent_id = GivenID;
        LOOP
            FETCH cur1 INTO next_id;
            EXIT WHEN NOT FOUND;
            PERFORM pantry.Hierarchy(next_id, 0);
        END LOOP;
        CLOSE cur1;
    END IF;
    IF initial=-1 THEN
        UPDATE OUT_TEMP ot SET role_id = GivenID WHERE ot.role_id IS NULL;
    ELSEIF GivenID IS NULL THEN
        RETURN QUERY SELECT DISTINCT ot.role_id, ot.permission, ot.api, ot.isFrontend FROM OUT_TEMP ot;
 DROP TABLE OUT_TEMP;
    ELSEIF initial = 1 THEN
        RETURN QUERY SELECT DISTINCT ot.permission, ot.api, ot.isFrontend FROM OUT_TEMP;
 DROP TABLE OUT_TEMP;
    END IF;
END;
$$;
CREATE FUNCTION report.dependency_tree(search_pattern text) RETURNS TABLE(dependency_tree text)
    LANGUAGE sql SECURITY DEFINER
    AS $$
WITH target AS (
  SELECT objid, dependency_chain
  FROM report.dependency
  WHERE object_identity ~ search_pattern
)
, list AS (
  SELECT
    format('%*s%s %s', -4*level
          , CASE WHEN object_identity ~ search_pattern THEN '*' END
          , object_type, object_identity
    ) AS dependency_tree
  , dependency_sort_chain
  FROM target
  JOIN report.dependency report
    ON report.objid = ANY(target.dependency_chain) -- root-bound chain
    OR target.objid = ANY(report.dependency_chain) -- leaf-bound chain
  WHERE LENGTH(search_pattern) > 0
  UNION
  SELECT
    format('%*s%s %s', 4*level, '', object_type, object_identity) AS depedency_tree
  , dependency_sort_chain
  FROM report.dependency
  WHERE LENGTH(COALESCE(search_pattern,'')) = 0
)
SELECT dependency_tree FROM list
ORDER BY dependency_sort_chain;
$$;
CREATE FUNCTION pantry.fn_product_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 BEGIN
    INSERT INTO pantry.product_history (price, cost, start_time, end_time, product_id, campus_id)
    VALUES(NEW.price, NEW.cost, (SELECT date_part('epoch',CURRENT_TIMESTAMP)::int), NULL, NEW.id, NEW.campus_id);
RETURN NEW;
END;
$$;
CREATE FUNCTION rptg.non_byte_sales(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, order_id character varying, kiosk_id bigint, product_id bigint, time_bought timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/*
The following query is used to get all non byte kiosks. Unlike byte sales that is =
non free kiosks sale + free kiosk sales + free kiosk losses, non byte kiosks = all non byte kiosk
sales.
*/
SELECT  epc_ as epc,
    order_id_ as order_id,
    kiosk_id_ as kiosk_id,
    product_id_ as product_id,
    time_bought_ as time_bought,
    cost_ as cost,
    price_ as price
    FROM rptg.sales(beginning_date, ending_date)  gl
    WHERE kiosk_campus_id_ != 87
    AND product_campus_id_ != 87;
END;
$$;
CREATE FUNCTION beta.get_label_stats(start_date date, end_date date, product_list integer[], kiosk_list integer[]) RETURNS TABLE(label_epc character varying, label_total bigint, label_order_total bigint, label_order_sold_total bigint, history_total bigint, history_unique_order_total bigint, history_unique_kid_total bigint, history_min_ts timestamp without time zone, history_max_ts timestamp without time zone, history_last_kid bigint, spoilage_total bigint, byte_spoilage_total bigint, label_spoilage_total bigint, label_ok_total bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: compute label stats
Input: 
	start_date, end_date of label created
	list of kiosks
Return
	stats
*/
begin
	return query
		select t0.epc, coalesce(t1.label_total, 0), coalesce(t2.label_order_total, 0), coalesce(t3.label_order_sold_total, 0), coalesce(t4.history_total, 0),
		coalesce(t5.history_unique_order_total, 0), coalesce(t6.history_unique_kid_total, 0),
		cast(t7.history_min_ts as timestamp), cast(t7.history_max_ts as timestamp), coalesce(t8.history_last_kid, 0), coalesce(t9.spoilage_total, 0),
		coalesce(t10.byte_spoilage_total, 0), coalesce(t11.label_spoilage_total, 0), coalesce(t12.label_ok_total, 0)
		from
			(select distinct epc
				from pantry.label l
			 	join pantry.kiosk k on l.kiosk_id = k.id and k.campus_id = 87 and k.enable_reporting = 1
				where to_timestamp(time_added) between start_date and end_date
					and product_id in (select unnest(product_list))
			  		and kiosk_id in (select unnest(kiosk_list))
			)t0
		left join 
			(
			select epc, count(*) label_total 
				from pantry.label
				where to_timestamp(time_added) between start_date and end_date
			 	group by epc
			)t1 on t0.epc = t1.epc
		left join 
			(
			select epc, count(*) label_order_total 
				from pantry.label
				where to_timestamp(time_added) between start_date and end_date
				and order_id is not null 
			 	group by epc
			)t2 on t0.epc = t2.epc
		left join 
			(
			select epc, count(*) label_order_sold_total 
				from pantry.label
				where to_timestamp(time_added) between start_date and end_date
				and order_id is not null and status='sold'
			 	group by epc
			)t3 on t0.epc = t3.epc
		left join
			(select h.epc, count(*) history_total 
			 	from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
				join pantry.history h on l.epc = h.epc
				group by h.epc
			)t4  on t0.epc = t4.epc
		left join
			(select h.epc, count(distinct h.order_id) history_unique_order_total 
			 	from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
				join pantry.history h on l.epc = h.epc and h.order_id is not null
				group by h.epc
			)t5 on t0.epc = t5.epc
		left join
			(select h.epc, count(distinct h.kiosk_id) history_unique_kid_total 
				from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
				join pantry.history h on l.epc = h.epc and h.kiosk_id is not null
				group by h.epc
			)t6 on t0.epc = t6.epc
		left join
		(select h.epc, min(to_timestamp(time)) history_min_ts, max(to_timestamp(time)) history_max_ts
			from 
				(select distinct epc
					from pantry.label
					where to_timestamp(time_added) between start_date and end_date
				) l
			join pantry.history h on l.epc = h.epc
		 	group by h.epc
		)t7 on t0.epc = t7.epc
		left join
			(select h_disctinct_last_kid.epc, h_disctinct_last_kid.kiosk_id history_last_kid
				from 
					(select distinct epc
						from pantry.label
						where to_timestamp(time_added) between start_date and end_date
					) l
					join 
					(select distinct epc, kiosk_id
					 from
						(select epc, kiosk_id, to_timestamp(time) ts,
								rank() over (partition by epc order by time desc) r
						from pantry.history
						where to_timestamp(time) >= start_date and kiosk_id is not null
						) h_last_kid where r = 1) h_disctinct_last_kid
					on l.epc = h_disctinct_last_kid.epc
			)t8 on t0.epc = t8.epc
		left join
		(select s.epc, count(*) spoilage_total
			from
				(select distinct epc
					from pantry.label
					where to_timestamp(time_added) between start_date and end_date
				) l
				join pantry.spoilage s on l.epc = s.epc
				group by s.epc
		)t9 on t0.epc = t9.epc
		left join
		(select bs.epc, count(*) byte_spoilage_total
			from
				(select distinct epc
					from pantry.label
					where to_timestamp(time_added) between start_date and end_date
				) l 
			join public.byte_spoilage bs
				on l.epc = bs.epc
			group by bs.epc
		)t10 on t0.epc = t10.epc
		left join
		(select epc, count(*) label_spoilage_total
			from pantry.label
			where to_timestamp(time_added) between start_date and end_date
			and status = 'out' and order_id like 'RE%' group by 1
		)t11 on t0.epc = t11.epc
		left join
		(select epc, count(*) label_ok_total
			from pantry.label
			where to_timestamp(time_added) between start_date and end_date
			and status = 'ok' and order_id is null group by 1
		)t12 on t0.epc = t12.epc;
end;
$$;
CREATE FUNCTION beta.pick_audit(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, restocker text, product_id integer, pick_qty integer, restock_qty integer, discrepancy integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity of above product_id for the same route_date
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	set timezone to 'US/Pacific';
	return query
		select a.kiosk_id, a.route_date, r.restocker, a.sku_id, cast(sum(a.qty) as integer), 
			coalesce(cast(sum(l.total) as integer), 0), cast(coalesce(sum(l.total), 0) - sum(a.qty) as integer)
			from inm.pick_allocation a 
			left join 
				(select to_timestamp(time_created)::date restock_date, pantry.label.kiosk_id, pantry.label.product_id, count(*) total
					from pantry.label group by 1,2,3) l
					on a.route_date = l.restock_date and a.kiosk_id=l.kiosk_id and a.sku_id = l.product_id
			left join 
					(select distinct to_timestamp(created)::date route_date, o.kiosk_id, first_name || ' ' || last_name restocker from pantry.order o
						where order_id like 'RE%' and to_timestamp(created)::date between start_date and end_date + 1 order by 1,2) r
					on r.route_date = a.route_date and r.kiosk_id = a.kiosk_id
			where a.route_date between start_date and end_date
		group by 1, 2, 3, 4;
end;
$$;
CREATE FUNCTION pantry.fn_add_to_watch(label_id bigint, order_id character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$ 
BEGIN 
  INSERT INTO pantry.tmp_watcher
              ( 
                          label_id,
                          order_id,                           
                          created
              ) 
  VALUES (
  		label_id, order_id, (SELECT date_part('epoch',CURRENT_TIMESTAMP)::int)
  	);
END
$$;
CREATE FUNCTION inm_backup.pick_get_demand_weekly_wo_min_20190108() RETURNS TABLE(kiosk_id bigint, sku_group character varying, sample_size bigint, dt_avg numeric, dt_std numeric, w_departure_time numeric, preference numeric, pref_total numeric, ws_avg numeric, ws_std numeric, ws_live bigint, demand_weekly_wo_min numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM weekly demand without min by velocity
*/
begin
	return query
			select *,
	round((t7.preference/t7.pref_total)*(t7.ws_avg+t7.ws_std), 2) as demand_weekly_wo_min
from (
	select t4.kiosk_id,
		t4.sku_group,
		t4.sample_size,
		t4.dt_avg,
		t4.dt_std,
		t4.w_departure_time,
		t4.preference,
		sum(t4.preference) over (partition by t4.kiosk_id) as pref_total,
		t6.ws_avg,
		t6.ws_std,
		t6.ws_live
	from (
		select t3.kiosk_id, 
			t3.sku_group, 
			count(t3.purchase_index) as sample_size,
			round((avg(t3.departure_time))::numeric, 2) as dt_avg,
			coalesce(round((stddev(t3.departure_time))::numeric, 2), 0) as dt_std,
			round(sum(t3.departure_time*t3.w)/sum(t3.w)::numeric, 2) as w_departure_time,
			least(round(1.00/(sum(t3.departure_time*t3.w)/sum(t3.w))::numeric, 2), 0.20) as preference
		from (
			select *,
				greatest(coalesce(round((t2.time_sold - greatest(t2.last_sale, t2.time_stocked))::numeric/3600, 2), 50.00), 1.00) as departure_time,
				0 as qty_sold,
				1 as w
			from (
				select *,
					lag(t1.time_sold, 1) over (partition by t1.kiosk_id, t1.sku_group order by t1.time_sold) as last_sale,
					lag(t1.purchase_index, 1) over (partition by t1.kiosk_id, t1.sku_group order by t1.time_sold) as last_purchase_index
				from (
					select k.kiosk_id,
						p.sku_group,
						l.time_stocked,
						l.time_sold,
						l.purchase_index
					from (
						select k.id as kiosk_id
						from pantry.kiosk k
						where k.campus_id=87
							and k.archived=0
							and k.enable_reporting=1
					) k
					cross join (
						select distinct fc_title as sku_group
						from pantry.product p
						where p.campus_id=87
							and p.archived=0
							and p.fc_title is not null
							and p.fc_title!='N/A'
						order by p.fc_title asc
					) p
					left outer join (
						select l.kiosk_id as kiosk_id,
							p.fc_title as sku_group,
							l.time_created as time_stocked, 
							l.time_updated as time_sold,
							row_number() over (partition by l.kiosk_id order by l.time_updated) as purchase_index
						from pantry.label l
							join pantry.product p on l.product_id=p.id
						where l.kiosk_id is not null
							and l.status='sold'
							and to_timestamp(l.time_updated) at time zone 'US/Pacific' > date_trunc('week', current_timestamp) - interval '24 weeks'
							and p.campus_id=87
							and p.archived=0
							and p.fc_title is not null
					) l on k.kiosk_id=l.kiosk_id and p.sku_group=l.sku_group
					order by k.kiosk_id, p.sku_group, l.purchase_index
				) t1
			) t2
		) t3
		group by t3.kiosk_id, t3.sku_group
	) t4
	join 
	(select t5.kiosk_id, round(avg(units_sold), 2) ws_avg, round(stddev(units_sold), 2) ws_std, count(units_sold) ws_live
		from (
			SELECT concat(kk.kiosk_id::character varying(4), ' ', kk.woy) AS key,
				kk.kiosk_id,
				kk.woy,
				ss.units_sold
			FROM (
				SELECT k.id AS kiosk_id,
					generate_series(1, 52) AS woy
				FROM pantry.kiosk k
				WHERE k.campus_id = 87 AND k.archived = 0 AND k.enable_reporting = 1 AND k.enable_monitoring = 1) kk
			LEFT JOIN ( 
				SELECT s.kiosk_id,
					date_part('week'::text, s.ts) AS woy,
					count(*) AS units_sold
				FROM byte_epcssold_3months s
				GROUP BY s.kiosk_id, (date_part('week'::text, s.ts))) ss ON kk.kiosk_id = ss.kiosk_id AND kk.woy::double precision = ss.woy
			ORDER BY ss.kiosk_id, ss.woy) t5
		group by t5.kiosk_id
		order by t5.kiosk_id asc
	) t6 on t4.kiosk_id=t6.kiosk_id) t7;
end;
$$;
CREATE FUNCTION mixalot.plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, driver_name character varying, location_name character varying, next_delivery_ts timestamp with time zone, time_to_next_delivery interval, days_to_next_delivery double precision, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM plan kiosks for a pick window.
*/
begin
	return query
		select ds.kiosk_id, ds.route_date_time, ds.driver_name, ds.location_name, ps.next_delivery_ts,
		ps.next_delivery_ts - ds.route_date_time as time_to_next_delivery,		
		  case 
		  	when ps.next_delivery_ts - ds.route_date_time between interval '12 hours' and interval '24 hours' then 1
			else extract(day from ps.next_delivery_ts - ds.route_date_time)
			end as days_to_next_delivery,
		  row_number() over (order by ds.route_date_time asc) as delivery_order
		from
		(select t.kiosk_id, t.route_date_time, t.driver_name, t.location_name from
			(select location_number as kiosk_id, rs.route_date_time, rs.driver_name, rs.location_name,
				rank() over (partition by location_number order by rs.route_date_time) as r
				from mixalot.route_stop rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan winddow start
				and location_number > 0) t
				where r = 1) ds
		left join 
		(select t.kiosk_id, t.route_date_time next_delivery_ts from
			(select location_number as kiosk_id, rs.route_date_time,
				rank() over (partition by location_number order by rs.route_date_time) as r
				from mixalot.route_stop rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan window start
				and location_number > 0) t
				where r = 2) ps
			on ds.kiosk_id = ps.kiosk_id
			join pantry.kiosk k on ds.kiosk_id = k.id
			where ds.route_date_time between plan_window_start and plan_window_stop
			and k.campus_id= 87;	
end;
$$;
CREATE FUNCTION pantry.fn_discount_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE pantry.discount_history SET end_time = EXTRACT(epoch FROM NOW()) WHERE discount_id = OLD.id AND end_time IS NULL;
	INSERT INTO pantry.discount_history (kiosk_id, product_id, value, start_time, end_time, discount_id)
    VALUES(NEW.kiosk_id, NEW.product_id, NEW.value, EXTRACT(epoch FROM NOW()) + 1, NULL, NEW.id);
RETURN NEW;
END;
$$;
CREATE FUNCTION inm_backup.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_demand_qty numeric, plan_demand_qty numeric, plan_order_qty numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - return INM order based on sales ratio for pick sales period (time between deliveries)
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  week_demand_qty: demand based on once a week delivery (without minimum)
  plan_demand_qty: demand based on sales ratio for pick sales period (without minimum)
  plan_order_qty: order based on sales ratio for pick sales period
*/
begin
	return query
		select sr.kiosk_id, sr.route_date_time, sga.id, dwbv.fc_title, dwbv.demand_weekly as week_demand_qty, 
			cast(1.4 * sr.sales_ratio * dwbv.demand_weekly as numeric (8,2)) plan_demand_qty,
			case 
				when dwbv.demand_weekly = 0 or ksms.scale = 0.0 then 0 
				else
					least(
						least(greatest(ceiling(1.4 * sr.sales_ratio * dwbv.demand_weekly) + sga.minimum_kiosk_qty - coalesce(inv.count, 0),
											  0) /* change negative demand to 0 */
								   , sga.maximum_kiosk_qty),
						dwbv.demand_weekly)
			end as plan_order_qty -- end case
			from inm.pick_get_sales_period_ratio(start_ts, end_ts) sr
				join inm.pick_get_demand_weekly_by_velocity() dwbv
					on sr.kiosk_id = dwbv.kiosk_id 
				join inm.sku_group_attribute sga
					on sga.title = dwbv.fc_title			
				left join mixalot.inm_kiosk_projected_stock inv
					on dwbv.kiosk_id = inv.kiosk_id and dwbv.fc_title = inv.fc_title
				left join inm.kiosk_sku_group_manual_scale ksms
					on sr.kiosk_id = ksms.kiosk_id and sga.id = ksms.sku_group_id;				
	end;
$$;
CREATE FUNCTION pantry.fn_kiosk_audit_log_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF (
 NEW.archived != OLD.archived
 OR
 NEW.enable_reporting != OLD.enable_reporting
 OR
 NEW.enable_monitoring != OLD.enable_monitoring
) THEN
 INSERT INTO pantry.kiosk_audit_log (
    kiosk_id, archived, enable_reporting, enable_monitoring
 ) VALUES (
    OLD.id, NEW.archived, NEW.enable_reporting, NEW.enable_monitoring
);
END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION pantry.fn_product_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE pantry.product_history SET end_time = EXTRACT(epoch FROM NOW()) WHERE product_id = OLD.id AND end_time IS NULL;
RETURN NEW;
END;
$$;
CREATE FUNCTION rptg.byte_losses(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_updated timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/*
The following query is used to get non free kiosks and free kiosks lost. SEE
ENG-708. Non free kiosks losses = lost items. Since lost items are always counted as sold for free
free kiosks, Free kiosks losses = 0.
*/
SELECT epc_ as epc,
    kiosk_id_ as kiosk_id,
    product_id_ as product_id,
    time_updated_ as time_updated,
    cost_ as cost,
    price_ as price
    FROM rptg.losses(beginning_date, ending_date) gl
    JOIN pantry.kiosk k
    ON gl.kiosk_id_ = k.id
    WHERE subsidy_info != '100%'
    AND enable_reporting_ = 1
    AND kiosk_campus_id_ = 87
    AND product_campus_id_ = 87;
 END;
$$;
CREATE FUNCTION beta.pick_get_order_by_sales_4wk(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title character varying, plan_qty integer)
    LANGUAGE plpgsql ROWS 10000
    AS $$
/*
Purpose - return INM order for the next sale period which is the time between the deliveries of this pick and the next pick
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  plan_qty: order quantity for the above fc_title for the next sale period
*/
begin
	return query
		select four_weeks.kiosk_id, four_weeks.route_date_time, four_weeks.id, four_weeks.fc_title, cast (sum(qty) as integer)
		from
			(-- week -1
			select pk.kiosk_id, pk.route_date_time, sga.id, p.fc_title, count(*) qty
				from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					join pantry.product p on l.product_id = p.id
					left join inm.sku_group_attribute sga on sga.title = p.fc_title
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '7 days' and pk.next_delivery_ts - interval '7 days'
					group by 1,2,3,4
			union
			select pk.kiosk_id, pk.route_date_time, sga.id, p.fc_title, count(*) qty
				from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					join pantry.product p on l.product_id = p.id
					left join inm.sku_group_attribute sga on sga.title = p.fc_title
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '14 days' and pk.next_delivery_ts - interval '14 days'
					group by 1,2,3,4
			union
			select pk.kiosk_id, pk.route_date_time, sga.id, p.fc_title, count(*) qty
				from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					join pantry.product p on l.product_id = p.id
					left join inm.sku_group_attribute sga on sga.title = p.fc_title
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '21 days' and pk.next_delivery_ts - interval '21 days'
					group by 1,2,3,4
			union
			select pk.kiosk_id, pk.route_date_time, sga.id, p.fc_title, count(*) qty
				from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
					join pantry.label l on pk.kiosk_id=l.kiosk_id
					join pantry.product p on l.product_id = p.id
					left join inm.sku_group_attribute sga on sga.title = p.fc_title
					where l.status in ('out', 'sold') and to_timestamp(l.time_updated) between pk.route_date_time - interval '28 days' and pk.next_delivery_ts - interval '28 days'
					group by 1,2,3,4
				) four_weeks
				group by 1, 2, 3, 4;
	end;
$$;
CREATE FUNCTION mixalot.pick_get_delivery_schedule(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, driver_name character varying, route_date_time timestamp with time zone, location_name character varying, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM delivery schedule for a pick window.
*/
begin
	return query
		select pk.kiosk_id, r.driver_name, r.route_date_time, pk.location_name, pk.delivery_order
			from mixalot.route r join mixalot.pick_get_plan_kiosks(start_ts, end_ts) pk
				on r.route_date_time = pk.route_date_time and r.driver_name = pk.driver_name
				where r.route_date_time between start_ts and end_ts;
end;
$$;
CREATE FUNCTION pantry.fn_kiosk_audit_log_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO pantry.kiosk_audit_log (
    kiosk_id, archived, enable_reporting, enable_monitoring
) VALUES (
    NEW.id, NEW.archived, NEW.enable_reporting, NEW.enable_monitoring
);
RETURN NEW;
END;
$$;
CREATE FUNCTION rptg.spoils(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, order_id_ character varying, kiosk_id_ bigint, product_id_ bigint, time_updated_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/*
SPOIL QUERY From Art's logic: see ENG-834
For a given time window W1 (e.g. from beginning_date through ending_date) and an extended time
window W2, with W1 being a subset of W2 (e.g. W1 +1 and -1 month from beginning_date through
ending_date)
Spoil: count of unique epc’s which have at least one spoil label record within W1 and have no
sale record within W2.
A spoil label record has an order id which starts with RE and has an out status.
For a spoil label record to be within time window W1, the order creation time needs to be within W1.
*/
SELECT epc as epc_,
    order_id as order_id_,
    kiosk_id as kiosk_id_,
    product_id as product_id_,
    time_updated as time_updated_,
    cost as cost_,
    price as pice_,
    kiosk_campus_id as kiosk_campus_id_,
    product_campus_id as product_campus_id_,
    enable_reporting as enable_reporting_
    FROM (SELECT unique_epcs.epc as epc,
        order_id,
        kiosk_id,
        product_id,
        to_timestamp(all_epc_data. time_updated) as time_updated,
        cost,
        price,
        kiosk_campus_id,
        product_campus_id,
        enable_reporting
        FROM(SELECT epc,
            max(created) as time_updated
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
            JOIN pantry.order o
            ON o.order_id = l.order_id
            WHERE to_timestamp(created)::date >= beginning_date
            AND to_timestamp(created)::date <= ending_date
            AND l.status = 'out'
            AND l.order_id LIKE 'RE%'
            GROUP BY epc
        ) as unique_epcs
        /*
        This subquery is used to get the order_id, time the order was created, price and cost
        values for the distinct EPCs we selected in the subquery above.
        */
        LEFT JOIN (SELECT epc,
            l.product_id,
            l.order_id,
            o.created as time_updated,
            COALESCE(l.cost, ph.cost, p.cost,0) as cost,
            COALESCE(ph.price, l.price, p.price,0) as price,
            l.kiosk_id,
            k.campus_id as kiosk_campus_id,
            p.campus_id as product_campus_id,
            k.enable_reporting
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
            JOIN pantry.order o
            ON o.order_id = l.order_id
            AND to_timestamp(created)::date >= beginning_date
            AND to_timestamp(created)::date <= ending_date
            LEFT JOIN pantry.product_history ph ON ph.product_id = p.id
            AND o.created >= ph.start_time AND (ph.end_time IS NULL OR o.created <
            ph.end_time)
            AND l.status = 'out'
            AND l.order_id LIKE 'RE%'
        ) as all_epc_data
        ON unique_epcs.epc = all_epc_data.epc
        AND unique_epcs. time_updated = all_epc_data. time_updated
    ) as spoiled_data
    /*
    This subquery is used to eliminate any EPCs that were sold in W2
    (View first comment above to get details on W2)
    */
    WHERE epc NOT IN (SELECT epc
        FROM pantry.label l
        JOIN pantry.kiosk k
        ON k.id = l.kiosk_id
        JOIN pantry.product p
        ON p.id = l.product_id
        JOIN pantry.order o
        ON o.order_id = l.order_id
        WHERE to_timestamp(created)::date >= (SELECT beginning_date::date - INTERVAL '1 month')
        AND to_timestamp(created)::date <= (SELECT ending_date::date + INTERVAL '1 month')
        AND l.status = 'sold'
        AND l.order_id NOT LIKE 'RE%'
        AND l.order_id IS NOT NULL);
 END;
$$;
CREATE FUNCTION inm_backup.pick_get_demand_weekly_by_velocity_20190108() RETURNS TABLE(kiosk_id bigint, sku_group_id integer, fc_title text, demand_weekly numeric, kc_start_level numeric, kc_min_level numeric, kc_scale numeric, kc_manual_multiplier numeric, sgc_default_level numeric, sgc_scale numeric, ksms_scale numeric, ws_live bigint, velocity_demand numeric)
    LANGUAGE plpgsql
    AS $$
/*
Purpose: return INM weekly demand by velocity
*/
begin
	return query
		select cast(kc.kiosk_id as bigint) , sg.id, cast(sg.fc_title as text),
			cast(
				case when coalesce(dwwom.ws_live, 0) < 4
				then greatest(
					coalesce (demand_weekly_wo_min * coalesce(ksms.scale, 1.0) * kc.manual_multiplier * sgc.scale, 0),
					coalesce (kc.start_level * sgc.default_level * kc.manual_multiplier * sgc.scale, 0)
					)
				else greatest(
					coalesce (demand_weekly_wo_min * coalesce(ksms.scale, 1.0) * kc.manual_multiplier * sgc.scale, 0),
					coalesce (kc.min_level * sgc.default_level * coalesce(ksms.scale, 1.0) * kc.manual_multiplier * sgc.scale, 0)
					)
				end as decimal(4,2)) as wk_demand,
				kc.start_level, kc.min_level, kc.scale, kc.manual_multiplier, sgc.default_level, sgc.scale, coalesce(ksms.scale, 1.0) , coalesce(dwwom.ws_live, 0),
				dwwom.demand_weekly_wo_min
			from inm.sku_group sg
				cross join inm.kiosk_control kc
				left join inm.kiosk_sku_group_manual_scale ksms on ksms.kiosk_id=kc.kiosk_id and ksms.sku_group_id=sg.id
				left join inm.sku_group_control sgc on sgc.sku_group_id = sg.id
				left join inm.pick_get_demand_weekly_wo_min() dwwom on dwwom.kiosk_id = kc.kiosk_id and dwwom.sku_group = sg.fc_title;
end;
$$;
CREATE FUNCTION inm_backup.pick_get_ticket(target_date date) RETURNS TABLE(pick_station bigint, vendor character varying, item_code bigint, item_name character varying, site_code bigint, site_name character varying, proposed_supply integer, total_pick_qty bigint, total_pick_sku integer, driver_name character varying, route_date date, route_time time without time zone, route_date_time timestamp without time zone, route_number character varying, restrictions text, address character varying, pull_date date, delivery_order integer, pick_order integer)
    LANGUAGE plpgsql
    AS $$
	declare latest_import_ts timestamp;
	declare plan_window_start timestamp;
	declare plan_window_stop timestamp;
begin
	select max(import_ts) from mixalot.inm_data into latest_import_ts;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Start'
		into plan_window_start;
	select i.route_date from mixalot.inm_data i
		where import_ts = latest_import_ts and data_type = 'Plan Window Stop'
		into plan_window_stop;
	if target_date is null
		then target_date = plan_window_start::date;
	end if;
	return query
		select 
				p.pick_station, p.vendor, p.id, p.title ItemName,
				k.id sitecode, k.title sitename, a.qty proposed_supply, 
				sum(a.qty) over(partition by k.id, route.route_date) total_pick_qty,
				-1 total_pick_sku, route.driver_name DriverName,
				route.route_date RouteDate, route.route_time RouteTime,
				route.route_date + route.route_time route_date_time, route.route_number,
				r.restrictions,
				k.address,
				pd.pull_date,
				cast(route.delivery_order as integer),
				spo.pick_order
			from inm.pick_allocation a 
				left join pantry.kiosk k on a.kiosk_id = k.id
				left join inm.kiosk_restriction_list r on k.id = r.kiosk_id
				join pantry.product p on a.sku_id = p.id
				join inm.pick_route route on a.pick_date=route.pick_date and a.route_date = route.route_date and a.kiosk_id = route.kiosk_id
				left join inm.get_pull_date(plan_window_start, plan_window_stop) pd on a.kiosk_id = pd.kiosk_id
				left join mixalot.sku_pick_order(latest_import_ts) spo on p.id = spo.sku_id
			where k.campus_id = 87
			and a.pick_date = target_date;
end
$$;
CREATE FUNCTION pantry.fn_discount_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE pantry.discount_history 
SET end_time = (SELECT date_part('epoch',CURRENT_TIMESTAMP)::int) 
WHERE discount_id = OLD.id AND end_time IS NULL;
RETURN NEW;
END;
$$;
CREATE FUNCTION beta.compare_pick_vs_delivery(start_date date, end_date date DEFAULT NULL::date) RETURNS TABLE(kiosk_id integer, route_date date, restocker text, product_id integer, pick_qty integer, restock_qty integer, discrepancy integer)
    LANGUAGE plpgsql
    AS $$
/*
Purpose - compare pick to restock
Input - 
	start_date: first pick date to consider
	end_date: last pick date to consider. If not given, compute the result for only start_date
Output - 
	kiosk_id: id for kiosk
	route_date: delivery date
	kiosk_title: kiosk name
	product_id: what picked/allocated
	pick_qty: quantity above product_id picked
	restock_qty: quantity of above product_id for the same route_date
	discrepancy: restock_qty - pick_quantity for target_date  
*/
declare target_date date;
declare pick_window_start timestamp with time zone;
declare pick_window_end timestamp with time zone;
begin
	set timezone to 'US/Pacific';
	return query
		select a.kiosk_id, a.route_date, r.restocker, a.sku_id, cast(sum(a.qty) as integer), 
			coalesce(cast(sum(l.total) as integer), 0), cast(coalesce(sum(l.total), 0) - sum(a.qty) as integer)
			from inm.pick_allocation a 
			left join 
				(select to_timestamp(time_created)::date restock_date, pantry.label.kiosk_id, pantry.label.product_id, count(*) total
					from pantry.label group by 1,2,3) l
					on a.route_date = l.restock_date and a.kiosk_id=l.kiosk_id and a.sku_id = l.product_id
			left join 
					(select distinct to_timestamp(created)::date route_date, o.kiosk_id, first_name || ' ' || last_name restocker from pantry.order o
						where order_id like 'RE%' and to_timestamp(created)::date between start_date and end_date + 1 order by 1,2) r
					on r.route_date = a.route_date and r.kiosk_id = a.kiosk_id
			where a.route_date between start_date and end_date
		group by 1, 2, 3, 4;
end;
$$;
CREATE FUNCTION inm_beta.pick_get_sales_period_ratio_4wks(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sales_ratio numeric)
    LANGUAGE plpgsql ROWS 10000
    AS $$
/*
Purpose - return INM the ratio of the next sale period(time between the deliveries of this pick and the next pick) vs sales for the week
Input -
  start_ts: plan window start date time with time zone
  end_ts: plan window end date time with time zone
Return -
  kiosk_id: together with route_date_time is unique for the plan window
  route_date_time: route starting date time
  fc_title: sku group name
  plan_qty: order quantity for the above fc_title for the next sale period
*/
begin	
	return query
		select scheduled_kiosks.kiosk_id, scheduled_kiosks.route_date_time, coalesce(existing_kiosk_with_sales_ratio.ratio, 1.0/3.0)
			from inm.pick_get_plan_kiosk(start_ts, end_ts) scheduled_kiosks -- all the kiosks on route
				left join -- kiosks with sales history
					(
					select whole_4_weeks.kiosk_id, whole_4_weeks.route_date_time, 
						case when whole_4_weeks.qty < 5 then 1.0/3.0 -- new kiosk, assume period sale is 1/3 of total week
							else cast(period_4_weeks.qty as decimal)/cast(whole_4_weeks.qty as decimal)
							end ratio		
					from
						(select pk.kiosk_id, pk.route_date_time, count(*) qty 
							from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
								join pantry.label l on pk.kiosk_id=l.kiosk_id
								where l.status in ('out', 'sold')
									and to_timestamp(l.time_updated) between
										pk.next_delivery_ts - interval '35 days'
										and pk.next_delivery_ts - interval '7 days'
							group by 1, 2
						 ) whole_4_weeks
						join 
						(
						select pk.kiosk_id, pk.route_date_time, count(*) qty
							from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
								join pantry.label l on pk.kiosk_id=l.kiosk_id
								where l.status in ('out', 'sold') and 
									(to_timestamp(l.time_updated) between pk.route_date_time - interval '7 days' + interval '4 hours' and pk.next_delivery_ts - interval '7 days'  + interval '4 hours' or
									 to_timestamp(l.time_updated) between pk.route_date_time - interval '14 days'  + interval '4 hours' and pk.next_delivery_ts - interval '14 days'  + interval '4 hours' or
									 to_timestamp(l.time_updated) between pk.route_date_time - interval '21 days'  + interval '4 hours' and pk.next_delivery_ts - interval '21 days'  + interval '4 hours' or
									 to_timestamp(l.time_updated) between pk.route_date_time - interval '28 days'  + interval '4 hours' and pk.next_delivery_ts - interval '28 days' + interval '4 hours')
								group by 1, 2
							) period_4_weeks
						on whole_4_weeks.kiosk_id = period_4_weeks.kiosk_id
					 ) existing_kiosk_with_sales_ratio 
				on scheduled_kiosks.kiosk_id = existing_kiosk_with_sales_ratio.kiosk_id and scheduled_kiosks.route_date_time = existing_kiosk_with_sales_ratio.route_date_time;
	end;
$$;
CREATE FUNCTION pantry.fn_kiosk_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF (NEW.archived <> OLD.archived OR NEW.campus_id <> OLD.campus_id) THEN
      UPDATE pantry.ro_order roo        
      SET campus_id = k.campus_id, 
      archived = 
      	CASE WHEN (k.archived = 1 OR o.archived = 1) 
      		THEN 1 
      		ELSE 0 
      	END
      FROM pantry.kiosk k, pantry.order o
      WHERE k.id = NEW.id AND roo.order_id = o.order_id AND k.id = roo.kiosk_id;
    END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION pantry.fn_audit_kiosk_attribute() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
   IF (TG_OP = 'INSERT') THEN
       INSERT INTO pantry.history_kiosk_attribute(kiosk_id,gad_id,value,time_modified,action)
       VALUES(NEW.kiosk_id, NEW.key_id, NEW.value, now(),'INSERT');
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       INSERT INTO pantry.history_kiosk_attribute(kiosk_id,gad_id,value,time_modified,action)
       VALUES(NEW.kiosk_id, NEW.key_id, NEW.value, now(),'UPDATE');
       RETURN NEW;
   ELSEIF (TG_OP = 'DELETE') THEN
       INSERT INTO pantry.history_kiosk_attribute(kiosk_id,gad_id,value,time_modified,action)
       VALUES(OLD.kiosk_id, OLD.key_id, OLD.value, now(),'DELETE');
       RETURN OLD;
   END IF;
   RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$$;
CREATE FUNCTION pantry.fn_label_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF (OLD.order_id IS NOT NULL OR NEW.order_id IS NOT NULL) THEN
      IF NEW.order_id = OLD.order_id THEN
        IF NEW.price <> OLD.price THEN
          PERFORM pantry.fn_add_to_watch(NEW.id, NEW.order_id);
        END IF;
      ELSE
        IF NEW.order_id IS NOT NULL THEN
          PERFORM pantry.fn_add_to_watch(NEW.id, NEW.order_id);
        END IF;
        IF OLD.order_id IS NOT NULL THEN
          PERFORM pantry.fn_add_to_watch(NEW.id, OLD.order_id);
        END IF;
      END IF;
    END IF;
RETURN NEW;
END;
$$;
CREATE FUNCTION rptg.losses(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, kiosk_id_ bigint, product_id_ bigint, time_updated_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/*
LOST QUERY From Art's logic: ENG-834
For a given time window W1 (e.g. from beginning_date through ending_date) and an extended time
window W2, with W1 being a subset of W2 (e.g. W1 +1 and -1 month from beginning_date through
ending_date)
Loss: count of unique epc’s which have at least one out label record within W1 and have no sale,
spoil, or inventory records within W2.
An out label record has no order id and has a status of out. For a out label record to be within
time window W1, the label update time needs to be within W1.
*/
SELECT epc as epc_,
        kiosk_id as kiosk_id_,
        product_id as product_id_,
        time_updated as time_updated_,
        cost as cost_,
        price as price_,
        kiosk_campus_id as kiosk_campus_id_,
        product_campus_id as product_campus_id_,
        enable_reporting as enable_reporting_
        FROM (SELECT unique_epcs.epc,
        to_timestamp(all_epc_data.time_updated) as time_updated,
        cost,
        price,
        kiosk_id,
        product_id,
        kiosk_campus_id,
        product_campus_id,
        enable_reporting
        FROM(SELECT epc,
            max(time_updated) as time_updated
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
            WHERE to_timestamp(time_updated)::date >= beginning_date
            AND to_timestamp(time_updated)::date <= ending_date
            AND l.status = 'out'
            AND l.order_id IS NULL
            GROUP BY epc
        ) as unique_epcs
        /*
        This subquery is used to get the price and cost values for the distinct EPCs we selected
        in the subquery above.
        */
        LEFT JOIN (SELECT epc,
            l.product_id,
            l.time_updated as time_updated,
            COALESCE(l.cost, ph.cost, p.cost,0) as cost,
            COALESCE(ph.price, l.price, p.price,0) as price,
            l.kiosk_id,
            k.campus_id as kiosk_campus_id,
            p.campus_id as product_campus_id,
            k.enable_reporting
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
            LEFT JOIN pantry.product_history ph ON ph.product_id = p.id
            AND l.time_updated >= ph.start_time AND (ph.end_time IS NULL OR l.time_updated <
            ph.end_time)
            AND to_timestamp(time_updated)::date >= beginning_date
            AND to_timestamp(time_updated)::date <= ending_date
            AND l.status = 'out'
            AND l.order_id IS NULL
        ) as all_epc_data
        ON unique_epcs.epc = all_epc_data.epc
        AND unique_epcs.time_updated = all_epc_data.time_updated
    ) as lost_data
    /*
    This subquery is used to eliminate any EPCs that were sold in W2
    (View first comment above to get details on W2)
    */
    WHERE EPC NOT IN (SELECT epc
        FROM pantry.label l
        JOIN pantry.kiosk k
        ON k.id = l.kiosk_id
        JOIN pantry.product p
        ON p.id = l.product_id
        JOIN pantry.order o
        ON o.order_id = l.order_id
        WHERE to_timestamp(created)::date >= (SELECT beginning_date::date - INTERVAL '1 month')
        AND to_timestamp(created)::date <= (SELECT ending_date::date + INTERVAL '1 month')
        AND l.status = 'sold'
        AND l.order_id NOT LIKE 'RE%'
        AND l.order_id IS NOT NULL)
    /*
    This subquery is used to eliminate any EPCs that were spoiled in W2
    (View first comment above to get details on W2)
    */
    AND EPC NOT IN (SELECT epc
        FROM pantry.label l
        JOIN pantry.kiosk k
        ON k.id = l.kiosk_id
        JOIN pantry.product p
        ON p.id = l.product_id
        JOIN pantry.order o
        ON o.order_id = l.order_id
        WHERE to_timestamp(created)::date >= (SELECT beginning_date::date - INTERVAL '1 month')
        AND to_timestamp(created)::date <= (SELECT ending_date::date + INTERVAL '1 month')
        AND l.status = 'out'
        AND l.order_id LIKE 'RE%')
    /*
    This subquery is used to eliminate any EPCs that are currently in the kiosk
    */
    AND EPC NOT IN (SELECT epc
        FROM pantry.label l
        JOIN pantry.kiosk k
        ON k.id = l.kiosk_id
        JOIN pantry.product p
        ON p.id = l.product_id
        AND l.status = 'ok'
        AND l.order_id IS NULL);
 END;
$$;
CREATE FUNCTION mixalot.set_sequence_val_max(schema_name name, table_name name DEFAULT NULL::name, raise_notice boolean DEFAULT false) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    row_data RECORD;
    sql_code TEXT;
BEGIN
    IF ((SELECT COUNT(*) FROM pg_namespace WHERE nspname = schema_name) = 0) THEN
        RAISE EXCEPTION 'The schema "%" does not exist', schema_name;
    END IF;
    FOR sql_code IN
        SELECT 'SELECT SETVAL(' ||quote_literal(N.nspname || '.' || S.relname)|| ', MAX(' ||quote_ident(C.attname)|| ') ) FROM ' || quote_ident(N.nspname) || '.' || quote_ident(T.relname)|| ';' AS sql_code
            FROM pg_class AS S
            INNER JOIN pg_depend AS D ON S.oid = D.objid
            INNER JOIN pg_class AS T ON D.refobjid = T.oid
            INNER JOIN pg_attribute AS C ON D.refobjid = C.attrelid AND D.refobjsubid = C.attnum
            INNER JOIN pg_namespace N ON N.oid = S.relnamespace
            WHERE S.relkind = 'S' AND N.nspname = schema_name AND (table_name IS NULL OR T.relname = table_name)
            ORDER BY S.relname
    LOOP
        IF (raise_notice) THEN
            RAISE NOTICE 'sql_code: %', sql_code;
        END IF;
        EXECUTE sql_code;
    END LOOP;
END;
$$;
CREATE FUNCTION public.fmt_ts(timestamp with time zone) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT to_char($1, 'YYYY-MM-DD HH24:MI');
$_$;
ALTER FUNCTION public.fmt_ts(timestamp with time zone) OWNER TO dbservice;
CREATE FUNCTION public.fmt_ts_mmdd(timestamp with time zone) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT to_char($1, 'MM-DD HH24:MI');
$_$;
ALTER FUNCTION public.fmt_ts_mmdd(timestamp with time zone) OWNER TO dbservice;
CREATE FUNCTION public.frac(numeric, numeric) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$
 SELECT if( $1::float + $2::float > 0.0, $1::float / ($1::float + $2::float), 0.0::float)
$_$;
ALTER FUNCTION public.frac(numeric, numeric) OWNER TO dbservice;
CREATE FUNCTION public.get_sum(a numeric, b numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN a + b;
END; $$;
ALTER FUNCTION public.get_sum(a numeric, b numeric) OWNER TO dbservice;
CREATE FUNCTION public.hash_to_bigint(hexval character varying) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    result  bigint;
BEGIN
    EXECUTE 'SELECT x''' || hexval || '''::bigint' INTO result;
    RETURN result;
END;
$$;
CREATE FUNCTION public.if(boolean, anyelement, anyelement) RETURNS anyelement
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT CASE WHEN ($1) THEN ($2) ELSE ($3) END
$_$;
ALTER FUNCTION public.if(boolean, anyelement, anyelement) OWNER TO dbservice;
CREATE FUNCTION public.int_hash(text) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$
 SELECT abs(('x'||substr(md5($1),1,8))::bit(32)::int);
$_$;
ALTER FUNCTION public.int_hash(text) OWNER TO dbservice;
CREATE FUNCTION public.interval_hours(interval) RETURNS numeric
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT ((extract(hour from (60 * $1))+extract(day from 24 * 60 * $1))/60.0)::numeric(6,2);
$_$;
ALTER FUNCTION public.interval_hours(interval) OWNER TO dbservice;
CREATE FUNCTION public.is_older_software_version(source_version text, target_version text) RETURNS boolean
    LANGUAGE sql
    AS $$
  select string_to_array(source_version, '.')::int[] < string_to_array(target_version, '.')::int[];
$$;
CREATE FUNCTION rptg.restocks(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, kiosk_id_ bigint, product_id_ bigint, time_added_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
/* Restock is a count of unique epcs based on time_created*/
SELECT epc as epc_,
    kiosk_id as kiosk_id_,
    product_id as product_id_,
    time_added as time_added_ ,
    cost as cost_,
    price as price_,
    kiosk_campus_id as kiosk_campus_id_,
    product_campus_id as product_campus_id_,
    enable_reporting as enable_reporting_
    FROM (SELECT unique_epcs.epc,
        kiosk_id,
        product_id,
        to_timestamp(all_epc_data.time_created) as time_added,
        cost,
        price,
        kiosk_campus_id,
        product_campus_id,
        enable_reporting
        FROM(SELECT epc,
            max(time_created) as time_created
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
            WHERE to_timestamp(time_created)::date >= beginning_date
            AND to_timestamp(time_created)::date <= ending_date
            GROUP BY epc
        ) as unique_epcs
        /*
        This subquery is used to get the price and cost values for the distinct EPCs we selected
        in the subquery above.
        */
        LEFT JOIN (SELECT epc,
            l.product_id,
            l.time_created as time_created,
            p.cost,
            p.price,
            l.kiosk_id,
            k.campus_id as kiosk_campus_id,
            p.campus_id as product_campus_id,
            k.enable_reporting
            FROM pantry.label l
            JOIN pantry.kiosk k
            ON k.id = l.kiosk_id
            JOIN pantry.product p
            ON p.id = l.product_id
        ) as all_epc_data
        ON unique_epcs.epc = all_epc_data.epc
        AND unique_epcs. time_created = all_epc_data.time_created
    ) as restocks;
 END;
$$;
ALTER FUNCTION public.pick_get_next_delivery(target_date date) OWNER TO dbservice;
ALTER FUNCTION rptg.non_byte_losses(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION rptg.sales(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION inm_test.test_demand(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_audit_kiosk_attribute() OWNER TO dbservice;
ALTER FUNCTION public.is_older_software_version(source_version text, target_version text) OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_delivery_schedule(target_date date) OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_allocation_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_kiosk_status_insert() OWNER TO dbservice;
ALTER FUNCTION beta.compare_pick_vs_delivery(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_discount_delete() OWNER TO dbservice;
ALTER FUNCTION inm_test.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_kiosk_update() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_order_insert() OWNER TO dbservice;
ALTER FUNCTION public.f_nr_stockout_minutes(ts timestamp with time zone, kiosk_restock_ts timestamp with time zone, hour_start timestamp with time zone, hour_end timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION beta.get_label_stats(start_date date, end_date date, product_list integer[], kiosk_list integer[]) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_card_insert() OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_plan_kiosk_bringg(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_test.compare_pick_vs_delivery(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_audit_campus_attribute() OWNER TO dbservice;
ALTER FUNCTION rptg.byte_sales(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION beta.get_label_stats_v0(start_date date, end_date date, product_list integer[]) OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_ticket(target_date date) OWNER TO dbservice;
ALTER FUNCTION inm.get_performance_pull_list(given_kiosk_id integer) OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_get_delivery_schedule(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_label_delete() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_audit_kiosk_service_version() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_product_delete() OWNER TO dbservice;
ALTER FUNCTION rptg.pick_audit(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION inm_test.pick_inventory_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_add_to_watch(label_id bigint, order_id character varying) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_discount_insert() OWNER TO dbservice;
ALTER FUNCTION beta.pick_get_delivery_schedule_optimo(target_date date) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_campus_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_kiosk_audit_log_update() OWNER TO dbservice;
ALTER FUNCTION beta.pick_audit(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION inm_test.pick_check_restriction(_pick_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_spoilage_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.get_permissions(a integer) OWNER TO dbservice;
ALTER FUNCTION public.user_retention_by_week(n integer) OWNER TO dbservice;
ALTER FUNCTION rptg.restocks(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_product_update() OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_summary(target_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_discount_update() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_label_update() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_product_stats_by_kiosk() OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_sales_period_ratio_4wks(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_ticket(target_date date) OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_demand_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_kiosk_audit_log_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_ro_order_update_full_price(orderid character varying) OWNER TO dbservice;
ALTER FUNCTION public.hash_to_bigint(hexval character varying) OWNER TO dbservice;
ALTER FUNCTION public.hex_to_int(hexval character varying) OWNER TO dbservice;
ALTER FUNCTION beta.compare_pick_vs_delivery_test(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.hierarchy(givenid integer, initial integer) OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_plan_kiosk_disabled_product(pick_date date) OWNER TO dbservice;
ALTER FUNCTION inm_test.pick_get_plan_demand(allocation_factor numeric, start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_test.pick_get_plan_demand_w_manual(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION util.fix_orders_using_request_log() OWNER TO dbservice;
ALTER FUNCTION beta.pick_get_order_by_sales_4wk_avg(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION fnrenames.fn_ro_order_update_full_price(orderid character varying) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_demand_weekly_by_velocity() OWNER TO dbservice;
ALTER FUNCTION public.user_retention_by_month(n integer) OWNER TO dbservice;
ALTER FUNCTION report.dependency_tree(search_pattern text) OWNER TO dbservice;
ALTER FUNCTION beta.compare_pick_vs_delivery_by_sku(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION inm.pick_get_delivery_schedule_optimo(target_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.kiosk_guardrails_ssl_cert_bytetech_co() OWNER TO dbservice;
ALTER FUNCTION inm.sync_restriction_by_property(kiosk_id integer, restriction character varying) OWNER TO dbservice;
ALTER FUNCTION inm_test.pick_get_order_with_sales_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION fnrenames.fn_kiosk_audit_log_update() OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_get_summary(target_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_label_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_order_update() OWNER TO dbservice;
ALTER FUNCTION rptg.spoils(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION beta.compare_pick_vs_delivery_ignore_null(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION mixalot.set_sequence_val_max(schema_name name, table_name name, raise_notice boolean) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_get_gsheets_plan_demand(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_order_with_sales_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_audit_global_attribute_def() OWNER TO dbservice;
ALTER FUNCTION beta.sku_pick_order(target_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION mixalot.backup_pick_allocation(target_pick_date date) OWNER TO dbservice;
ALTER FUNCTION mixalot.plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION util.extract_request_log_epc_order(target_kiosk_id integer, report_start timestamp without time zone, report_end timestamp without time zone) OWNER TO dbservice;
ALTER FUNCTION fnrenames.fn_kiosk_audit_log_insert() OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_demand_weekly_wo_min_20190108() OWNER TO dbservice;
ALTER FUNCTION beta.pick_get_order_by_sales_4wk(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION fnrenames.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm.allocation_ratio_by_sku_group_test(target_date date) OWNER TO dbservice;
ALTER FUNCTION rptg.non_byte_sales(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION beta.compare_pick_vs_delivery_v3(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION inm.get_all_pull_list(given_kiosk_id integer) OWNER TO dbservice;
ALTER FUNCTION public.stockout_hours(text, text) OWNER TO dbservice;
ALTER FUNCTION rptg.byte_losses(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_product_insert() OWNER TO dbservice;
ALTER FUNCTION pantry.key_loc_lookup(param_kiosk_id bigint, key_name character varying) OWNER TO dbservice;
ALTER FUNCTION inm_beta.pick_get_demand_weekly_wo_min() OWNER TO dbservice;
ALTER FUNCTION beta.compare_pick_vs_delivery_v2(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION rptg.losses(beginning_date date, ending_date date) OWNER TO dbservice;
ALTER FUNCTION mixalot.pick_get_plan_demand(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION public.set_sequence_val_max(schema_name name, table_name name, raise_notice boolean) OWNER TO dbservice;
ALTER FUNCTION beta.bringg_vs_optimo_delta(start_date date, end_date date) OWNER TO dbservice;
ALTER FUNCTION beta.pick_get_order_by_sales_4wks_availability(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm.pick_get_plan_kiosk_bringg(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_demand_weekly_by_velocity() OWNER TO dbservice;
ALTER FUNCTION inm_backup.pick_get_demand_weekly_by_velocity_20190108() OWNER TO dbservice;
ALTER FUNCTION mixalot.sku_pick_order(target_ts timestamp with time zone) OWNER TO dbservice;
ALTER FUNCTION pantry.fn_audit_kiosk_device() OWNER TO dbservice;
ALTER FUNCTION pantry.fn_ro_order_set_order(orderid character varying) OWNER TO dbservice;
ALTER FUNCTION public.monthly_infographic_data(yyyy_mm text) OWNER TO dbservice;
ALTER FUNCTION beta.test_insert(n integer, m integer, OUT submitted_data integer) OWNER TO dbservice;
ALTER FUNCTION inm.allocation_ratio_by_sku_group(target_date date) OWNER TO dbservice;