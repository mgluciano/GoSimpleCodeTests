
CREATE DOMAIN type.money_max_10k AS numeric(6,2);
CREATE DOMAIN type.money_max_1k AS numeric(5,2);
CREATE DOMAIN type.money_max_1m AS numeric(8,2);
CREATE DOMAIN type.zero_or_one AS smallint
	CONSTRAINT zero_or_one_check CHECK (((VALUE >= 0) AND (VALUE <= 1)));
CREATE INDEX client_contact_client_id_idx ON erp.client_contact USING btree (client_id);
CREATE INDEX ro_order_to_timestamp_campus_id_idx ON pantry.ro_order USING btree (to_timestamp((created)::double precision), campus_id);
CREATE INDEX fact_daily_kiosk_sku_summary_product_id_idx ON test.fact_daily_kiosk_sku_summary USING btree (product_id);
CREATE INDEX dw_fact_daily_kiosk_sku_summary_product_id ON dw.fact_daily_kiosk_sku_summary USING btree (product_id);
CREATE INDEX idx_pantry_product_consumer_category ON pantry.product USING btree (consumer_category);
CREATE INDEX to_timestamp_time ON pantry.kiosk_status USING btree (to_timestamp(("time")::double precision));
CREATE UNIQUE INDEX tag_type_type_key ON erp.tag_type USING btree (type);
CREATE SEQUENCE erp.fcm_repeater_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.sku_property_def_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.history_order_pipeline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.history_order_pipeline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.product_fact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE inm_test.even_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE inm_test.even_id_id_seq
    START WITH 1
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE inm.kiosk_control TO yann;
RESET SESSION AUTHORIZATION;
COMMENT ON FUNCTION pantry.get_label_order_epc() IS 'retrieves tag data and generates epc for scheduled label orders';
COMMENT ON TABLE inm.warehouse_order_history IS 'product orders for the warehouse';
COMMENT ON TABLE erp.kiosk_accounting IS 'one kiosk_accounting, one kiosk';
COMMENT ON FUNCTION dw.sales(beginning_date date, ending_date date) IS 'returns sales';
COMMENT ON VIEW inm.kiosk_projected_stock IS 'kiosk current stock plus items on route';
COMMENT ON FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) IS 'returns non campus 87 sales';
COMMENT ON TABLE inm.pick_demand IS 'sku_groups requested per kiosk';
COMMENT ON TABLE dw.dim_product IS 'product info';
COMMENT ON TABLE erp.product_pricing IS 'unit and case price, cost, tax info';
COMMENT ON FUNCTION dw.export_feedback(beginning_date date, ending_date date) IS 'returns feedback info';
COMMENT ON TABLE inm.pick_allocation IS 'items allocated per kiosk';
COMMENT ON TABLE erp.product_handling IS 'Product physical characteristics. Product rfid tags order handling options';
COMMENT ON TABLE erp.client_contact IS 'one client, many contacts';
COMMENT ON TABLE erp.kiosk_restriction_by_product IS 'one kiosk, many restricted products';
COMMENT ON FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts losses in dw.fact_daily_kiosk_sku_summary';
COMMENT ON FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) IS 'returns non campus 87 losses';
COMMENT ON VIEW dw.export_inventory_lots IS 'returns detailed current inventory';
COMMENT ON TABLE dw.fact_daily_byte_foods_summary IS 'campus 87 key metrics per day';
COMMENT ON TABLE erp.address IS 'addresses and geographical information including latitude and longitude';
COMMENT ON FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'inserts sales in dw.fact_daily_byte_foods_summary';
COMMENT ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) IS 'return pull_date per kiosk per pick window';
COMMENT ON TABLE inm.pick_preference_kiosk_sku IS 'kiosk preference factor of skus';
COMMENT ON FUNCTION dw.refresh_dim_product() IS 'updates dw.dim_product';
COMMENT ON TABLE erp.classic_product_category_tag IS 'product tag compatible with pantry.kiosk';
COMMENT ON TABLE erp.product_nutrition IS 'one product, one product_nutrition record';
COMMENT ON TABLE dw.fact_daily_kiosk_sku_summary IS 'key metrics per kiosk, SKU and day';
COMMENT ON TABLE inm.pick_list IS 'completed picks';
COMMENT ON TABLE erp.kiosk IS 'main table for kiosk data';
COMMENT ON TABLE erp.kiosk_attribute IS 'one kiosk, many attributes';
COMMENT ON TABLE erp.product_property IS 'one product, many properties';
COMMENT ON FUNCTION inm.pick_get_demand_weekly_wo_min() IS 'return inm_beta weekly demand without min by velocity';
COMMENT ON FUNCTION dw.byte_spoils(beginning_date date, ending_date date) IS 'returns campus 87 spoils';
COMMENT ON TABLE inm.sku_group_control IS 'allocation control for sku_groups';
COMMENT ON TABLE erp.product_category_def IS 'Defines categories identified by id. `name` = category type, `value` = display text';
COMMENT ON TABLE erp.product_sourcing IS 'product vendor and source';
COMMENT ON FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) IS 'clears dw.fact_monthly_kiosk_summary';
COMMENT ON TABLE erp.hardware_software IS 'kiosk hardware and software versions';
COMMENT ON FUNCTION dw.export_kiosk_status(kiosk_number bigint) IS 'returns kiosk status info';
COMMENT ON TABLE dw.fact_monthly_kiosk_summary IS 'key metrics per kiosk and month';
COMMENT ON TABLE erp.product IS 'main table for product data';
COMMENT ON TABLE erp.product_asset IS 'product display values';
COMMENT ON TABLE erp.tag_order IS 'order data for tags';
COMMENT ON TABLE erp.kiosk_restriction_by_property IS 'one kiosk, many restricted properties';
COMMENT ON TABLE inm.kiosk_restriction_by_property IS 'one kiosk, many restricted properties';
COMMENT ON VIEW dw.last_15_months IS 'returns the last 15 months';
COMMENT ON TABLE erp.tag_type IS 'types for tags a.k.a. labels';
COMMENT ON FUNCTION dw.byte_sales(beginning_date date, ending_date date) IS 'returns campus 87 sales';
COMMENT ON TABLE inm.kiosk_restriction_by_product IS 'one kiosk, many restricted products';
COMMENT ON TABLE erp.kiosk_contact IS 'one kiosk, many contacts';
COMMENT ON TABLE erp.kiosk_delivery_window IS 'one kiosk, many delivery time blocks';
COMMENT ON FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'inserts heart beat info in dw.fact_daily_byte_foods_summary';
COMMENT ON FUNCTION dw.losses(beginning_date date, ending_date date) IS 'returns losses';
COMMENT ON VIEW dw.current_inventory IS 'returns current inventory';
COMMENT ON TABLE dw.dim_kiosk IS 'kiosk info';
COMMENT ON TABLE erp.kiosk_status IS 'last update timestamps';
COMMENT ON TABLE inm.configuration IS 'inm configuration values';
COMMENT ON TABLE inm.route_stop IS 'delivery schedule for kiosks';
COMMENT ON TABLE inm.sku_group_attribute IS 'Defines sku_groups';
COMMENT ON VIEW dw.last_15_weeks IS 'returns the last 15 weeks';
COMMENT ON TABLE erp.tag_price IS 'tag price per campus';
COMMENT ON FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts sales in dw.fact_daily_kiosk_sku_summary';
COMMENT ON FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) IS 'returns non campus 87 spoils';
COMMENT ON FUNCTION dw.restocks(beginning_date date, ending_date date) IS 'returns restocks';
COMMENT ON TABLE inm.pick_route IS 'route details including driver name';
COMMENT ON TABLE erp.client_industry IS 'one client, one industry';
COMMENT ON TABLE inm.pick_rejection IS 'items rejects by kiosk';
COMMENT ON TABLE erp.product_property_tag IS 'translates between product property and pantry.tag';
COMMENT ON TABLE inm.pick_substitution IS 'items substituted';
COMMENT ON TABLE inm.kiosk_sku_group_manual_scale IS 'control sku_group scale per kiosk';
COMMENT ON TABLE erp.global_attribute_def IS 'Defines attributes identified by id. `name` = attribute type, `value` = display text';
COMMENT ON FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts stock ins in dw.fact_daily_kiosk_sku_summary';
COMMENT ON FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'updates dw.fact_daily_byte_foods_summary';
COMMENT ON FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) IS 'updates dw.fact_monthly_kiosk_summary';
COMMENT ON TABLE erp.kiosk_note IS 'one kiosk, many notes, with possible start/end time';
COMMENT ON TABLE erp.product_property_def IS 'Defines properties identified by id. `name` = property type, `value` = display text';
COMMENT ON FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'clears dw.fact_daily_kiosk_sku_summary';
COMMENT ON FUNCTION dw.refresh_dim_kiosk() IS 'updates dw.dim_kiosk';
COMMENT ON TABLE dw.dim_campus IS 'campus info';
COMMENT ON TABLE dw.dim_date IS 'date values from 2012 through 2039';
COMMENT ON TABLE inm.product_property IS 'one product - many properties';
COMMENT ON TABLE erp.contact IS 'contacts catalog';
COMMENT ON TABLE erp.product_category IS 'one product, many categories';
COMMENT ON TABLE inm.pick_inventory IS 'projected kiosk inventory at pick time';
COMMENT ON TABLE inm.product_property_def IS 'Defines properties identified by id. `name` = property type, `value` = display text';
COMMENT ON FUNCTION dw.byte_losses(beginning_date date, ending_date date) IS 'returns campus 87 losses';
COMMENT ON TABLE inm.kiosk_control IS 'kiosk settings';
COMMENT ON VIEW dw.last_30_days IS 'returns the last 30 days';
COMMENT ON TABLE inm.warehouse_inventory IS 'daily warehouse inventory';
COMMENT ON TABLE inm.pick_priority_sku IS 'lower priority get distributed first';
COMMENT ON VIEW dw.byte_current_inventory IS 'returns campus 87 current inventory';
COMMENT ON FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'inserts 10am inventory snapshot in dw.fact_daily_byte_foods_summary';
COMMENT ON FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts spoils in dw.fact_daily_kiosk_sku_summary';
COMMENT ON TABLE erp.client IS 'client data';
COMMENT ON TABLE erp.tag_order_stats IS 'stats for fulfilled tag orders';
COMMENT ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) IS 'summarize allocation settings, input, and results';
COMMENT ON TABLE erp.sku_group IS 'Defines facing categories title and physical size';
COMMENT ON FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'updates dw.fact_daily_kiosk_sku_summary';
COMMENT ON FUNCTION inm.get_spoilage_pull_list() IS 'return items that will spoil before the next delivery';
COMMENT ON TABLE inm.pick_priority_kiosk IS 'higher priority get first pick';
COMMENT ON TABLE erp.client_campus IS 'one client, many campuses';
COMMENT ON TABLE erp.kiosk_access_card IS 'kiosk physical location access card';
COMMENT ON FUNCTION dw.spoils(beginning_date date, ending_date date) IS 'returns spoils';
CREATE UNIQUE INDEX client_id_contact_type ON erp_test.contact USING btree (client_id, contact_type);