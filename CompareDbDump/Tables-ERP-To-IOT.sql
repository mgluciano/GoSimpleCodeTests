
CREATE TABLE erp.fcm_repeater (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    email character varying(127),
    fcm_command character varying(100) NOT NULL,
    req_time bigint NOT NULL,
    resolution_time bigint,
    process smallint DEFAULT 0,
    resolution smallint DEFAULT 0
);
CREATE TABLE dw.dim_campus (
    id bigint NOT NULL,
    title character varying(135) NOT NULL,
    timezone character varying(150),
    archived integer
);
CREATE TABLE erp_test.product_property (
    product_id bigint NOT NULL,
    property_id integer NOT NULL
);
CREATE TABLE inm_restore_0625.kiosk_restriction_by_property_gs (
    kiosk_id integer,
    property_id integer
);
CREATE TABLE erp.global_attribute_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text200 NOT NULL,
    note type.text200
);
CREATE TABLE erp.product (
    id bigint NOT NULL,
    brand type.text400,
    campus_id integer NOT NULL,
    sku_group_id integer,
    fc_title type.text_name,
    archived type.zero_or_one NOT NULL,
    last_update bigint NOT NULL
);
CREATE TABLE test.fact_daily_campus_87 (
    campus_id integer,
    product_id bigint,
    date_id integer,
    sales_qty integer,
    sales_amt numeric(12,2),
    cost_amt numeric(12,2),
    gross_margin_amt numeric(12,2),
    spoils_qty integer,
    spoils_amt numeric(12,2),
    losses_qty integer,
    stocked_percent numeric(3,2),
    ip_commerce numeric(12,2),
    freedom_pay numeric(12,2),
    complimentary numeric(12,2),
    sales_after_discount numeric(12,2)
);
CREATE TABLE erp.contact (
    id integer NOT NULL,
    client_id integer NOT NULL,
    title type.text_name,
    first_name type.text_name,
    last_name type.text_name,
    email type.email,
    phone type.phone,
    contact_type integer NOT NULL
);
CREATE TABLE erp.kiosk_contact (
    contact_id integer NOT NULL,
    kiosk_id integer NOT NULL
);
CREATE TABLE erp_backup.product_property (
    product_id bigint NOT NULL,
    property_id integer NOT NULL
);
CREATE TABLE fnrenames.awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);
CREATE TABLE inm_test.kiosk_sku_group_manual_scale_20190624 (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2)
);
CREATE TABLE erp.product_pricing (
    product_id bigint NOT NULL,
    price type.money_max_1k NOT NULL,
    cost type.money_max_10k NOT NULL,
    ws_case_cost type.money_max_10k,
    pricing_tier type.text40,
    taxable type.zero_or_one
);
CREATE TABLE pantry.temp_kiosk (
    id bigint NOT NULL,
    campus_id bigint NOT NULL,
    serial character varying(45) NOT NULL,
    title character varying(46),
    address character varying(127),
    location_x numeric(9,6) NOT NULL,
    location_y numeric(9,6) NOT NULL,
    gcm_id character varying(255),
    app_vname character varying(63),
    app_vcode integer,
    archived bigint,
    creation_time bigint,
    deployment_time bigint,
    last_update bigint,
    client_name character varying(255),
    last_status bigint,
    last_inventory bigint NOT NULL,
    kiosk_name character varying(255) NOT NULL,
    payment_start bigint,
    payment_stop bigint,
    features character varying(255) NOT NULL,
    sales_tax smallint NOT NULL,
    default_fee_plan bigint NOT NULL,
    timezone character varying(50),
    estd_num_users bigint,
    tags character varying(255),
    publicly_accessible bigint,
    cardkey_required bigint,
    delivery_insns character varying(65535),
    fridge_loc_info character varying(65535),
    contact_first_name character varying(65535),
    contact_last_name character varying(65535),
    contact_email character varying(65535),
    contact_phone character varying(65535),
    accounting_email character varying(65535),
    byte_discount character varying(255),
    subsidy_info character varying(50),
    subsidy_notes character varying(65535),
    max_subscription character varying(50),
    delivery_window_mon character varying(50),
    delivery_window_tue character varying(50),
    delivery_window_wed character varying(50),
    delivery_window_thu character varying(50),
    delivery_window_fri character varying(50),
    delivery_window_sat character varying(50),
    delivery_window_sun character varying(50),
    notes character varying(2000),
    components text,
    email_receipt_subject character varying(255),
    ops_team_notes character varying(65535),
    geo character varying(3),
    server_url character varying(127),
    subscription_amount numeric(8,2) NOT NULL,
    enable_reporting bigint,
    enable_monitoring bigint,
    employees_num bigint,
    kiosk_restrictions character varying(2000)
);
CREATE TABLE erp_test.global_attribute_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text200 NOT NULL,
    note type.text200
);
CREATE TABLE inm_restore_0625.kiosk_restriction_by_property (
    kiosk_id integer,
    property_id integer
);
CREATE TABLE erp.classic_product_allergen_tag (
    product_id integer NOT NULL,
    tag_id integer NOT NULL
);
CREATE TABLE erp.kiosk_access_card (
    id integer NOT NULL,
    card_id type.text400 NOT NULL,
    client_id integer NOT NULL,
    expiration_date date
);
CREATE TABLE erp_test.client (
    id integer NOT NULL,
    name type.text_name,
    address_id integer,
    employees_num integer,
    industry integer
);
CREATE TABLE erp_test.client_contact (
    contact_id integer NOT NULL,
    client_id integer NOT NULL
);
CREATE TABLE erp_test.product (
    id bigint NOT NULL,
    brand type.text400,
    campus_id integer NOT NULL,
    sku_group_id integer,
    fc_title type.text_name,
    archived type.zero_or_one NOT NULL,
    last_update bigint NOT NULL
);
CREATE TABLE inm.warehouse_order_history (
    time_added timestamp(6) with time zone NOT NULL,
    sku integer NOT NULL,
    qty integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    amount_arrived integer,
    status character varying(200),
    warehouse_comment text,
    ordering_comment text,
    action character varying(200),
    purchase_order character varying(200),
    best_by_date character varying(200)
);
CREATE TABLE erp_backup.address (
    id integer NOT NULL,
    client_id integer,
    address1 type.text200,
    address2 type.text200,
    city type.text40,
    state type.text40,
    zip type.text40,
    location_x numeric(9,6) NOT NULL,
    location_y numeric(9,6) NOT NULL,
    timezone type.text40
);
CREATE TABLE erp_backup.product_property_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text100
);
CREATE TABLE inm_test.temp_a (
    id integer NOT NULL,
    name text
);
CREATE TABLE erp.product_nutrition (
    product_id bigint NOT NULL,
    total_cal smallint,
    num_servings real,
    calories real,
    proteins real,
    sugar real,
    carbohydrates real,
    fat real,
    sodium real,
    ingredients type.text4k,
    shelf_time smallint NOT NULL
);
CREATE TABLE erp_test.product_pricing (
    product_id bigint NOT NULL,
    price type.money_max_1k NOT NULL,
    cost type.money_max_10k NOT NULL,
    ws_case_cost type.money_max_10k,
    pricing_tier type.text40,
    taxable type.zero_or_one
);
CREATE TABLE inm_test.bkup_kiosk_product_disabled_20190408 (
    kiosk_id bigint,
    product_id bigint
);
CREATE TABLE erp.kiosk_restriction_by_product (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL
);
CREATE TABLE inm_restore_0625.sku_group_control (
    sku_group_id integer,
    default_level numeric(4,2),
    scale numeric(4,2),
    min_qty smallint,
    max_qty smallint
);
CREATE TABLE inm_test.odd_id (
    id integer NOT NULL,
    ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    comment text
);
CREATE TABLE erp_test.sku_group (
    id integer,
    fc_title type.text_name,
    unit_size numeric(4,2)
);
CREATE TABLE inm_test.test_sequence (
    id integer NOT NULL,
    name text
);
CREATE TABLE test.fact_monthly_kiosk_summary (
    campus_id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    date_id integer NOT NULL,
    sales_list_price numeric(12,2),
    sales_after_discount numeric(12,2),
    food_cost numeric(12,2),
    credit_card numeric(12,2),
    freedom_pay numeric(12,2),
    complimentary numeric(12,2),
    monthly_lease numeric(12,2),
    payment_processing_fee numeric(12,2),
    connectivity_fee numeric(12,2),
    sales_tax numeric(12,2),
    tag_fee numeric(12,2),
    losses_amt numeric(12,2),
    manual_adjustment numeric(12,2),
    fee_plan_name text,
    prepaid_number_of_months bigint,
    prepaid_until character varying(20),
    licensing_subscription_fee numeric(12,2),
    tag_price numeric(12,2),
    payment_processing_rate character varying(20),
    details text
);
CREATE TABLE erp_test.address (
    id integer NOT NULL,
    client_id integer,
    address1 type.text200,
    address2 type.text200,
    city type.text40,
    state type.text40,
    zip type.text40,
    location_x numeric(9,6) NOT NULL,
    location_y numeric(9,6) NOT NULL,
    timezone type.text40
);
CREATE TABLE erp_test.kiosk_status (
    kiosk_id integer NOT NULL,
    last_update bigint,
    last_status bigint,
    last_inventory bigint NOT NULL
);
CREATE TABLE erp.kiosk_attribute (
    kiosk_id bigint NOT NULL,
    attribute_id integer NOT NULL
);
CREATE TABLE migration.product (
    id bigint NOT NULL,
    title character varying(127) NOT NULL,
    description character varying(4095),
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2) NOT NULL,
    cost numeric(5,2) NOT NULL,
    shelf_time integer NOT NULL,
    campus_id bigint NOT NULL,
    image smallint NOT NULL,
    image_time bigint,
    last_update bigint NOT NULL,
    archived bigint,
    taxable smallint,
    allergens character varying(255),
    attribute_names character varying(511),
    categories character varying(255),
    category_names character varying(511),
    vendor character varying(135),
    source character varying(135),
    notes character varying(2000),
    total_cal bigint,
    num_servings real,
    ingredients character varying(2000),
    calories real,
    proteins real,
    sugar real,
    carbohydrates real,
    fat real,
    consumer_category character varying(2000),
    ws_case_size bigint,
    kiosk_ship_qty bigint,
    ws_case_cost numeric(5,2),
    pick_station bigint,
    fc_title character varying(255),
    pricing_tier character varying(255),
    width_space real,
    height_space real,
    depth_space real,
    slotted_width real,
    tag_volume bigint,
    delivery_option character varying(255),
    tag_applied_by character varying(255)
);
CREATE TABLE public.product_fact (
    id integer NOT NULL,
    product_id integer,
    sku text,
    first_available_ts timestamp(6) with time zone,
    first_purchased_ts timestamp(6) with time zone,
    kiosks text,
    cnt_sales_1w integer,
    cnt_sales_30d integer,
    cnt_sales_6m integer
);
CREATE TABLE inm_restore_0625.kiosk_sku_group_manual_scale (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2)
);
CREATE TABLE inm_test.label (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    epc character varying(24) NOT NULL,
    is_generic_sku smallint,
    kiosk_id bigint,
    order_id character varying(45),
    status character varying(4),
    price numeric(6,2),
    cost numeric(6,2),
    time_created bigint,
    time_added bigint,
    time_updated bigint,
    notes text
);
CREATE TABLE inm.route_stop (
    route_date_time timestamp(6) with time zone NOT NULL,
    driver_name character varying(200) NOT NULL,
    location_name character varying(200) NOT NULL,
    schedule_at timestamp(6) with time zone NOT NULL,
    longitude numeric(28,6),
    address character varying(200),
    latitude numeric(28,6),
    stop_number integer,
    order_number character varying(200),
    location_number integer
);
CREATE TABLE erp.kiosk_delivery_window (
    kiosk_id bigint NOT NULL,
    dow type.dow NOT NULL,
    start_time time with time zone NOT NULL,
    end_time time with time zone NOT NULL,
    access_card_required type.zero_or_one
);
CREATE TABLE erp.product_asset (
    product_id bigint NOT NULL,
    title type.text400 NOT NULL,
    description type.text4k,
    tiny_description type.text100,
    short_description type.text200,
    medium_description type.text400,
    long_description type.text1k,
    image type.zero_or_one,
    image_url type.text400,
    image_time bigint
);
CREATE TABLE inm.product_pick_order_temp (
    product_id integer NOT NULL,
    qty integer,
    sku_group text,
    pick_order smallint DEFAULT 0 NOT NULL
);
CREATE TABLE inm_test.test2 (
    id integer NOT NULL,
    intval integer,
    strval text
);
CREATE TABLE test.kiosk_log (
    id integer NOT NULL,
    update_count integer DEFAULT 0,
    ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE dw.dim_product (
    id bigint NOT NULL,
    title text,
    campus_id integer NOT NULL,
    fc_title text,
    archived smallint NOT NULL,
    consumer_category text
);
CREATE TABLE erp.tag_order_stats (
    product_id bigint NOT NULL,
    used_since_last_delivery bigint,
    used_total bigint,
    last_delivery_date timestamp with time zone,
    last_delivery bigint,
    delivered_total bigint
);
CREATE TABLE inm_test.route_stop_20190616 (
    route_date_time timestamp(6) with time zone,
    driver_name character varying(200),
    location_name character varying(200),
    schedule_at timestamp(6) with time zone,
    longitude numeric(28,6),
    address character varying(200),
    latitude numeric(28,6),
    stop_number integer,
    order_number character varying(200),
    location_number integer
);
CREATE TABLE inm_test.temp_test (
    id integer NOT NULL
);
CREATE TABLE erp.classic_product_category_tag (
    product_id integer NOT NULL,
    tag_id integer NOT NULL
);
CREATE TABLE erp.tag_price (
    campus_id integer NOT NULL,
    tag_type type.text100 NOT NULL,
    price numeric(6,2)
);
CREATE TABLE test.fact_daily_kiosk_sku_summary (
    campus_id integer NOT NULL,
    product_id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    date_id integer NOT NULL,
    sales_qty integer,
    sales_amt numeric(12,2),
    cost_amt numeric(12,2),
    gross_margin_amt numeric(12,2),
    spoils_qty integer,
    spoils_amt numeric(12,2),
    losses_qty integer,
    losses_amt numeric(12,2),
    stocked_percent numeric(3,2),
    ip_commerce numeric(12,2),
    freedom_pay numeric(12,2),
    card_smith numeric(12,2),
    complimentary numeric(12,2),
    sales_after_discount numeric(12,2)
);
CREATE TABLE erp_test.client_industry (
    client_name type.text400,
    industry type.text40
);
CREATE TABLE public.history_order_pipeline (
    id integer NOT NULL,
    order_id character varying(45),
    action character varying(45),
    system character varying(45),
    "user" character varying(45),
    data text,
    ts timestamp(6) with time zone
);
CREATE TABLE public.bak_awsdms_validation_failures_v1 (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "FAILURE_TIME" timestamp without time zone NOT NULL,
    "KEY_TYPE" character varying(128) NOT NULL,
    "KEY" character varying(8000) NOT NULL,
    "FAILURE_TYPE" character varying(128) NOT NULL,
    "DETAILS" character varying(8000) NOT NULL
);
CREATE TABLE erp_backup.contact (
    id integer NOT NULL,
    client_id integer NOT NULL,
    title type.text_name,
    first_name type.text_name,
    last_name type.text_name,
    email type.email,
    phone type.phone,
    contact_type integer NOT NULL
);
CREATE TABLE inm_restore_0625.product_property (
    product_id bigint,
    property_id integer
);
CREATE TABLE inm_test.kiosk_projected_stock (
    kiosk_id bigint,
    kiosk_title character varying,
    fc_title character varying(765),
    count numeric
);
CREATE TABLE erp_test.product_nutrition (
    product_id bigint NOT NULL,
    total_cal smallint,
    num_servings real,
    calories real,
    proteins real,
    sugar real,
    carbohydrates real,
    fat real,
    sodium real,
    ingredients type.text4k,
    shelf_time smallint NOT NULL
);
CREATE TABLE migration.temp_product (
    id bigint NOT NULL,
    title character varying(127) NOT NULL,
    description character varying(4095),
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2) NOT NULL,
    cost numeric(5,2) NOT NULL,
    shelf_time integer NOT NULL,
    campus_id bigint NOT NULL,
    image smallint NOT NULL,
    image_time bigint,
    last_update bigint NOT NULL,
    archived bigint,
    taxable smallint,
    allergens character varying(255),
    attribute_names character varying(511),
    categories character varying(255),
    category_names character varying(511),
    vendor character varying(135),
    source character varying(135),
    notes character varying(2000),
    total_cal bigint,
    num_servings real,
    ingredients character varying(2000),
    calories real,
    proteins real,
    sugar real,
    carbohydrates real,
    fat real,
    consumer_category character varying(2000),
    ws_case_size bigint,
    kiosk_ship_qty bigint,
    ws_case_cost numeric(5,2),
    pick_station bigint,
    fc_title character varying(255),
    pricing_tier character varying(255),
    width_space real,
    height_space real,
    depth_space real,
    slotted_width real,
    tag_volume bigint,
    delivery_option character varying(255),
    tag_applied_by character varying(255)
);
CREATE TABLE dw.dim_date (
    date_id integer NOT NULL,
    as_date date,
    year_month integer,
    month_num integer,
    month_name text,
    month_short_name text,
    week_num integer,
    day_of_year integer,
    day_of_month integer,
    day_of_week integer,
    day_name text,
    day_short_name text,
    quarter integer,
    year_quarter integer,
    day_of_quarter integer,
    year integer,
    year_week integer
);
CREATE TABLE erp_test.contact (
    id integer NOT NULL,
    client_id integer NOT NULL,
    title type.text_name,
    first_name type.text_name,
    last_name type.text_name,
    email type.email,
    phone type.phone,
    contact_type integer NOT NULL
);
CREATE TABLE erp_test.kiosk (
    id bigint NOT NULL,
    campus_id integer NOT NULL,
    serial type.text100 NOT NULL,
    client_id integer NOT NULL,
    title type.text_name,
    name type.text_name NOT NULL,
    geo type.text_name,
    address_id integer,
    publicly_accessible type.zero_or_one,
    location_type integer,
    estd_num_users integer,
    enable_reporting smallint,
    creation_time bigint,
    deployment_time bigint,
    deployment_status_id integer,
    bank type.zero_or_one,
    archived type.zero_or_one
);
CREATE TABLE dw.fact_daily_kiosk_sku_summary (
    campus_id integer NOT NULL,
    product_id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    date_id integer NOT NULL,
    sales_qty integer,
    sales_amt numeric(12,2),
    cost_amt numeric(12,2),
    gross_margin_amt numeric(12,2),
    spoils_qty integer,
    spoils_amt numeric(12,2),
    losses_qty integer,
    losses_amt numeric(12,2),
    stocked_percent numeric(3,2),
    ip_commerce numeric(12,2),
    freedom_pay numeric(12,2),
    card_smith numeric(12,2),
    complimentary numeric(12,2),
    sales_after_discount numeric(12,2)
);
CREATE TABLE inm_restore_0625.kiosk_control (
    kiosk_id integer,
    start_level numeric(4,2),
    min_level numeric(4,2),
    scale numeric(4,2),
    manual_multiplier numeric(4,2)
);
CREATE TABLE erp_test.product_asset (
    product_id bigint NOT NULL,
    title type.text400 NOT NULL,
    description type.text4k,
    tiny_description type.text100,
    short_description type.text200,
    medium_description type.text400,
    long_description type.text1k,
    image type.zero_or_one,
    image_url type.text400,
    image_time bigint
);
CREATE TABLE inm_restore_0625.kiosk_sku_group_manual_scale_gs (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2)
);
CREATE TABLE erp.kiosk_status (
    kiosk_id integer NOT NULL,
    last_update bigint,
    last_status bigint,
    last_inventory bigint NOT NULL
);
CREATE TABLE migration.kiosk (
    id bigint NOT NULL,
    campus_id bigint NOT NULL,
    serial character varying(45) NOT NULL,
    title character varying(46),
    address character varying(127),
    location_x numeric(9,6) NOT NULL,
    location_y numeric(9,6) NOT NULL,
    gcm_id character varying(255),
    app_vname character varying(63),
    app_vcode integer,
    archived bigint,
    creation_time bigint,
    deployment_time bigint,
    last_update bigint,
    client_name character varying(255),
    last_status bigint,
    last_inventory bigint NOT NULL,
    kiosk_name character varying(255) NOT NULL,
    payment_start bigint,
    payment_stop bigint,
    features character varying(255) NOT NULL,
    sales_tax smallint NOT NULL,
    default_fee_plan bigint NOT NULL,
    timezone character varying(50),
    estd_num_users bigint,
    tags character varying(255),
    publicly_accessible bigint,
    cardkey_required bigint,
    delivery_insns character varying(65535),
    fridge_loc_info character varying(65535),
    contact_first_name character varying(65535),
    contact_last_name character varying(65535),
    contact_email character varying(65535),
    contact_phone character varying(65535),
    accounting_email character varying(65535),
    byte_discount character varying(255),
    subsidy_info character varying(50),
    subsidy_notes character varying(65535),
    max_subscription character varying(50),
    delivery_window_mon character varying(50),
    delivery_window_tue character varying(50),
    delivery_window_wed character varying(50),
    delivery_window_thu character varying(50),
    delivery_window_fri character varying(50),
    delivery_window_sat character varying(50),
    delivery_window_sun character varying(50),
    notes character varying(2000),
    components text,
    email_receipt_subject character varying(255),
    ops_team_notes character varying(65535),
    geo character varying(3),
    server_url character varying(127),
    subscription_amount numeric(8,2) NOT NULL,
    enable_reporting bigint,
    enable_monitoring bigint,
    employees_num bigint,
    kiosk_restrictions character varying(2000)
);
CREATE TABLE erp_backup.hardware_software (
    kiosk_id bigint NOT NULL,
    gcm_id type.text400,
    app_vname type.text40,
    app_vcode integer,
    features type.text400 NOT NULL,
    components type.text2k,
    server_url type.text400,
    peekaboo_url type.text400,
    email_receipt_subject type.text200
);
CREATE TABLE inm_restore_0625.diff_kiosk_control (
    kiosk_id integer,
    start_level numeric(4,2),
    min_level numeric(4,2),
    scale numeric(4,2),
    manual_multiplier numeric(4,2),
    count bigint
);
CREATE TABLE inm_test.temp_b (
    id integer NOT NULL,
    name text
);
CREATE TABLE pantry.awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);
CREATE TABLE erp_backup.kiosk_note (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    note_type integer NOT NULL,
    content type.text10k NOT NULL,
    start_ts timestamp with time zone,
    end_ts timestamp with time zone
);
CREATE TABLE erp_test.kiosk_accounting (
    kiosk_id bigint NOT NULL,
    start_date date,
    payment_start date,
    payment_stop date,
    sales_tax type.zero_or_one NOT NULL,
    default_fee_plan integer NOT NULL,
    byte_discount type.text40,
    subsidy_info type.text40,
    max_subscription type.text40,
    subscription_amount type.money_max_1m NOT NULL,
    setup_fee type.money_max_1m,
    subsidy_notes type.text400
);
CREATE TABLE inm_restore_0625.diff_kiosk_restriction_by_property (
    kiosk_id integer,
    property_id integer,
    count bigint
);
CREATE TABLE inm_restore_0625.sku_group_control_gs (
    sku_group_id integer,
    default_level numeric(4,2),
    scale numeric(4,2),
    min_qty smallint,
    max_qty smallint
);
CREATE TABLE dw.fact_daily_byte_foods_summary (
    date_id integer NOT NULL,
    active_byte_customers integer,
    active_skus integer,
    active_brands integer,
    active_cards integer,
    active_usernames integer,
    active_emails integer,
    orders integer,
    orders_w_email integer,
    inventory_units integer,
    inventory_amt_list numeric(12,2),
    inventory_kiosks integer,
    avg_inventory_dollar numeric(12,2),
    avg_inventory_units integer,
    fridge_uptime numeric(3,2),
    major_fridge_outages integer
);
CREATE TABLE fnrenames.awsdms_validation_failures_v1 (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "FAILURE_TIME" timestamp without time zone NOT NULL,
    "KEY_TYPE" character varying(128) NOT NULL,
    "KEY" character varying(8000) NOT NULL,
    "FAILURE_TYPE" character varying(128) NOT NULL,
    "DETAILS" character varying(8000) NOT NULL
);
CREATE TABLE inm_restore_0625.diff_kiosk_sku_group_manual_scale (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2),
    count bigint
);
CREATE TABLE erp.client_campus (
    client_id integer NOT NULL,
    campus_id integer NOT NULL
);
CREATE TABLE erp.sku_group (
    id integer NOT NULL,
    fc_title type.text_name NOT NULL,
    unit_size numeric(4,2) NOT NULL
);
CREATE TABLE erp_test.kiosk_contact (
    contact_id integer NOT NULL,
    kiosk_id integer NOT NULL
);
CREATE TABLE erp.product_category (
    product_id bigint NOT NULL,
    category_id integer NOT NULL
);
CREATE TABLE erp.client_contact (
    contact_id integer NOT NULL,
    client_id integer NOT NULL
);
CREATE TABLE erp_backup.kiosk (
    id bigint NOT NULL,
    campus_id integer NOT NULL,
    serial type.text100 NOT NULL,
    client_id integer NOT NULL,
    title type.text_name,
    name type.text_name NOT NULL,
    geo type.text_name,
    address_id integer,
    publicly_accessible type.zero_or_one,
    location_type integer,
    estd_num_users integer,
    enable_reporting smallint,
    creation_time bigint,
    deployment_time bigint,
    deployment_status_id integer,
    bank type.zero_or_one,
    archived type.zero_or_one
);
CREATE TABLE erp_test.client_campus (
    client_id integer NOT NULL,
    campus_id integer NOT NULL
);
CREATE TABLE erp_backup.kiosk_accounting (
    kiosk_id bigint NOT NULL,
    start_date date,
    payment_start date,
    payment_stop date,
    sales_tax type.zero_or_one NOT NULL,
    default_fee_plan integer NOT NULL,
    byte_discount type.text40,
    subsidy_info type.text40,
    max_subscription type.text40,
    subscription_amount type.money_max_1m NOT NULL,
    setup_fee type.money_max_1m,
    subsidy_notes type.text400
);
CREATE TABLE erp.product_category_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text100 NOT NULL
);
CREATE TABLE inm_restore_0625.product_property_gs (
    product_id bigint,
    property_id integer
);
CREATE TABLE dw.fact_monthly_kiosk_summary (
    campus_id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    date_id integer NOT NULL,
    sales_list_price numeric(12,2),
    sales_after_discount numeric(12,2),
    food_cost numeric(12,2),
    credit_card numeric(12,2),
    freedom_pay numeric(12,2),
    complimentary numeric(12,2),
    monthly_lease numeric(12,2),
    payment_processing_fee numeric(12,2),
    connectivity_fee numeric(12,2),
    sales_tax numeric(12,2),
    tag_fee numeric(12,2),
    losses_amt numeric(12,2),
    manual_adjustment numeric(12,2),
    fee_plan_name text,
    prepaid_number_of_months bigint,
    prepaid_until character varying(20),
    licensing_subscription_fee numeric(12,2),
    tag_price numeric(12,2),
    payment_processing_rate character varying(20),
    details text
);
CREATE TABLE erp_backup.client (
    id integer NOT NULL,
    name type.text_name,
    address_id integer,
    employees_num integer,
    industry integer
);
CREATE TABLE pantry.temp_product (
    id bigint NOT NULL,
    title character varying(127) NOT NULL,
    description character varying(4095),
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2) NOT NULL,
    cost numeric(5,2) NOT NULL,
    shelf_time integer NOT NULL,
    campus_id bigint NOT NULL,
    image smallint NOT NULL,
    image_time bigint,
    last_update bigint NOT NULL,
    archived bigint,
    taxable smallint,
    allergens character varying(255),
    attribute_names character varying(511),
    categories character varying(255),
    category_names character varying(511),
    vendor character varying(135),
    source character varying(135),
    notes character varying(2000),
    total_cal bigint,
    num_servings real,
    ingredients character varying(2000),
    calories real,
    proteins real,
    sugar real,
    carbohydrates real,
    fat real,
    consumer_category character varying(2000),
    ws_case_size bigint,
    kiosk_ship_qty bigint,
    ws_case_cost numeric(5,2),
    pick_station bigint,
    fc_title character varying(255),
    pricing_tier character varying(255),
    width_space real,
    height_space real,
    depth_space real,
    slotted_width real,
    tag_volume bigint,
    delivery_option character varying(255),
    tag_applied_by character varying(255)
);
CREATE TABLE erp.product_property (
    product_id bigint NOT NULL,
    property_id integer NOT NULL
);
CREATE TABLE migration.reverse_product (
    id bigint NOT NULL,
    title character varying(127) NOT NULL,
    description character varying(4095),
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2) NOT NULL,
    cost numeric(5,2) NOT NULL,
    shelf_time integer NOT NULL,
    campus_id bigint NOT NULL,
    image smallint NOT NULL,
    image_time bigint,
    last_update bigint NOT NULL,
    archived bigint,
    taxable smallint,
    allergens character varying(255),
    attribute_names character varying(511),
    categories character varying(255),
    category_names character varying(511),
    vendor character varying(135),
    source character varying(135),
    notes character varying(2000),
    total_cal bigint,
    num_servings real,
    ingredients character varying(2000),
    calories real,
    proteins real,
    sugar real,
    carbohydrates real,
    fat real,
    consumer_category character varying(2000),
    ws_case_size bigint,
    kiosk_ship_qty bigint,
    ws_case_cost numeric(5,2),
    pick_station bigint,
    fc_title character varying(255),
    pricing_tier character varying(255),
    width_space real,
    height_space real,
    depth_space real,
    slotted_width real,
    tag_volume bigint,
    delivery_option character varying(255),
    tag_applied_by character varying(255)
);
CREATE TABLE erp.address (
    id integer NOT NULL,
    client_id integer,
    address1 type.text200,
    address2 type.text200,
    city type.text40,
    state type.text40,
    zip type.text40,
    location_x numeric(9,6) NOT NULL,
    location_y numeric(9,6) NOT NULL,
    timezone type.text40
);
CREATE TABLE erp.client (
    id integer NOT NULL,
    name type.text_name,
    address_id integer,
    employees_num integer,
    industry integer
);
CREATE TABLE dw.dim_kiosk (
    id bigint NOT NULL,
    campus_id integer NOT NULL,
    client_name character varying(765),
    title text,
    geo text,
    location_type integer,
    enable_reporting smallint,
    archived smallint
);
CREATE TABLE erp.tag_order (
    id integer NOT NULL,
    tag_type_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer NOT NULL,
    custom_product_name type.text1k,
    microwave_warning boolean,
    status type.text200 NOT NULL,
    delivery_option type.text200 NOT NULL,
    tracking type.text200,
    order_ts timestamp with time zone NOT NULL,
    process_ts timestamp with time zone,
    ship_ts timestamp with time zone
);
CREATE TABLE erp.awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);
CREATE TABLE erp_test.product_handling (
    product_id bigint NOT NULL,
    width_space real,
    height_space real,
    depth_space real,
    slotted_width real,
    kiosk_ship_qty smallint,
    ws_case_size smallint,
    preparation_instruction type.text4k,
    include_microwave_warning type.zero_or_one DEFAULT 0,
    rfid_tag_type integer,
    tag_volume integer,
    tag_delivery_option type.tag_delivery_option,
    tag_applied_by type.tag_applied_by,
    pick_station smallint
);
CREATE TABLE erp_test.kiosk_note (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    note_type integer NOT NULL,
    content type.text10k NOT NULL,
    start_ts timestamp with time zone,
    end_ts timestamp with time zone
);
CREATE TABLE public.bak_awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);
CREATE TABLE erp.kiosk_note (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    note_type integer NOT NULL,
    content type.text10k NOT NULL,
    start_ts timestamp with time zone,
    end_ts timestamp with time zone
);
CREATE TABLE erp.tag_type (
    id integer NOT NULL,
    type type.text100 NOT NULL,
    description type.text400,
    char_limit smallint NOT NULL,
    dimensions box NOT NULL,
    active boolean DEFAULT true NOT NULL,
    show_micro_warning boolean DEFAULT true NOT NULL,
    print_template type.text400
);
CREATE TABLE inm.product_pick_order (
    product_id integer NOT NULL,
    pick_order smallint DEFAULT 0 NOT NULL
);
CREATE TABLE inm_test.bkup_kiosk_product_disabled (
    kiosk_id bigint,
    product_id integer
);
CREATE TABLE inm.kiosk_restriction_by_product_ed (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL,
    end_date date,
    comment type.text400,
    record_ts timestamp with time zone
);
CREATE TABLE erp.product_handling (
    product_id bigint NOT NULL,
    width_space real,
    height_space real,
    depth_space real,
    slotted_width real,
    kiosk_ship_qty smallint,
    ws_case_size smallint,
    preparation_instruction type.text4k,
    include_microwave_warning type.zero_or_one DEFAULT 0,
    rfid_tag_type integer,
    tag_volume integer,
    tag_delivery_option type.tag_delivery_option,
    tag_applied_by type.tag_applied_by,
    pick_station smallint
);
CREATE TABLE test.pick_priority_kiosk (
    kiosk_id integer,
    priority integer,
    start_date date,
    end_date date,
    comment text
);
CREATE TABLE erp_test.kiosk_audit (
    a text,
    b text,
    kid integer NOT NULL,
    status text,
    e text,
    enable_reporting character(1),
    enable_monitoring character(1)
);
CREATE TABLE inm_test.bkup_kiosk_restriction_by_product (
    kiosk_id bigint,
    product_id integer,
    end_date date,
    comment type.text400,
    record_ts timestamp with time zone
);
CREATE TABLE test.kiosk_20190528 (
    id bigint,
    campus_id bigint,
    serial character varying(45),
    title character varying(46),
    address character varying(127),
    location_x numeric(9,6),
    location_y numeric(9,6),
    gcm_id character varying(255),
    app_vname character varying(63),
    app_vcode integer,
    archived bigint,
    creation_time bigint,
    deployment_time bigint,
    last_update bigint,
    client_name character varying(255),
    last_status bigint,
    last_inventory bigint,
    kiosk_name character varying(255),
    payment_start bigint,
    payment_stop bigint,
    features character varying(255),
    sales_tax smallint,
    default_fee_plan bigint,
    timezone character varying(50),
    estd_num_users bigint,
    tags character varying(255),
    publicly_accessible bigint,
    cardkey_required bigint,
    delivery_insns character varying(65535),
    fridge_loc_info character varying(65535),
    contact_first_name character varying(65535),
    contact_last_name character varying(65535),
    contact_email character varying(65535),
    contact_phone character varying(65535),
    accounting_email character varying(65535),
    byte_discount character varying(255),
    subsidy_info character varying(50),
    subsidy_notes character varying(65535),
    max_subscription character varying(50),
    delivery_window_mon character varying(50),
    delivery_window_tue character varying(50),
    delivery_window_wed character varying(50),
    delivery_window_thu character varying(50),
    delivery_window_fri character varying(50),
    delivery_window_sat character varying(50),
    delivery_window_sun character varying(50),
    notes character varying(2000),
    components text,
    email_receipt_subject character varying(255),
    ops_team_notes character varying(65535),
    geo character varying(3),
    server_url character varying(127),
    subscription_amount numeric(8,2),
    enable_reporting bigint,
    enable_monitoring bigint,
    employees_num bigint,
    kiosk_restrictions character varying(2000)
);
CREATE TABLE test.remittance_history (
    period text NOT NULL,
    version text NOT NULL,
    campus_title character varying,
    campus_id bigint NOT NULL,
    name character varying,
    email character varying,
    number_of_kiosks bigint,
    client_type text,
    sales_list_price numeric,
    sales_after_discount numeric,
    complimentary numeric,
    freedom_pay numeric,
    credit_card numeric,
    monthly_lease numeric,
    connectivity_fee numeric,
    payment_processing_fee numeric,
    tag_fee numeric,
    tags_got integer,
    tag_price numeric,
    net_remittance numeric,
    net_total numeric,
    manual_adjustment numeric,
    fees_before_tags numeric,
    details text
);
CREATE TABLE erp.hardware_software (
    kiosk_id bigint NOT NULL,
    gcm_id type.text400,
    app_vname type.text40,
    app_vcode integer,
    features type.text400 NOT NULL,
    components type.text2k,
    server_url type.text400,
    peekaboo_url type.text400,
    email_receipt_subject type.text200
);
CREATE TABLE inm_restore_0625.kiosk_control_gs (
    kiosk_id integer,
    start_level numeric(4,2),
    min_level numeric(4,2),
    scale numeric(4,2),
    manual_multiplier numeric(4,2)
);
CREATE TABLE erp.product_property_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text100
);
CREATE TABLE erp_test.product_sourcing (
    product_id bigint NOT NULL,
    vendor type.text400,
    source type.text400
);
CREATE TABLE erp.kiosk (
    id bigint NOT NULL,
    campus_id integer NOT NULL,
    serial type.text100 NOT NULL,
    client_id integer NOT NULL,
    title type.text_name,
    name type.text_name NOT NULL,
    geo type.text_name,
    address_id integer,
    publicly_accessible type.zero_or_one,
    location_type integer,
    estd_num_users integer,
    enable_reporting smallint,
    creation_time bigint,
    deployment_time bigint,
    deployment_status_id integer,
    bank type.zero_or_one,
    archived type.zero_or_one
);
CREATE TABLE inm_test.even_id (
    id integer DEFAULT nextval('inm_test.even_id_id_seq'::regclass) NOT NULL,
    ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    comment text
);
CREATE TABLE inm_test."order" (
    order_id character varying(45) NOT NULL,
    first_name character varying(45),
    last_name character varying(45),
    kiosk_id bigint NOT NULL,
    kiosk_title character varying(46),
    email character varying(127) NOT NULL,
    amount_paid numeric(6,2),
    payment_system character varying(45) NOT NULL,
    transaction_id character varying(45) NOT NULL,
    approval_code character varying(45) NOT NULL,
    status_code character varying(45),
    status_message character varying(45),
    status character varying(45),
    batch_id character varying(15),
    created bigint,
    auth_amount character varying(7),
    data_token character varying(2047),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(88) NOT NULL,
    state character varying(15) NOT NULL,
    archived bigint,
    stamp bigint NOT NULL,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(4),
    coupon_id bigint,
    coupon character varying(45),
    refund numeric(6,2) NOT NULL,
    receipt bigint NOT NULL,
    campus_id bigint NOT NULL,
    amount_list_price numeric(6,2),
    notes text,
    time_door_opened bigint,
    time_door_closed bigint
);
CREATE TABLE erp.client_industry (
    client_name type.text400 NOT NULL,
    industry type.text40 NOT NULL
);
CREATE TABLE erp.product_property_tag (
    property_id integer NOT NULL,
    tag_id integer NOT NULL,
    tag type.text_name NOT NULL
);
CREATE TABLE dw.fact_monthly_byte_foods_summary (
    year_month integer NOT NULL,
    active_byte_customers integer,
    active_skus integer,
    active_brands integer,
    active_cards integer,
    active_usernames integer,
    active_emails integer,
    orders integer,
    orders_w_email integer
);
CREATE TABLE erp.kiosk_accounting (
    kiosk_id bigint NOT NULL,
    start_date date,
    payment_start date,
    payment_stop date,
    sales_tax type.zero_or_one NOT NULL,
    default_fee_plan integer NOT NULL,
    byte_discount type.text40,
    subsidy_info type.text40,
    max_subscription type.text40,
    subscription_amount type.money_max_1m NOT NULL,
    setup_fee type.money_max_1m,
    subsidy_notes type.text400
);
CREATE TABLE erp.kiosk_restriction_by_property (
    kiosk_id bigint NOT NULL,
    property_id integer NOT NULL
);
CREATE TABLE erp.product_sourcing (
    product_id bigint NOT NULL,
    vendor type.text400,
    source type.text400
);
CREATE TABLE erp_test.hardware_software (
    kiosk_id bigint NOT NULL,
    gcm_id type.text400,
    app_vname type.text40,
    app_vcode integer,
    features type.text400 NOT NULL,
    components type.text2k,
    server_url type.text400,
    peekaboo_url type.text400,
    email_receipt_subject type.text200
);
ALTER TABLE erp.v_campus_list OWNER TO lambdazen;
ALTER TABLE erp.fcm_repeater OWNER TO erpuser;
ALTER TABLE erp.kiosk_restriction_by_product OWNER TO erpuser;
ALTER TABLE fnrenames.v_warehouse_ordering_rec OWNER TO erpuser;
ALTER TABLE inm.v_warehouse_order_delivered_totals OWNER TO erpuser;
ALTER TABLE campus_87."order" OWNER TO erpuser;
ALTER TABLE erp_test.kiosk_status OWNER TO erpuser;
ALTER TABLE erp_test.product_asset OWNER TO erpuser;
ALTER TABLE inm_restore_0625.kiosk_control_gs OWNER TO erpuser;
ALTER TABLE erp_backup.product_property_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.product_property_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);
ALTER TABLE inm_test.bkup_kiosk_product_disabled_20190408 OWNER TO erpuser;
ALTER TABLE inm_test.temp_b OWNER TO erpuser;
ALTER TABLE pantry.temp_product OWNER TO erpuser;
ALTER TABLE erp_test.client_campus OWNER TO erpuser;
ALTER TABLE erp_test.contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE inm_test.kiosk_sku_group_manual_scale_20190624 OWNER TO erpuser;
ALTER TABLE inm_test.odd_id ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME inm_test.odd_id_id_seq
    START WITH 1
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE campus_87.pick_preference_kiosk_sku OWNER TO erpuser;
ALTER TABLE inm.product_pick_order_temp OWNER TO erpuser;
ALTER TABLE inm_restore_0625.diff_kiosk_control OWNER TO erpuser;
ALTER TABLE inm_test.even_id OWNER TO erpuser;
ALTER TABLE test.sync_qa_kiosk_erp OWNER TO erpuser;
ALTER TABLE erp.product_property_tag OWNER TO erpuser;
ALTER TABLE erp_backup.client ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);
ALTER TABLE inm_test.test_sequence ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME inm_test.test_sequence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE mixalot.history_order_pipeline_id_seq OWNER TO erpuser;
ALTER TABLE campus_87.pick_demand OWNER TO erpuser;
ALTER TABLE campus_87.sku_group_control OWNER TO erpuser;
ALTER TABLE campus_87.pick_rejection OWNER TO erpuser;
ALTER TABLE campus_87.pick_list OWNER TO erpuser;
ALTER TABLE erp.v_product OWNER TO lambdazen;
ALTER TABLE inm_test.bkup_kiosk_restriction_by_product OWNER TO erpuser;
ALTER TABLE pantry.awsdms_apply_exceptions OWNER TO erpuser;
ALTER TABLE erp.tag_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.tag_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.client_industry OWNER TO erpuser;
ALTER TABLE migration.kiosk_dest_to_match OWNER TO erpuser;
ALTER TABLE migration.v_product OWNER TO erpuser;
ALTER TABLE test.pick_priority_kiosk OWNER TO erpuser;
ALTER TABLE campus_87.pick_route OWNER TO erpuser;
ALTER TABLE erp_test.product_handling OWNER TO erpuser;
ALTER TABLE campus_87.route_stop OWNER TO erpuser;
ALTER TABLE erp.kiosk_status OWNER TO erpuser;
ALTER TABLE erp.sku_group OWNER TO erpuser;
ALTER TABLE campus_87.kiosk OWNER TO erpuser;
ALTER TABLE campus_87.product_property OWNER TO erpuser;
ALTER TABLE dw.dim_kiosk OWNER TO muriel;
ALTER TABLE erp_backup.kiosk_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.kiosk_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);
ALTER TABLE test.remittance_history OWNER TO erpuser;
ALTER TABLE campus_87.kiosk_control OWNER TO erpuser;
ALTER TABLE erp.client ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.client_contact OWNER TO erpuser;
ALTER TABLE erp.product OWNER TO erpuser;
ALTER TABLE erp.product_nutrition OWNER TO erpuser;
ALTER TABLE erp.tag_price OWNER TO erpuser;
ALTER TABLE erp_test.client ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE dw.fact_monthly_byte_foods_summary OWNER TO erpuser;
ALTER TABLE public.history_order_pipeline OWNER TO erpuser;
ALTER TABLE erp.kiosk_attribute OWNER TO erpuser;
ALTER TABLE erp_backup.contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);
ALTER TABLE inm_test.temp_a OWNER TO erpuser;
ALTER TABLE migration.kiosk OWNER TO erpuser;
ALTER TABLE dw.last_15_months OWNER TO muriel;
ALTER TABLE dw.fact_daily_byte_foods_summary OWNER TO erpuser;
ALTER TABLE erp_backup.address ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);
ALTER TABLE erp_test.product_nutrition OWNER TO erpuser;
ALTER TABLE inm_test.even_id_seq OWNER TO erpuser;
ALTER TABLE dw.fact_daily_kiosk_sku_summary OWNER TO muriel;
ALTER TABLE inm_test.label OWNER TO erpuser;
ALTER TABLE inm_restore_0625.kiosk_restriction_by_property_gs OWNER TO erpuser;
ALTER TABLE erp.product_classic_view OWNER TO erpuser;
ALTER TABLE erp_test.sku_group OWNER TO erpuser;
ALTER TABLE erp_backup.product_property OWNER TO erpuser;
ALTER TABLE inm_restore_0625.sku_group_control_gs OWNER TO erpuser;
ALTER TABLE migration.product OWNER TO erpuser;
ALTER TABLE erp.fcm_repeater_id_seq OWNER TO erpuser;
ALTER TABLE erp_test.kiosk_contact OWNER TO erpuser;
ALTER TABLE inm_test.route_stop_20190616 OWNER TO erpuser;
ALTER TABLE campus_87.fact_daily_kiosk_sku_summary OWNER TO erpuser;
ALTER TABLE inm_restore_0625.kiosk_control OWNER TO erpuser;
ALTER TABLE dw.fact_monthly_kiosk_summary OWNER TO erpuser;
ALTER TABLE erp.address ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.v_tag_order_list OWNER TO lambdazen;
ALTER TABLE campus_87.label OWNER TO erpuser;
ALTER TABLE erp_test.client_industry OWNER TO erpuser;
ALTER TABLE erp.awsdms_apply_exceptions OWNER TO erpuser;
ALTER TABLE erp.tag_order_stats OWNER TO erpuser;
ALTER TABLE inm_restore_0625.kiosk_restriction_by_property OWNER TO erpuser;
ALTER TABLE dw.dim_date OWNER TO muriel;
ALTER TABLE dw.last_30_days OWNER TO muriel;
ALTER TABLE inm_restore_0625.sku_group_control OWNER TO erpuser;
ALTER TABLE migration.sync_qa_product_source OWNER TO erpuser;
ALTER TABLE campus_87.kiosk_restriction_by_product_ed OWNER TO erpuser;
ALTER TABLE erp.kiosk_delivery_window OWNER TO erpuser;
ALTER TABLE erp.product_property OWNER TO erpuser;
ALTER TABLE erp_backup.product_classic_view OWNER TO erpuser;
ALTER TABLE migration.reverse_product OWNER TO erpuser;
ALTER TABLE campus_87.product OWNER TO erpuser;
ALTER TABLE erp.v_client_list OWNER TO lambdazen;
ALTER TABLE erp.v_kiosk_inventory OWNER TO lambdazen;
ALTER TABLE dw.last_15_weeks OWNER TO muriel;
ALTER TABLE erp_test.global_attribute_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.global_attribute_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);
ALTER TABLE inm.warehouse_order_history OWNER TO erpuser;
ALTER TABLE erp.product_handling OWNER TO erpuser;
ALTER TABLE fnrenames.awsdms_apply_exceptions OWNER TO erpuser;
ALTER TABLE inm.product_picking_order OWNER TO erpuser;
ALTER TABLE migration.sync_qa_product_dest OWNER TO erpuser;
ALTER TABLE campus_87.campus OWNER TO erpuser;
ALTER TABLE campus_87.product_property_def OWNER TO erpuser;
ALTER TABLE erp_test.hardware_software OWNER TO erpuser;
ALTER TABLE test.sync_qa_kiosk_before_2way OWNER TO erpuser;
ALTER TABLE campus_87.pick_allocation OWNER TO erpuser;
ALTER TABLE erp_test.kiosk OWNER TO erpuser;
ALTER TABLE test.kiosk_log OWNER TO erpuser;
ALTER TABLE campus_87.dim_date OWNER TO erpuser;
ALTER TABLE erp.classic_product_allergen_tag OWNER TO erpuser;
ALTER TABLE erp.v_transaction_list OWNER TO lambdazen;
ALTER TABLE erp_backup.kiosk_accounting OWNER TO erpuser;
ALTER TABLE inm_test.test2 OWNER TO erpuser;
ALTER TABLE dw.dim_product OWNER TO muriel;
ALTER TABLE erp_backup.hardware_software OWNER TO erpuser;
ALTER TABLE mixalot.inm_kiosk_projected_stock OWNER TO erpuser;
ALTER TABLE erp.kiosk_contact OWNER TO erpuser;
ALTER TABLE erp_backup.kiosk OWNER TO erpuser;
ALTER TABLE erp_test.kiosk_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.kiosk_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);
ALTER TABLE mixalot.sku_property_def_id_seq OWNER TO erpuser;
ALTER TABLE test.fact_daily_kiosk_sku_summary OWNER TO erpuser;
ALTER TABLE campus_87.warehouse_inventory OWNER TO erpuser;
ALTER TABLE test.sync_qa_kiosk_iotmaster OWNER TO erpuser;
ALTER TABLE campus_87.kiosk_sku_group_manual_scale OWNER TO erpuser;
ALTER TABLE campus_87.sku_group_attribute OWNER TO erpuser;
ALTER TABLE erp_test.client_contact OWNER TO erpuser;
ALTER TABLE inm_test.bkup_kiosk_product_disabled OWNER TO erpuser;
ALTER TABLE erp.kiosk_restriction_by_property OWNER TO erpuser;
ALTER TABLE inm_restore_0625.kiosk_sku_group_manual_scale_gs OWNER TO erpuser;
ALTER TABLE erp.product_sourcing OWNER TO erpuser;
ALTER TABLE erp.v_kiosk_options OWNER TO lambdazen;
ALTER TABLE pantry.temp_kiosk OWNER TO erpuser;
ALTER TABLE dw.current_inventory OWNER TO erpuser;
ALTER TABLE campus_87.warehouse_order_history OWNER TO erpuser;
ALTER TABLE erp_test.product_property OWNER TO erpuser;
ALTER TABLE fnrenames.awsdms_validation_failures_v1 OWNER TO erpuser;
ALTER TABLE erp.product_pricing OWNER TO erpuser;
ALTER TABLE erp.v_product_list OWNER TO lambdazen;
ALTER TABLE erp_test.product_pricing OWNER TO erpuser;
ALTER TABLE test.fact_monthly_kiosk_summary OWNER TO erpuser;
ALTER TABLE inm.kiosk_restriction_by_product_ed OWNER TO erpuser;
ALTER TABLE dw.non_byte_current_inventory OWNER TO erpuser;
ALTER TABLE erp.classic_product_category_tag OWNER TO erpuser;
ALTER TABLE erp_test.kiosk_classic_view OWNER TO erpuser;
ALTER TABLE inm_test.kiosk_classic_view OWNER TO erpuser;
ALTER TABLE campus_87.pick_inventory OWNER TO erpuser;
ALTER TABLE migration.temp_product OWNER TO erpuser;
ALTER TABLE erp_test.kiosk_audit OWNER TO erpuser;
ALTER TABLE erp.kiosk_access_card ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.kiosk_access_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.product_property_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.product_property_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.tag_order ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.tag_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE dw.byte_current_inventory OWNER TO erpuser;
ALTER TABLE inm_restore_0625.diff_kiosk_restriction_by_property OWNER TO erpuser;
ALTER TABLE inm_restore_0625.product_property_gs OWNER TO erpuser;
ALTER TABLE erp.client_campus OWNER TO erpuser;
ALTER TABLE erp.kiosk_accounting OWNER TO erpuser;
ALTER TABLE public.bak_awsdms_validation_failures_v1 OWNER TO erpuser;
ALTER TABLE public.product_fact OWNER TO erpuser;
ALTER TABLE campus_87.byte_feedback_monthly OWNER TO erpuser;
ALTER TABLE dw.dim_campus OWNER TO muriel;
ALTER TABLE erp.contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.kiosk_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.kiosk_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.kiosk_classic_view OWNER TO erpuser;
ALTER TABLE campus_87.kiosk_restriction_by_property OWNER TO erpuser;
ALTER TABLE public.product_fact_id_seq OWNER TO erpuser;
ALTER TABLE inm.route_stop OWNER TO erpuser;
ALTER TABLE erp.v_kiosk_list OWNER TO lambdazen;
ALTER TABLE inm_test."order" OWNER TO erpuser;
ALTER TABLE inm_test.even_id_id_seq OWNER TO erpuser;
ALTER TABLE erp.kiosk OWNER TO erpuser;
ALTER TABLE erp.v_warehouse_inventory OWNER TO lambdazen;
ALTER TABLE dw.export_inventory_lots OWNER TO erpuser;
ALTER TABLE erp.product_asset OWNER TO erpuser;
ALTER TABLE erp.v_kiosk_heartbeat OWNER TO lambdazen;
ALTER TABLE campus_87.pick_priority_sku OWNER TO erpuser;
ALTER TABLE inm_test.temp_test OWNER TO erpuser;
ALTER TABLE public.history_order_pipeline_id_seq OWNER TO erpuser;
ALTER TABLE erp.product_category_tag OWNER TO erpuser;
ALTER TABLE erp.v_kiosk OWNER TO lambdazen;
ALTER TABLE public.bak_awsdms_apply_exceptions OWNER TO erpuser;
ALTER TABLE campus_87.pick_priority_kiosk OWNER TO erpuser;
ALTER TABLE campus_87.kiosk_restriction_by_product OWNER TO erpuser;
ALTER TABLE erp.global_attribute_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.global_attribute_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.hardware_software OWNER TO erpuser;
ALTER TABLE erp_test.product_sourcing OWNER TO erpuser;
ALTER TABLE inm_restore_0625.kiosk_sku_group_manual_scale OWNER TO erpuser;
ALTER TABLE test.kiosk_20190528 OWNER TO erpuser;
ALTER TABLE dw.last_30_days_kpis OWNER TO muriel;
ALTER TABLE erp.product_category OWNER TO erpuser;
ALTER TABLE erp.v_product_options OWNER TO lambdazen;
ALTER TABLE inm_restore_0625.product_property OWNER TO erpuser;
ALTER TABLE test.fact_daily_campus_87 OWNER TO erpuser;
ALTER TABLE dw.monthly_kpis OWNER TO muriel;
ALTER TABLE erp.v_client OWNER TO lambdazen;
ALTER TABLE erp.v_sku_group_list OWNER TO lambdazen;
ALTER TABLE erp_test.kiosk_accounting OWNER TO erpuser;
ALTER TABLE erp_test.product OWNER TO erpuser;
ALTER TABLE erp.product_category_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.product_category_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE erp.v_transaction_detail OWNER TO lambdazen;
ALTER TABLE erp.v_warehouse_inventory_entry OWNER TO lambdazen;
ALTER TABLE erp_test.address ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE inm.product_pick_order OWNER TO erpuser;
ALTER TABLE inm_restore_0625.diff_kiosk_sku_group_manual_scale OWNER TO erpuser;
ALTER TABLE migration.kiosk_source_to_match OWNER TO erpuser;
ALTER TABLE inm_test.kiosk_projected_stock OWNER TO erpuser;