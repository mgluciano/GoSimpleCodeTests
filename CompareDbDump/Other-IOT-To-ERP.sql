
CREATE UNIQUE INDEX last_kiosk_status_id ON pantry.last_kiosk_status USING btree (kiosk_id);
CREATE UNIQUE INDEX vantiv_20190801_referencenumber_idx ON test.vantiv_20190801 USING btree (referencenumber);
CREATE OR REPLACE PROCEDURAL LANGUAGE plperl;
CREATE UNIQUE INDEX awsdms_history_task_history_index ON public.awsdms_history USING btree (server_name, task_name, timeslot_type, timeslot);
CREATE UNIQUE INDEX awsdms_status_task_status_index ON public.awsdms_status USING btree (server_name, task_name);
CREATE UNIQUE INDEX awsdms_suspended_tables_task_suspended_tables_index ON public.awsdms_suspended_tables USING btree (server_name, task_name, table_owner, table_name);
CREATE INDEX idx_bko_hkp ON public.byte_kp_sales USING btree (kiosk_id, product_id, sales_hour);
CREATE INDEX idx_bkp_savg ON public.byte_kp_sales_avgdowhour USING btree (kiosk_id, product_id, dowhour);
CREATE INDEX history_epc_order_time ON pantry.history_epc_order USING btree ("time");
CREATE INDEX inventory_request_ts ON pantry.inventory_request USING btree (to_timestamp(("time")::double precision));
CREATE INDEX tmp_payment_order_with_id_payload_idx ON pantry.tmp_payment_order_with_id USING btree (payload);
CREATE INDEX bytecodelog_bytecode_expires_at ON public.bytecodelog USING btree (bytecode, expires_at);
CREATE INDEX kiosk_restriction_by_property_property_id_idx ON mixalot.kiosk_restriction_by_property USING btree (property_id);
CREATE INDEX sku_property_property_id_idx ON mixalot.sku_property USING btree (property_id);
CREATE INDEX byte_product_stats_by_kiosk_idx ON pantry.product_stats_by_kiosk USING btree (to_timestamp(("timestamp")::double precision));
CREATE INDEX request_log_version ON mixalot.request_log USING btree (version);
CREATE INDEX byte_spoilage_ts_idx ON pantry.spoilage USING btree (to_timestamp((time_removed)::double precision));
CREATE INDEX byte_stockouts_ts_idx ON pantry.stockout USING btree (to_timestamp(("timestamp")::double precision));
CREATE INDEX idx_bkg_hkp ON public.byte_kp_grid USING btree (kiosk_id, product_id, hour_start);
CREATE INDEX idx_bkp_oavg ON public.byte_kp_oos_avgdowhour USING btree (kiosk_id, product_id, dowhour);
CREATE INDEX sku_property_property_id_idx ON inm.sku_property USING btree (property_id);
CREATE INDEX kiosk_restriction_by_sku_sku_id_idx ON mixalot.kiosk_restriction_by_sku USING btree (sku_id);
ALTER PROCEDURAL LANGUAGE plperl OWNER TO dbservice;
CREATE SEQUENCE pantry.facing_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.manual_adjustment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.component_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.transact_express_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public."pantry.kiosk_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.discount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.kiosk_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.server_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.kiosk_cd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.kiosk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.product_kiosk_fact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.cron_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.fee_rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.track_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.last_kiosk_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.campaigns_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.customers_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.payment_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE beta.pick_demand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.lineitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.order_meta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.product_kiosk_price_offset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.kiosk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE beta.temp_test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.merchandising_slot_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.merchandising_slot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.kiosk_attribute_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.kiosk_audit_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.nutrition_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.product_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.card_fact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.test_time_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.kiosk_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.accounting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.kiosk_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.transact_ipc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.discount_applied_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.kiosk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE test.transactions_pending_sync_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE beta.temp_test2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.stockout_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.history_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.par_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.restock_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.delivery_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.inventory_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.transact_fp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE test.request_log_sold_epc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.sku_attribute_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.awsdms_heartbeat_hb_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.campus_attribute_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.global_attribute_def_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.nutrition_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.transact_comp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE mixalot.temp_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.currency_symbol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.spoilage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.bad_timestamp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.kiosks_date_non_new_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE fnrenames.discount_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.campus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.discount_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE pantry.product_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE public.track_dashboard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE UNIQUE INDEX order_id_unique ON pantry.feedback USING btree (order_id);
CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;
CREATE DOMAIN inm_beta.text100_nb AS inm_beta.text100
	CONSTRAINT text100_nb_check CHECK ((length((VALUE)::text) >= 1));
CREATE UNIQUE INDEX tag_name_id ON pantry.tag USING btree (tag);
CREATE UNIQUE INDEX tag_unique_constraint_index ON pantry.tag USING btree (lower((tag)::text));
COMMENT ON VIEW inm.kiosk_projected_stock_sku_level IS 'Projected skus in a kiosk which includes items on delivery';
COMMENT ON SCHEMA inm IS 'Demand planning';
COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';
COMMENT ON SCHEMA inm_backup IS 'back up of tables containing inm settings such as kiosk_sku_preference before the latest changes.';
COMMENT ON SCHEMA inm_test IS 'Where as inm schema will contain production pick result, inm_test will contain test pick results so that they do not affect actual inm production stats.';
COMMENT ON TABLE mixalot.sku_group_def IS 'sku group id''s and names';
COMMENT ON SCHEMA beta IS 'development schema';
COMMENT ON TABLE pantry.history_kiosk_device IS 'Table used to store changes information relating to kiosk_device';
COMMENT ON TABLE pantry.history_kiosk_service_version IS 'Table used to store changes information relating to kiosk_service_version';
COMMENT ON TABLE pantry.history_campus_attribute IS 'Table used to store changes information relating to history_campus_attribute';
COMMENT ON TABLE pantry.history_global_attribute_def IS 'Table used to store changes to global_attribute_def';
COMMENT ON TABLE pantry.history_kiosk_attribute IS 'Table used to store changes information relating to kiosk_attribute';
COMMENT ON SCHEMA inm_beta IS 'New schema to be used by LambdaZen. Contains iINM related objects plus new versions of other general objects currently in pantry schema such as KIOSK and KIOSK related tables.';
COMMENT ON SCHEMA monitor IS 'stores kiosk monitor data';
COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';
COMMENT ON FUNCTION inm.pick_check_restriction(_pick_date date) IS 'Run this after a pick to find restricted products in allocation.';
COMMENT ON TABLE mixalot.sku_group_sku IS 'store SKUs for each sku_group';
COMMENT ON TABLE mixalot.temp_ms_to_sg IS 'temp lookup table for merchandising slot to skugroup';
COMMENT ON TABLE mixalot.temp_sku_to_skugroup IS 'temp lookup table for sku-sku_group';
COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';
COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';
COMMENT ON VIEW inm.kiosk_projected_minimum IS 'Anbalysis of minimum using current and expect inventory from pick';
COMMENT ON TABLE mixalot.merchandising_slot_sku_group IS 'store all the sku groups for each merchandising slot';
COMMENT ON TABLE mixalot.sku_property IS 'all the properties for each sku';
COMMENT ON TABLE pantry.order_meta IS 'Table used to store additional information relating to pantry_meta';
COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';
COMMENT ON TABLE mixalot.sku_def IS 'SKUs id''s and names';