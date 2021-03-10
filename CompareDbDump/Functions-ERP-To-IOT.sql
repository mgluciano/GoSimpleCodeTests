
CREATE FUNCTION inm.pick_check_duplicate_stop() RETURNS TABLE(kiosk_id integer, driver_name character varying, order_number character varying, route_date_time timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose: return duplicate stops present in table route_stop for route stop from present day forward
    */
begin
  set timezone to 'US/Pacific';
  return query
    select s.location_number, s.driver_name, s.order_number, s.route_date_time
    from mixalot.route_stop s
       join
         (select rs.route_date_time, rs.location_number, count(*) from mixalot.route_stop rs
          where rs.route_date_time::date >= current_date and location_number <> -1
          group by 1,2 having count(*) > 1) d
       on s.location_number=d.location_number and s.route_date_time=d.route_date_time;
end;
$$;
CREATE FUNCTION pantry.get_label_order_epc() RETURNS TABLE(id bigint, title character varying, epc text)
    LANGUAGE plpgsql
    AS $$
declare
PREFIX text := '0000';
LOCATIONS text := '01';
begin
  /*
    Returns tag order data used for printing:
    - sku
    - product name
    - epc
  */
  return query
  select
    p.id,
    p.title,
    PREFIX || l.product_id || LOCATIONS || l.time_order || to_char(generator.id, 'fm0000') as epc
  from pantry.product as p, pantry.label_order as l, generate_series(1, l.amount) as generator(id)
where p.id = l.product_id and l.status = 'Scheduled' and p.archived = 0;
end;
$$;
CREATE FUNCTION dw.insert_in_monthly_kiosk_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $_$
    BEGIN
        INSERT INTO dw.fact_monthly_kiosk_summary(
            campus_id,
            kiosk_id,
            date_id,
            fee_plan_name,
            prepaid_number_of_months,
            prepaid_until,
            licensing_subscription_fee,
            tag_price,
            payment_processing_rate,
            sales_list_price,
            sales_after_discount,
            food_cost,
            credit_card ,
            freedom_pay,
            complimentary,
            monthly_lease,
            payment_processing_fee,
            connectivity_fee,
            manual_adjustment,
            details
        )
        (SELECT distinct monthly_report.campus_id,
            monthly_report.kiosk_id,
            monthly_report.date_id,
            monthly_report.fee_plan_name,
            monthly_report.prepaid_number_of_months,
            monthly_report.prepaid_until,
            monthly_report.licensing_subscription_fee,
            monthly_report.tag_price,
            monthly_report.payment_processing_rate,
            monthly_report.sales_list_price,
            monthly_report.sales_after_discount,
            monthly_report.food_cost,
            monthly_report.credit_card ,
            monthly_report.freedom_pay,
            monthly_report.complimentary,
            monthly_report.monthly_lease,
            monthly_report.payment_processing_fee,
            monthly_report.connectivity_fee,
            monthly_report.manual_adjustment,
            monthly_report.details
            FROM (SELECT
                kiosks.campus_id,
                kiosks.kiosk_id,
                TO_CHAR(date_trunc('month', month_date::date)::date, 'YYYYMMDD')::int AS date_id,
                fee_plan_name,
                prepaid_number_of_months,
                prepaid_until,
                licensing_subscription_fee,
                tag_price,
                payment_processing_rate,
                COALESCE(amount_list_price, 0) as sales_list_price,
                COALESCE(sales_after_discount, 0) as sales_after_discount,
                COALESCE(food_cost, 0) as food_cost,
                COALESCE(ip_commerce, 0) as credit_card ,
                COALESCE(freedom_pay, 0) as freedom_pay,
                COALESCE(complimentary, 0) as complimentary,
                COALESCE(monthly_lease, 0) as monthly_lease,
                COALESCE(ROUND((ip_commerce * fee_ipc)::numeric, 2), 0) as payment_processing_fee,
                COALESCE(connectivity, 0) as connectivity_fee,
                COALESCE(manual_adjustment, 0) as manual_adjustment,
                details
                FROM (SELECT id as kiosk_id,
                    campus_id
                    FROM pantry.kiosk
                ) as kiosks
                LEFT JOIN (SELECT campus_id,
                    kiosk_id,
                    SUM(sales_amt) as amount_list_price,
                    SUM(cost_amt) as food_cost,
                    SUM(ip_commerce) as ip_commerce,
                    SUM(freedom_pay)  as freedom_pay,
                    SUM(complimentary) as complimentary,
                    SUM(sales_after_discount) as sales_after_discount
                    FROM dw.fact_daily_kiosk_sku_summary daily
                    JOIN dw.dim_date as dd
                    ON dd.date_id = daily.date_id
                    WHERE as_date >= date_trunc('month', month_date::date)::date
                    AND as_date <= (date_trunc('month', month_date::date) + interval '1 month'
                        -  interval '1 day' )::date
                    GROUP BY kiosk_id, campus_id
                ) as amount_list_price
                ON kiosks.kiosk_id = amount_list_price.kiosk_id
                LEFT JOIN (SELECT kiosk_id,
                    campus_id,
                    sum(sum) as manual_adjustment,
                    STRING_AGG( CASE WHEN sum IS NOT NULL
                        THEN CONCAT(
                            CASE WHEN SIGN(SUM) = 1
                                THEN CONCAT('$', SUM)
                                WHEN SIGN(SUM) = -1
                                THEN CONCAT('-$', -SUM)
                                END,
                            ' ',
                            reason,
                            ' (for kiosk "', k.title, '")') END
                        , ' | ' ) as details
                    FROM pantry.manual_adjustment ma
                    JOIN pantry.kiosk k
                    ON ma.kiosk_id = k.id
                    WHERE date = TO_CHAR(date_trunc('month', month_date::date) + interval '1' day,
                        'YYYY-MM-fmDD')
                    AND ma.archived = 0
                    GROUP BY campus_id, kiosk_id
                ) as manual_adjust
                ON manual_adjust.kiosk_id = kiosks.kiosk_id
                LEFT JOIN (SELECT deployed_kiosks.kiosk_id,
                    deployed_kiosks.campus_id,
                    COALESCE(monthly_lease, 0) as monthly_lease,
                    COALESCE(connectivity, 0) as connectivity
                    FROM (SELECT id as kiosk_id,
                        campus_id
                        FROM pantry.kiosk
                        WHERE to_timestamp(deployment_time)::date <=
                        (date_trunc('month', month_date) + interval '1 month'
                            - interval '1 day')::date
                    ) as deployed_kiosks
                    LEFT JOIN (SELECT kiosk_id,
                        campus_id,
                        monthly_lease,
                        connectivity
                        FROM (SELECT a.campus_id,
                            kiosk_id,
                            (SELECT prorated_fee FROM dw.calculate_prorated_fee(fee_lease,
                                month_date, to_timestamp(k.deployment_time)::date))
                                as monthly_lease,
                            (SELECT prorated_fee FROM dw.calculate_prorated_fee(fee_connectivity,
                                month_date, to_timestamp(k.deployment_time)::date))
                                as connectivity
                            FROM pantry.accounting a
                            JOIN pantry.fee_rates r
                            ON a.current_fee = r.id
                            AND a.prepaid = 0
                            JOIN pantry.kiosk k
                            ON k.id = a.kiosk_id
                            WHERE a.date = TO_CHAR(date_trunc('month', month_date::date) +
                                interval '1' day, 'YYYY-MM-fmDD')
                        ) as fee_lease
                    ) as all_lease
                    ON all_lease.kiosk_id = deployed_kiosks.kiosk_id
                ) as lease
                ON lease.kiosk_id = kiosks.kiosk_id
                LEFT JOIN (SELECT kiosk_id,
                    a.campus_id,
                    r.name as fee_plan_name,
                    a.prepaid as prepaid_number_of_months,
                    fee_lease as licensing_subscription_fee,
                    r.fee_tags as tag_price,
                    CONCAT(ROUND(fee_ipc * 100, 2), '%') as payment_processing_rate,
                    CASE WHEN a.prepaid = 0
                        THEN '_'
                        ELSE TO_CHAR((month_date + (a.prepaid - 1 || ' MONTH')::INTERVAL),
                            'MM/DD/YYYY')
                        END as prepaid_until,
                    fee_ipc
                    FROM pantry.accounting a
                    JOIN pantry.fee_rates r
                    ON a.current_fee = r.id
                    LEFT JOIN pantry.kiosk k
                    ON a.kiosk_id = k.id
                    WHERE a.date = TO_CHAR(date_trunc('month', month_date::date)
                        + interval '1' day, 'YYYY-MM-fmDD')
                    GROUP BY a.campus_id, kiosk_id, r.name, a.prepaid, a.prepaid_day, fee_lease,
                        r.fee_tags, fee_ipc,
                        to_timestamp(k.deployment_time)::date
                ) as charge
                ON kiosks.kiosk_id = charge.kiosk_id
            ) as monthly_report
            WHERE licensing_subscription_fee > 0 OR
            tag_price > 0 OR
            sales_list_price > 0 OR
            sales_after_discount > 0 OR
            food_cost > 0 OR
            credit_card > 0 OR
            freedom_pay > 0 OR
            complimentary > 0 OR
            monthly_lease > 0 OR
            payment_processing_fee > 0 OR
            connectivity_fee > 0 OR
            manual_adjustment > 0
        )
        ON CONFLICT (campus_id, kiosk_id, date_id) DO UPDATE
        SET (sales_list_price,
            sales_after_discount,
            food_cost,
            credit_card ,
            freedom_pay,
            complimentary,
            monthly_lease,
            payment_processing_fee,
            connectivity_fee,
            manual_adjustment,
            fee_plan_name,
            prepaid_number_of_months,
            prepaid_until,
            licensing_subscription_fee,
            tag_price,
            payment_processing_rate,
            details
        ) = (excluded.sales_list_price,
            excluded.sales_after_discount,
            excluded.food_cost,
            excluded.credit_card ,
            excluded.freedom_pay,
            excluded.complimentary,
            excluded.monthly_lease,
            excluded.payment_processing_fee,
            excluded.connectivity_fee,
            excluded.manual_adjustment,
            excluded.fee_plan_name,
            excluded.prepaid_number_of_months,
            excluded.prepaid_until,
            excluded.licensing_subscription_fee,
            excluded.tag_price,
            excluded.payment_processing_rate,
            excluded.details);
    END;
$_$;
ALTER FUNCTION dw.insert_in_monthly_kiosk_summary(month_date date) OWNER TO muriel;
COMMENT ON FUNCTION dw.insert_in_monthly_kiosk_summary(month_date date) IS 'inserts key metrics in dw.fact_monthly_kiosk_summary';
CREATE FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO dw.fact_daily_byte_foods_summary(
            date_id,
            inventory_units,
            inventory_amt_list,
            inventory_kiosks,
            avg_inventory_units,
            avg_inventory_dollar)
        (/* This query is used to get inventory info for all byte foods fridges at 10 am. This
        includes:
            - a count of all items
            - the total price of all items
            - the number of kiosks involved
            - the average amount of items per kiosk
            - the average amount list price per kiosk */
        SELECT date_id,
            sum(qty) as inventory_units,
            sum(total_price) as inventory_amt_list,
            count(distinct(kiosk_id)) as inventory_kiosks,
            sum(qty) / count(distinct(kiosk_id)) as avg_inventory_units,
            ROUND (sum(total_price) / count(distinct(kiosk_id)), 2) as avg_inventory_dollar
            FROM (SELECT (TO_CHAR(to_timestamp(time)::date, 'YYYYMMDD'))::int as date_id,
                kiosk_id,
                qty,
                (qty * price) as total_price
                FROM pantry.inventory_history ih
                JOIN pantry.kiosk k ON k.id = ih.kiosk_id
                JOIN pantry.product p ON ih.product_id = p.id
                WHERE to_timestamp(time)::date >= beginning_date
                AND to_timestamp(time)::date <= ending_date
                AND extract(hour from to_timestamp(ih.time))= '10'
                AND k.campus_id = 87
                AND k.enable_reporting = 1
                ORDER BY ih.kiosk_id, ih.product_id
            ) as inv
            GROUP BY date_id
        )
        ON CONFLICT (date_id) DO UPDATE
        SET (inventory_units, inventory_amt_list, inventory_kiosks, avg_inventory_units, avg_inventory_dollar) =
        (excluded.inventory_units, excluded.inventory_amt_list, excluded.inventory_kiosks,
        excluded.avg_inventory_units, excluded.avg_inventory_dollar);
    END;
$$;
CREATE FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM dw.insert_sales_monthly_byte_foods_summary(month_date);
    END;
$$;
CREATE FUNCTION erp.parse_phone(text_to_parse text) RETURNS TABLE(phone text)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose - Return the first phone number from an contact_phone field in pantry.kiosk string with embedded phones.
    Input -
      s: string with embedded phone
    Return -
      phone: general phone number
      mobile: mobile phone number
    */
declare
  s text;
  parsed_phone text default null;
begin
  s = regexp_replace(text_to_parse, '\D', '', 'g');
  if length(s) >= 10
  then
    parsed_phone = substring(s, 1, 10);
  end if;
  return query
    select parsed_phone;
end;
$$;
CREATE FUNCTION test.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) RETURNS TABLE(order_id character varying, date_time timestamp with time zone, state character varying, campus_title character varying, campus_id bigint, client_name character varying, kiosk_title character varying, kiosk_id bigint, uid bigint, email character varying, customer_first_name character varying, customer_last_name character varying, vendor character varying, product_tile character varying, sku bigint, menu_category character varying, product_group character varying, qty bigint, total_list_price numeric, price_after_discounts numeric, total_price_after_discounts numeric, total_coupon_value numeric, total_cost numeric, margin numeric, credit_card text, credit_card_number text, approval_code character varying, geo character varying, coupon_code character varying, coupon_campaign character varying)
    LANGUAGE plpgsql
    AS $_$
BEGIN
  RETURN QUERY
    SELECT o.order_id,
           to_timestamp(o.created) as date_time,
           o.state,
           c.title as campus_title,
           k.campus_id,
           k.client_name as client_name,
           k.title as kiosk_title,
           o.kiosk_id,
           ca.id as uid,
           o.email,
           o.first_name as customer_first_name,
           o.last_name as customer_last_name,
           p.vendor,
           p.title as product_tile,
           l.product_id as sku,
           p.consumer_category as menu_category,
           p.fc_title as product_group,
           count(l.epc) as qty,
           sum(COALESCE(ph.price, p.price,0)) as total_list_price,
           GREATEST(COALESCE((l.price),0) - COALESCE((CASE WHEN real_discount != 0 AND real_discount
             IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
             price_after_discounts,
           GREATEST(COALESCE(sum(l.price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
             IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
             total_after_discounts,
           COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
             IS NOT NULL THEN real_discount ELSE  flat_discount END), 0) as total_coupon_value,
           (l.cost * count(l.epc)) as total_cost,
           sum(COALESCE(ph.price, p.price,0)) - (l.cost * count(l.epc)) as margin,
           CASE WHEN payment_system = 'IPCommerce' OR payment_system =  'Express'
                  THEN 'Y' ELSE 'N' END as credit_card,
           RIGHT(ca.number, 4) as credit_card_number,
           o.approval_code as approval_code,
           k.geo,
           o.coupon as coupon_code,
           co.campaign as coupon_campaign
    FROM pantry.order o
           LEFT JOIN pantry.label l ON l.order_id = o.order_id
           LEFT JOIN pantry.kiosk k ON k.id = o.kiosk_id
           LEFT JOIN pantry.campus c ON c.id = k.campus_id
           LEFT JOIN pantry.card ca ON ca.hash = o.card_hash
           LEFT JOIN pantry.product p ON p.id = l.product_id
           LEFT JOIN pantry.coupon co ON co.id = o.coupon_id
           LEFT JOIN pantry.product_history ph ON ph.product_id = p.id
      AND o.created >= ph.start_time AND (ph.end_time IS NULL OR o.created < ph.end_time)
    WHERE to_timestamp(o.created) AT TIME ZONE time_zone >= beginning_date
      AND to_timestamp(o.created) AT TIME ZONE time_zone <= ending_date
    GROUP BY o.order_id, to_timestamp(o.created), o.state, k.campus_id, c.title, k.title, o.kiosk_id,
             ca.id, o.email, o.first_name, o.last_name, p.vendor, p.title, l.product_id, p.consumer_category,
             p.fc_title, p.price, l.cost, o.approval_code, k.geo, co.campaign, o.coupon, l.price, co.real_discount,
             co.flat_discount, k.client_name;
END;
$_$;
ALTER FUNCTION test.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) OWNER TO erpuser;
CREATE FUNCTION test.insert_in_monthly_kiosk_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $_$
BEGIN
  INSERT INTO test.fact_monthly_kiosk_summary(
    campus_id,
    kiosk_id,
    date_id,
    fee_plan_name,
    prepaid_number_of_months,
    prepaid_until,
    licensing_subscription_fee,
    tag_price,
    payment_processing_rate,
    sales_list_price,
    sales_after_discount,
    food_cost,
    credit_card ,
    freedom_pay,
    complimentary,
    monthly_lease,
    payment_processing_fee,
    connectivity_fee,
    manual_adjustment,
    details
  )
    (SELECT monthly_report.campus_id,
            monthly_report.kiosk_id,
            monthly_report.date_id,
            monthly_report.fee_plan_name,
            monthly_report.prepaid_number_of_months,
            monthly_report.prepaid_until,
            monthly_report.licensing_subscription_fee,
            monthly_report.tag_price,
            monthly_report.payment_processing_rate,
            monthly_report.sales_list_price,
            monthly_report.sales_after_discount,
            monthly_report.food_cost,
            monthly_report.credit_card ,
            monthly_report.freedom_pay,
            monthly_report.complimentary,
            monthly_report.monthly_lease,
            monthly_report.payment_processing_fee,
            monthly_report.connectivity_fee,
            monthly_report.manual_adjustment,
            monthly_report.details
     FROM (SELECT
             kiosks.campus_id,
             kiosks.kiosk_id,
             TO_CHAR(date_trunc('month', month_date::date)::date, 'YYYYMMDD')::int AS date_id,
             fee_plan_name,
             prepaid_number_of_months,
             prepaid_until,
             licensing_subscription_fee,
             tag_price,
             payment_processing_rate,
             COALESCE(amount_list_price, 0) as sales_list_price,
             COALESCE(sales_after_discount, 0) as sales_after_discount,
             COALESCE(food_cost, 0) as food_cost,
             COALESCE(ip_commerce, 0) as credit_card ,
             COALESCE(freedom_pay, 0) as freedom_pay,
             COALESCE(complimentary, 0) as complimentary,
             COALESCE(monthly_lease, 0) as monthly_lease,
             COALESCE(ROUND((ip_commerce * fee_ipc)::numeric, 2), 0) as payment_processing_fee,
             COALESCE(connectivity, 0) as connectivity_fee,
             COALESCE(manual_adjustment, 0) as manual_adjustment,
             details
           FROM (SELECT id as kiosk_id,
                        campus_id
                 FROM pantry.kiosk
                ) as kiosks
                  LEFT JOIN (SELECT campus_id,
                                    kiosk_id,
                                    SUM(sales_amt) as amount_list_price,
                                    SUM(cost_amt) as food_cost,
                                    SUM(ip_commerce) as ip_commerce,
                                    SUM(freedom_pay)  as freedom_pay,
                                    SUM(complimentary) as complimentary,
                                    SUM(sales_after_discount) as sales_after_discount
                             FROM dw.fact_daily_kiosk_sku_summary daily
                                    JOIN dw.dim_date as dd
                                         ON dd.date_id = daily.date_id
                             WHERE as_date >= date_trunc('month', month_date::date)::date
                               AND as_date <= (date_trunc('month', month_date::date) + interval '1 month'
                               -  interval '1 day' )::date
                             GROUP BY kiosk_id, campus_id
           ) as amount_list_price
                            ON kiosks.kiosk_id = amount_list_price.kiosk_id
                  LEFT JOIN (SELECT kiosk_id,
                                    campus_id,
                                    sum(sum) as manual_adjustment,
                                    STRING_AGG( CASE WHEN sum IS NOT NULL
                                                       THEN CONCAT(
                                        CASE WHEN SIGN(SUM) = 1
                                               THEN CONCAT('$', SUM)
                                             WHEN SIGN(SUM) = -1
                                               THEN CONCAT('-$', -SUM)
                                          END,
                                        ' ',
                                        reason,
                                        ' (for kiosk "', k.title, '")') END
                                      , ' | ' ) as details
                             FROM pantry.manual_adjustment ma
                                    JOIN pantry.kiosk k
                                         ON ma.kiosk_id = k.id
                             WHERE date = TO_CHAR(date_trunc('month', month_date::date) + interval '1' day,
                                                  'YYYY-MM-fmDD')
                               AND ma.archived = 0
                             GROUP BY campus_id, kiosk_id
           ) as manual_adjust
                            ON manual_adjust.kiosk_id = kiosks.kiosk_id
                  LEFT JOIN (SELECT deployed_kiosks.kiosk_id,
                                    deployed_kiosks.campus_id,
                                    COALESCE(monthly_lease, 0) as monthly_lease,
                                    COALESCE(connectivity, 0) as connectivity
                             FROM (SELECT id as kiosk_id,
                                          campus_id
                                   FROM pantry.kiosk
                                   WHERE to_timestamp(deployment_time)::date <=
                                         (date_trunc('month', month_date) + interval '1 month'
                                           - interval '1 day')::date
                                  ) as deployed_kiosks
                                    LEFT JOIN (SELECT kiosk_id,
                                                      campus_id,
                                                      monthly_lease,
                                                      connectivity
                                               FROM (SELECT a.campus_id,
                                                            kiosk_id,
                                                            (SELECT prorated_fee FROM dw.calculate_prorated_fee(fee_lease,
                                                                                                                month_date, to_timestamp(k.deployment_time)::date))
                                                              as monthly_lease,
                                                            (SELECT prorated_fee FROM dw.calculate_prorated_fee(fee_connectivity,
                                                                                                                month_date, to_timestamp(k.deployment_time)::date))
                                                              as connectivity
                                                     FROM pantry.accounting a
                                                            JOIN pantry.fee_rates r
                                                                 ON a.current_fee = r.id
                                                                   AND a.prepaid = 0
                                                            JOIN pantry.kiosk k
                                                                 ON k.id = a.kiosk_id
                                                     WHERE a.date = TO_CHAR(date_trunc('month', month_date::date) +
                                                                            interval '1' day, 'YYYY-MM-fmDD')
                                                    ) as fee_lease
                             ) as all_lease
                                              ON all_lease.kiosk_id = deployed_kiosks.kiosk_id
           ) as lease
                            ON lease.kiosk_id = kiosks.kiosk_id
                  LEFT JOIN (SELECT kiosk_id,
                                    a.campus_id,
                                    r.name as fee_plan_name,
                                    a.prepaid as prepaid_number_of_months,
                                    fee_lease as licensing_subscription_fee,
                                    r.fee_tags as tag_price,
                                    CONCAT(ROUND(fee_ipc * 100, 2), '%') as payment_processing_rate,
                                    CASE WHEN a.prepaid = 0
                                           THEN '_'
                                         ELSE TO_CHAR((month_date + (a.prepaid - 1 || ' MONTH')::INTERVAL),
                                                      'MM/DD/YYYY')
                                      END as prepaid_until,
                                    fee_ipc
                             FROM pantry.accounting a
                                    JOIN pantry.fee_rates r
                                         ON a.current_fee = r.id
                                    LEFT JOIN pantry.kiosk k
                                              ON a.kiosk_id = k.id
                             WHERE a.date = TO_CHAR(date_trunc('month', month_date::date)
                                                      + interval '1' day, 'YYYY-MM-fmDD')
                             GROUP BY a.campus_id, kiosk_id, r.name, a.prepaid, a.prepaid_day, fee_lease,
                                      r.fee_tags, fee_ipc,
                                      to_timestamp(k.deployment_time)::date
           ) as charge
                            ON kiosks.kiosk_id = charge.kiosk_id
          ) as monthly_report
     WHERE licensing_subscription_fee > 0 OR
         tag_price > 0 OR
         sales_list_price > 0 OR
         sales_after_discount > 0 OR
         food_cost > 0 OR
         credit_card > 0 OR
         freedom_pay > 0 OR
         complimentary > 0 OR
         monthly_lease > 0 OR
         payment_processing_fee > 0 OR
         connectivity_fee > 0 OR
         manual_adjustment > 0
    )
  ON CONFLICT (campus_id, kiosk_id, date_id) DO UPDATE
    SET (sales_list_price,
         sales_after_discount,
         food_cost,
         credit_card ,
         freedom_pay,
         complimentary,
         monthly_lease,
         payment_processing_fee,
         connectivity_fee,
         manual_adjustment,
         fee_plan_name,
         prepaid_number_of_months,
         prepaid_until,
         licensing_subscription_fee,
         tag_price,
         payment_processing_rate,
         details
          ) = (excluded.sales_list_price,
               excluded.sales_after_discount,
               excluded.food_cost,
               excluded.credit_card ,
               excluded.freedom_pay,
               excluded.complimentary,
               excluded.monthly_lease,
               excluded.payment_processing_fee,
               excluded.connectivity_fee,
               excluded.manual_adjustment,
               excluded.fee_plan_name,
               excluded.prepaid_number_of_months,
               excluded.prepaid_until,
               excluded.licensing_subscription_fee,
               excluded.tag_price,
               excluded.payment_processing_rate,
               excluded.details);
END;
$_$;
ALTER FUNCTION test.insert_in_monthly_kiosk_summary(month_date date) OWNER TO erpuser;
COMMENT ON FUNCTION test.insert_in_monthly_kiosk_summary(month_date date) IS 'inserts key metrics in dw.fact_monthly_kiosk_summary';
CREATE FUNCTION test.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $_$
BEGIN
  INSERT INTO test.fact_daily_kiosk_sku_summary(
    campus_id,
    kiosk_id,
    product_id,
    date_id,
    ip_commerce,
    freedom_pay,
    card_smith,
    complimentary,
    sales_after_discount
  )
    (SELECT campus_id,
            kiosk_id,
            product_id,
            date_id,
            sum(ipcommerce) as ipcommerce,
            sum(freedomPay) as freedomPay,
            sum(CardSmith) as cardSmith,
            sum(Complimentary) as complimentary,
            sum(sales_after_discount) as sales_after_discount
     FROM (SELECT  kiosk_campus_id as campus_id,
                   kiosk_id,
                   product_id,
                   date_id,
                   CASE WHEN payment_system = 'IPCommerce' OR payment_system =  'Express'
                          THEN sum(price) END as ipcommerce,
                   CASE WHEN payment_system = 'FreedomPay'
                          THEN sum(price) END as freedomPay,
                   CASE WHEN payment_system = 'CardSmith'
                          THEN sum(price) END as cardSmith,
                   CASE WHEN payment_system = 'Complimentary' OR payment_system = 'Nursing'
                          THEN sum(price) END as complimentary,
                   CASE WHEN payment_system = 'Complimentary'
                     OR payment_system =  'Express'
                     OR payment_system = 'FreedomPay'
                     OR payment_system = 'CardSmith'
                     OR payment_system = 'Nursing'
                          THEN sum(price) END as sales_after_discount
           FROM (SELECT (TO_CHAR(date_, 'YYYYMMDD'))::int AS date_id,
                        kiosk_id,
                        product_id,
                        kiosk_campus_id,
                        payment_system,
                        CASE WHEN
                          COALESCE(sum(price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                            IS NOT NULL THEN real_discount ELSE  flat_discount END), 0) >= 0
                            THEN
                              COALESCE(sum(price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                                IS NOT NULL THEN real_discount ELSE  flat_discount END), 0)
                            ELSE
                              0
                          END AS price
                 FROM (SELECT payment_system,
                              to_timestamp(created)::date as date_,
                              COALESCE(l.cost) as cost,
                              COALESCE(l.price) as price,
                              l.kiosk_id,
                              l.product_id,
                              k.campus_id as kiosk_campus_id,
                              k.enable_reporting,
                              co.real_discount,
                              co.flat_discount
                       FROM pantry.label l
                              JOIN pantry.kiosk k
                                   ON k.id = l.kiosk_id
                              JOIN pantry.product p
                                   ON p.id = l.product_id
                              JOIN pantry.order o
                                   ON o.order_id = l.order_id
                              LEFT JOIN pantry.coupon co
                                        ON co.id = o.coupon_id
                       WHERE created BETWEEN extract('EPOCH' FROM (beginning_date::date))::BIGINT
                         AND extract('EPOCH' FROM (ending_date::date + interval '1 day'))::BIGINT - 1
                         AND o.state in ('Processed', 'Refunded')
                         AND l.status = 'sold'
                      )  as amount_paid_without_discount
                 GROUP BY payment_system, kiosk_id, product_id, kiosk_campus_id, date_id
                ) as amount_paid_with_discounts
           GROUP BY kiosk_campus_id, kiosk_id, product_id, date_id, payment_system
          ) as sum_amount_paid
     GROUP BY campus_id, kiosk_id, product_id, date_id
    )
  ON CONFLICT (campus_id, product_id, kiosk_id, date_id) DO UPDATE
    SET (ip_commerce,
         freedom_pay,
         card_smith,
         complimentary,
         sales_after_discount
          ) = (
               excluded.ip_commerce,
               excluded.freedom_pay,
               excluded.card_smith,
               excluded.complimentary,
               excluded.sales_after_discount);
END;
$_$;
ALTER FUNCTION test.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO erpuser;
CREATE FUNCTION test.spoils(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, order_id_ character varying, kiosk_id_ bigint, product_id_ bigint, time_updated_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
    /*
    For a given time window W1 (e.g. from beginning_date through ending_date) and an extended time
    window W2, with W1 being a subset of W2 (e.g. W1 +1 and -1 month from beginning_date through
    ending_date)
    Spoil: count of unique epc’s which have at least one spoil label record within W1 and have no
    sale record within W2.
    A spoil label record has an order id which starts with RE and has an out or lost LABEL STATUS.
    For a spoil label record to be within time window W1, the order creation time needs to be within W1.
    * ENG-834: Art's logic, the origin for this function
    * ENG-1922: Add label state lost; Restrict order state from the sales subquery
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
                 AND l.status in ('out', 'lost')
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
                                  LEFT JOIN pantry.product_history ph ON ph.product_id = p.id
                             AND o.created >= ph.start_time AND (ph.end_time IS NULL OR o.created <
                                                                                        ph.end_time)
                           WHERE to_timestamp(created)::date >= beginning_date
                             AND to_timestamp(created)::date <= ending_date
                             AND l.status in ('out', 'lost')
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
                        AND o.state in ('Placed', 'Processed', 'Refunded', 'Adjusted', 'Declined', 'Error')
                        AND l.status = 'sold'
                        AND l.order_id NOT LIKE 'RE%'
                        AND l.order_id IS NOT NULL);
END;
$$;
CREATE FUNCTION dw.byte_spoils(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_updated timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
/*
The following query is used to get byte kiosks spoils.
*/
SELECT epc_ as epc,
    kiosk_id_ as kiosk_id,
    product_id_ as product_id,
    time_updated_ as time_updated,
    cost_ as cost,
    price_ as price
    FROM dw.spoils(beginning_date, ending_date) gl
    WHERE kiosk_campus_id_ = BYTE_CAMPUS
    AND enable_reporting_ = 1;
 END;
$$;
CREATE FUNCTION dw.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) RETURNS TABLE(order_id character varying, date_time timestamp with time zone, state character varying, campus_title character varying, campus_id bigint, client_name character varying, kiosk_title character varying, kiosk_id bigint, uid bigint, email character varying, customer_first_name character varying, customer_last_name character varying, vendor character varying, product_tile character varying, sku bigint, menu_category character varying, product_group character varying, qty bigint, total_list_price numeric, price_after_discounts numeric, total_price_after_discounts numeric, total_coupon_value numeric, total_cost numeric, margin numeric, credit_card text, credit_card_number text, approval_code character varying, geo character varying, coupon_code character varying, coupon_campaign character varying, time_door_closed bigint, time_door_opened bigint)
    LANGUAGE plpgsql
    AS $_$
    BEGIN
        RETURN QUERY
        SELECT o.order_id,
            to_timestamp(o.created) as date_time,
            case when o.status = 'Declined' then 'Declined' else o.state end as state,
            c.title as campus_title,
            k.campus_id,
            k.client_name as client_name,
            k.title as kiosk_title,
            o.kiosk_id,
            ca.id as uid,
            o.email,
            o.first_name as customer_first_name,
            o.last_name as customer_last_name,
            p.vendor,
            p.title as product_tile,
            l.product_id as sku,
            COALESCE(
                p.consumer_category,
                STRING_AGG(DISTINCT p_tags.pc_categories, ',')
            ) as menu_category,
            COALESCE(
                p.fc_title,
                STRING_AGG(DISTINCT p_tags.tag_names, ',')
            ) as product_group,
            count(l.epc) as qty,
            sum(COALESCE(ph.price, p.price,0)) as total_list_price,
            GREATEST(COALESCE((l.price),0) - COALESCE((CASE WHEN real_discount != 0 AND real_discount
                IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
                price_after_discounts,
            GREATEST(COALESCE(sum(l.price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
                total_after_discounts,
            COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                IS NOT NULL THEN real_discount ELSE  flat_discount END), 0) as total_coupon_value,
            (l.cost * count(l.epc)) as total_cost,
            sum(COALESCE(ph.price, p.price,0)) - (l.cost * count(l.epc)) as margin,
            CASE WHEN payment_system = 'IPCommerce' OR payment_system =  'Express'
                THEN 'Y' ELSE 'N' END as credit_card,
            RIGHT(ca.number, 4) as credit_card_number,
            o.approval_code as approval_code,
            k.geo,
            o.coupon as coupon_code,
            co.campaign as coupon_campaign,
            o.time_door_closed,
            o.time_door_opened
            FROM pantry.order o
            LEFT JOIN pantry.label l ON l.order_id = o.order_id
            LEFT JOIN pantry.kiosk k ON k.id = o.kiosk_id
            LEFT JOIN pantry.campus c ON c.id = k.campus_id
            LEFT JOIN pantry.card ca ON ca.hash = o.card_hash
            LEFT JOIN pantry.product p ON p.id = l.product_id
            LEFT JOIN pantry.coupon co ON co.id = o.coupon_id
            LEFT JOIN pantry.product_history ph ON ph.product_id = p.id
                AND o.created >= ph.start_time AND (ph.end_time IS NULL OR o.created < ph.end_time)
            LEFT JOIN (
                SELECT p.id, 
                STRING_AGG(DISTINCT pc.cat_name, ',') AS pc_categories,
                STRING_AGG(DISTINCT t.tag, ',') as tag_names
                FROM pantry.product p 
                JOIN pantry.tag t ON t.id::text=any(string_to_array(p.categories, ','))
                JOIN pantry.product_categories pc ON string_to_array(pc.tags, ',') && string_to_array(p.categories, ',')
                GROUP BY p.id
            ) p_tags ON p_tags.id = p.id
            WHERE to_timestamp(o.created) AT TIME ZONE time_zone >= beginning_date
            AND to_timestamp(o.created) AT TIME ZONE time_zone <= ending_date
            GROUP BY o.order_id, k.id, c.title, ca.id, p.id, l.product_id, l.cost,
            co.campaign, l.price, co.real_discount, co.flat_discount,
            p_tags.pc_categories, p_tags.tag_names;
    END;
$_$;
ALTER FUNCTION dw.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) OWNER TO erpuser;
CREATE FUNCTION dw.export_unconsolidated_remittance(month_date date) RETURNS TABLE(campus_title character varying, campus_id bigint, kiosk_id bigint, kiosk_title character varying, client_type text, deployment_date date, sales_after_discount numeric, sales_list_price numeric, credit_card numeric, freedom_pay numeric, complimentary numeric, monthly_lease numeric, connectivity_fee numeric, payment_processing_fee numeric, manual_adjustment numeric, details text, prepaid_until character varying, fees_before_tags numeric, net_total_before_tags numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT r.campus_title,
            r.campus_id,
            r.kiosk_id,
            r.kiosk_title,
            r.client_type,
            deployment_time::date as deployment_date,
            r.sales_after_discount,
            r.sales_list_price,
            r.credit_card,
            r.freedom_pay,
            r.complimentary,
            r.monthly_lease,
            r.connectivity_fee,
            r.payment_processing_fee,
            r.manual_adjustment,
            r.details,
            r.prepaid_until,
            r.connectivity_fee + r.payment_processing_fee + r.monthly_lease  as fees_before_tags,
            r.credit_card - r.connectivity_fee - r.payment_processing_fee - r.monthly_lease
                + r.manual_adjustment + r.freedom_pay + r.complimentary
                as net_total_before_tags
            FROM dw.export_remittance(month_date) r;
    END;
$$;
CREATE FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO dw.fact_daily_byte_foods_summary(
            date_id,
            fridge_uptime,
            major_fridge_outages)
        (/* A fridge's heart beat is recorded in pantry.status every 10 minutes. In a day, each
        kiosk should have a total of 144 heart beats. If a kiosk has 126 heart beats or less, it's
        considered a major outage. This query is used to calculate Byte Foods fridges major outages
        per day and kiosk uptime.
        Kiosk uptime  = total heart beats / (number of kiosks * 144)
        */
        SELECT (TO_CHAR(datee, 'YYYYMMDD'))::int as date_id,
            sum(heart_beat) / ( (count(DISTINCT kiosk_id)) * 144 ) as fridge_uptime,
            sum(if(heart_beat < (126), 1, 0)) as major_fridge_outages
            FROM (SELECT date as datee,
                kiosk_id,
                count(DISTINCT ts_10min) as heart_beat
                FROM kiosk_status
                JOIN pantry.kiosk
                ON kiosk.id = kiosk_status.kiosk_id
                WHERE ts_10min::date >= beginning_date
                AND ts_10min::date <= ending_date
                AND kiosk.campus_id = 87
                AND kiosk.enable_reporting = 1
                GROUP BY kiosk_status.date, kiosk_status.kiosk_id
            ) as byte_heart_beat_by_kiosk
            GROUP BY datee
        )
        ON CONFLICT (date_id) DO UPDATE
        SET (fridge_uptime, major_fridge_outages) =
        (excluded.fridge_uptime, excluded.major_fridge_outages);
    END;
$$;
CREATE FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) RETURNS TABLE(kiosk_id bigint, kiosk_title character varying, campus_id bigint, product_id bigint, product_title character varying, sales bigint, spoils bigint, losses bigint, stockout_percent numeric)
    LANGUAGE plpgsql
    AS $$
   DECLARE
       DATE_DIFFERENCE bigint := ending_date - beginning_date + 1 ;
   BEGIN
     SET enable_seqscan TO false;
       RETURN QUERY
       SELECT all_kiosk_product.kiosk_id,
           all_kiosk_product.kiosk_title,
           all_kiosk_product.k_campus_id,
           all_kiosk_product.product_id,
           all_kiosk_product.product_title,
           coalesce(stockouts.sales_qty, 0) as sales,
           coalesce(stockouts.spoils_qty, 0) as spoils,
           coalesce(stockouts.losses_qty, 0) as losses,
           coalesce(stockouts.stockout_percent, 100.00) as stockout_percent
           FROM (SELECT k.id as kiosk_id,
               k.title as kiosk_title,
               k.campus_id as k_campus_id,
               p.id as product_id,
               p.title as product_title,
               p.campus_id as p_campus_id
               FROM pantry.kiosk k
               CROSS JOIN pantry.product p
               WHERE k.campus_id = p.campus_id
               AND k.id = kiosk_number
           ) as all_kiosk_product
           LEFT JOIN( SELECT fd.kiosk_id,
               fd.product_id,
               fd.campus_id,
               sum(fd.sales_qty) as sales_qty,
               sum(fd.spoils_qty) as spoils_qty,
               sum(fd.losses_qty) as losses_qty,
               DATE_DIFFERENCE - sum(coalesce(stocked_percent,0)) as stockout_percent
               FROM dw.fact_daily_kiosk_sku_summary fd
               JOIN dw.dim_date dd
               ON dd.date_id = fd.date_id
               WHERE as_date >= beginning_date
               AND as_date <= ending_date
               AND fd.kiosk_id = kiosk_number
               GROUP by fd.kiosk_id, fd.product_id, fd.campus_id
            ) as stockouts
            ON all_kiosk_product.kiosk_id = stockouts.kiosk_id
            AND all_kiosk_product.product_id = stockouts.product_id
            ORDER BY coalesce(stockouts.stockout_percent, 100.00);
   END;
$$;
CREATE FUNCTION dw.non_byte_restocks(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_added timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
        /*
        The following query is used to get non byte kiosks restocks.
        */
        SELECT epc_ as epc,
            kiosk_id_ as kiosk_id,
            product_id_ as product_id,
            time_added_ as time_added,
            cost_ as cost,
            price_ as price
            FROM dw.restocks(beginning_date, ending_date)
            WHERE kiosk_campus_id_ != BYTE_CAMPUS;
    END;
$$;
CREATE FUNCTION inm_test.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, delivery_date date, pull_date date)
    LANGUAGE plpgsql
    AS $$
  /*
  pull_date is target expiration date for the restocker to remove food from the kiosk.
  The later the pull_date, the more food get removed. Unnecessarily late pull_dates
  cause higher spoilage.
  This function computes normal_pull_date and enhanced_pull_date, then return enhanced_pull_date
  if available, otherwise normal_pull_date.
  normal_pull_date is the day before the next delivery, meaning at restock time, all food expires
  before the next delivery date is removed.
  enhanced_pull_date looks at past sales by day of the week for the kiosk, and set the pull_date
  to the last business day for the kiosk before the normal_pull_date.
  For a typical kiosk with last delivery of the week on Wednesday or Thursday and no business on
  the weekend, enhanced_pull_date will prevent food that are OK up to the end of Friday in the
  kiosk to be sold, which otherwise would be removed by normal_pull_date because they would
  expire on the weekend.
  */
begin
  set timezone to 'US/Pacific';
  return query
    with
      dd as
        (select t.kiosk_id, t.delivery_date_time as delivery_dt from
          (select location_number as kiosk_id, rs.route_date_time as delivery_date_time,
                  dense_rank() over (partition by location_number order by rs.route_date_time) as r
           from mixalot.route_stop rs
           where rs.route_date_time >= plan_window_start -- routes starting at plan window start
             and rs.route_date_time <= plan_window_stop
             and location_number > 0) t
         where r = 1),
      npd as
      (select t.kiosk_id,
              t.delivery_date_time - interval '1 days' as pull_date,
              extract(dow from t.delivery_date_time) as dow
        from
          (select location_number as kiosk_id, rs.route_date_time as delivery_date_time,
                  dense_rank() over (partition by location_number order by rs.route_date_time) as r
           from mixalot.route_stop rs
           where rs.route_date_time >= plan_window_start -- routes starting at plan window start
             and location_number > 0) t
         where r = 2),
      pepd as
        (select d as pull_date, extract(dow from d) as dow
          from (select generate_series(plan_window_start,
            plan_window_start::timestamp + interval '6 days', interval '1 days')::date as d) dates),
      sales_history as
        (select v.kiosk_id, v.dow
          from inm.v_kiosk_sale_hourly v
          group by 1, 2
          having sum(units_sold_normalized) >= 0.05),
      epd as
        (select dd.kiosk_id, dd.delivery_dt,
             max(pepd.pull_date) as pull_date
          from dd
            join npd on dd.kiosk_id = npd.kiosk_id
            left join sales_history on dd.kiosk_id = sales_history.kiosk_id
            left join pepd on sales_history.dow = pepd.dow
          where
            pepd.pull_date > dd.delivery_dt and pepd.pull_date < npd.pull_date
            group by 1,2)
  select dd.kiosk_id, 
         dd.delivery_dt::date, 
         coalesce(epd.pull_date, npd.pull_date::date) as pull_date
    from dd
      join npd on dd.kiosk_id = npd.kiosk_id
      left join epd on dd.kiosk_id = epd.kiosk_id;
end;
$$;
CREATE FUNCTION inm_test.get_pull_date_enhanced(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, delivery_date date, pull_date date)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose: return INM pull date aka next delivery date
    Note: this used to be part of mixalot.plan_kiosk, but due to unreliable time portion of route_stop.route_date_time,
    this pull_date function is created to restrict the result to date portion of the data which is accurate and sufficient
    because pull_date doesn't need accurate time unlike mixalot.plan_kiosk.
    */
begin
  return query
    select ds.kiosk_id, ds.delivery_date_time::date, ps.pull_date_time::date
    from
      (select t.kiosk_id, t.delivery_date_time
       from (select location_number                                                        as kiosk_id,
                    rs.route_date_time                                                     as delivery_date_time,
                    rank() over (partition by location_number order by rs.route_date_time) as r
             from mixalot.route_stop rs
             where rs.route_date_time >= plan_window_start -- look at routes starting at plan winddow start
               and location_number > 0) t
       where r = 1) ds
    left join
    (select o.kiosk_id                                             kiosk_id,
              if(o.os = 0, o.pull_date_time,
                 (o.pull_date_time - interval '1 day' * (o.os + 1))) pull_date_time
       from (
              select nd.kiosk_id,
                     nd.pull_date_time,
                     nd.pull_dow,
                     nd.pull_dow - os.os                                                     as pull_dow_os,
                     mod((7 + nd.pull_dow - os.os)::integer, 7)                              as pull_dow_os_mod,
                     os.os,
                     ks.kiosk_sale_daily                                                     as kiosk_sale_daily,
                     row_number()
                         over (partition by nd.kiosk_id order by (nd.pull_dow - os.os) desc) as row_number
              from (
                     select t.kiosk_id,
                            t.delivery_date_time - interval '1 day'                        pull_date_time,
                            EXTRACT(DOW from (t.delivery_date_time - interval '1 day')) as pull_dow
                     from (
                            select location_number                                                     as kiosk_id,
                                   rs.route_date_time::date                                            as delivery_date_time,
                                   dense_rank()
                                       over (partition by location_number order by rs.route_date_time::date) as r
                            from mixalot.route_stop rs
                            where rs.route_date_time >= plan_window_start -- look at routes starting at plan window start
                              and location_number > 0) t
                     where r = 2
                   ) nd
                     cross join (
                select generate_series as os
                from generate_series(0, 6)
              ) os
                     left join (
                select vksh.kiosk_id, vksh.dow, sum(vksh.units_sold_normalized) as kiosk_sale_daily
                from inm.v_kiosk_sale_hourly vksh
                group by vksh.kiosk_id, vksh.dow
              ) ks
                               on nd.kiosk_id = ks.kiosk_id and
                                  mod((7 + nd.pull_dow - os.os)::integer, 7) = ks.dow
              where ks.kiosk_sale_daily >= 0.05
              order by nd.kiosk_id asc, (nd.pull_dow - os.os) desc
            ) o
       where o.row_number = 1) ps
      on ds.kiosk_id = ps.kiosk_id
        join pantry.kiosk k on ds.kiosk_id = k.id
    where ds.delivery_date_time between plan_window_start and plan_window_stop
      and k.campus_id = 87;
end;
$$;
CREATE FUNCTION erp.sync_kiosk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  _client_id integer;
  _client_name text;
  _address_id integer;
  _address1 text;
  _address2 text;
  _city text;
  _state text;
  _zip text;
  _phone text;
  _email type.email;
  _industry integer;
  _location_type integer := -1;
  _payment_start_date date;
  _payment_stop_date date;
  _general_contact_type integer;
  _general_contact_id integer;
  _accounting_contact_type integer;
  _accounting_contact_id integer;
  _note_type integer;
  BYTE_CAMPUS INTEGER := 87;
  _record_exists boolean;
  _target_record record;
begin
  if tg_op in  ('INSERT', 'UPDATE')
    then
      select exists(select 1 from erp.kiosk where id = new.id) into _record_exists ;
      if new.client_name = 'Byte'
        then
          new.address = '101 Glacier Point, San Rafael, CA 94901';
          new.contact_first_name = 'Megan';
          new.contact_last_name = 'Mokri';
          new.contact_email = 'megan@bytefoods.co';
          new.accounting_email = 'same';
          new.location_x = 37.950262;
          new.location_y = -122.489975;
      end if;
      select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
      select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';
      select address1, address2, city, state, zip from erp.parse_address(new.address)
                                                    into _address1, _address2, _city, _state, _zip;
      select address.id into _address_id from erp.address
      where address1 = _address1 and address2 = _address2 and city = _city and state = _state and zip = _zip;
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);
      select coalesce(ga.id, -1) into _industry
      from erp.client_industry ci
             left join (select * from erp.global_attribute_def ga where ga.name = 'industry') ga
                       on ci.industry = ga.value
      where ci.client_name = new.client_name;
      if _industry is null
        then _industry = -1;
      end if;
      insert into erp.client(name, employees_num, industry)
        values(_client_name, new.employees_num, _industry)
        on conflict(name) do nothing;
      select id into _client_id from erp.client c where c.name = _client_name;
      insert into erp.address(client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
        values(_client_id, _address1, _address2, _city, _state, _zip, new.location_x, new.location_y, new.timezone)
        returning id into _address_id;
      select phone into _phone from erp.parse_phone(new.contact_phone);
      begin
        _email = new.contact_email;
        exception
          when others then _email = null;
      end;
      insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
        values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
        on conflict do nothing;
      if new.accounting_email = 'same'
        then
          insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
            values(_client_id, new.contact_first_name, new.contact_last_name,
                   _email, _phone, _accounting_contact_type)
            on conflict do nothing;
      end if;
      select id into _client_id from erp.client where name = _client_name;
      select contact.id into _general_contact_id from erp.contact
        where first_name = new.contact_first_name and last_name = new.contact_last_name
          and contact_type = _general_contact_type;
      select contact.id into _accounting_contact_id from erp.contact
        where first_name = new.contact_first_name and last_name = new.contact_last_name
          and contact_type = _accounting_contact_type;
      if new.payment_start is null or new.payment_start = 0
        then _payment_start_date = null;
        else _payment_start_date = to_timestamp(new.payment_start)::date;
      end if;
      if new.payment_stop is null or new.payment_stop = 0
        then _payment_stop_date = null;
        else _payment_stop_date = to_timestamp(new.payment_stop)::date;
      end if;
  end if;
  case
    when tg_op = 'INSERT' and not _record_exists
      then
        insert into erp.kiosk(id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
                              location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
                              deployment_status_id, bank, archived)
        values (new.id, new.campus_id, new.serial, _client_id,
                new.title, new.kiosk_name, new.geo, _address_id, new.publicly_accessible, _location_type,
                new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
                0, 0, new.archived);
        insert into erp.hardware_software(kiosk_id, gcm_id, app_vname, app_vcode, features, components,
                                          server_url, peekaboo_url, email_receipt_subject)
        values(new.id, new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
               '', new.email_receipt_subject);
        insert into erp.kiosk_accounting(kiosk_id, start_date, payment_start, payment_stop, sales_tax,
                                         default_fee_plan, byte_discount, subsidy_info, max_subscription,
                                         subscription_amount, setup_fee, subsidy_notes)
        values (new.id,
                null, -- start_date,
                _payment_start_date, _payment_stop_date, new.sales_tax, new.default_fee_plan, new.byte_discount,
                new.subsidy_info, new.max_subscription, new.subscription_amount,
                null, -- new.setup_fee,
                new.subsidy_notes);
        if new.fridge_loc_info is not null and new.fridge_loc_info <> ''
        then
          select id into _note_type from erp.global_attribute_def where name = 'note_type' and value = 'Location';
          insert into erp.kiosk_note(kiosk_id, note_type, content)
          values(new.id, _note_type, new.fridge_loc_info);
        end if;
        if new.delivery_insns is not null and new.delivery_insns <> ''
        then
          select id into _note_type from erp.global_attribute_def where name = 'note_type' and value = 'Delivery Instruction';
          insert into erp.kiosk_note(kiosk_id, note_type, content)
          values(new.id, _note_type, new.delivery_insns);
        end if;
        if new.ops_team_notes is not null and new.ops_team_notes <> ''
        then
          select id into _note_type from erp.global_attribute_def where name = 'note_type' and value = 'OPS';
          insert into erp.kiosk_note(kiosk_id, note_type, content)
          values(new.id, _note_type, new.ops_team_notes);
        end if;
        insert into erp.kiosk_status(kiosk_id, last_update, last_status, last_inventory)
        values(new.id, new.last_update, new.last_status, new.last_inventory);
        if _general_contact_id is not null
        then
          insert into erp.kiosk_contact(kiosk_id, contact_id) values(new.id, _general_contact_id)
          on conflict do nothing;
        end if;
        if new.campus_id = BYTE_CAMPUS then
          insert into inm.kiosk_control(kiosk_id) values(new.id)
            on conflict do nothing;
        end if;
    when tg_op = 'UPDATE' or (tg_op = 'INSERT' and _record_exists) then
      update erp.kiosk
      set
        (id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
         location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
         deployment_status_id, bank, archived)
          =
          (new.id, new.campus_id, new.serial, _client_id,
           new.title, new.kiosk_name, new.geo, _address_id, new.publicly_accessible, _location_type,
           new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
           0, 0, new.archived)
      where id = new.id;
      update erp.hardware_software
      set
        (gcm_id, app_vname, app_vcode, features, components,
         server_url, peekaboo_url, email_receipt_subject)
          =
          (new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
           '', new.email_receipt_subject)
      where kiosk_id=new.id;
      update erp.kiosk_accounting
      set
        (start_date, payment_start, payment_stop, sales_tax, default_fee_plan, byte_discount,
         subsidy_info, max_subscription, subscription_amount, setup_fee, subsidy_notes)
          =
          (null, _payment_start_date, _payment_stop_date, new.sales_tax, new.default_fee_plan, new.byte_discount,
           new.subsidy_info, new.max_subscription, new.subscription_amount, null, new.subsidy_notes)
      where kiosk_id=new.id;
      update erp.kiosk_status
      set
        (last_update, last_status, last_inventory)
          =
          (new.last_update, new.last_status, new.last_inventory)
      where kiosk_id=new.id;
    when tg_op = 'DELETE'
      then
        delete from erp.kiosk where id = old.id;
        delete from erp.hardware_software where kiosk_id = old.id;
        delete from erp.kiosk_accounting where kiosk_id = old.id;
        delete from erp.kiosk_status where kiosk_id = old.id;
        delete from erp.kiosk_contact where kiosk_id = old.id;
        delete from erp.kiosk_note where kiosk_id = old.id;
    end case;
  if tg_op in ('INSERT', 'UPDATE')
    then return new;
    else return old;
  end if;
end;
$$;
CREATE FUNCTION erp_test.sync_kiosk() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
  /*
  Insert/update/delete erp_test.kiosk and related tables when a pantry.kiosk record is changed
  This code works in conjunction with erp_test.reverse_sync_kiosk. To prevent infinite sync cycle, it does the following:
  1. Use erp_test.kiosk.skip_reverse_trigger transaction scope parameter to signal when it starts
     to prevent a reverse sync to run.
  2. Check if the new record already exists and therefore no changes is needed and the sync should be skipped.
  */
declare
  _client_id integer;
  _client_name text;
  _address_id integer;
  _address1 text;
  _address2 text;
  _city text;
  _state text;
  _zip text;
  _phone text;
  _email text;
  _industry integer;
  _location_type integer := -1;
  _payment_start_date date;
  _payment_stop_date date;
  _general_contact_type integer;
  _general_contact_id integer;
  _accounting_contact_type integer;
  _accounting_contact_id integer;
  _note_type integer;
  _record_exists BOOLEAN;
  _target_record record;
  _insync BOOLEAN;
  _skip_trigger boolean;
begin
  _skip_trigger = (coalesce(current_setting('erp_test.kiosk.skip_forward_trigger', true), '') = 'true');
  if tg_op in ('INSERT', 'UPDATE')
  then
    select * from pantry.temp_kiosk where id = new.id into _target_record;
    _insync = (_target_record = new);
  else
    _insync = false;
  end if;
  if _skip_trigger or _insync
  then
    return null;
  else
    set local erp_test.kiosk.skip_reverse_trigger='true';
    if tg_op in  ('INSERT', 'UPDATE')
      then
        select exists(select 1 from erp_test.kiosk where id = new.id) into _record_exists ;
        if new.client_name = 'Byte'
          then
            new.address = '101 Glacier Point, San Rafael, CA 94901';
            new.contact_first_name = 'Megan';
            new.contact_last_name = 'Mokri';
            new.contact_email = 'megan@bytefoods.co';
            new.accounting_email = 'same';
            new.location_x = 37.950262;
            new.location_y = -122.489975;
        end if;
        select id into _general_contact_type from erp_test.global_attribute_def where name = 'contact_type' and value = 'general';
        select id into _accounting_contact_type from erp_test.global_attribute_def where name = 'contact_type' and value = 'accounting';
        select address1, address2, city, state, zip from erp_test.parse_address(new.address)
          into _address1, _address2, _city, _state, _zip;
        select address.id into _address_id from erp_test.address
        where address1 = _address1 and address2 = _address2 and city = _city and state = _state and zip = _zip;
        _client_name = coalesce(new.client_name, 'Address: ' || new.address);
        select coalesce(ga.id, -1) into _industry
        from erp_test.client_industry ci
               left join (select * from erp_test.global_attribute_def ga where ga.name = 'industry') ga
                         on ci.industry = ga.value
        where ci.client_name = new.client_name;
        if _industry is null then
          _industry = -1;
        end if;
        insert into erp_test.client(name, employees_num, industry)
          values(_client_name, new.employees_num, _industry)
          on conflict(name) do nothing;
        select id into _client_id from erp_test.client c where c.name = _client_name;
        insert into erp_test.address(client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
        values(_client_id, _address1, _address2, _city, _state, _zip, new.location_x, new.location_y, new.timezone)
        on conflict(address1) do
          update set
            (client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
              =
                (_client_id,
                 coalesce(_address1, erp_test.address.address1),
                 coalesce(_address2, erp_test.address.address2),
                 coalesce(_city, erp_test.address.city),
                 coalesce(_state, erp_test.address.state),
                 coalesce(_zip, erp_test.address.zip),
                 coalesce(new.location_x, erp_test.address.location_x),
                 coalesce(new.location_y, erp_test.address.location_y),
                 coalesce(new.timezone, erp_test.address.timezone))
          returning id into _address_id;
        select phone into _phone from erp_test.parse_phone(new.contact_phone);
        if new.contact_email ~ '^\w+@[0-9a-zA-Z_]+?\.[0-9a-zA-Z]{2,3}$'
        then _email = new.contact_email;
        else _email = null;
        end if;
        insert into erp_test.contact(client_id, first_name, last_name, email, phone, contact_type)
        values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
        on conflict do nothing;
        if new.accounting_email = 'same'
        then insert into erp_test.contact(client_id, first_name, last_name, email, phone, contact_type)
        values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _accounting_contact_type)
        on conflict do nothing;
        end if;
        select id into _client_id from erp_test.client where name = _client_name;
        select contact.id into _general_contact_id from erp_test.contact
        where first_name = new.contact_first_name and last_name = new.contact_last_name and contact_type = _general_contact_type;
        select contact.id into _accounting_contact_id from erp_test.contact
        where first_name = new.contact_first_name and last_name = new.contact_last_name and contact_type = _accounting_contact_type;
        if new.payment_start is null or new.payment_start = 0
          then _payment_start_date = null;
          else _payment_start_date = to_timestamp(new.payment_start)::date;
        end if;
        if new.payment_stop is null or new.payment_stop = 0
        then _payment_stop_date = null;
        else _payment_stop_date = to_timestamp(new.payment_stop)::date;
        end if;
    end if;
    case
      when tg_op = 'INSERT' and not _record_exists
        then
          insert into erp_test.kiosk(id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
                                location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
                                deployment_status_id, bank, archived)
            values (new.id, new.campus_id, new.serial, _client_id,
                    new.title, new.kiosk_name, new.geo, _address_id, new.publicly_accessible, _location_type,
                    new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
                    0, 0, new.archived);
          insert into erp_test.hardware_software(kiosk_id, gcm_id, app_vname, app_vcode, features, components,
                                                 server_url, peekaboo_url, email_receipt_subject)
            values(new.id, new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
                   '', new.email_receipt_subject);
          insert into erp_test.kiosk_accounting(kiosk_id, start_date, payment_start, payment_stop, sales_tax,
                                                default_fee_plan, byte_discount, subsidy_info, max_subscription,
                                                subscription_amount, setup_fee, subsidy_notes)
            values (new.id,
                    null, -- start_date,
                    _payment_start_date, _payment_stop_date, new.sales_tax, new.default_fee_plan, new.byte_discount,
                    new.subsidy_info, new.max_subscription, new.subscription_amount,
                    null, -- new.setup_fee,
                    new.subsidy_notes);
          if new.fridge_loc_info is not null and new.fridge_loc_info <> ''
          then
            select id into _note_type from erp_test.global_attribute_def where name = 'note_type' and value = 'Location';
            insert into erp_test.kiosk_note(kiosk_id, note_type, content)
            values(new.id, _note_type, new.fridge_loc_info);
          end if;
          if new.delivery_insns is not null and new.delivery_insns <> ''
          then
            select id into _note_type from erp_test.global_attribute_def where name = 'note_type' and value = 'Delivery Instruction';
            insert into erp_test.kiosk_note(kiosk_id, note_type, content)
            values(new.id, _note_type, new.delivery_insns);
          end if;
          if new.ops_team_notes is not null and new.ops_team_notes <> ''
          then
            select id into _note_type from erp_test.global_attribute_def where name = 'note_type' and value = 'OPS';
            insert into erp_test.kiosk_note(kiosk_id, note_type, content)
              values(new.id, _note_type, new.ops_team_notes);
          end if;
          insert into erp_test.kiosk_status(kiosk_id, last_update, last_status, last_inventory)
            values(new.id, new.last_update, new.last_status, new.last_inventory);
          if _general_contact_id is not null
            then
              insert into erp_test.kiosk_contact(kiosk_id, contact_id) values(new.id, _general_contact_id)
                on conflict do nothing;
          end if;
          return new;
      when tg_op = 'UPDATE' or (tg_op = 'INSERT' and _record_exists) then
        update erp_test.kiosk
          set
              (id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
               location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
               deployment_status_id, bank, archived)
            =
              (new.id, new.campus_id, new.serial, _client_id,
               new.title, new.kiosk_name, new.geo, _address_id, new.publicly_accessible, _location_type,
               new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
               0, 0, new.archived)
            where id = new.id;
        update erp_test.hardware_software
          set
              (gcm_id, app_vname, app_vcode, features, components,
               server_url, peekaboo_url, email_receipt_subject)
            =
                (new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
                 '', new.email_receipt_subject)
            where kiosk_id=new.id;
        update erp_test.kiosk_accounting
          set
              (start_date, payment_start, payment_stop, sales_tax, default_fee_plan, byte_discount,
               subsidy_info, max_subscription, subscription_amount, setup_fee, subsidy_notes)
            =
              (null, _payment_start_date, _payment_stop_date, new.sales_tax, new.default_fee_plan, new.byte_discount,
             new.subsidy_info, new.max_subscription, new.subscription_amount, null, new.subsidy_notes)
            where kiosk_id=new.id;
        update erp_test.kiosk_status
          set
              (last_update, last_status, last_inventory)
            =
              (new.last_update, new.last_status, new.last_inventory)
            where kiosk_id=new.id;
        return new;
      when tg_op = 'DELETE'
        then
          delete from erp_test.kiosk where id = old.id;
          delete from erp_test.hardware_software where kiosk_id = old.id;
          delete from erp_test.kiosk_accounting where kiosk_id = old.id;
          delete from erp_test.kiosk_note where kiosk_id = old.id;
          delete from erp_test.kiosk_status where kiosk_id = old.id;
          delete from erp_test.kiosk_contact where kiosk_id = old.id;
          delete from erp_test.kiosk_note where kiosk_id = old.id;
          return old;
      end case;
  end if; -- _skip_trigger or _insync
end;
$_$;
ALTER FUNCTION erp_test.sync_kiosk() OWNER TO erpuser;
CREATE FUNCTION erp_test.sync_kiosk_reference() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
  /*
Required: populated erp.global_attribute_def, erp.client_industry
Prepare kiosk reference:
  erp.client
  erp.address
  erp.contact
*/
declare
  i smallint;
  address_fields text[5];
  _client_id integer;
  _client_name text;
  _address_id integer;
  _address1 text;
  _address2 text;
  _city text;
  _state text;
  _zip text;
  _phone text;
  _email text;
  _kiosk_name text;
  _industry integer;
  _location_type_string text;
  _location_type integer;
  _general_contact_type integer;
  _accounting_contact_type integer;
  _accounting_contact_id integer;
  _airport_location_type integer;
  _apartment_location_type integer;
  _gym_location_type integer;
  _higher_education_location_type integer;
  _hospital_location_type integer;
  _hotel_location_type integer;
  _k_12_education_location_type integer;
  _other_location_type integer;
  _workplace_location_type integer;
begin
  select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
  select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';
  select id into _airport_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Airport';
  select id into _apartment_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Apartment';
  select id into _gym_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Gym';
  select id into _higher_education_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Higher Education';
  select id into _hospital_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Hospital';
  select id into _hotel_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Hotel';
  select id into _k_12_education_location_type from erp.global_attribute_def where name = 'location_type' and value = 'K-12 Education';
  select id into _other_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Other';
  select id into _workplace_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Workplace';
  if tg_op in ('INSERT', 'UPDATE')
    then
      if new.client_name = 'Byte'
        then
          new.address = '101 Glacier Point, San Rafael, CA 94901';
          new.contact_first_name = 'Megan';
          new.contact_last_name = 'Mokri';
          new.contact_email = 'megan@bytefoods.co';
          new.accounting_email = 'same';
          new.location_x = 37.950262;
          new.location_y = -122.489975;
      end if;
      select address1, address2, city, state, zip from erp.parse_address(new.address)
        into _address1, _address2, _city, _state, _zip;
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);
      select coalesce(ga.id, -1) into _industry
      from erp.client_industry ci
             left join (select * from erp.global_attribute_def ga where ga.name = 'industry') ga
                       on ci.industry = ga.value
      where ci.client_name = new.client_name;
      if _industry is null then
        _industry = -1;
      end if;
      insert into erp_test.client(name, employees_num, industry)
        values(_client_name, new.employees_num, _industry)
        on conflict(name) do nothing;
      select id into _client_id from erp_test.client c where c.name = _client_name;
      insert into erp_test.address(client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
      values(_client_id, _address1, _address2, _city, _state, _zip, new.location_x, new.location_y, new.timezone)
      on conflict(address1) do
        update set
          (client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
            =
          (_client_id,
          coalesce(_address1, erp_test.address.address1),
          coalesce(_address2, erp_test.address.address2),
          coalesce(_city, erp_test.address.city),
          coalesce(_state, erp_test.address.state),
          coalesce(_zip, erp_test.address.zip),
          coalesce(new.location_x, erp_test.address.location_x),
          coalesce(new.location_y, erp_test.address.location_y),
          coalesce(new.timezone, erp_test.address.timezone))
        returning id into _address_id;
      select phone into _phone from erp.parse_phone(new.contact_phone);
      if new.contact_email ~ '^\w+@[0-9a-zA-Z_]+?\.[0-9a-zA-Z]{2,3}$'
      then _email = new.contact_email;
      else _email = null;
      end if;
      insert into erp_test.contact(client_id, first_name, last_name, email, phone, contact_type)
      values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
      on conflict do nothing;
      if new.accounting_email = 'same'
      then insert into erp_test.contact(client_id, first_name, last_name, email, phone, contact_type)
           values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _accounting_contact_type)
           on conflict do nothing;
      end if;
    return new;
  end if;
end;
$_$;
ALTER FUNCTION erp_test.sync_kiosk_reference() OWNER TO erpuser;
CREATE FUNCTION erp_test.sync_product() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  _sku_group_id integer;
  _product_exists BOOLEAN;
  _target_record record;
  _insync BOOLEAN;
  _skip_trigger boolean;
  _consumer_category_id integer;
  /*
  Insert/update/delete erp_test.product and related tables according to tg_op value, except for when insert conflict, then
update erp_test.product and related tables instead. This exception happens if syncing table and synced tables were not
in sync (for example, aws dms was disabled)
  This code works in conjunction with erp_test.reverse_sync_product. To prevent infinite sync cycle, it does the following:
  1. Use erp_test.product.skip_trigger transaction scope parameter to signal when either a sync or reverse sync
    is in progress to prevent a sync to initiate reverse sync an vice versa
  2. Check if the new record already exists and therefore no changes is needed and sync should be skipped
  */
begin
  _skip_trigger = (coalesce(current_setting('erp_test.product.skip_forward_trigger', true), '') = 'true');
  if tg_op in ('INSERT', 'UPDATE')
  then
    select * from pantry.product where id = new.id into _target_record;
    _insync = (_target_record = new);
  else
    _insync = false;
  end if;
  if _skip_trigger -- or _insync
  then
    return null;
  else
    set local erp_test.product.skip_reverse_trigger='true';
    if tg_op in ('INSERT', 'UPDATE')
    then
      select id from erp_test.sku_group where fc_title = new.fc_title into _sku_group_id;
      select into _product_exists exists(select 1 from erp_test.product where id = new.id);
      select into _consumer_category_id id from product_category_def where name = 'consumer' and value = new.consumer_category;
    end if;
    case when tg_op = 'INSERT' and not _product_exists
      then
        select into _product_exists True from erp_test.product where id = new.id;
        insert into erp_test.product(id, brand, campus_id, sku_group_id, fc_title, archived, last_update)
        values(new.id, new.vendor, new.campus_id, _sku_group_id, new.fc_title, new.archived, new.last_update);
        insert into erp_test.product_asset(product_id, title, description, tiny_description, short_description, medium_description, long_description, image_time)
        values (new.id, new.title, new.description, new.tiny_description, new.short_description, new.medium_description, new.long_description, new.image_time);
        insert into erp_test.product_pricing(product_id,price,cost,ws_case_cost,pricing_tier,taxable)
        values(new.id,new.price,new.cost,new.ws_case_cost,new.pricing_tier,new.taxable);
        insert into erp_test.product_nutrition(product_id,total_cal,num_servings,calories,proteins,sugar,carbohydrates,fat,ingredients,shelf_time)
        values(new.id,new.total_cal,new.num_servings,new.calories,new.proteins,new.sugar,new.carbohydrates,new.fat,new.ingredients,new.shelf_time);
        insert into erp_test.product_property(product_id, property_id)
          select p.id, def.id from
            (select id, unnest(string_to_array(attribute_names, ';')) attrib
             from pantry.product) p
              join erp_test.product_property_def def
                   on p.attrib = def.value and p.id = new.id
          on conflict do nothing;
        insert into erp_test.product_category(product_id, category_id) values(new.id, _consumer_category_id);
        insert into erp_test.product_handling(product_id,width_space,height_space,depth_space,slotted_width,kiosk_ship_qty,
                                         ws_case_size,tag_volume,tag_delivery_option,tag_applied_by,pick_station)
        values(new.id,new.width_space,new.height_space,new.depth_space,new.slotted_width,new.kiosk_ship_qty,
               new.ws_case_size,new.tag_volume,new.delivery_option,new.tag_applied_by,new.pick_station);
        insert into erp_test.product_sourcing(product_id,vendor,source) values(new.id,new.vendor,new.source);
        return new;
      when tg_op = 'UPDATE' or (tg_op = 'INSERT' and _product_exists) then
        update erp_test.product
        set brand=new.vendor, campus_id=new.campus_id, sku_group_id=_sku_group_id,
            fc_title=new.fc_title, archived=new.archived, last_update=new.last_update
        where id = new.id;
        update erp_test.product_asset
        set title=new.title, description=new.description, tiny_description=new.tiny_description,
            short_description=new.short_description, medium_description=new.medium_description,
            long_description=new.long_description, image_time=new.image_time
        where product_id = new.id;
        update erp_test.product_pricing
        set price=new.price,cost=new.cost,ws_case_cost=new.ws_case_cost,pricing_tier=new.pricing_tier,taxable=new.taxable
        where product_id=new.id;
        update erp_test.product_nutrition
        set total_cal=new.total_cal,num_servings=new.num_servings,calories=new.calories,proteins=new.proteins,
            sugar=new.sugar,carbohydrates=new.carbohydrates,fat=new.fat,ingredients=new.ingredients,
            shelf_time=new.shelf_time where product_id=new.id;
        delete from erp_test.product_property where product_id=new.id;
        insert into erp_test.product_property(product_id, property_id)
        select p.id, def.id from
          (select id, unnest(string_to_array(attribute_names, ';')) attrib
           from pantry.product) p
            join erp_test.product_property_def def
                 on p.attrib = def.value and p.id = new.id;
        insert into erp_test.product_category(product_id, category_id) values(new.id, _consumer_category_id)
          on conflict(product_id, category_id) do update set category_id = _consumer_category_id;
        update erp_test.product_handling
        set width_space=new.width_space,height_space=new.height_space,depth_space=new.depth_space,
            slotted_width=new.slotted_width,kiosk_ship_qty=new.kiosk_ship_qty,ws_case_size=new.ws_case_size,
            tag_volume=new.tag_volume,tag_delivery_option=new.delivery_option,tag_applied_by=new.tag_applied_by,
            pick_station=new.pick_station
        where product_id=new.id;
        update erp_test.product_sourcing set vendor=new.vendor,source=new.source where product_id=new.id;
        return new;
      when tg_op = 'DELETE' then
        delete from erp_test.product where id = old.id;
        delete from erp_test.product_asset where product_id=old.id;
        delete from erp_test.product_pricing where product_id=old.id;
        delete from erp_test.product_nutrition where product_id=old.id;
        delete from erp_test.product_property where product_id=old.id;
        delete from erp_test.product_handling where product_id=old.id;
        delete from erp_test.product_sourcing where product_id=old.id;
        return old;
      end case;
  end if;
end;
$$;
CREATE FUNCTION dw.export_consolidated_remittance(month_date date) RETURNS TABLE(campus_title character varying, campus_id bigint, name character varying, email character varying, number_of_kiosks bigint, client_type text, sales_list_price numeric, sales_after_discount numeric, complimentary numeric, freedom_pay numeric, credit_card numeric, monthly_lease numeric, connectivity_fee numeric, payment_processing_fee numeric, tag_fee numeric, tags_got integer, tag_price numeric, net_remittance numeric, net_total numeric, manual_adjustment numeric, fees_before_tags numeric, details text)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT campus_remittance.campus_title,
            campus_remittance.campus_id,
            campus_remittance.name,
            campus_remittance.email,
            campus_remittance.number_of_kiosks,
            campus_remittance.client_type,
            COALESCE(campus_remittance.sales_list_price, 0) as sales_list_price,
            COALESCE(campus_remittance.sales_after_discount, 0) as sales_after_discount,
            COALESCE(campus_remittance.complimentary, 0) as complimentary,
            COALESCE(campus_remittance.freedom_pay, 0) as freedom_pay,
            COALESCE(campus_remittance.credit_card, 0) as credit_card,
            COALESCE(campus_remittance.monthly_lease, 0) as monthly_lease,
            COALESCE(campus_remittance.connectivity_fee, 0) as connectivity_fee,
            COALESCE(campus_remittance.payment_processing_fee, 0) as payment_processing_fee,
            COALESCE(campus_remittance.tag_fee, 0) as tag_fee,
            COALESCE(campus_remittance.tags_got, 0) as tags_got,
            COALESCE(campus_remittance.tag_price, 0) as tag_price,
            COALESCE(campus_remittance.net_remittance, 0) as net_remittance,
            COALESCE(campus_remittance.net_total, 0) as net_total,
            COALESCE(campus_remittance.manual_adjustment, 0) as manual_adjustment,
            COALESCE(campus_remittance.connectivity_fee, 0)
                + COALESCE(campus_remittance.payment_processing_fee, 0)
                + COALESCE(campus_remittance.monthly_lease, 0) as fees_before_tags,
            campus_remittance.details
            FROM (SELECT c.campus_title,
                c.campus_id,
                r.name,
                r.email,
                r.number_of_kiosks,
                r.client_type,
                r.sales_after_discount,
                r.sales_list_price,
                r.complimentary,
                r.freedom_pay,
                r.credit_card,
                r.monthly_lease,
                r.connectivity_fee,
                r.payment_processing_fee,
                COALESCE(new_tags_obtained.total_price, 0) as tag_fee,
                COALESCE(new_tags_obtained.amount_total, 0)  as tags_got,
                r.tag_price,
                r.credit_card
                    - r.monthly_lease
                    - r.connectivity_fee
                    - r.payment_processing_fee
                    - COALESCE(new_tags_obtained.total_price, 0)
                    + r.manual_adjustment  as net_remittance,
                r.credit_card
                    - r.monthly_lease
                    - r.connectivity_fee
                    - r.payment_processing_fee
                    - COALESCE(new_tags_obtained.total_price, 0)
                    + r.manual_adjustment
                    + r.complimentary
                    + r.freedom_pay as net_total,
                r.manual_adjustment,
                r.details
                FROM (SELECT id as campus_id,
                    title as campus_title
                    FROM pantry.campus
                ) c
                LEFT JOIN (SELECT er.campus_title,
                    er.campus_id,
                    er.name,
                    er.email,
                    count(er.kiosk_id) as number_of_kiosks,
                    STRING_AGG(er.kiosk_id::text, ', ') as kiosk_id,
                    STRING_AGG(distinct(er.client_type), ', ') as client_type,
                    sum(er.credit_card) as credit_card,
                    sum(er.sales_after_discount) as sales_after_discount,
                    sum(er.sales_list_price) as sales_list_price,
                    sum(er.complimentary) as complimentary,
                    sum(er.freedom_pay) as freedom_pay,
                    sum(er.monthly_lease) as monthly_lease,
                    sum(er.connectivity_fee) as connectivity_fee,
                    sum(er.payment_processing_fee) as payment_processing_fee,
                    max(er.tag_price) as tag_price,
                    sum(er.manual_adjustment) as manual_adjustment,
                    STRING_AGG(er.details, ' | ') as details
                    FROM dw.export_remittance(month_date) er
                    GROUP BY er.name, er.campus_id, er.campus_title, er.email
                ) r
                ON r.campus_id = c.campus_id
                LEFT JOIN
                (WITH consolidated_tag_price AS
                (SELECT implicit_price.campus_id, implicit_price.tag_type,
                    COALESCE(explicit_price.price, implicit_price.price) price
                    FROM (SELECT c.id campus_id, tag_type, tp.price
                    FROM pantry.campus c, erp.tag_price tp
                    WHERE tp.campus_id = 0) implicit_price
                LEFT JOIN
                (SELECT c.id campus_id, tp.tag_type, tp.price
                   FROM pantry.campus c
                   JOIN erp.tag_price tp ON tp.campus_id = c.id) explicit_price
                   ON explicit_price.campus_id = implicit_price.campus_id
                   AND explicit_price.tag_type = implicit_price.tag_type)
                SELECT SUM(tag_order.amount)::int AS amount_total,
                   p.campus_id,
                   SUM(tag_order.amount * tp.price) AS total_price
                   FROM erp.tag_order
                   LEFT JOIN erp.tag_type tt ON tt.id = tag_order.tag_type_id
                   JOIN pantry.product p ON tag_order.product_id = p.id
                   JOIN pantry.campus c ON p.campus_id = c.id
                   JOIN consolidated_tag_price tp ON tt.type = tp.tag_type
                   AND tp.campus_id = p.campus_id
                WHERE status = 'fulfilled'
                AND process_ts >=  date_trunc('month', month_date::date)
                AND process_ts <  date_trunc('month', month_date::date + INTERVAL '1 month')
                GROUP BY p.campus_id
                ) AS new_tags_obtained
                ON new_tags_obtained.campus_id = c.campus_id
            ) as campus_remittance
            WHERE campus_remittance.sales_after_discount > 0 OR
            campus_remittance.complimentary > 0 OR
            campus_remittance.freedom_pay > 0 OR
            campus_remittance.credit_card > 0 OR
            campus_remittance.monthly_lease > 0 OR
            campus_remittance.connectivity_fee > 0 OR
            campus_remittance.payment_processing_fee > 0 OR
            campus_remittance.tag_fee > 0 OR
            campus_remittance.tags_got > 0 OR
            campus_remittance.tag_price > 0 OR
            campus_remittance.net_remittance > 0 OR
            campus_remittance.net_total > 0 OR
            campus_remittance.manual_adjustment > 0 OR
            campus_remittance.number_of_kiosks > 0
            ORDER BY campus_remittance.campus_id;
    END;
$$;
CREATE FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date, ending_date);
        PERFORM dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date, ending_date);
        PERFORM dw.insert_sales_daily_byte_foods_summary(beginning_date, ending_date);
    END;
$$;
CREATE FUNCTION dw.refresh_dim_product() RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO dw.dim_product (id,
            campus_id,
            title,
            fc_title,
            consumer_category,
            archived)
            (SELECT p.id,
                p.campus_id,
                pa.title,
                p.fc_title,
                p.consumer_category,
                p.archived
                FROM pantry.product p
                LEFT JOIN erp.product_asset pa
                ON p.id = pa.product_id
            )
            ON CONFLICT (id) DO UPDATE
            SET (campus_id, title, fc_title, consumer_category, archived) =
                (excluded.campus_id, excluded.title, excluded.fc_title, excluded.consumer_category, excluded.archived);       
        END;
$$;
CREATE FUNCTION test.uptime_percentage(start_date date, end_date date) RETURNS TABLE(uptime_percent numeric)
    LANGUAGE plpgsql
    AS $$
declare
  total_active_kiosks integer;
  measured_heartbeats integer;
  expected_heartbeats integer;
begin
  /*
  Return uptime percentage: 100 * measured_heartbeats/expected_heartbeats.
  Heart beats are reported every 10 minutes.
  Caveat: kiosks that enter/exit service during the reporting period.
   */
  select count(*), sum(heart_beats)
  from
    (select
       kiosk_id, count(*) heart_beats
     FROM kiosk_status
            JOIN pantry.kiosk ON kiosk.id = kiosk_status.kiosk_id
     WHERE to_timestamp(time) >= start_date
       AND to_timestamp(time)  < end_date
       AND kiosk.archived = 0
       AND to_timestamp(deployment_time) < start_date
     group by 1) per_kiosk_heartbeats
    into total_active_kiosks, measured_heartbeats;
  select 144 * total_active_kiosks *  (end_date - start_date) into expected_heartbeats;
  return query
    select (100 * measured_heartbeats::decimal/expected_heartbeats)::decimal(4,2);
end
$$;
CREATE FUNCTION inm_test.pick_get_delivery_schedule(pick_date date) RETURNS TABLE(driver_name character varying, route_date_time timestamp with time zone, kiosk_id integer, kiosk_title character varying, address character varying, delivery_order integer)
    LANGUAGE plpgsql
    AS $$
declare
  latest_import_ts timestamp;
  pst_plan_window_start_str text;
  plan_window_start timestamp with time zone;
  plan_window_stop timestamp with time zone;
  /*
  Purpose: return INM delivery schedule for a pick date.
  Input
    target_date: pick_date
  Return
    Data to generate the drivers sheets
  */
begin
    pst_plan_window_start_str = cast(pick_date as text) || ' 13:00 -8';
    select into plan_window_start cast(pst_plan_window_start_str as timestamp with time zone);
    plan_window_stop = plan_window_start + interval '22 hours';
  return query
    select rs.driver_name, rs.route_date_time, location_number kiosk_id, k.title kiosk_title, k.address, rs.stop_number delivery_order
    from mixalot.route_stop rs join pantry.kiosk k on rs.location_number = k.id
    where rs.route_date_time between plan_window_start and plan_window_stop;
end;
$$;
CREATE FUNCTION public.dowhour(timestamp with time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ((1+extract(DOW FROM $1))*100 + extract(hour from $1))::int
$_$;
ALTER FUNCTION public.dowhour(timestamp with time zone) OWNER TO erpuser;
CREATE FUNCTION public.if(boolean, anyelement, anyelement) RETURNS anyelement
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CASE WHEN ($1) THEN ($2) ELSE ($3) END
$_$;
ALTER FUNCTION public.if(boolean, anyelement, anyelement) OWNER TO erpuser;
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
CREATE FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) RETURNS TABLE(kiosk_id bigint, kiosk_title character varying, campus_id bigint, campus_title character varying, geo character varying, client_name character varying, byte_discount character varying, subsidy_info character varying, subscription_amount numeric, amount_list_price numeric, credit_card numeric, food_cost numeric, spoilage numeric, losses numeric, margin numeric, deliveries numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT fd.kiosk_id,
            k.title as kiosk_title,
            k.campus_id,
            c.title as campus_title,
            k.geo,
            k.client_name,
            k.byte_discount,
            k.subsidy_info,
            k.subscription_amount,
            sum(sales_amt) as amount_list_price,
            sum(ip_commerce) as credit_card,
            sum(cost_amt) as food_cost,
            sum(spoils_amt) as spoilage,
            sum(losses_amt) as losses,
            k.subscription_amount + sum(sales_amt) - sum(cost_amt) - sum(spoils_amt) - sum(losses_amt)
                as margin,
            sum(deliv.deliveries) as deliveries
            FROM pantry.kiosk k
            JOIN dw.fact_daily_kiosk_sku_summary fd
            ON fd.kiosk_id = k.id
            JOIN pantry.campus c
            ON c.id = k.campus_id
            LEFT JOIN (SELECT (TO_CHAR(route_date_time, 'YYYYMMDD'))::int as date_id,
                location_number,
                count(*) as deliveries
                FROM mixalot.route_stop rs
                WHERE route_date_time::date >= beginning_date
                AND route_date_time::date <= ending_date
                GROUP BY (TO_CHAR(route_date_time, 'YYYYMMDD'))::int, location_number
            ) as deliv
            ON fd.date_id = deliv.date_id
            AND fd.kiosk_id = deliv.location_number
            JOIN dw.dim_date as dd
            ON dd.date_id = fd.date_id
            WHERE as_date >= beginning_date
            AND as_date <= ending_date
            GROUP BY fd.kiosk_id, kiosk_title, k.campus_id, k.geo, k.client_name,
            k.subscription_amount, c.title, k.byte_discount, k.subsidy_info;
    END;
$$;
CREATE FUNCTION dw.losses(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, kiosk_id_ bigint, product_id_ bigint, time_updated_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        /*
        For a given time window W1 (e.g. from beginning_date through ending_date) and an extended time
        window W2, with W1 being a subset of W2 (e.g. W1 +1 and -1 month from beginning_date through
        ending_date)
        Loss: count of unique epc's which have at least one out label record within W1 and have no sale,
        spoil, or inventory records within W2.
        An out label record has no order id and has a LABEL STATUS of 'out' or 'sold'. For an out label record
        to be within the time window W1, the label update time needs to be within W1.
        For specification details, see these related tickets:
        * ENG-834: Art's logic, the origin for this function
        * ENG-1922: Add label state lost; Restrict order state from the sales subquery
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
                    AND l.status in ('out', 'lost')
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
                    WHERE to_timestamp(time_updated)::date >= beginning_date
                    AND to_timestamp(time_updated)::date <= ending_date
                    AND l.status in ('out', 'lost')
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
                AND o.state in ('Placed', 'Processed', 'Refunded', 'Adjusted', 'Declined', 'Error')
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
                AND l.status in ('out', 'lost')
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
CREATE FUNCTION fnrenames.parse_phone(text_to_parse text) RETURNS TABLE(phone text)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose - Return the first phone number from an contact_phone field in pantry.kiosk string with embedded phones.
    Input -
      s: string with embedded phone
    Return -
      phone: general phone number
      mobile: mobile phone number
    */
declare
  s text;
  parsed_phone text default null;
begin
  s = regexp_replace(text_to_parse, '\D', '', 'g');
  if length(s) >= 10
  then
    parsed_phone = substring(s, 1, 10);
  end if;
  return query
    select parsed_phone;
end;
$$;
CREATE FUNCTION dw.export_losses(beginning_date date, ending_date date) RETURNS TABLE(as_date date, campus_id integer, campus_title character varying, kiosk_id bigint, kiosk_title character varying, product_id bigint, product_title character varying, menu_category character varying, product_group character varying, product_cost numeric, losses_qty integer, losses_cost numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT dd.as_date,
        fd.campus_id,
        c.title as campus_title,
        fd.kiosk_id,
        k.title as kiosk_title,
        fd.product_id,
        p.title as product_title,
        p.consumer_category as menu_category,
        p.fc_title as product_group,
        p.cost as product_cost,
        fd.losses_qty,
        fd.losses_amt as losses_cost
        FROM dw.fact_daily_kiosk_sku_summary fd
        JOIN pantry.product p
        ON p.id = fd.product_id
        JOIN pantry.kiosk k
        ON k.id = fd.kiosk_id
        JOIN dw.dim_date dd
        ON dd.date_id = fd.date_id
        JOIN pantry.campus c
        ON c.id = fd.campus_id
        WHERE fd.losses_qty > 0
        AND dd.as_date >= beginning_date
        AND dd.as_date <= ending_date;
    END;
$$;
CREATE FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
     INSERT INTO dw.fact_daily_kiosk_sku_summary(
        campus_id,
        kiosk_id,
        product_id,
        date_id,
        losses_qty,
        losses_amt
        )
        (--- Byte losses
        SELECT campus_id,
            kiosk_id,
            product_id,
            (TO_CHAR(time_updated, 'YYYYMMDD'))::int AS date_id,
            COUNT(*) AS losses_qty,
            SUM(cost) AS losses_amt
            FROM dw.byte_losses(beginning_date, ending_date) bl
            LEFT JOIN pantry.kiosk k
            ON bl.kiosk_id = k.id
            GROUP BY kiosk_id, product_id, date_id, campus_id
        UNION ALL
         SELECT campus_id,
            kiosk_id,
            product_id,
            (TO_CHAR(time_updated, 'YYYYMMDD'))::int AS date_id,
            COUNT(*) AS losses_qty,
            SUM(cost) AS losses_amt
            FROM dw.non_byte_losses(beginning_date, ending_date) bl
            LEFT JOIN pantry.kiosk k
            ON bl.kiosk_id = k.id
            GROUP BY kiosk_id, product_id, date_id, campus_id
        )
        ON CONFLICT (campus_id, product_id, kiosk_id, date_id) DO UPDATE
        SET (losses_qty, losses_amt) =
        (excluded.losses_qty, excluded.losses_amt);
END;
$$;
CREATE FUNCTION dw.insert_sales_monthly_byte_foods_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO dw.fact_monthly_byte_foods_summary(
            year_month,
            active_byte_customers,
            active_skus,
            active_brands,
            active_cards,
            active_usernames,
            active_emails,
            orders,
            orders_w_email)
        (SELECT (CONCAT( extract(year from time_bought),  to_char(time_bought,'MM')))::int   as month_year,
            count(DISTINCT client_name) as active_byte_customers,
            count(DISTINCT s.product_id) as active_skus,
            count(DISTINCT p.vendor) as active_brands,
            count(DISTINCT card_hash) as active_cards,
            count(DISTINCT (concat("left"(btrim(o.first_name::text), 1), '.', btrim(o.last_name::text)))) as
                active_usernames,
            count(DISTINCT email) as active_emails,
            count(DISTINCT s.order_id) as orders,
            count(DISTINCT(CASE WHEN o.email IS NULL OR o.email::text = ''::text
                THEN ''::character varying
                ELSE o.order_id
                END)) as orders_w_email
            FROM dw.byte_sales(date_trunc('month', month_date::date)::date, (date_trunc('month',
                month_date::date) + interval '1 month' -  interval '1 day' )::date ) s
            LEFT JOIN pantry.kiosk k
            ON s.kiosk_id = k.id
            LEFT JOIN pantry.order o
            ON o.order_id = s.order_id
            LEFT JOIN pantry.product p
            ON p.id = s.product_id
            LEFT JOIN pantry.feedback f
            ON f.order_id = o.order_id
            GROUP BY (CONCAT( extract(year from time_bought),  to_char(time_bought,'MM')))::int
        )
        ON CONFLICT (year_month) DO UPDATE
        SET (active_byte_customers, active_skus, active_brands, active_cards,
        active_usernames, active_emails, orders, orders_w_email) =
        (excluded.active_byte_customers, excluded.active_skus, excluded.active_brands,
        excluded.active_cards, excluded.active_usernames, excluded.active_emails, excluded.orders,
        excluded.orders_w_email);
    END;
$$;
CREATE FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    PERFORM dw.clear_fact_monthly_kiosk_summary(month_date);
    PERFORM dw.insert_in_monthly_kiosk_summary(month_date);
END;
$$;
CREATE FUNCTION erp_test.fn_ro_order_update_full_price(orderid character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  rfp NUMERIC(11,2);
  fp NUMERIC(11,2);
  tc bigint;
  orderid varchar(135);
BEGIN
  rfp = (
    SELECT
      CASE WHEN (o.state <> 'NonTrans')
             THEN
             COALESCE(SUM(l.price), 0)
        END
    FROM pantry.label l
           JOIN pantry.order o ON o.order_id = l.order_id
    GROUP BY o.state
  ),
    fp = (
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
    tc = (SELECT date_part('epoch',CURRENT_TIMESTAMP)::int);
  UPDATE pantry.ro_order
  SET
    real_full_price = rfp, full_price = fp, created = tc
  WHERE ro_order.order_id = orderId;
END
$$;
CREATE FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    DELETE FROM dw.fact_monthly_kiosk_summary 
    WHERE date_id = TO_CHAR(date_trunc('month', month_date ), 'YYYYMMDD')::int;
END;
$$;
CREATE FUNCTION dw.export_feedback(beginning_date date, ending_date date) RETURNS TABLE(order_id character varying, created timestamp with time zone, first_name character varying, last_name character varying, amount_list_price numeric, amount_paid numeric, campus_id bigint, kiosk_id bigint, kiosk_title character varying, geo character varying, message character varying, rate bigint, taste bigint, freshness bigint, variety bigint, value bigint, product_id_list text, product_title_list text)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT o.order_id,
            to_timestamp(o.created) as created,
            c.first_name,
            c.last_name,
            o.amount_list_price,
            o.amount_paid,
            k.campus_id,
            k.id as kiosk_id,
            k.title as kiosk_title,
            k.geo,
            f.message,
            f.rate,
            COALESCE(f.taste, 0) as taste,
            COALESCE(f.freshness, 0) as freshness,
            COALESCE(f.variety, 0) as variety,
            COALESCE(f.value, 0) as value,
            STRING_AGG(p.id::text, '; ') product_id_list,
            STRING_AGG(p.title, '; ') product_title_list
            FROM pantry.feedback f
            JOIN pantry.order o ON o.order_id = f.order_id
            JOIN pantry.card c ON c.hash = o.card_hash
            JOIN pantry.kiosk k ON o.kiosk_id = k.id
            JOIN pantry.label l ON l.order_id = o.order_id
            JOIN pantry.product p ON p.id = l.product_id
            WHERE o.created BETWEEN extract('EPOCH' FROM (beginning_date)::timestamp WITH TIME ZONE)::BIGINT
                AND extract('EPOCH' FROM (ending_date + INTERVAL '1 day')::timestamp WITH TIME ZONE)::BIGINT
                 - 1
            GROUP BY o.created, k.campus_id, c.first_name, c.last_name, o.order_id, o.amount_list_price,
            o.amount_paid, k.id, k.title, k.geo, f.message, f.rate, f.taste, f.freshness, f.variety, f.value
            ORDER BY o.created DESC;
    END;
$$;
CREATE FUNCTION dw.export_kiosk_status(kiosk_number bigint) RETURNS TABLE(kiosk_id_ bigint, geo_ character varying, kiosk_temperature_ numeric, kiosk_temperature_count_ smallint, kiosk_temperature_source_ character varying, temperature_tags_ character varying, kit_temperature_ numeric, power_ integer, battery_level_ smallint, rfid_0_ integer, rfid_1_ integer, rfid_2_ integer, rfid_3_ integer, rfid_4_ integer, rfid_5_ integer, rfid_6_ integer, rfid_7_ integer, modem_signal_percentage_ smallint, modem_signal_type_ character varying, ip_ character varying, time_ timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
    SELECT ks.kiosk_id as kiosk_id_ ,
        k.geo as geo_,
        ks.kiosk_temperature as kiosk_temperature_,
        ks.kiosk_temperature_count as kiosk_temperature_count_,
        ks.kiosk_temperature_source as kiosk_temperature_source_,
        ks.temperature_tags as temperature_tags_,
        ks.kit_temperature as kit_temperature_,
        ks.power as power_,
        ks.battery_level as battery_level_,
        ks.rfid_0 as rfid_0_,
        ks.rfid_1 as rfid_1_,
        ks.rfid_2 as rfid_2_,
        ks.rfid_3 as rfid_3_,
        ks.rfid_4 as rfid_4_,
        ks.rfid_5 as rfid_5_,
        ks.rfid_6 as rfid_6_,
        ks.rfid_7 as rfid_7_,
        ks.modem_signal_percentage as modem_signal_percentage_,
        ks.modem_signal_type as modem_signal_type_,
        ks.ip as ip_,
        to_timestamp(ks.time)::TIMESTAMP WITH TIME ZONE as time_
        FROM pantry.kiosk_status ks
        JOIN pantry.kiosk k ON k.id = ks.kiosk_id
        WHERE ks.kiosk_id = kiosk_number
        AND ks.time >= extract('EPOCH' FROM (now()::date - INTERVAL '3 months')::timestamp WITH TIME
        ZONE)::BIGINT
        ORDER BY ks.time DESC;
END;
$$;
CREATE FUNCTION migration.test_get_product_record(pid integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
declare
  result record;
begin
      select * from migration.product where id=pid;
end;
$$;
CREATE FUNCTION pantry.sync_label_order() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  _target_record record;
  _insync BOOLEAN;
  /*
  Insert/update/delete pantry.label_order according to tg_op value.
  This code works in conjunction with pantry.sync_label_order_reverse. Together they use transaction scope
  SKIP_SYNC_PARAM_NAME param to signal if the sync or reverse sync should be skipped to prevent unnecessary sync and
  more importantly infinite sync cycles.
  */
begin
  if tg_op in ('INSERT', 'UPDATE')
  then
    select * from pantry.label_order where id = new.id into _target_record;
    _insync = (_target_record = new);
  else
    _insync = false;
  end if;
  if _insync
  then
    return null;
  else
    if tg_op in ('INSERT', 'UPDATE')
    then
      return new;
    else
      return old;
    end if;
  end if;
end;
$$;
CREATE FUNCTION dw.byte_sales(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, order_id character varying, kiosk_id bigint, product_id bigint, time_bought timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
        /*
        The following query is used to get all non free kiosks and free kiosks sales. SEE
        ENG-708. Byte kiosks sales = non free kiosks sale + free kiosk sales + free kiosk losses.
        Alterations from ENG-1922
        - remove product_campus_id filter
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
                FROM dw.sales(beginning_date, ending_date)  gs
                JOIN pantry.kiosk k
                ON gs.kiosk_id_ = k.id
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND enable_reporting_ = 1
                AND kiosk_campus_id_ = BYTE_CAMPUS
            UNION
            SELECT epc_,
                NULL as order_id_,
                kiosk_id_,
                product_id_,
                time_updated_ as time_bought_,
                cost_ ,
                price_
                FROM dw.losses(beginning_date, ending_date)  gl
                JOIN pantry.kiosk k
                ON gl.kiosk_id_ = k.id
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND enable_reporting_ = 1
                AND kiosk_campus_id_ = BYTE_CAMPUS
            UNION
            SELECT epc_,
                order_id_,
                kiosk_id_,
                product_id_,
                time_bought_,
                cost_,
                price_
                FROM dw.sales(beginning_date, ending_date)  gs
                JOIN pantry.kiosk k
                ON gs.kiosk_id_ = k.id
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE (value != 100 OR value IS NULL)
                AND enable_reporting_ = 1
                AND kiosk_campus_id_ = BYTE_CAMPUS
            ) as all_kiosk_sale;
    END;
$$;
CREATE FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $_$
    BEGIN
        INSERT INTO dw.fact_daily_kiosk_sku_summary(
            campus_id,
            kiosk_id,
            product_id,
            date_id,
            ip_commerce,
            freedom_pay,
            card_smith,
            complimentary,
            sales_after_discount
        )
        (SELECT campus_id,
            kiosk_id,
            product_id,
            date_id,
            sum(ipcommerce) as ipcommerce,
            sum(freedomPay) as freedomPay,
            sum(CardSmith) as cardSmith,
            sum(Complimentary) as complimentary,
            sum(sales_after_discount) as sales_after_discount
            FROM (SELECT  kiosk_campus_id as campus_id,
                kiosk_id,
                product_id,
                date_id,
                CASE WHEN payment_system = 'IPCommerce' OR payment_system =  'Express'
                    THEN sum(price) END as ipcommerce,
                CASE WHEN payment_system = 'FreedomPay'
                    THEN sum(price) END as freedomPay,
                CASE WHEN payment_system = 'CardSmith'
                    THEN sum(price) END as cardSmith,
                CASE WHEN payment_system = 'Complimentary' OR payment_system = 'Nursing'
                    THEN sum(price) END as complimentary,
                CASE WHEN payment_system = 'Complimentary'
                    OR payment_system =  'Express'
                    OR payment_system = 'FreedomPay'
                    OR payment_system = 'CardSmith'
                    OR payment_system = 'Nursing'
                    THEN sum(price) END as sales_after_discount
                FROM (SELECT (TO_CHAR(date_, 'YYYYMMDD'))::int AS date_id,
                    kiosk_id,
                    product_id,
                    kiosk_campus_id,
                    payment_system,
                    GREATEST(
                      COALESCE(sum(price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                        IS NOT NULL THEN real_discount ELSE  flat_discount END), 0),
                      0)
                      AS price
                    FROM (SELECT payment_system,
                        to_timestamp(created)::date as date_,
                        COALESCE(l.cost) as cost,
                        COALESCE(l.price) as price,
                        l.kiosk_id,
                        l.product_id,
                        k.campus_id as kiosk_campus_id,
                        k.enable_reporting,
                        co.real_discount,
                        co.flat_discount
                        FROM pantry.label l
                        JOIN pantry.kiosk k
                        ON k.id = l.kiosk_id
                        JOIN pantry.product p
                        ON p.id = l.product_id
                        JOIN pantry.order o
                        ON o.order_id = l.order_id
                        LEFT JOIN pantry.coupon co
                        ON co.id = o.coupon_id
                        WHERE created BETWEEN extract('EPOCH' FROM (beginning_date::date))::BIGINT
                        AND extract('EPOCH' FROM (ending_date::date + interval '1 day'))::BIGINT - 1
                        AND o.state in ('Processed', 'Refunded')
                        AND l.status = 'sold'
                   )  as amount_paid_without_discount
                    GROUP BY payment_system, kiosk_id, product_id, kiosk_campus_id, date_id
                ) as amount_paid_with_discounts
                GROUP BY kiosk_campus_id, kiosk_id, product_id, date_id, payment_system
            ) as sum_amount_paid
            GROUP BY campus_id, kiosk_id, product_id, date_id
        )
        ON CONFLICT (campus_id, product_id, kiosk_id, date_id) DO UPDATE
        SET (ip_commerce,
            freedom_pay,
        card_smith,
        complimentary,
        sales_after_discount
        ) = (
        excluded.ip_commerce,
        excluded.freedom_pay,
        excluded.card_smith,
        excluded.complimentary,
        excluded.sales_after_discount);
    END;
$_$;
ALTER FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO erpuser;
COMMENT ON FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts sales after discount in dw.fact_daily_kiosk_sku_summary';
CREATE FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO dw.fact_daily_byte_foods_summary(
            date_id,
            active_byte_customers,
            active_skus,
            active_brands,
            active_cards,
            active_usernames,
            active_emails,
            orders,
            orders_w_email)
        (SELECT (TO_CHAR(time_bought::date, 'YYYYMMDD'))::int  as date_id,
            count(DISTINCT client_name) as active_byte_customers,
            count(DISTINCT s.product_id) as active_skus,
            count(DISTINCT p.vendor) as active_brands,
            count(DISTINCT card_hash) as active_cards,
            count(DISTINCT (concat("left"(btrim(o.first_name::text), 1), '.', btrim(o.last_name::text)))) as
                active_usernames,
            count(DISTINCT email) as active_emails,
            count(DISTINCT s.order_id) as orders,
            count(DISTINCT(CASE WHEN o.email IS NULL OR o.email::text = ''::text
                THEN ''::character varying
                ELSE o.order_id
                END)) as orders_w_email
            FROM dw.byte_sales(beginning_date, ending_date) s
            LEFT JOIN pantry.kiosk k
            ON s.kiosk_id = k.id
            LEFT JOIN pantry.order o
            ON o.order_id = s.order_id
            LEFT JOIN pantry.product p
            ON p.id = s.product_id
            GROUP BY (TO_CHAR(time_bought::date, 'YYYYMMDD'))::int
        )
        ON CONFLICT (date_id) DO UPDATE
        SET (active_byte_customers, active_skus, active_brands, active_cards,
        active_usernames, active_emails, orders, orders_w_email) =
        (excluded.active_byte_customers, excluded.active_skus, excluded.active_brands,
        excluded.active_cards, excluded.active_usernames, excluded.active_emails, excluded.orders,
        excluded.orders_w_email);
    END;
$$;
CREATE FUNCTION erp_test.test(_id integer) RETURNS TABLE(twice integer)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose - Return the first phone number from an contact_phone field in pantry.kiosk string with embedded phones.
    Input -
      s: string with embedded phone
    Return -
      phone: general phone number
      mobile: mobile phone number
    */
declare
  cid integer;
  kid integer;
begin
  cid = (select campus_id from erp.kiosk where id = _id),
  kid = (_id);
  return query
    select cid + kid;
end;
$$;
CREATE FUNCTION dw.spoils(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, order_id_ character varying, kiosk_id_ bigint, product_id_ bigint, time_updated_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
        /*
        For a given time window W1 (e.g. from beginning_date through ending_date) and an extended time
        window W2, with W1 being a subset of W2 (e.g. W1 +1 and -1 month from beginning_date through
        ending_date)
        Spoil: count of unique epc’s which have at least one spoil label record within W1 and have no
        sale record within W2.
        A spoil label record has an order id which starts with RE and has an out or lost LABEL STATUS.
        For a spoil label record to be within time window W1, the order creation time needs to be within W1.
        * ENG-834: Art's logic, the origin for this function
        * ENG-1922: Add label state lost; Restrict order state from the sales subquery
        NOTE: `to_timestamp(o.created)::date` date casting needed to remove time portion for whole day comparision,
        otherwise result will ignore records created on ending_date because datetime>date.
        */
        select l.epc, l.order_id, l.kiosk_id, l.product_id, to_timestamp(l.time_updated),
               coalesce(l.cost, ph.cost, p.cost, 0) as cost,
               coalesce(ph.price, l.price, p.price, 0) as price,
               k.campus_id, p.campus_id, k.enable_reporting
        from
            (select epc, o.order_id, o.kiosk_id, product_id, time_updated, price, cost,
                    rank() over(partition by epc order by time_updated desc) as latest_time_update_rank
             from
                  pantry.label l
                      join pantry.order o on l.order_id = o.order_id
                  where to_timestamp(o.created)::date between beginning_date and ending_date
                      and o.order_id > 'RE'
                      and l.status in ('out', 'lost')
            ) l
            left join
                (select epc from pantry.label l
                    join pantry.order o on l.order_id = o.order_id
                 where to_timestamp(created)::date between beginning_date - interval '1 months'
                   and ending_date + interval '1 months'
                   and l.status='sold'
                )sold_items on l.epc = sold_items.epc
                join pantry.product p on p.id = l.product_id
                join pantry.order o on l.order_id = o.order_id
                left join pantry.product_history ph on ph.product_id = p.id
                  and o.created >= ph.start_time AND (ph.end_time is null or o.created < ph.end_time)
                join pantry.kiosk k on l.kiosk_id = k.id
        where sold_items.epc is null and l.latest_time_update_rank = 1;
end;
$$;
CREATE FUNCTION erp_test.parse_address(address_str text) RETURNS TABLE(address1 text, address2 text, city text, state text, zip text)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose - parse address fields from an address string
    Input -
      address_str: address string
    Return -
      address1, address2, city, state, zip
    */
declare
  address_fields text[5];
  remainder text;
begin
  address_fields = string_to_array(address_str, ',', null);
  for i in 1..4 loop
      address_fields[i] = trim(address_fields[i]);
      address_fields[i] = trim(address_fields[i], chr(160));
  end loop;
  if address_fields[3] is null
  then
    remainder = address_fields[2];
    zip = regexp_replace(remainder, '^.* ', '');
    remainder = trim(substring(remainder from 1 for length(remainder) - length(zip)));
    state = regexp_replace(remainder, '^.* ', '');
    city = trim(substring(remainder from 1 for length(remainder) - length(state)));
    address2 = '';
    address1 = address_fields[1];
  elseif address_fields[4] is null then
    zip = split_part(trim(address_fields[3]), ' ', 2);
    state = split_part(trim(address_fields[3]), ' ', 1);
    city = address_fields[2];
    address2 = '';
    address1 = address_fields[1];
  else
    zip = split_part(trim(address_fields[4]), ' ', 2);
    state = split_part(trim(address_fields[4]), ' ', 1);
    city = address_fields[3];
    address2 = address_fields[2];
    address1 = address_fields[1];
  end if;
  return query
    select address1, address2, city, state, zip;
end;
$$;
CREATE FUNCTION dw.byte_losses(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_updated timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
        /*
        The following query is used to get non free kiosks and free kiosks lost. SEE
        ENG-708. Non free kiosks losses = lost items. Since lost items are always counted as sold
        for free kiosks, Free kiosks losses = 0.
        Alterations from ENG-1922
        - remove product_campus_id filter
        */
        SELECT epc_ as epc,
            kiosk_id_ as kiosk_id,
            product_id_ as product_id,
            time_updated_ as time_updated,
            cost_ as cost,
            price_ as price
            FROM dw.losses(beginning_date, ending_date) gl
            JOIN pantry.kiosk k
            ON gl.kiosk_id_ = k.id
            LEFT JOIN pantry.discount d
            ON k.id = d.kiosk_id
            AND d.product_id IS NULL
            WHERE (value != 100 OR value IS NULL)
            AND enable_reporting_ = 1
            AND kiosk_campus_id_ = BYTE_CAMPUS;
    END;
$$;
CREATE FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
    INVENTORY_HISTORY_FREQUENCY integer := 24;
    BEGIN
    INSERT INTO dw.fact_daily_kiosk_sku_summary(
        campus_id,
        kiosk_id,
        product_id,
        date_id,
        stocked_percent
        )
   (--- This query is used to get the stocked percentage of of a product in a particular kiosk.
 SELECT k.campus_id,
kiosk_id, 
product_id, 
(TO_CHAR(to_timestamp(time), 'YYYYMMDD'))::int AS date_id,
round(count(*)::numeric/INVENTORY_HISTORY_FREQUENCY::numeric, 2) as stocked_percent
FROM pantry.inventory_history ih
JOIN pantry.product p ON p.id = ih.product_id
JOIN pantry.kiosk k ON k.id = ih.kiosk_id
WHERE to_timestamp(time)::date >= beginning_date
AND to_timestamp(time)::date <= ending_date
GROUP BY (TO_CHAR(to_timestamp(time), 'YYYYMMDD'))::int, kiosk_id, product_id, k.campus_id  
        )
        ON CONFLICT (campus_id, kiosk_id, product_id, date_id) DO UPDATE
        SET stocked_percent = excluded.stocked_percent;
END;
$$;
CREATE FUNCTION dw.sales(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, order_id_ character varying, kiosk_id_ bigint, product_id_ bigint, time_bought_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        /*
        For a given time window W1 (e.g. from beginning_date through ending_date) and an extended time
        window W2, with W1 being a subset of W2 (e.g. W1 +1 and -1 month from beginning_date through
        ending_date)
        Sale(amount_list_price): count of epc’s which have at least one sale label record within W1.
        A sale(amount_list_price) label record has an order id which does not start with RE and has an
        ORDER STATE of Placed, Processed, Refunded, Adjusted, Declined, Error and a LABEL STATUS of sold
        For specification details, see these related tickets:
        * ENG-834: Art's logic, the origin for this function
        * ENG-1922: Include duplicated EPCs; Restrict order state
        */
            SELECT epc as epc_,
                order_id as order_id_,
                kiosk_id as kiosk_id_,
                product_id as product_id_,
                to_timestamp(time_bought) as time_bought_,
                cost as cost_,
                price as price_,
                kiosk_campus_id as kiosk_campus_id_,
                product_campus_id as product_campus_id_,
                enable_reporting as enable_reporting_
                FROM  (SELECT epc,
                    l.product_id,
                    l.order_id,
                    o.created as time_bought,
                    COALESCE(l.cost, ph.cost, p.cost,0) as cost,
                    COALESCE(ph.price, p.price,0) as price,
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
                    LEFT JOIN pantry.product_history ph ON ph.product_id = p.id
                    AND o.created >= ph.start_time AND (ph.end_time IS NULL OR o.created <
                    ph.end_time)
                    WHERE to_timestamp(created)::date >= beginning_date
                    AND to_timestamp(created)::date <= ending_date
                    AND o.state in ('Placed', 'Processed', 'Refunded', 'Adjusted', 'Declined', 'Error')
                    AND l.status = 'sold'
                    AND l.order_id NOT LIKE 'RE%'
                    AND l.order_id IS NOT NULL
                ) as all_epc_data;
    END;
$$;
CREATE FUNCTION test.export_consolidated_remittance(month_date date) RETURNS TABLE(campus_title character varying, campus_id bigint, name character varying, email character varying, number_of_kiosks bigint, client_type text, sales_list_price numeric, sales_after_discount numeric, complimentary numeric, freedom_pay numeric, credit_card numeric, monthly_lease numeric, connectivity_fee numeric, payment_processing_fee numeric, tag_fee numeric, tags_got integer, tag_price numeric, net_remittance numeric, net_total numeric, manual_adjustment numeric, fees_before_tags numeric, details text)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT campus_remittance.campus_title,
            campus_remittance.campus_id,
            campus_remittance.name,
            campus_remittance.email,
            campus_remittance.number_of_kiosks,
            campus_remittance.client_type,
            COALESCE(campus_remittance.sales_list_price, 0) as sales_list_price,
            COALESCE(campus_remittance.sales_after_discount, 0) as sales_after_discount,
            COALESCE(campus_remittance.complimentary, 0) as complimentary,
            COALESCE(campus_remittance.freedom_pay, 0) as freedom_pay,
            COALESCE(campus_remittance.credit_card, 0) as credit_card,
            COALESCE(campus_remittance.monthly_lease, 0) as monthly_lease,
            COALESCE(campus_remittance.connectivity_fee, 0) as connectivity_fee,
            COALESCE(campus_remittance.payment_processing_fee, 0) as payment_processing_fee,
            COALESCE(campus_remittance.tag_fee, 0) as tag_fee,
            COALESCE(campus_remittance.tags_got, 0) as tags_got,
            COALESCE(campus_remittance.tag_price, 0) as tag_price,
            COALESCE(campus_remittance.net_remittance, 0) as net_remittance,
            COALESCE(campus_remittance.net_total, 0) as net_total,
            COALESCE(campus_remittance.manual_adjustment, 0) as manual_adjustment,
            COALESCE(campus_remittance.connectivity_fee, 0)
                + COALESCE(campus_remittance.payment_processing_fee, 0)
                + COALESCE(campus_remittance.monthly_lease, 0) as fees_before_tags,
            campus_remittance.details
            FROM (SELECT c.campus_title,
                c.campus_id,
                r.name,
                r.email,
                r.number_of_kiosks,
                r.client_type,
                r.sales_after_discount,
                r.sales_list_price,
                r.complimentary,
                r.freedom_pay,
                r.credit_card,
                r.monthly_lease,
                r.connectivity_fee,
                r.payment_processing_fee,
                (COALESCE(tags_obtained.tags_got, 0) * COALESCE(r.tag_price, 0) +
                 COALESCE(new_tags_obtained.total_price, 0)) as tag_fee,
                (COALESCE(new_tags_obtained.amount_total, 0) + tags_obtained.tags_got) as tags_got,
                r.tag_price,
                r.credit_card
                    - r.monthly_lease
                    - r.connectivity_fee
                    - r.payment_processing_fee
                    - (COALESCE(tags_obtained.tags_got, 0) * COALESCE(r.tag_price, 0))
                    - (COALESCE(new_tags_obtained.total_price, 0))
                    + r.manual_adjustment  as net_remittance,
                r.credit_card
                    - r.monthly_lease
                    - r.connectivity_fee
                    - r.payment_processing_fee
                    - (COALESCE(tags_obtained.tags_got, 0) * COALESCE(r.tag_price, 0))
                    - (COALESCE(new_tags_obtained.total_price, 0))
                    + r.manual_adjustment
                    + r.complimentary
                    + r.freedom_pay as net_total,
                r.manual_adjustment,
                r.details
                FROM (SELECT id as campus_id,
                    title as campus_title
                    FROM pantry.campus
                ) c
                LEFT JOIN (SELECT er.campus_title,
                    er.campus_id,
                    er.name,
                    er.email,
                    count(er.kiosk_id) as number_of_kiosks,
                    STRING_AGG(er.kiosk_id::text, ', ') as kiosk_id,
                    STRING_AGG(distinct(er.client_type), ', ') as client_type,
                    sum(er.credit_card) as credit_card,
                    sum(er.sales_after_discount) as sales_after_discount,
                    sum(er.sales_list_price) as sales_list_price,
                    sum(er.complimentary) as complimentary,
                    sum(er.freedom_pay) as freedom_pay,
                    sum(er.monthly_lease) as monthly_lease,
                    sum(er.connectivity_fee) as connectivity_fee,
                    sum(er.payment_processing_fee) as payment_processing_fee,
                    max(er.tag_price) as tag_price,
                    sum(er.manual_adjustment) as manual_adjustment,
                    STRING_AGG(er.details, ' | ') as details
                    FROM dw.export_remittance(month_date) er
                    GROUP BY er.name, er.campus_id, er.campus_title, er.email
                ) r
                ON r.campus_id = c.campus_id
                LEFT JOIN
                (SELECT p.campus_id,
                    sum(lo.amount)::int tags_got
                    FROM pantry.label_order lo
                    JOIN pantry.product p
                    ON lo.product_id = p.id
                    WHERE lo.status = 'Fulfilled'
                    AND lo.time_delivery >= extract('EPOCH'
                        FROM ( date_trunc('month', month_date)))::BIGINT
                    AND lo.time_delivery <= extract('EPOCH'
                        FROM (date_trunc('month', month_date + INTERVAL '1 month')))::BIGINT - 1
                    GROUP BY p.campus_id
                ) as tags_obtained
                ON tags_obtained.campus_id = c.campus_id
                LEFT JOIN
                (WITH consolidated_tag_price AS
                (SELECT implicit_price.campus_id, implicit_price.tag_type,
                    COALESCE(explicit_price.price, implicit_price.price) price
                    FROM (SELECT c.id campus_id, tag_type, tp.price
                    FROM pantry.campus c, erp.tag_price tp
                    WHERE tp.campus_id = 0) implicit_price
                LEFT JOIN
                (SELECT c.id campus_id, tp.tag_type, tp.price
                   FROM pantry.campus c
                   JOIN erp.tag_price tp ON tp.campus_id = c.id) explicit_price
                   ON explicit_price.campus_id = implicit_price.campus_id
                   AND explicit_price.tag_type = implicit_price.tag_type)
                SELECT SUM(tag_order.amount)::int AS amount_total,
                   p.campus_id,
                   SUM(tag_order.amount * tp.price) AS total_price
                   FROM erp.tag_order
                   LEFT JOIN erp.tag_type tt ON tt.id = tag_order.tag_type_id
                   JOIN pantry.product p ON tag_order.product_id = p.id
                   JOIN pantry.campus c ON p.campus_id = c.id
                   JOIN consolidated_tag_price tp ON tt.type = tp.tag_type
                   AND tp.campus_id = p.campus_id
                WHERE status = 'fulfilled'
                AND process_ts >=  date_trunc('month', month_date::date)
                AND process_ts <  date_trunc('month', month_date::date + INTERVAL '1 month')
                GROUP BY p.campus_id
                ) AS new_tags_obtained
                ON new_tags_obtained.campus_id = c.campus_id
            ) as campus_remittance
            WHERE campus_remittance.sales_after_discount > 0 OR
            campus_remittance.complimentary > 0 OR
            campus_remittance.freedom_pay > 0 OR
            campus_remittance.credit_card > 0 OR
            campus_remittance.monthly_lease > 0 OR
            campus_remittance.connectivity_fee > 0 OR
            campus_remittance.payment_processing_fee > 0 OR
            campus_remittance.tag_fee > 0 OR
            campus_remittance.tags_got > 0 OR
            campus_remittance.tag_price > 0 OR
            campus_remittance.net_remittance > 0 OR
            campus_remittance.net_total > 0 OR
            campus_remittance.manual_adjustment > 0 OR
            campus_remittance.number_of_kiosks > 0
            ORDER BY campus_remittance.campus_id;
    END;
$$;
CREATE FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    INSERT INTO dw.fact_daily_kiosk_sku_summary(
        campus_id,
        kiosk_id,
        product_id,
        date_id,
        spoils_qty,
        spoils_amt
        )
    (--- Byte spoilage
        SELECT campus_id,
            kiosk_id,
            product_id,
            (TO_CHAR(time_updated, 'YYYYMMDD'))::int AS date_id,
            COUNT(*) AS spoils_qty,
            SUM(cost) AS spoils_amt
            FROM dw.byte_spoils(beginning_date, ending_date) s
            LEFT JOIN pantry.kiosk k
            ON s.kiosk_id = k.id
            GROUP BY kiosk_id, product_id, date_id, campus_id
        UNION ALL
         SELECT campus_id,
            kiosk_id,
            product_id,
            (TO_CHAR(time_updated, 'YYYYMMDD'))::int AS date_id,
            COUNT(*) AS spoils_qty,
            SUM(cost) AS spoils_amt
            FROM dw.non_byte_spoils(beginning_date, ending_date) s
            LEFT JOIN pantry.kiosk k
            ON s.kiosk_id = k.id
            GROUP BY kiosk_id, product_id, date_id, campus_id
        )
        ON CONFLICT (campus_id, product_id, kiosk_id, date_id) DO UPDATE
        SET (spoils_qty, spoils_amt) =
        (excluded.spoils_qty, excluded.spoils_amt);
END;
$$;
CREATE FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, order_id character varying, kiosk_id bigint, product_id bigint, time_bought timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
        /*
        The following query is used to get all non byte kiosks sales. Sales =
        non free kiosks sale + free kiosk sales + free kiosk losses.
        SEE ENG-2199
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
                FROM dw.sales(beginning_date, ending_date)  gs
                JOIN pantry.kiosk k
                ON gs.kiosk_id_ = k.id
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND kiosk_campus_id_ != BYTE_CAMPUS
            UNION
            SELECT epc_,
                NULL as order_id_,
                kiosk_id_,
                product_id_,
                time_updated_ as time_bought_,
                cost_ ,
                price_
                FROM dw.losses(beginning_date, ending_date)  gl
                JOIN pantry.kiosk k
                ON gl.kiosk_id_ = k.id
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND kiosk_campus_id_ != BYTE_CAMPUS
            UNION
            SELECT epc_,
                order_id_,
                kiosk_id_,
                product_id_,
                time_bought_,
                cost_,
                price_
                FROM dw.sales(beginning_date, ending_date)  gs
                JOIN pantry.kiosk k
                ON gs.kiosk_id_ = k.id
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE (value != 100 OR value IS NULL)
                AND kiosk_campus_id_ != BYTE_CAMPUS
            ) as all_kiosk_sale;
    END;
$$;
CREATE FUNCTION erp.reverse_sync_kiosk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  FORWARD_SYNC varchar(100) := 'sync';
  REVERSE_SYNC varchar(100) := 'reverse_sync';
  SKIP_SYNC_PARAM_NAME varchar(100) := 'pantry.kiosk.skip_sync';
  _skip_trigger boolean;
  _record_id integer;
  _last_inventory bigint;
  _last_status bigint;
  /*
  Insert/update/delete pantry.kiosk when erp.kiosk and related tables are changed
  This code works in conjunction with erp.sync_kiosk. To prevent infinite sync cycle, it does the following:
  1. Set SKIP_SYNC_PARAM_NAME transaction scope param to disable the sync for the transaction.
  2. Skip the reverse sync if changes are unnecessary (new record = existing record).
  */
begin
  _skip_trigger = (coalesce(current_setting(SKIP_SYNC_PARAM_NAME, true), '') = REVERSE_SYNC);
  if _skip_trigger
  then
    return null;
  else
    set local pantry.kiosk.skip_sync = FORWARD_SYNC;
    if tg_op in ('UPDATE', 'INSERT') then
      _record_id = null;
      begin
        _record_id = new.id;
      exception
        when undefined_column then
          _record_id = new.kiosk_id;
      end;
      select max(time) from pantry.last_kiosk_status where kiosk_id = _record_id into _last_status;
      select max(time) from pantry.inventory_history where kiosk_id = _record_id into _last_inventory;
    end if;
    case
      when tg_op = 'UPDATE' then
        _record_id = null;
        begin
          _record_id = new.id;
        exception
          when undefined_column then
            _record_id = new.kiosk_id;
        end;
        update pantry.kiosk k
        set (campus_id, serial, title, address, location_x, location_y, gcm_id, app_vname, app_vcode, archived,
             creation_time, deployment_time, last_update, client_name, last_status, last_inventory, kiosk_name,
             payment_start, payment_stop, features, sales_tax, default_fee_plan, timezone, estd_num_users, tags,
             publicly_accessible, cardkey_required, delivery_insns, fridge_loc_info, contact_first_name,
             contact_last_name, contact_email, contact_phone, accounting_email, byte_discount, subsidy_info,
             subsidy_notes, max_subscription, delivery_window_mon, delivery_window_tue, delivery_window_wed,
             delivery_window_thu, delivery_window_fri, delivery_window_sat, delivery_window_sun, notes, components,
             email_receipt_subject, ops_team_notes, geo, server_url, subscription_amount, enable_reporting,
             enable_monitoring, employees_num, kiosk_restrictions)
          =
          (vk.campus_id, vk.serial, vk.title, vk.address, vk.location_x, vk.location_y, vk.gcm_id, vk.app_vname,
           vk.app_vcode, vk.archived, vk.creation_time, vk.deployment_time, vk.last_update, vk.client_name,
           greatest(_last_status, vk.last_status),
           greatest(_last_inventory, vk.last_inventory),
           vk.kiosk_name, vk.payment_start, vk.payment_stop, vk.features,
           vk.sales_tax, vk.default_fee_plan, vk.timezone, vk.estd_num_users, vk.tags, vk.publicly_accessible,
           vk.cardkey_required, vk.delivery_insns, vk.fridge_loc_info, vk.contact_first_name, vk.contact_last_name,
           vk.contact_email, vk.contact_phone, vk.accounting_email, vk.byte_discount, vk.subsidy_info,
           vk.subsidy_notes, vk.max_subscription, vk.delivery_window_mon, vk.delivery_window_tue,
           vk.delivery_window_wed, vk.delivery_window_thu, vk.delivery_window_fri, vk.delivery_window_sat,
           vk.delivery_window_sun, vk.notes, vk.components, vk.email_receipt_subject, vk.ops_team_notes, vk.geo,
           vk.server_url, vk.subscription_amount, vk.enable_reporting, vk.enable_monitoring, vk.employees_num,
           vk.kiosk_restrictions)
        from (select * from erp.kiosk_classic_view where id=_record_id) vk
        where k.id=vk.id;
        insert into test.kiosk_log(id, update_count) values(_record_id, 1)
          on conflict(id) do
            update set update_count = test.kiosk_log.update_count + 1, ts = current_timestamp;
        return new;
      when tg_op = 'INSERT' then
        insert into pantry.kiosk select * from erp.kiosk_classic_view where id = _record_id;
        insert into test.kiosk_log(id, update_count) values(_record_id, 1)
        on conflict(id) do
          update set update_count = test.kiosk_log.update_count + 1, ts = current_timestamp;
        return new;
      when tg_op = 'DELETE' then
        delete from pantry.kiosk where id = old.id;
        return old;
      end case;
  end if;
end;
$$;
CREATE FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    DELETE FROM dw.fact_daily_kiosk_sku_summary 
    WHERE date_id >= TO_CHAR(beginning_date, 'YYYYMMDD')::int 
    AND date_id <= TO_CHAR(ending_date, 'YYYYMMDD')::int ;
END;
$$;
CREATE FUNCTION dw.refresh_dim_kiosk() RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO dw.dim_kiosk (id,
            campus_id,
            client_name,
            title,
            geo,
            location_type,
            enable_reporting,
            archived)
            (SELECT k.id,
                k.campus_id,
                c.name as client_name,
                k.title,
                k.geo,
                k.location_type,
                k.enable_reporting,
                k.archived
                FROM erp.kiosk k
                LEFT JOIN erp.client c
                ON k.client_id = c.id
            )
            ON CONFLICT (id) DO UPDATE
            SET (campus_id, client_name, title, geo, location_type, enable_reporting, archived) =
                (excluded.campus_id, excluded.client_name, excluded.title, excluded.geo,
                excluded.location_type, excluded.enable_reporting, excluded.archived);
        END;
$$;
CREATE FUNCTION dw.restocks(beginning_date date, ending_date date) RETURNS TABLE(epc_ character varying, kiosk_id_ bigint, product_id_ bigint, time_added_ timestamp with time zone, cost_ numeric, price_ numeric, kiosk_campus_id_ bigint, product_campus_id_ bigint, enable_reporting_ bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
/*
Restock is a count of unique epcs based on time_created. If there are duplicate epc,
use the most recently added.
*/
	RETURN QUERY
		SELECT epc AS epc_,
			kiosk_id AS kiosk_id_,
			product_id AS product_id_,
			time_added AS time_added_,
			cost AS cost_,
			price AS price_,
			k.campus_id kiosk_campus_id_,
			p.campus_id product_campus_id_,
			k.enable_reporting AS enable_reporting_
		FROM (SELECT *
					FROM (SELECT epc,
									kiosk_id,
									product_id,
									to_timestamp(time_added) AS time_added,
									rank() OVER (PARTITION BY epc ORDER BY time_added DESC) r
								FROM pantry.label
								WHERE to_timestamp(time_added) BETWEEN beginning_date AND ending_date
					) ranked_items
					WHERE r = 1) restocked_item
					 JOIN pantry.product p ON restocked_item.product_id = p.id
					 JOIN pantry.kiosk k ON restocked_item.kiosk_id = k.id;
END;
$$;
CREATE FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_updated timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
/*
The following query is used to get non byte kiosks spoils.
*/
SELECT epc_ as epc,
    kiosk_id_ as kiosk_id,
    product_id_ as product_id,
    time_updated_ as time_updated,
    cost_ as cost,
    price_ as price
    FROM dw.spoils(beginning_date, ending_date) gl
    WHERE kiosk_campus_id_ != BYTE_CAMPUS;
 END;
$$;
CREATE FUNCTION erp.sync_product() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  /*
  Insert/update/delete erp.product and related tables according to tg_op value, except for when insert conflict, then
update erp.product and related tables instead. This exception happens if syncing table and synced tables were not
in sync (for example, aws dms was disabled)
  This code works in conjunction with erp.reverse_sync_product. To prevent infinite sync cycle, it does the following:
  1. Use erp.product.skip_trigger transaction scope parameter to signal when either a sync or reverse sync
    is in progress to prevent a sync to initiate reverse sync an vice versa
  2. Check if the new record already exists and therefore no changes is needed and sync should be skipped
  */
declare
  FORWARD_SYNC varchar(100) := 'sync';
  REVERSE_SYNC varchar(100) := 'reverse_sync';
  SKIP_SYNC_PARAM_NAME varchar(100) := 'pantry.product.skip_sync';
  _record_exists boolean;
  _target_record record;
  _insync boolean;
  _skip_trigger boolean;
  _sku_group_id integer;
  _consumer_category_id integer;
begin
  _skip_trigger = (coalesce(current_setting(SKIP_SYNC_PARAM_NAME, true), '') = FORWARD_SYNC);
  if tg_op in ('INSERT', 'UPDATE')
    then
      select * from pantry.product where id = new.id into _target_record;
      _insync = (_target_record = new);
    else
      _insync = false;
  end if;
  if _insync
    then return null;
    else
      set local pantry.product.skip_sync = REVERSE_SYNC;
      if not _skip_trigger
        then
          if tg_op in ('INSERT', 'UPDATE')
            then
              select id from erp.sku_group where fc_title = new.fc_title into _sku_group_id;
              select exists(select 1 from pantry.product where id = new.id) into _record_exists;
              select id from erp.product_category_def
                where name = 'consumer' and value = new.consumer_category
                into _consumer_category_id;
            end if;
          case
            when tg_op = 'INSERT' and not _record_exists then
              insert into erp.product(id, brand, campus_id, sku_group_id, fc_title, archived, last_update)
              values(new.id, new.vendor, new.campus_id, _sku_group_id, new.fc_title, new.archived, new.last_update);
              insert into erp.product_asset(product_id, title, description, tiny_description, short_description, medium_description, long_description, image, image_time)
              values (new.id, new.title, new.description, new.tiny_description, new.short_description, new.medium_description, new.long_description, new.image, new.image_time);
              insert into erp.product_pricing(product_id,price,cost,ws_case_cost,pricing_tier,taxable)
              values(new.id,new.price,new.cost,new.ws_case_cost,new.pricing_tier,new.taxable);
              insert into erp.product_nutrition(product_id,total_cal,num_servings,calories,proteins,sugar,carbohydrates,fat,ingredients,shelf_time)
              values(new.id,new.total_cal,new.num_servings,new.calories,new.proteins,new.sugar,new.carbohydrates,new.fat,new.ingredients,new.shelf_time);
              insert into erp.product_property(product_id, property_id)
                select new.id, def.id
                  from (select unnest(string_to_array(new.allergens, ','))::int a_id) allergen_list
                         join pantry.tag t on allergen_list.a_id = t.id
                         join erp.product_property_def def on t.tag = def.value
                    on conflict do nothing;
              if _consumer_category_id is not null
                then insert into erp.product_category(product_id, category_id) values(new.id, _consumer_category_id);
              end if;
              delete from erp.classic_product_category_tag where product_id = new.id;
              insert into erp.classic_product_category_tag(product_id, tag_id)
                select new.id, tags.tag_id
                  from (select unnest(string_to_array(new.categories, ','))::int as tag_id) tags
                    on conflict do nothing;
              insert into erp.product_handling(product_id,width_space,height_space,depth_space,slotted_width,kiosk_ship_qty,
                                               ws_case_size,tag_volume,tag_delivery_option,tag_applied_by,pick_station)
              values(new.id,new.width_space,new.height_space,new.depth_space,new.slotted_width,new.kiosk_ship_qty,
                     new.ws_case_size,new.tag_volume,new.delivery_option,new.tag_applied_by,new.pick_station);
              insert into erp.product_sourcing(product_id,vendor,source) values(new.id,new.vendor,new.source);
            when tg_op = 'UPDATE' or (tg_op = 'INSERT' and _record_exists) then
              update erp.product
              set brand=new.vendor, campus_id=new.campus_id, sku_group_id=_sku_group_id,
                fc_title=new.fc_title, archived=new.archived, last_update=new.last_update
              where id = new.id;
              update erp.product_asset
              set title=new.title, description=new.description, tiny_description=new.tiny_description,
                short_description=new.short_description, medium_description=new.medium_description,
                long_description=new.long_description, image=new.image, image_time=new.image_time
              where product_id = new.id;
              update erp.product_pricing
              set price=new.price,cost=new.cost,ws_case_cost=new.ws_case_cost,pricing_tier=new.pricing_tier,taxable=new.taxable
              where product_id=new.id;
              update erp.product_nutrition
              set total_cal=new.total_cal,num_servings=new.num_servings,calories=new.calories,proteins=new.proteins,
                sugar=new.sugar,carbohydrates=new.carbohydrates,fat=new.fat,ingredients=new.ingredients,
                shelf_time=new.shelf_time where product_id=new.id;
              delete from erp.product_property where product_id=new.id;
              insert into erp.product_property(product_id, property_id)
              select new.id, def.id
              from (select unnest(string_to_array(new.allergens, ','))::int a_id) allergen_list
                     join pantry.tag t on allergen_list.a_id = t.id
                     join erp.product_property_def def on t.tag = def.value
              on conflict do nothing;
              delete from erp.product_category where product_id = new.id
                and category_id in (select id from erp.product_category_def where name = 'consumer');
              if _consumer_category_id is not null
                then insert into erp.product_category(product_id, category_id) values(new.id, _consumer_category_id);
              end if;
              delete from erp.classic_product_category_tag where product_id = new.id;
              insert into erp.classic_product_category_tag(product_id, tag_id)
              select new.id, tags.tag_id
                from (select unnest(string_to_array(new.categories, ','))::int as tag_id) tags
                  on conflict do nothing;
              update erp.product_handling
              set width_space=new.width_space,height_space=new.height_space,depth_space=new.depth_space,
                slotted_width=new.slotted_width,kiosk_ship_qty=new.kiosk_ship_qty,ws_case_size=new.ws_case_size,
                tag_volume=new.tag_volume,tag_delivery_option=new.delivery_option,tag_applied_by=new.tag_applied_by,
                pick_station=new.pick_station
              where product_id=new.id;
              update erp.product_sourcing set vendor=new.vendor,source=new.source where product_id=new.id;
            when tg_op = 'DELETE' then
              delete from erp.product where id = old.id;
              delete from erp.product_asset where product_id=old.id;
              delete from erp.product_pricing where product_id=old.id;
              delete from erp.product_nutrition where product_id=old.id;
              delete from erp.product_property where product_id=old.id;
              delete from erp.product_handling where product_id=old.id;
              delete from erp.product_sourcing where product_id=old.id;
              delete from erp.product_category where product_id=old.id;
              delete from erp.classic_product_category_tag where product_id=old.id;
          end case;
      end if; -- not skip trigger ?
      if tg_op in ('INSERT', 'UPDATE')
        then return new;
        else return old;
      end if;
  end if; -- in sync?
end;
$$;
CREATE FUNCTION fnrenames.parse_address(address_str text) RETURNS TABLE(address1 text, address2 text, city text, state text, zip text)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose - parse address fields from an address string
    Input -
      address_str: address string
    Return -
      address1, address2, city, state, zip
    */
declare
  address_fields text[5];
  remainder text;
begin
  address_fields = string_to_array(address_str, ',', null);
  for i in 1..4 loop
      address_fields[i] = trim(address_fields[i]);
      address_fields[i] = trim(address_fields[i], chr(160));
  end loop;
  if address_fields[3] is null
  then
    remainder = address_fields[2];
    zip = regexp_replace(remainder, '^.* ', '');
    remainder = trim(substring(remainder from 1 for length(remainder) - length(zip)));
    state = regexp_replace(remainder, '^.* ', '');
    city = trim(substring(remainder from 1 for length(remainder) - length(state)));
    address2 = '';
    address1 = address_fields[1];
  elseif address_fields[4] is null then
    zip = split_part(trim(address_fields[3]), ' ', 2);
    state = split_part(trim(address_fields[3]), ' ', 1);
    city = address_fields[2];
    address2 = '';
    address1 = address_fields[1];
  else
    zip = split_part(trim(address_fields[4]), ' ', 2);
    state = split_part(trim(address_fields[4]), ' ', 1);
    city = address_fields[3];
    address2 = address_fields[2];
    address1 = address_fields[1];
  end if;
  return query
    select address1, address2, city, state, zip;
end;
$$;
CREATE FUNCTION dw.export_licensee_fee(month_date date) RETURNS TABLE(kiosk_id bigint, kiosk_title character varying, campus_id bigint, campus_title character varying, deployment_date date, fee_plan_name text, licensing_subscription_fee numeric, tag_price numeric, payment_processing_rate character varying, connectivity_fee numeric, prepaid_number_of_months bigint, prepaid_until character varying)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT mk.kiosk_id,
            k.title as kiosk_title,
            k.campus_id,
            c.title as campus_title,
            to_timestamp(k.deployment_time)::date as deployment_date,
            mk.fee_plan_name,
            mk.licensing_subscription_fee,
            mk.tag_price,
            mk.payment_processing_rate,
            mk.connectivity_fee,
            mk.prepaid_number_of_months,
            mk.prepaid_until
            FROM dw.fact_monthly_kiosk_summary mk
            JOIN pantry.kiosk k
            ON mk.kiosk_id = k.id
            JOIN pantry.campus c
            ON c.id = k.campus_id
            WHERE mk.date_id = TO_CHAR(date_trunc('month', month_date ), 'YYYYMMDD')::int
            ORDER BY mk.kiosk_id;
    END;
$$;
CREATE FUNCTION dw.export_remittance(month_date date) RETURNS TABLE(name character varying, email character varying, account_type text, kiosk_id bigint, kiosk_title character varying, campus_id bigint, campus_title character varying, deployment_time timestamp with time zone, payment_start timestamp with time zone, client_type text, sales_after_discount numeric, sales_list_price numeric, credit_card numeric, monthly_lease numeric, connectivity_fee numeric, payment_processing_fee numeric, manual_adjustment numeric, prepaid_until character varying, freedom_pay numeric, complimentary numeric, tag_price numeric, details text)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT g.name,
            u.email,
            fee_plan_name as account_type,
            mk.kiosk_id,
            k.title as kiosk_title,
            k.campus_id,
            c.title as campus_title,
            to_timestamp(k.deployment_time) deployment_time,
            to_timestamp(k.payment_start) payment_start,
            CASE WHEN a.prepaid = 0
                    THEN 'Monthly'
                WHEN prepaid > 0
                    THEN 'Pre-paid'
                END as client_type,
            mk.sales_after_discount,
            mk.sales_list_price,
            mk.credit_card,
            mk.monthly_lease as monthly_lease,
            mk.connectivity_fee,
            mk.payment_processing_fee,
            mk.manual_adjustment,
            mk.prepaid_until,
            mk.freedom_pay,
            mk.complimentary,
            mk.tag_price,
            mk.details
            FROM dw.fact_monthly_kiosk_summary mk
            LEFT JOIN pantry.group_campus gc
            ON gc.campus_id = mk.campus_id
            LEFT JOIN pantry.group g
            ON gc.group_id = g.id
            LEFT JOIN pantry.kiosk k
            ON k.id = mk.kiosk_id
            LEFT JOIN pantry.campus c
            ON c.id = k.campus_id
            JOIN dw.dim_date dd
            ON dd.date_id = mk.date_id
            LEFT JOIN (SELECT ranked_duplicated_users.name,
                user_id,
                ranked_duplicated_users.email,
                group_id
                FROM (SELECT g.name,
                    u.group_id,
                    u.id user_id,
                    u.email,
                    u.role_id,
                    u.date_registered,
                    rank() over (partition by g.name order by u.role_id desc,
                        u.date_registered desc) r
                    FROM pantry.user u
                    JOIN pantry.group g
                    on concat(u.first_name, ' ', u.last_name) = g.name AND g.id = u.group_id
                ) as ranked_duplicated_users
                where r = 1
            ) u
            ON u.name = g.name
            AND gc.group_id = u.group_id
            LEFT JOIN pantry.accounting a
            ON a.kiosk_id = mk.kiosk_id
            AND TO_CHAR(date_trunc('month', as_date) + interval '1' day, 'YYYY-MM-fmDD') = a.date
            WHERE gc.owner = 1
            AND mk.date_id = TO_CHAR(date_trunc('month', month_date::date)::date, 'YYYYMMDD')::int
            GROUP BY g.name, fee_plan_name, mk.kiosk_id, k.title, k.campus_id, k.payment_start,
            mk.credit_card, mk.monthly_lease, mk.connectivity_fee, mk.payment_processing_fee,
            mk.manual_adjustment, a.prepaid, k.deployment_time, c.title, u.email,
            mk.sales_after_discount, mk.sales_list_price, mk.freedom_pay, mk.complimentary,
            mk.prepaid_until, mk.tag_price, mk.details
            ORDER BY name;
    END;
$$;
CREATE FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    INSERT INTO dw.fact_daily_kiosk_sku_summary(
        campus_id,
        kiosk_id,
        product_id,
        date_id,
        sales_qty,
        sales_amt,
        cost_amt,
        gross_margin_amt)
        (--- Byte sales
        SELECT campus_id,
            kiosk_id,
            product_id,
            (TO_CHAR(time_bought, 'YYYYMMDD'))::int AS date_id,
            COUNT(*) AS sales_qty,
            SUM(price) AS sales_amt,
            SUM(cost) AS cost_amt,
            SUM(price) - SUM(cost) AS gross_margin_amt
            FROM dw.byte_sales(beginning_date, ending_date) s
            LEFT JOIN pantry.kiosk k
            ON s.kiosk_id = k.id
            GROUP BY kiosk_id, product_id, date_id, campus_id
        UNION ALL
         SELECT campus_id,
            kiosk_id,
            product_id,
            (TO_CHAR(time_bought, 'YYYYMMDD'))::int AS date_id,
            COUNT(*) AS sales_qty,
            SUM(price) AS sales_amt,
            SUM(cost) AS cost_amt,
            SUM(price) - SUM(cost) AS gross_margin_amt
            FROM dw.non_byte_sales(beginning_date, ending_date) s
            LEFT JOIN pantry.kiosk k
            ON s.kiosk_id = k.id
            GROUP BY kiosk_id, product_id, date_id, campus_id
        )
        ON CONFLICT (campus_id, product_id, kiosk_id, date_id) DO UPDATE
        SET (sales_qty, sales_amt, cost_amt, gross_margin_amt) =
        (excluded.sales_qty, excluded.sales_amt, excluded.cost_amt, excluded.gross_margin_amt);
END;
$$;
CREATE FUNCTION dw.byte_restocks(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_added timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
        /*
        The following query is used to get byte kiosks restocks.
        */
        SELECT epc_ as epc,
            kiosk_id_ as kiosk_id,
            product_id_ as product_id,
            time_added_ as time_added,
            cost_ as cost,
            price_ as price
            FROM dw.restocks(beginning_date, ending_date)
            WHERE kiosk_campus_id_ = BYTE_CAMPUS
            AND enable_reporting_ = 1;
    END;
$$;
CREATE FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    PERFORM dw.refresh_dim_product();
    PERFORM dw.refresh_dim_kiosk();
    PERFORM dw.clear_daily_kiosk_sku_summary(beginning_date, ending_date);
    PERFORM dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date, ending_date);
    PERFORM dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date, ending_date);
    PERFORM dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date, ending_date);
    PERFORM dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date, ending_date);
    PERFORM dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date, ending_date);
END;
$$;
CREATE FUNCTION erp.parse_address(address_str text) RETURNS TABLE(address1 text, address2 text, city text, state text, zip text)
    LANGUAGE plpgsql
    AS $$
  /*
      Purpose - parse address fields from an address string
      Input -
        address_str: address string
      Return -
        address1, address2, city, state, zip
      */
declare
  address_fields text[5];
  remainder text;
begin
  address_fields = string_to_array(address_str, ',', null);
  for i in 1..4 loop
      address_fields[i] = trim(address_fields[i]);
      address_fields[i] = trim(address_fields[i], chr(160));
  end loop;
  if address_fields[3] is null
  then
    remainder = address_fields[2];
    zip = regexp_replace(remainder, '^.* ', '');
    remainder = trim(substring(remainder from 1 for length(remainder) - length(zip)));
    state = regexp_replace(remainder, '^.* ', '');
    city = trim(substring(remainder from 1 for length(remainder) - length(state)));
    address2 = '';
    address1 = address_fields[1];
  elseif address_fields[4] is null then
    zip = split_part(trim(address_fields[3]), ' ', 2);
    state = split_part(trim(address_fields[3]), ' ', 1);
    city = address_fields[2];
    address2 = '';
    address1 = address_fields[1];
  else
    zip = split_part(trim(address_fields[4]), ' ', 2);
    state = split_part(trim(address_fields[4]), ' ', 1);
    city = address_fields[3];
    address2 = address_fields[2];
    address1 = address_fields[1];
  end if;
  return query
    select address1, address2, city, state, zip;
end;
$$;
CREATE FUNCTION erp_test.parse_phone(text_to_parse text) RETURNS TABLE(phone text)
    LANGUAGE plpgsql
    AS $$
  /*
    Purpose - Return the first phone number from an contact_phone field in pantry.kiosk string with embedded phones.
    Input -
      s: string with embedded phone
    Return -
      phone: general phone number
      mobile: mobile phone number
    */
declare
  s text;
  parsed_phone text default null;
begin
  s = regexp_replace(text_to_parse, '\D', '', 'g');
  if length(s) >= 10
  then
    parsed_phone = substring(s, 1, 10);
  end if;
  return query
    select parsed_phone;
end;
$$;
CREATE FUNCTION erp_test.reverse_sync_kiosk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  _skip_trigger boolean;
  _record_id integer;
  /*
  Insert/update/delete pantry.kiosk when a record in erp_test.kiosk or related tables is changed.
  This code works in conjunction with erp_test.sync_kiosk. To prevent infinite sync cycle, it
  uses erp_test.kiosk.skip_forward_sync_trigger transaction scope parameter to signal when it starts
     to prevent a forward sync to run.
  */
begin
  _skip_trigger = (coalesce(current_setting('erp_test.kiosk.skip_reverse_trigger', true), '') = 'true');
  if _skip_trigger
  then
    return null;
  else
    set local erp_test.kiosk.skip_forward_trigger='true';
    case
      when tg_op = 'UPDATE' then
        _record_id = null;
        begin
          _record_id = new.id;
        exception
          when undefined_column then
            _record_id = new.kiosk_id;
        end;
        update pantry.kiosk k
        set (campus_id, serial, title, address, location_x, location_y, gcm_id, app_vname, app_vcode, archived,
             creation_time, deployment_time, last_update, client_name, last_status, last_inventory, kiosk_name,
             payment_start, payment_stop, features, sales_tax, default_fee_plan, timezone, estd_num_users, tags,
             publicly_accessible, cardkey_required, delivery_insns, fridge_loc_info, contact_first_name,
             contact_last_name, contact_email, contact_phone, accounting_email, byte_discount, subsidy_info,
             subsidy_notes, max_subscription, delivery_window_mon, delivery_window_tue, delivery_window_wed,
             delivery_window_thu, delivery_window_fri, delivery_window_sat, delivery_window_sun, notes, components,
             email_receipt_subject, ops_team_notes, geo, server_url, subscription_amount, enable_reporting,
             enable_monitoring, employees_num, kiosk_restrictions)
              =
            (vk.campus_id, vk.serial, vk.title, vk.address, vk.location_x, vk.location_y, vk.gcm_id, vk.app_vname,
             vk.app_vcode, vk.archived, vk.creation_time, vk.deployment_time, vk.last_update, vk.client_name,
             vk.last_status, vk.last_inventory, vk.kiosk_name, vk.payment_start, vk.payment_stop, vk.features,
             vk.sales_tax, vk.default_fee_plan, vk.timezone, vk.estd_num_users, vk.tags, vk.publicly_accessible,
             vk.cardkey_required, vk.delivery_insns, vk.fridge_loc_info, vk.contact_first_name, vk.contact_last_name,
             vk.contact_email, vk.contact_phone, vk.accounting_email, vk.byte_discount, vk.subsidy_info,
             vk.subsidy_notes, vk.max_subscription, vk.delivery_window_mon, vk.delivery_window_tue,
             vk.delivery_window_wed, vk.delivery_window_thu, vk.delivery_window_fri, vk.delivery_window_sat,
             vk.delivery_window_sun, vk.notes, vk.components, vk.email_receipt_subject, vk.ops_team_notes, vk.geo,
             vk.server_url, vk.subscription_amount, vk.enable_reporting, vk.enable_monitoring, vk.employees_num,
             vk.kiosk_restrictions)
        from (select * from erp_test.kiosk_classic_view where id=_record_id) vk
        where k.id=vk.id;
        return new;
      when tg_op = 'INSERT' then
        insert into pantry.temp_kiosk select * from erp_test.kiosk_classic_view where id = _record_id;
        return new;
      when tg_op = 'DELETE' then
        delete from pantry.kiosk where id = old.id;
        return old;
      end case;
  end if;
end;
$$;
CREATE FUNCTION pantry.sync_campus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  _target_record record;
  _insync BOOLEAN;
begin
  if tg_op in ('INSERT', 'UPDATE')
    then
      select * from pantry.campus where id = new.id into _target_record;
      _insync = (_target_record = new);
    else
      _insync = false;
  end if;
  if _insync
    then
      return null;
    else
      if tg_op in ('INSERT', 'UPDATE')
        then
          return new;
        else
          return old;
      end if;
  end if;
end;
$$;
CREATE FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) RETURNS TABLE(prorated_fee numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT CASE WHEN date_trunc('month', month_date) = date_trunc('month', deployment_date)
            THEN ROUND(
                (
                    (   --- number days in month
                        (DATE_PART('days', DATE_TRUNC('month', month_date)
                            + '1 MONTH - 1 DAY'::INTERVAL))
                        -  (EXTRACT(DAY FROM deployment_date))
                        + 1
                    )
                    *
                    (
                         fee
                         /
                         DATE_PART('days', DATE_TRUNC('month', month_date)
                            + '1 MONTH - 1 DAY'::INTERVAL)
                    )
                )::numeric, 2)
             ELSE fee
             END AS prorated_fee;
    END;
$$;
CREATE FUNCTION dw.export_spoilage(beginning_date date, ending_date date) RETURNS TABLE(as_date date, campus_id integer, campus_title character varying, kiosk_id bigint, kiosk_title character varying, product_id bigint, product_title character varying, menu_category character varying, product_group character varying, product_cost numeric, spoils_qty integer, spoilage_cost numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT dd.as_date,
            fd.campus_id,
            c.title as campus_title,
            fd.kiosk_id,
            k.title as kiosk_title,
            fd.product_id,
            p.title as product_title,
            p.consumer_category as menu_category,
            p.fc_title as product_group,
            p.cost as product_cost,
            fd.spoils_qty,
            fd.spoils_amt as spoilage_cost
            FROM dw.fact_daily_kiosk_sku_summary fd
            JOIN pantry.product p
            ON p.id = fd.product_id
            JOIN pantry.kiosk k
            ON k.id = fd.kiosk_id
            JOIN dw.dim_date dd
            ON dd.date_id = fd.date_id
            JOIN pantry.campus c
            ON c.id = fd.campus_id
            WHERE fd.spoils_qty > 0
            AND dd.as_date >= beginning_date
            AND dd.as_date <= ending_date;
    END;
$$;
CREATE FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) RETURNS TABLE(epc character varying, kiosk_id bigint, product_id bigint, time_updated timestamp with time zone, cost numeric, price numeric)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        BYTE_CAMPUS INTEGER := 87;
    BEGIN
        RETURN QUERY
        /*
        The following query is used to get non byte kiosks losses. SEE ENG-1272 and ENG-2199. 
        We remove free kiosks losses from the the total loss since free kiosks losses are 
        considered sales. 
        */
        SELECT epc_ as epc,
            kiosk_id_ as kiosk_id,
            product_id_ as product_id,
            time_updated_ as time_updated,
            cost_ as cost,
            price_ as price
            FROM dw.losses(beginning_date, ending_date) gl
            JOIN pantry.kiosk k
            ON k.id = gl.kiosk_id_
            LEFT JOIN pantry.discount d
            ON k.id = d.kiosk_id
            AND d.product_id IS NULL
            WHERE (value != 100 OR value IS NULL)
            AND kiosk_campus_id_ != BYTE_CAMPUS;
    END;
$$;
CREATE FUNCTION test.uptime_ratio(start_date date, end_date date) RETURNS TABLE(uptime_percent numeric)
    LANGUAGE plpgsql
    AS $$
declare
  total_active_kiosks integer;
  measured_heartbeats integer;
  expected_heartbeats integer;
begin
  /*
  Return uptime ratio: measured_heartbeats/expected_heartbeats.
  Heart beats are reported every 10 minutes.
  Caveat: kiosks that enter/exit service during the reporting period.
   */
  select count(*), sum(heart_beats)
  from
    (select
       kiosk_id, count(*) heart_beats
     FROM kiosk_status
            JOIN pantry.kiosk ON kiosk.id = kiosk_status.kiosk_id
     WHERE to_timestamp(time) >= start_date
       AND to_timestamp(time)  < end_date
       AND kiosk.archived = 0
       AND to_timestamp(deployment_time) < start_date
     group by 1) per_kiosk_heartbeats
    into total_active_kiosks, measured_heartbeats;
  select 144 * total_active_kiosks *  (end_date - start_date) into expected_heartbeats;
  return query
    select (measured_heartbeats::decimal/expected_heartbeats)::decimal(6,4);
end
$$;
CREATE FUNCTION erp.sync_kiosk_reference() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
  /*
Required: populated erp.global_attribute_def, erp.client_industry
Prepare kiosk reference:
  erp.client
  erp.address
  erp.contact
*/
declare
  i smallint;
  address_fields text[5];
  _client_id integer;
  _client_name text;
  _address_id integer;
  _address1 text;
  _address2 text;
  _city text;
  _state text;
  _zip text;
  _phone text;
  _email text;
  _kiosk_name text;
  _industry integer;
  _location_type_string text;
  _location_type integer;
  _general_contact_type integer;
  _accounting_contact_type integer;
  _accounting_contact_id integer;
  _airport_location_type integer;
  _apartment_location_type integer;
  _gym_location_type integer;
  _higher_education_location_type integer;
  _hospital_location_type integer;
  _hotel_location_type integer;
  _k_12_education_location_type integer;
  _other_location_type integer;
  _workplace_location_type integer;
begin
  select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
  select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';
  select id into _airport_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Airport';
  select id into _apartment_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Apartment';
  select id into _gym_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Gym';
  select id into _higher_education_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Higher Education';
  select id into _hospital_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Hospital';
  select id into _hotel_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Hotel';
  select id into _k_12_education_location_type from erp.global_attribute_def where name = 'location_type' and value = 'K-12 Education';
  select id into _other_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Other';
  select id into _workplace_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Workplace';
  if tg_op in ('INSERT', 'UPDATE')
    then
      if new.client_name = 'Byte'
        then
          new.address = '101 Glacier Point, San Rafael, CA 94901';
          new.contact_first_name = 'Megan';
          new.contact_last_name = 'Mokri';
          new.contact_email = 'megan@bytefoods.co';
          new.accounting_email = 'same';
          new.location_x = 37.950262;
          new.location_y = -122.489975;
      end if;
      select address1, address2, city, state, zip from erp.parse_address(new.address)
        into _address1, _address2, _city, _state, _zip;
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);
      select coalesce(ga.id, -1) into _industry
      from erp.client_industry ci
             left join (select * from erp.global_attribute_def ga where ga.name = 'industry') ga
                       on ci.industry = ga.value
      where ci.client_name = new.client_name;
      if _industry is null then
        _industry = -1;
      end if;
      insert into erp.client(name, employees_num, industry)
        values(_client_name, new.employees_num, _industry)
        on conflict(name) do nothing;
      select id into _client_id from erp.client c where c.name = _client_name;
      insert into erp.address(client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
      values(_client_id, _address1, _address2, _city, _state, _zip, new.location_x, new.location_y, new.timezone)
      on conflict(address1) do
        update set
          (client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
            =
          (_client_id,
          coalesce(_address1, erp.address.address1),
          coalesce(_address2, erp.address.address2),
          coalesce(_city, erp.address.city),
          coalesce(_state, erp.address.state),
          coalesce(_zip, erp.address.zip),
          coalesce(new.location_x, erp.address.location_x),
          coalesce(new.location_y, erp.address.location_y),
          coalesce(new.timezone, erp.address.timezone))
        returning id into _address_id;
      select phone into _phone from erp.parse_phone(new.contact_phone);
      if new.contact_email ~ '^\w+@[0-9a-zA-Z_]+?\.[0-9a-zA-Z]{2,3}$'
      then _email = new.contact_email;
      else _email = null;
      end if;
      insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
      values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
      on conflict do nothing;
      if new.accounting_email = 'same'
      then insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
           values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _accounting_contact_type)
           on conflict do nothing;
      end if;
    return null;
  end if;
end;
$_$;
ALTER FUNCTION erp.sync_kiosk_reference() OWNER TO erpuser;
CREATE FUNCTION erp.sync_kiosk_tables() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  /*
Required: populated erp.global_attribute_def, erp.client_industry
Prepare kiosk reference:
  erp.client
  erp.address
  erp.contact
*/
declare
  i smallint;
  address_fields text[5];
  _client_id integer;
  _client_name text;
  _address_id integer;
  _address1 text;
  _address2 text;
  _city text;
  _state text;
  _zip text;
  _phone text;
  _email text;
  _kiosk_name text;
  _industry integer;
  _location_type_string text;
  _location_type integer;
  _payment_start_date date;
  _payment_stop_date date;
  _general_contact_type integer;
  _general_contact_id integer;
  _accounting_contact_type integer;
  _accounting_contact_id integer;
  _airport_location_type integer;
  _apartment_location_type integer;
  _gym_location_type integer;
  _higher_education_location_type integer;
  _hospital_location_type integer;
  _hotel_location_type integer;
  _k_12_education_location_type integer;
  _other_location_type integer;
  _workplace_location_type integer;
begin
  select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
  select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';
  select id into _airport_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Airport';
  select id into _apartment_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Apartment';
  select id into _gym_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Gym';
  select id into _higher_education_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Higher Education';
  select id into _hospital_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Hospital';
  select id into _hotel_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Hotel';
  select id into _k_12_education_location_type from erp.global_attribute_def where name = 'location_type' and value = 'K-12 Education';
  select id into _other_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Other';
  select id into _workplace_location_type from erp.global_attribute_def where name = 'location_type' and value = 'Workplace';
  if tg_op in  ('INSERT', 'UPDATE')
    then
      select address1, address2, city, state, zip from erp.parse_address(new.address)
                                                       into _address1, _address2, _city, _state, _zip;
      select address.id into _address_id from erp.address
      where address1 = _address1 and address2 = _address2 and city = _city and state = _state and zip = _zip;
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);
      select id into _client_id from erp.client where name = _client_name;
      select contact.id into _general_contact_id from erp.contact
      where first_name = new.contact_first_name and last_name = new.contact_last_name and contact_type = _general_contact_type;
      select contact.id into _accounting_contact_id from erp.contact
      where first_name = new.contact_first_name and last_name = new.contact_last_name and contact_type = _accounting_contact_type;
      _kiosk_name = 'KID' || new.id;
      if new.payment_start is null or new.payment_start = 0
        then _payment_start_date = null;
        else _payment_start_date = to_timestamp(new.payment_start)::date;
      end if;
      if new.payment_stop is null or new.payment_stop = 0
      then _payment_stop_date = null;
      else _payment_stop_date = to_timestamp(new.payment_stop)::date;
      end if;
  end if;
  if tg_op = 'INSERT'
    then
      insert into erp.kiosk(id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
                            location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
                            deployment_status_id, bank, archived)
        values (new.id, new.campus_id, new.serial,
                _client_id,
                new.title, _kiosk_name, new.geo, _address_id, new.publicly_accessible,
                _location_type,
                new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
                0,
                0,
                new.archived);
      insert into erp.hardware_software(kiosk_id, gcm_id, app_vname, app_vcode, features, components, server_url, peekaboo_url, email_receipt_subject)
        values(new.id, new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
               '', --new.peekaboo_url,
               new.email_receipt_subject);
      insert into erp.kiosk_accounting(kiosk_id, start_date, payment_start, payment_stop, sales_tax, default_fee_plan,
                                       byte_discount, subsidy_info, max_subscription, subscription_amount, setup_fee, subsidy_notes)
        values (new.id,
                null, -- start_date,
                _payment_start_date, _payment_stop_date, new.sales_tax, new.default_fee_plan, new.byte_discount,
                new.subsidy_info, new.max_subscription, new.subscription_amount,
                null, -- new.setup_fee,
                new.subsidy_notes);
      return new;
  elseif tg_op = 'DELETE'
    then
      delete from erp.kiosk where id = old.id;
      delete from erp.hardware_software where kiosk_id = old.id;
      delete from erp.kiosk_accounting where kiosk_id = old.id;
      return old;
  end if;
end;
$$;
ALTER FUNCTION pantry.sync_label_order() OWNER TO erpuser;
ALTER FUNCTION dw.export_spoilage(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION erp.parse_address(address_str text) OWNER TO erpuser;
ALTER FUNCTION erp.sync_kiosk() OWNER TO erpuser;
ALTER FUNCTION dw.export_kiosk_status(kiosk_number bigint) OWNER TO erpuser;
ALTER FUNCTION dw.losses(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION dw.sales(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION erp_test.parse_address(address_str text) OWNER TO erpuser;
ALTER FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.non_byte_restocks(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION erp_test.reverse_sync_kiosk() OWNER TO erpuser;
ALTER FUNCTION dw.export_unconsolidated_remittance(month_date date) OWNER TO erpuser;
ALTER FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION test.uptime_ratio(start_date date, end_date date) OWNER TO erpuser;
ALTER FUNCTION dw.export_remittance(month_date date) OWNER TO erpuser;
ALTER FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) OWNER TO erpuser;
ALTER FUNCTION fnrenames.some_f(param character varying) OWNER TO erpuser;
ALTER FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.refresh_dim_kiosk() OWNER TO muriel;
ALTER FUNCTION erp_test.test(_id integer) OWNER TO erpuser;
ALTER FUNCTION pantry.get_label_order_epc() OWNER TO erpuser;
ALTER FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) OWNER TO erpuser;
ALTER FUNCTION dw.byte_sales(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION dw.byte_spoils(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) OWNER TO erpuser;
ALTER FUNCTION fnrenames.parse_address(address_str text) OWNER TO erpuser;
ALTER FUNCTION inm_test.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;
ALTER FUNCTION dw.byte_restocks(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) OWNER TO erpuser;
ALTER FUNCTION dw.export_losses(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION inm.pick_check_duplicate_stop() OWNER TO erpuser;
ALTER FUNCTION migration.test_get_product_record(pid integer) OWNER TO erpuser;
ALTER FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION dw.export_licensee_fee(month_date date) OWNER TO erpuser;
ALTER FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION erp_test.parse_phone(text_to_parse text) OWNER TO erpuser;
ALTER FUNCTION fnrenames.parse_phone(text_to_parse text) OWNER TO erpuser;
ALTER FUNCTION dw.export_consolidated_remittance(month_date date) OWNER TO erpuser;
ALTER FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.spoils(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION erp.parse_phone(text_to_parse text) OWNER TO erpuser;
ALTER FUNCTION erp.reverse_sync_kiosk() OWNER TO erpuser;
ALTER FUNCTION inm_test.pick_get_delivery_schedule(pick_date date) OWNER TO erpuser;
ALTER FUNCTION test.export_consolidated_remittance(month_date date) OWNER TO erpuser;
ALTER FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) OWNER TO erpuser;
ALTER FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION dw.refresh_dim_product() OWNER TO muriel;
ALTER FUNCTION erp.sync_kiosk_tables() OWNER TO erpuser;
ALTER FUNCTION erp_test.fn_ro_order_update_full_price(orderid character varying) OWNER TO erpuser;
ALTER FUNCTION test.uptime_percentage(start_date date, end_date date) OWNER TO erpuser;
ALTER FUNCTION inm_test.get_pull_date_enhanced(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;
ALTER FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION dw.restocks(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION erp.sync_product() OWNER TO erpuser;
ALTER FUNCTION dw.byte_losses(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION dw.insert_sales_monthly_byte_foods_summary(month_date date) OWNER TO erpuser;
ALTER FUNCTION pantry.sync_campus() OWNER TO erpuser;
ALTER FUNCTION dw.export_feedback(beginning_date date, ending_date date) OWNER TO erpuser;
ALTER FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;
ALTER FUNCTION erp_test.sync_product() OWNER TO erpuser;
ALTER FUNCTION test.spoils(beginning_date date, ending_date date) OWNER TO erpuser;