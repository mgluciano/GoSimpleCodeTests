
CREATE TABLE rptg.temp_yann_boardq3 (
    year double precision,
    month double precision,
    month_year text,
    product_id bigint,
    title character varying(381),
    sku_group character varying(765),
    consumer_category character varying(6000),
    "?column?" text,
    kiosk_w_sales bigint,
    units_sold_per_kiosk double precision,
    kiosk_week_sales_fix double precision,
    price numeric(5,2),
    cost numeric(5,2),
    unit_margin double precision,
    count_sales bigint,
    sales_list_price numeric,
    ttl_cost double precision,
    units_unsold double precision,
    cost_unsold double precision,
    units_lost bigint,
    cost_lost numeric,
    lost_percent double precision,
    rfid_cost double precision
);
CREATE TABLE inm_test.kiosk_20190508 (
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
CREATE TABLE inm_test.product_20190508 (
    id bigint,
    title character varying(127),
    description character varying(4095),
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2),
    cost numeric(5,2),
    shelf_time integer,
    campus_id bigint,
    image smallint,
    image_time bigint,
    last_update bigint,
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
CREATE TABLE mixalot.merchandising_slot (
    id integer NOT NULL,
    title character varying(512) NOT NULL
);
CREATE TABLE pantry.history_kiosk_service_version (
    id integer NOT NULL,
    time_modified timestamp with time zone,
    kiosk_id integer,
    service character varying(150),
    version character varying(100),
    action character varying(100)
);
CREATE TABLE pantry.restock_item (
    id integer NOT NULL,
    order_id character varying(36),
    epc character varying(72),
    created integer,
    kiosk_id integer,
    product_id integer
);
CREATE TABLE public.awsdms_heartbeat (
    hb_key integer NOT NULL,
    hb_created_at timestamp without time zone,
    hb_created_by character varying(64),
    hb_last_heartbeat_at timestamp without time zone,
    hb_last_heartbeat_by character varying(64)
);
CREATE TABLE develop.unused_user_mapping (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);
CREATE TABLE fnrenames.temp_sync_order_2018_12_13 (
    order_id character varying(135),
    first_name character varying(135),
    last_name character varying(135),
    kiosk_id bigint,
    kiosk_title character varying(138),
    email character varying(381),
    amount_paid numeric(6,2),
    payment_system character varying(135),
    transaction_id character varying(135),
    approval_code character varying(135),
    status_code character varying(135),
    status_message character varying(135),
    status character varying(135),
    batch_id character varying(45),
    created bigint,
    auth_amount character varying(21),
    data_token character varying(6141),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(264),
    state character varying(45),
    archived bigint,
    stamp bigint,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(12),
    coupon_id bigint,
    coupon character varying(135),
    refund numeric(6,2),
    receipt bigint,
    campus_id bigint,
    amount_list_price numeric(6,2),
    notes text,
    time_door_opened bigint,
    time_door_closed bigint
);
CREATE TABLE inm_backup.pick_route (
    pick_date date,
    kiosk_id integer,
    route_number character varying(256),
    driver_name character varying(64),
    route_time time(6) without time zone,
    route_date date,
    delivery_order smallint
);
CREATE TABLE test.kiosk_20190605 (
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
CREATE TABLE pantry.dc_inventory (
    product_id bigint NOT NULL,
    product_title character varying(765),
    tesla_inv bigint,
    inventory bigint,
    spoil bigint,
    date date
);
CREATE TABLE inm_test.plan_kiosks (
    kiosk_id integer,
    route_date_time timestamp(6) with time zone,
    driver_name character varying(8000),
    location_name character varying(8000),
    next_delivery_ts timestamp(6) with time zone,
    time_to_next_delivery interval,
    days_to_next_delivery double precision,
    delivery_order bigint
);
CREATE TABLE mixalot.discount_rule (
    id character varying(25) NOT NULL,
    create_d timestamp(6) without time zone NOT NULL,
    update_d timestamp(6) without time zone NOT NULL,
    hash character varying(32) NOT NULL,
    json text NOT NULL,
    repeat_count integer NOT NULL,
    repeat_cycle timestamp(6) without time zone NOT NULL
);
CREATE TABLE mixalot.kiosk_restriction (
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL
);
CREATE TABLE aws_dms.awsdms_status (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    task_status character varying(96),
    status_time timestamp without time zone,
    pending_changes bigint,
    disk_swap_size bigint,
    task_memory bigint,
    source_current_position character varying(384),
    source_current_timestamp timestamp without time zone,
    source_tail_position character varying(384),
    source_tail_timestamp timestamp without time zone,
    source_timestamp_applied timestamp without time zone
);
CREATE TABLE fnrenames.overstock_multiplier (
    setting character varying(100)
);
CREATE TABLE inm_beta.pick_preference_kiosk_sku (
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL,
    preference smallint NOT NULL
);
CREATE TABLE inm_beta.pick_allocation (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL,
    qty integer NOT NULL
);
CREATE TABLE inm_test.broken_product (
    id bigint,
    title character varying(127),
    description character varying(4095),
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2),
    cost numeric(5,2),
    shelf_time integer,
    campus_id bigint,
    image smallint,
    image_time bigint,
    last_update bigint,
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
CREATE TABLE inm_test.kiosk_20190531_test_update (
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
CREATE TABLE inm_test.kiosk_20190810 (
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
CREATE TABLE public.mkt_camp_20170123_whats_new_in_kiosk (
    "Kiosk name" text,
    "Email address" text,
    "Record Type" text,
    "Lifecycle Stage" text,
    "Coupon" text
);
CREATE TABLE inm_backup.pick_preference_kiosk_sku_20190120 (
    kiosk_id integer,
    sku_id integer,
    preference smallint
);
CREATE TABLE pantry.event (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    params character varying(6141) NOT NULL,
    action character varying(45) NOT NULL,
    options character varying(6141) NOT NULL,
    archived bigint NOT NULL
);
CREATE TABLE public.byte_kp_grid2 (
    hour_start timestamp(6) with time zone,
    hour_end timestamp(6) with time zone,
    dowhour double precision,
    kiosk_id integer,
    product_id integer
);
CREATE TABLE beta.temp_sync_label_2018_12_13 (
    id bigint,
    product_id bigint,
    epc character varying(72),
    is_generic_sku smallint,
    kiosk_id bigint,
    order_id character varying(135),
    status character varying(12),
    price numeric(6,2),
    cost numeric(6,2),
    time_created bigint,
    time_added bigint,
    time_updated bigint,
    notes text
);
CREATE TABLE inm.sku_group (
    id integer NOT NULL,
    fc_title inm_beta.text_name NOT NULL,
    unit_size numeric(4,2) NOT NULL
);
CREATE TABLE pantry.current_label_status_365days (
    epc character varying(72) NOT NULL,
    campus_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_title character varying(381) NOT NULL,
    price numeric(5,2) NOT NULL,
    status character varying(12) NOT NULL,
    kiosk_id bigint NOT NULL,
    order_id character varying(150) NOT NULL,
    first_timestamp bigint NOT NULL,
    last_timestamp bigint NOT NULL,
    cost numeric(5,2)
);
CREATE TABLE pantry.permission_mapping (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);
CREATE TABLE test.kiosk_20190612 (
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
CREATE TABLE beta.kiosks (
    id integer NOT NULL
);
CREATE TABLE inm_backup.sku_velocity_20190120 (
    kiosk_id bigint,
    sku_group character varying(765),
    sku bigint,
    name character varying(381),
    sample_size bigint,
    dt_avg numeric,
    dt_std numeric,
    w_departure_time numeric,
    preference numeric
);
CREATE TABLE pantry.tmp_eng_495_cards_to_update (
    card_id bigint NOT NULL,
    c_fn character varying(135),
    c_ln character varying(135)
);
CREATE TABLE public.tmp_dormant2 (
    email character varying(255),
    dayssincepurchase integer,
    kiosk character varying(255),
    couponcode character varying(20),
    couponamount numeric(28,6)
);
CREATE TABLE test.locked_kiosk_by_command (
    lock_ts_string text,
    kiosk_id integer,
    lock_ts timestamp with time zone
);
CREATE TABLE test.request_log_sold_epc (
    id integer NOT NULL,
    epc character varying(24) NOT NULL,
    order_id text,
    kiosk_id bigint,
    direction character varying(16) NOT NULL,
    reason text,
    ts timestamp without time zone NOT NULL
);
CREATE TABLE develop.last_kiosk_status (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    kiosk_temperature numeric(6,3),
    kit_temperature numeric(6,3),
    power integer,
    battery_level smallint,
    rfid_0 integer,
    rfid_1 integer,
    rfid_2 integer,
    rfid_3 bigint NOT NULL,
    "time" bigint,
    modem_signal_percentage smallint,
    modem_signal_type character varying(81),
    ip character varying(135)
);
CREATE TABLE pantry.history_kiosk_attribute (
    id integer NOT NULL,
    time_modified timestamp with time zone,
    kiosk_id integer,
    gad_id integer,
    value character varying(100),
    action character varying(100)
);
CREATE TABLE pantry.tmp_order_may_6_preapr23 (
    order_id character varying(45),
    first_name character varying(45),
    last_name character varying(45),
    kiosk_id bigint,
    kiosk_title character varying(46),
    email character varying(127),
    amount_paid numeric(6,2),
    payment_system character varying(45),
    transaction_id character varying(45),
    approval_code character varying(45),
    status_code character varying(45),
    status_message character varying(45),
    status character varying(45),
    batch_id character varying(15),
    created bigint,
    auth_amount character varying(7),
    data_token character varying(2047),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(88),
    state character varying(15),
    archived bigint,
    stamp bigint,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(4),
    coupon_id bigint,
    coupon character varying(45),
    refund numeric(6,2),
    receipt bigint,
    campus_id bigint,
    amount_list_price numeric(6,2),
    time_door_opened bigint,
    time_door_closed bigint,
    notes text
);
CREATE TABLE public.byte_kp_grid (
    hour_start timestamp(6) with time zone,
    hour_end timestamp(6) with time zone,
    dowhour double precision,
    kiosk_id bigint,
    product_id bigint
);
CREATE TABLE public.kiosk (
    id integer NOT NULL,
    title character varying(8000)
);
CREATE TABLE inm_backup.pick_allocation (
    pick_date date,
    route_date date,
    kiosk_id integer,
    sku_id integer,
    qty integer
);
CREATE TABLE mixalot.temp_sku_group_volume (
    title character varying(512) NOT NULL,
    volume numeric(4,2) NOT NULL,
    minimum smallint
);
CREATE TABLE pantry.history_kiosk_device (
    id integer NOT NULL,
    time_modified timestamp with time zone,
    kiosk_id integer,
    payload jsonb,
    action character varying(100)
);
CREATE TABLE pantry.running_service (
    app_name text NOT NULL,
    started_at timestamp without time zone,
    host text
);
CREATE TABLE public.awsdms_apply_exceptions (
    "TASK_NAME" character varying(384) NOT NULL,
    "TABLE_OWNER" character varying(384) NOT NULL,
    "TABLE_NAME" character varying(384) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);
CREATE TABLE aws_dms.awsdms_history (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    timeslot_type character varying(96) NOT NULL,
    timeslot timestamp without time zone NOT NULL,
    timeslot_duration bigint,
    timeslot_latency bigint,
    timeslot_records bigint,
    timeslot_volume bigint
);
CREATE TABLE develop.card (
    id bigint NOT NULL,
    hash character varying(264) NOT NULL,
    first_name character varying(135),
    last_name character varying(135),
    type character varying(45),
    number character varying(93),
    email character varying(381) NOT NULL
);
CREATE TABLE inm.temp_pick_order (
    kiosk_id integer,
    route_date_time timestamp with time zone,
    sku_group_id integer,
    fc_title text,
    week_qty integer,
    plan_qty integer
);
CREATE TABLE inm_backup.kiosk_control (
    kiosk_id integer NOT NULL,
    start_level numeric(4,2) NOT NULL,
    min_level numeric(4,2) NOT NULL,
    scale numeric(4,2) NOT NULL,
    manual_multiplier numeric(4,2) NOT NULL
);
CREATE TABLE inm_test.inm_kiosk_hourly_sale (
    key text,
    kiosk_id bigint,
    dow integer,
    hod integer,
    units_sold numeric(28,6)
);
CREATE TABLE test.accounting_bkup_20200204_partial (
    id bigint,
    date character varying(45),
    kiosk_id bigint,
    campus_id bigint,
    sales_ipc numeric(6,2),
    sales_fp numeric(6,2),
    sales_cs numeric(6,2),
    sales_cp numeric(6,2),
    tags_got bigint,
    tags_spent bigint,
    timezone smallint,
    sales_tax numeric(4,2),
    sales_tax_ipc numeric(6,2),
    sales_tax_fp numeric(6,2),
    sales_tax_cs numeric(6,2),
    sales_tax_cp numeric(6,2),
    prepaid bigint,
    current_fee bigint,
    next_fee bigint,
    recalculated_fee numeric(6,2),
    prepaid_day bigint,
    next_fee_from character varying(45),
    fee_connectivity numeric(5,2)
);
CREATE TABLE beta.route_stop (
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
CREATE TABLE develop.coupon (
    id bigint NOT NULL,
    code character varying(135) NOT NULL,
    flat_discount numeric(5,2) NOT NULL,
    real_discount numeric(5,2) NOT NULL,
    used smallint NOT NULL,
    kiosk_list character varying(765)
);
CREATE TABLE test.kiosk_20200304 (
    id integer,
    title character varying(8000)
);
CREATE TABLE mixalot.temp_sku_to_skugroup (
    sku integer NOT NULL,
    sku_group character varying(512) NOT NULL
);
CREATE TABLE pantry.tmp_april23_error_order_fixes (
    order_id character varying(45) NOT NULL,
    transaction_id character varying(45),
    amount_paid numeric(6,2)
);
CREATE TABLE pantry.tmp_revert_order_status (
    order_id character varying(45) NOT NULL
);
CREATE TABLE beta.kiosk_sku_group_manual_scale (
    kiosk_id integer NOT NULL,
    fc_title character varying(70) NOT NULL,
    scale numeric(4,2) NOT NULL
);
CREATE TABLE develop.fee_rates (
    id bigint NOT NULL,
    fee_lease numeric(6,2) NOT NULL,
    fee_tags numeric(3,2) NOT NULL,
    fee_ipc numeric(5,4) NOT NULL,
    bi_monthly smallint NOT NULL,
    archived smallint NOT NULL,
    custom smallint NOT NULL,
    prepaid_amount bigint NOT NULL,
    name character varying(384) NOT NULL
);
CREATE TABLE mixalot.sku_def (
    id integer NOT NULL,
    title character varying(512) NOT NULL
);
CREATE TABLE pantry.spoilage (
    id integer NOT NULL,
    epc character varying(72) NOT NULL,
    kiosk_id integer NOT NULL,
    order_id character varying(135),
    time_removed integer,
    time_added integer,
    product_id integer,
    "timestamp" integer
);
CREATE TABLE test.lost_wall_clock_orders (
    order_id text
);
CREATE TABLE beta.temp_product (
    id bigint NOT NULL,
    title character varying(381) NOT NULL,
    description character varying(12285),
    tiny_description character varying(120),
    short_description character varying(300),
    medium_description character varying(1200),
    long_description character varying(3600),
    price numeric(5,2) NOT NULL,
    cost numeric(5,2) NOT NULL,
    shelf_time integer NOT NULL,
    campus_id bigint NOT NULL,
    image smallint NOT NULL,
    image_time bigint,
    last_update bigint NOT NULL,
    archived bigint,
    taxable smallint,
    allergens character varying(765),
    attribute_names character varying(1533),
    categories character varying(765),
    category_names character varying(1533),
    vendor character varying(405),
    source character varying(405),
    notes character varying(6000),
    total_cal bigint,
    num_servings real,
    ingredients character varying(6000),
    calories real,
    proteins real,
    sugar real,
    carbohydrates real,
    fat real,
    consumer_category character varying(6000),
    ws_case_size bigint,
    kiosk_ship_qty bigint,
    ws_case_cost numeric(5,2),
    pick_station bigint,
    fc_title character varying(765),
    pricing_tier character varying(765),
    width_space real,
    height_space real,
    depth_space real,
    slotted_width real,
    tag_volume bigint,
    delivery_option character varying(765),
    tag_applied_by character varying(765)
);
CREATE TABLE develop.accounting (
    id bigint NOT NULL,
    date character varying(135) NOT NULL,
    kiosk_id bigint NOT NULL,
    campus_id bigint NOT NULL,
    sales_ipc numeric(6,2) NOT NULL,
    sales_fp numeric(6,2) NOT NULL,
    sales_cs numeric(6,2) NOT NULL,
    sales_cp numeric(6,2) NOT NULL,
    tags_got bigint NOT NULL,
    tags_spent bigint NOT NULL,
    timezone smallint NOT NULL,
    sales_tax numeric(4,2) NOT NULL,
    sales_tax_ipc numeric(6,2) NOT NULL,
    sales_tax_fp numeric(6,2) NOT NULL,
    sales_tax_cs numeric(6,2) NOT NULL,
    sales_tax_cp numeric(6,2) NOT NULL,
    prepaid bigint NOT NULL,
    current_fee bigint NOT NULL,
    next_fee bigint NOT NULL,
    recalculated_fee numeric(6,2),
    prepaid_day bigint NOT NULL,
    next_fee_from character varying(135),
    fee_connectivity numeric(5,2) NOT NULL
);
CREATE TABLE inm_beta.sku_group_control (
    sku_group_id integer NOT NULL,
    default_level numeric(4,2) DEFAULT '-1'::integer NOT NULL,
    scale numeric(4,2) DEFAULT 1.0 NOT NULL,
    min_qty smallint,
    max_qty smallint
);
CREATE TABLE inm_test.kiosk_software (
    id integer NOT NULL,
    app_vname character varying(63),
    components text
);
CREATE TABLE pantry.transact_comp (
    id bigint NOT NULL,
    order_id character varying(93),
    result character varying(3069),
    "time" bigint
);
CREATE TABLE test.cron_broken (
    id integer,
    "time" character varying(300),
    kiosks character varying(30000),
    command character varying(300),
    payload text,
    trigger_id integer,
    dependencies character varying(300),
    user_id integer,
    raw_task text,
    active integer,
    group_id integer,
    timezone character varying(210),
    archived integer
);
CREATE TABLE develop.permission (
    id integer NOT NULL,
    permission character varying(765),
    api character varying(765),
    "isFrontend" integer NOT NULL
);
CREATE TABLE develop.transact_cs (
    id bigint NOT NULL,
    order_id character varying(93),
    result character varying(3069),
    "time" bigint
);
CREATE TABLE inm_beta.product_property (
    product_id bigint,
    property_id integer
);
CREATE TABLE develop.product_history (
    id integer NOT NULL,
    price numeric(5,2),
    cost numeric(5,2),
    start_time integer,
    end_time integer,
    product_id integer,
    campus_id integer
);
CREATE TABLE fnrenames.tmp_payment_information (
    order_id character varying(20) NOT NULL,
    magne_print character varying(112),
    ksn character varying(20),
    magne_print_status character varying(8),
    track2 character varying(80)
);
CREATE TABLE mixalot.temp_test (
    id integer NOT NULL,
    name character varying(16) NOT NULL,
    total integer NOT NULL
);
CREATE TABLE develop.campus (
    id bigint NOT NULL,
    title character varying(135) NOT NULL,
    timezone character varying(150),
    archived smallint
);
CREATE TABLE develop.cron (
    id integer NOT NULL,
    "time" character varying(300),
    kiosks character varying(1500),
    command character varying(300),
    payload text,
    trigger_id integer,
    dependencies character varying(300),
    user_id integer,
    raw_task text,
    active integer,
    group_id integer,
    timezone character varying(210)
);
CREATE TABLE develop.history_epc_order (
    id bigint NOT NULL,
    epc character varying(72) NOT NULL,
    kiosk_id bigint NOT NULL,
    order_id character varying(135),
    "time" bigint NOT NULL,
    product_id integer
);
CREATE TABLE public.awsdms_status (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    task_status character varying(96),
    status_time timestamp without time zone,
    pending_changes bigint,
    disk_swap_size bigint,
    task_memory bigint,
    source_current_position character varying(384),
    source_current_timestamp timestamp without time zone,
    source_tail_position character varying(384),
    source_tail_timestamp timestamp without time zone,
    source_timestamp_applied timestamp without time zone
);
CREATE TABLE pantry.stockout (
    id integer NOT NULL,
    kiosk_id integer,
    product_id integer,
    order_id character varying(36),
    "timestamp" integer,
    restock_timestamp integer,
    restock_order_id character varying(36)
);
CREATE TABLE pantry.tmp_orderstoerror (
    order_id character varying(45)
);
CREATE TABLE pantry.tmp_price_finalized_order_ids (
    order_id character varying(45) DEFAULT 0 NOT NULL
);
CREATE TABLE pantry.order_meta (
    id integer NOT NULL,
    order_id character varying(45) NOT NULL,
    time_auth bigint,
    time_capture bigint,
    currency character varying DEFAULT 'USD'::character varying,
    num_scans_completed integer DEFAULT 0,
    tablet_processing_done boolean DEFAULT false,
    time_preauth bigint
);
CREATE TABLE pantry.tmp_may4_error_order_fixes (
    order_id character varying(45) NOT NULL,
    transaction_id character varying(45),
    amount_paid numeric(6,2)
);
CREATE TABLE inm.sku_property_def (
    id integer NOT NULL,
    attribute character varying(256),
    title character varying(512) NOT NULL
);
CREATE TABLE inm_backup.kiosk_product_disabled (
    kiosk_id bigint,
    product_id integer
);
CREATE TABLE test.request_log_order (
    order_id text NOT NULL
);
CREATE TABLE public.byte_kp_sales_avgdowhour (
    kiosk_id bigint,
    product_id bigint,
    dowhour double precision,
    avgsales numeric(28,6)
);
CREATE TABLE public.campaigns (
    campaign_id integer NOT NULL,
    title character varying(128),
    description character varying(250),
    owner character varying(24)
);
CREATE TABLE inm_beta.pick_priority_kiosk (
    kiosk_id integer NOT NULL,
    priority integer,
    start_date date,
    end_date date,
    comment text
);
CREATE TABLE pantry.tmp_payment_order (
    order_id character varying(45) NOT NULL,
    payload text,
    re_auth_attempts integer DEFAULT 0
);
CREATE TABLE beta.temp_nutrition_filter (
    id bigint NOT NULL,
    tag_id bigint,
    label character varying(150),
    icon character varying(381)
);
CREATE TABLE develop.kiosk_par_level (
    kiosk_id bigint NOT NULL,
    product_id bigint NOT NULL,
    amount bigint
);
CREATE TABLE develop.role (
    id integer NOT NULL,
    role character varying(765)
);
CREATE TABLE beta.missing_hash (
    order_id character varying(16) NOT NULL,
    transaction_id character varying(10),
    approval_code character varying(6),
    card_hash character varying(264),
    first_name character varying(135),
    last_name character varying(135),
    card_type character varying(45),
    card_number character varying(93),
    email character varying(381),
    created bigint,
    status_message character varying(25)
);
CREATE TABLE pantry.cron (
    id integer NOT NULL,
    "time" character varying(300),
    kiosks character varying(30000),
    command character varying(300),
    payload text,
    trigger_id integer,
    dependencies character varying(300),
    user_id integer,
    raw_task text,
    active integer DEFAULT 1,
    group_id integer,
    timezone character varying(210),
    archived integer DEFAULT 0 NOT NULL
);
CREATE TABLE mixalot.last_kiosk_status (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    kiosk_temperature numeric(6,3),
    kiosk_temperature_count smallint,
    kit_temperature numeric(6,3),
    temperature_tags character varying(6141),
    kiosk_temperature_source character varying(93),
    power integer,
    battery_level smallint,
    rfid_0 integer,
    rfid_1 integer,
    rfid_2 integer,
    rfid_3 integer,
    rfid_4 integer,
    rfid_5 integer,
    rfid_6 integer,
    rfid_7 integer,
    "time" bigint,
    modem_signal_percentage smallint,
    modem_signal_type character varying(81),
    ip character varying(135),
    app_uptime bigint,
    system_uptime bigint,
    is_locked smallint
);
CREATE TABLE public.awsdms_validation_failures_v1 (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "FAILURE_TIME" timestamp without time zone NOT NULL,
    "KEY_TYPE" character varying(128) NOT NULL,
    "KEY" character varying(8000) NOT NULL,
    "FAILURE_TYPE" character varying(128) NOT NULL,
    "DETAILS" character varying(8000) NOT NULL
);
CREATE TABLE develop.sessions (
    sid character varying(765) NOT NULL,
    session character varying(65535) NOT NULL,
    expires integer
);
CREATE TABLE inm_beta.kiosk_restriction_by_property (
    kiosk_id integer NOT NULL,
    property_id integer NOT NULL
);
CREATE TABLE inm_beta.pick_substitution (
    substituting_sku_group_id integer NOT NULL,
    substituted_sku_group_id integer NOT NULL,
    qty integer NOT NULL,
    pick_date date NOT NULL
);
CREATE TABLE inm_backup.pick_inventory (
    pick_date date,
    route_date date,
    kiosk_id integer,
    sku_group_id integer,
    qty integer
);
CREATE TABLE inm_beta.pick_priority_sku (
    sku_id integer NOT NULL,
    priority integer,
    start_date date,
    end_date date,
    comment text
);
CREATE TABLE pantry.tmp_march1_rollingback_auths (
    order_id character varying(45)
);
CREATE TABLE beta.temp_sku_group_attribute (
    title character varying(512) NOT NULL,
    relative_size numeric(4,2) NOT NULL,
    minimum_kiosk_qty smallint NOT NULL,
    maximum_kiosk_qty smallint NOT NULL
);
CREATE TABLE develop.manual_adjustment (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    date character varying(135) NOT NULL,
    sum numeric(6,2) NOT NULL,
    reason character varying(384) NOT NULL,
    auto_generated smallint NOT NULL,
    archived smallint NOT NULL
);
CREATE TABLE dms7.awsdms_suspended_tables (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    table_owner character varying(384) NOT NULL,
    table_name character varying(384) NOT NULL,
    suspend_reason character varying(96),
    suspend_timestamp timestamp without time zone
);
CREATE TABLE develop.refunds (
    order_id character varying(135) NOT NULL,
    product_id integer NOT NULL,
    price numeric(6,2) NOT NULL
);
CREATE TABLE inm.sku_def (
    id integer NOT NULL,
    title character varying(512) NOT NULL
);
CREATE TABLE pantry.temp_kiosk_backup (
    id bigint NOT NULL,
    campus_id bigint NOT NULL,
    serial character varying(135) NOT NULL,
    title character varying(138),
    address character varying(381),
    location_x numeric(9,6) NOT NULL,
    location_y numeric(9,6) NOT NULL,
    gcm_id character varying(765),
    app_vname character varying(189),
    app_vcode integer,
    archived bigint,
    creation_time bigint,
    deployment_time bigint,
    last_update bigint,
    client_name character varying(765),
    last_status bigint,
    last_inventory bigint NOT NULL,
    kiosk_name character varying(765) NOT NULL,
    payment_start bigint,
    payment_stop bigint,
    features character varying(765) NOT NULL,
    sales_tax smallint NOT NULL,
    default_fee_plan bigint NOT NULL,
    timezone character varying(150),
    estd_num_users bigint,
    tags character varying(765),
    publicly_accessible bigint,
    cardkey_required bigint,
    delivery_insns character varying(65535),
    fridge_loc_info character varying(65535),
    contact_first_name character varying(65535),
    contact_last_name character varying(65535),
    contact_email character varying(65535),
    contact_phone character varying(65535),
    accounting_email character varying(65535),
    byte_discount character varying(765),
    subsidy_info character varying(150),
    subsidy_notes character varying(65535),
    max_subscription character varying(150),
    delivery_window_mon character varying(150),
    delivery_window_tue character varying(150),
    delivery_window_wed character varying(150),
    delivery_window_thu character varying(150),
    delivery_window_fri character varying(150),
    delivery_window_sat character varying(150),
    delivery_window_sun character varying(150),
    notes character varying(6000),
    email_receipt_subject character varying(765),
    ops_team_notes character varying(65535),
    geo character varying(9),
    server_url character varying(381),
    subscription_amount numeric(8,2) NOT NULL,
    enable_reporting bigint,
    enable_monitoring bigint,
    employees_num bigint,
    kiosk_restrictions character varying(6000)
);
CREATE TABLE pantry.facing_category (
    id bigint NOT NULL,
    title character varying(765) NOT NULL,
    shelf_level bigint,
    sku_count bigint,
    min_slotted bigint,
    max_slotted bigint,
    mixed_slotted bigint
);
CREATE TABLE inm_test.restricted (
    kid integer NOT NULL,
    sku_id integer NOT NULL
);
CREATE TABLE mixalot.product_kiosk_fact (
    id integer NOT NULL,
    product_id integer,
    kiosk_id integer,
    qty integer,
    "timestamp" timestamp(6) with time zone
);
CREATE TABLE test.campus_20190620 (
    id bigint,
    title character varying(45),
    timezone character varying(50),
    archived integer
);
CREATE TABLE beta.route (
    route_date_time timestamp(6) with time zone,
    duration integer,
    vehicle_label character varying(200),
    vehicle_registration character varying(200),
    driver_serial character varying(200),
    distance numeric(28,6),
    driver_name character varying(200)
);
CREATE TABLE beta.temp_fc_default_level (
    fc_title character varying(60),
    default_level smallint
);
CREATE TABLE develop."order" (
    order_id character varying(135) NOT NULL,
    kiosk_id bigint NOT NULL,
    kiosk_title character varying(138),
    email character varying(381) NOT NULL,
    amount_paid numeric(6,2),
    payment_system character varying(135) NOT NULL,
    transaction_id character varying(135) NOT NULL,
    approval_code character varying(135) NOT NULL,
    status_code character varying(135),
    status_message character varying(135),
    status character varying(135),
    batch_id character varying(45),
    created bigint,
    auth_amount character varying(21),
    data_token character varying(6141),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(264) NOT NULL,
    state character varying(45) NOT NULL,
    archived smallint,
    stamp bigint NOT NULL,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(12),
    coupon_id bigint,
    coupon character varying(135),
    refund numeric(6,2) NOT NULL,
    receipt smallint NOT NULL,
    campus_id integer
);
CREATE TABLE test.discount_20190614 (
    id bigint,
    kiosk_id bigint,
    product_id bigint,
    value integer,
    type character varying(10),
    end_time integer,
    cron_task_id integer
);
CREATE TABLE test.kiosk_bkup_20200204 (
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
CREATE TABLE pantry.global_attribute_def (
    id integer NOT NULL,
    key character varying(150) NOT NULL,
    default_value character varying(150)
);
CREATE TABLE pantry.tmp_watcher (
    label_id bigint,
    order_id character varying(135) NOT NULL,
    created bigint
);
CREATE TABLE public.kiosk_first_seen (
    kiosk_id bigint,
    "time" bigint
);
CREATE TABLE test.accounting_partial_backup_20191101 (
    id bigint,
    date character varying(45),
    kiosk_id bigint,
    campus_id bigint,
    sales_ipc numeric(6,2),
    sales_fp numeric(6,2),
    sales_cs numeric(6,2),
    sales_cp numeric(6,2),
    tags_got bigint,
    tags_spent bigint,
    timezone smallint,
    sales_tax numeric(4,2),
    sales_tax_ipc numeric(6,2),
    sales_tax_fp numeric(6,2),
    sales_tax_cs numeric(6,2),
    sales_tax_cp numeric(6,2),
    prepaid bigint,
    current_fee bigint,
    next_fee bigint,
    recalculated_fee numeric(6,2),
    prepaid_day bigint,
    next_fee_from character varying(45),
    fee_connectivity numeric(5,2)
);
CREATE TABLE dms7.awsdms_apply_exceptions (
    "TASK_NAME" character varying(384) NOT NULL,
    "TABLE_OWNER" character varying(384) NOT NULL,
    "TABLE_NAME" character varying(384) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);
CREATE TABLE mixalot.kiosk_restriction_by_sku (
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL
);
CREATE TABLE mixalot.pick (
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL,
    inventory_qty smallint,
    demand_qty smallint,
    allocated_qty smallint,
    substituted_qty smallint,
    driver_name character varying(60) NOT NULL,
    route_time time(6) without time zone NOT NULL,
    route_date date NOT NULL,
    route_number character varying(60) NOT NULL,
    delivery_order smallint NOT NULL,
    pick_date date NOT NULL
);
CREATE TABLE pantry.permission (
    id integer NOT NULL,
    permission character varying(765),
    api character varying(765),
    "isFrontend" integer NOT NULL
);
CREATE TABLE pantry.product_kiosk_price_offset (
    id integer NOT NULL,
    name character varying(384),
    kiosk character varying(12288),
    product character varying(12288),
    vendor character varying(12288),
    discount character varying(3072),
    end_timestamp bigint
);
CREATE TABLE monitor.cron_state (
    key text NOT NULL,
    value text
);
CREATE TABLE pantry.kiosk_attribute (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    key_id integer NOT NULL,
    value character varying(150) NOT NULL
);
CREATE TABLE develop."group" (
    id bigint NOT NULL,
    name character varying(135) NOT NULL,
    title character varying(135) NOT NULL,
    notes character varying(6000) NOT NULL,
    archived smallint
);
CREATE TABLE develop.group_campus (
    group_id bigint NOT NULL,
    campus_id bigint NOT NULL,
    owner smallint NOT NULL,
    archived smallint
);
CREATE TABLE inm_backup.sku_group_def (
    id integer,
    title character varying(512),
    volume numeric(4,2)
);
CREATE TABLE pantry.par_history (
    id integer NOT NULL,
    kiosk_id integer,
    par_level character varying(3069),
    end_time integer
);
CREATE TABLE test.vantiv_20190801b (
    "Merchant DBA" text,
    transactionid integer,
    name text,
    terminalid text,
    approvalnumber text,
    expirationmonth integer,
    expirationyear integer,
    expressresponsecode integer,
    expressresponsemessage text,
    originalauthorizedamount numeric,
    referencenumber text,
    ticketnumber integer,
    transactionamount numeric,
    transactionstatus text,
    transactiontype text,
    cardnumbermasked text,
    cardlogo text,
    cardtype text,
    trackdatapresent text,
    expresstransactiondate integer,
    expresstransactiontime integer,
    merchantcategorycode integer,
    cardinputcode integer
);
CREATE TABLE develop.ro_order (
    order_id character varying(135) NOT NULL,
    campus_id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    kiosk_title character varying(138),
    created bigint,
    state character varying(45) NOT NULL,
    customer_full_name character varying(300),
    full_price numeric(6,2),
    real_full_price numeric(6,2),
    archived smallint,
    time_updated bigint
);
CREATE TABLE inm.bringg_delivery (
    task_id integer NOT NULL,
    route_date_time timestamp(6) with time zone NOT NULL,
    driver_name character varying(200) NOT NULL,
    kid integer NOT NULL,
    stop_number integer,
    status character varying(200),
    ready_to_execute character varying(200)
);
CREATE TABLE public.track_dashboard (
    date timestamp(6) with time zone,
    sum_amount_paid numeric(28,6),
    sum_list_price numeric(28,6),
    byte_kiosks bigint,
    byte_fridge_uptime numeric(28,6),
    major_byte_outages bigint,
    licensee_kiosks bigint,
    avg_inv_dolr numeric(28,6),
    avg_inv_units numeric(28,6),
    units_sold bigint,
    active_byte_customers bigint,
    active_skus bigint,
    active_brands bigint,
    cards bigint,
    estd_uniq_usernames bigint,
    unique_emails bigint,
    tickets bigint,
    tickets_w_email bigint,
    id integer NOT NULL,
    create_ts timestamp(6) with time zone
);
CREATE TABLE develop.contract (
    id bigint NOT NULL,
    url character varying(765) NOT NULL,
    user_id integer,
    name character varying(381),
    email character varying(381),
    payment_type character varying(150),
    pantry_quantity bigint,
    step smallint,
    paid smallint,
    archived smallint,
    initials character varying(150),
    total bigint,
    pricing_structure smallint,
    payment_transaction_id character varying(765),
    fee_monthly numeric(8,2),
    fee_6_month_pre_payment numeric(8,2),
    fee_12_month_pre_payment numeric(8,2),
    fee_label numeric(3,2),
    fee_transact numeric(5,4),
    fee_deposit numeric(8,2),
    logo character varying(765),
    terms character varying(765),
    requester_id bigint,
    monthly_allowed smallint NOT NULL
);
CREATE TABLE inm_beta.pick_inventory (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    qty integer NOT NULL
);
CREATE TABLE inm_backup.kiosk_restriction_by_product (
    kiosk_id bigint,
    product_id integer
);
CREATE TABLE public.mkt_camp_20170111_sku_revival_sonoma (
    "Kiosk name" text,
    "Email address" text,
    "Record Type" text,
    "Lifecycle Stage" text,
    "Coupon" text
);
CREATE TABLE public.tmp_dormant (
    email character varying(255)
);
CREATE TABLE public.track_inventory (
    kiosk_id bigint,
    kiosk character varying(138),
    product character varying(381),
    sku bigint,
    cost numeric(6,2),
    inventory_count bigint,
    inventory_value numeric(28,6),
    "current_date" timestamp(6) with time zone,
    id integer NOT NULL,
    create_ts timestamp(6) with time zone
);
CREATE TABLE beta.temp_pick_preference_kiosk_sku (
    kiosk_id integer,
    sku_id integer,
    preference smallint
);
CREATE TABLE inm.kiosk_attribute (
    id integer NOT NULL,
    start_level numeric(4,2) NOT NULL,
    min_level numeric(4,2) NOT NULL,
    manual_multiplier numeric(4,2) NOT NULL
);
CREATE TABLE mixalot.tally (
    n integer NOT NULL
);
CREATE TABLE public.awsdms_history (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    timeslot_type character varying(96) NOT NULL,
    timeslot timestamp without time zone NOT NULL,
    timeslot_duration bigint,
    timeslot_latency bigint,
    timeslot_records bigint,
    timeslot_volume bigint
);
CREATE TABLE develop.label_order (
    id bigint NOT NULL,
    product_id bigint,
    group_id bigint,
    box_id character varying(48),
    amount bigint NOT NULL,
    time_order bigint NOT NULL,
    time_encoded bigint,
    time_delivery bigint,
    time_updated bigint,
    status character varying(45)
);
CREATE TABLE develop.tag (
    id bigint NOT NULL,
    tag character varying(93) NOT NULL
);
CREATE TABLE inm_backup.pick_substitution (
    substituting_sku_group_id integer,
    substituted_sku_group_id integer,
    qty integer,
    pick_date date
);
CREATE TABLE inm_backup.ku_group_attribute (
    id integer,
    title character varying(512),
    relative_size numeric(4,2),
    minimum_kiosk_qty smallint,
    maximum_kiosk_qty smallint
);
CREATE TABLE inm_beta.pick_route (
    pick_date date NOT NULL,
    kiosk_id integer NOT NULL,
    route_number character varying(256),
    driver_name character varying(64) NOT NULL,
    route_time time(6) without time zone NOT NULL,
    route_date date NOT NULL,
    delivery_order smallint NOT NULL
);
CREATE TABLE inm_test.inm_kiosk_restock (
    key text,
    kiosk_id bigint,
    dow integer,
    hod integer,
    delivery bigint
);
CREATE TABLE inm_test.tag_2019_05_15 (
    id bigint,
    tag character varying(100)
);
CREATE TABLE beta.sku_group_attribute (
    id integer,
    title character varying(512),
    relative_size numeric(4,2),
    minimum_kiosk_qty smallint
);
CREATE TABLE beta.temp_sync_order_2018_12_13 (
    order_id character varying(135),
    first_name character varying(135),
    last_name character varying(135),
    kiosk_id bigint,
    kiosk_title character varying(138),
    email character varying(381),
    amount_paid numeric(6,2),
    payment_system character varying(135),
    transaction_id character varying(135),
    approval_code character varying(135),
    status_code character varying(135),
    status_message character varying(135),
    status character varying(135),
    batch_id character varying(45),
    created bigint,
    auth_amount character varying(21),
    data_token character varying(6141),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(264),
    state character varying(45),
    archived bigint,
    stamp bigint,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(12),
    coupon_id bigint,
    coupon character varying(135),
    refund numeric(6,2),
    receipt bigint,
    campus_id bigint,
    amount_list_price numeric(6,2),
    notes text,
    time_door_opened bigint,
    time_door_closed bigint
);
CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    email_address character varying(64),
    full_name character varying(64),
    kiosks integer,
    last_buy timestamp(6) with time zone,
    alt_email_address character varying(250),
    cardhash character varying(250),
    opt_out timestamp(6) with time zone,
    last_update timestamp(6) with time zone,
    editkey character varying(12),
    first_name character varying(64),
    last_name character varying(64)
);
CREATE TABLE test.kiosk_20190606 (
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
CREATE TABLE test.order_complimentary_eng_2292 (
    order_id character varying(45) NOT NULL
);
CREATE TABLE develop.label (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    epc character varying(72) NOT NULL,
    is_generic_sku smallint,
    kiosk_id bigint,
    order_id character varying(135),
    status character varying(12),
    price numeric(6,2),
    time_created bigint,
    time_added bigint,
    time_updated bigint
);
CREATE TABLE develop.par_history (
    id integer NOT NULL,
    kiosk_id integer,
    par_level character varying(3069),
    end_time integer
);
CREATE TABLE dms7.awsdms_status (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    task_status character varying(96),
    status_time timestamp without time zone,
    pending_changes bigint,
    disk_swap_size bigint,
    task_memory bigint,
    source_current_position character varying(384),
    source_current_timestamp timestamp without time zone,
    source_tail_position character varying(384),
    source_tail_timestamp timestamp without time zone,
    source_timestamp_applied timestamp without time zone
);
CREATE TABLE pantry.kiosk_device (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    payload jsonb
);
CREATE TABLE public.awsdms_suspended_tables (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    table_owner character varying(384) NOT NULL,
    table_name character varying(384) NOT NULL,
    suspend_reason character varying(96),
    suspend_timestamp timestamp without time zone
);
CREATE TABLE inm.sku_property (
    sku_id integer NOT NULL,
    property_id integer NOT NULL
);
CREATE TABLE inm_test.kiosk_par_level_bkup (
    kiosk_id bigint,
    product_id bigint,
    amount bigint
);
CREATE TABLE inm_beta.kiosk_product_disabled (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL
);
CREATE TABLE inm_test.backup_inm_data_09_16 (
    id integer,
    import_ts timestamp(6) with time zone,
    kiosk_id integer,
    product_id integer,
    fc_title text,
    qty integer,
    data_type text,
    route_date timestamp(6) with time zone,
    route_name text,
    route_time text,
    driver_name text,
    refrigerated smallint,
    sort_order integer
);
CREATE TABLE mixalot.temp_ms_to_sg (
    mslot character varying(512) NOT NULL,
    sgroup character varying(512) NOT NULL
);
CREATE TABLE beta.card (
    id bigint,
    hash character varying(264),
    first_name character varying(135),
    last_name character varying(135),
    type character varying(45),
    number character varying(93),
    email character varying(381),
    notes text,
    created bigint,
    last_update bigint
);
CREATE TABLE beta.warehouse_inventory_history (
    date_time timestamp(6) with time zone DEFAULT now(),
    sku integer NOT NULL,
    stickered_cases integer,
    stickered_units integer,
    unstickered_cases integer,
    unstickered_units integer,
    spoils integer,
    date_ date NOT NULL
);
CREATE TABLE test.transactions_pending_sync (
    id integer NOT NULL,
    epc character varying(24) NOT NULL,
    order_id text,
    kiosk_id bigint,
    direction character varying(16) NOT NULL,
    reason text,
    ts timestamp without time zone NOT NULL
);
CREATE TABLE develop.transact_ipc (
    id bigint NOT NULL,
    order_id character varying(93),
    result character varying(12285),
    "time" bigint
);
CREATE TABLE inm_test.route_stop (
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
CREATE TABLE mixalot.kiosk_restriction_by_property (
    kiosk_id integer NOT NULL,
    property_id integer NOT NULL
);
CREATE TABLE mixalot.server (
    id integer NOT NULL,
    name text,
    time_offset integer,
    modify_dt timestamp(6) with time zone
);
CREATE TABLE pantry.tmp_may4_pricefinalize_order_fixes (
    order_id character varying(45) NOT NULL,
    transaction_id character varying(45),
    amount_paid numeric(6,2)
);
CREATE TABLE public.byte_kp_oos_grid (
    sales_hour timestamp(6) with time zone,
    dowhour double precision,
    kiosk_id integer,
    product_id integer,
    oosminutes double precision
);
CREATE TABLE develop.role_mapping (
    role_id integer NOT NULL,
    parent_id integer NOT NULL
);
CREATE TABLE pantry.currency_symbol (
    id integer NOT NULL,
    code character(3) NOT NULL,
    symbol text NOT NULL
);
CREATE TABLE beta.sku_group_control (
    fc_title character varying(64) NOT NULL,
    start_level numeric(4,2) DEFAULT '-1'::integer NOT NULL,
    scale numeric(4,2) DEFAULT 1.0 NOT NULL,
    min_qty smallint DEFAULT 0 NOT NULL,
    max_qty smallint DEFAULT 0 NOT NULL
);
CREATE TABLE inm_test.kiosk_20190531 (
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
CREATE TABLE inm.temp_velocity (
    kiosk_id bigint,
    sku_group character varying(765),
    sample_size bigint,
    dt_avg numeric,
    dt_std numeric,
    w_departure_time numeric,
    preference numeric,
    pref_total numeric,
    ws_avg numeric,
    ws_std numeric,
    ws_live bigint,
    demand_weekly_wo_min numeric
);
CREATE TABLE pantry.tmp_process_order_vantiv (
    date integer,
    "time" integer,
    transactionid integer,
    status character varying(40),
    accountid character varying(40),
    acceptorid character varying(40),
    transactiontype character varying(40),
    rc integer,
    rm character varying(40),
    amount numeric(6,2),
    card character varying(40),
    apprv character varying(40),
    id integer NOT NULL
);
CREATE TABLE public.byte_kp_sales_grid (
    sales_hour timestamp(6) with time zone,
    dowhour double precision,
    kiosk_id bigint,
    product_id bigint,
    cnt bigint
);
CREATE TABLE test.campus_20190605 (
    id bigint,
    title character varying(45),
    timezone character varying(50),
    archived integer
);
CREATE TABLE beta.pick_demand (
    id integer NOT NULL,
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    qty integer NOT NULL
);
CREATE TABLE develop.inventory_history (
    id integer NOT NULL,
    "time" integer NOT NULL,
    kiosk_id integer NOT NULL,
    product_id integer NOT NULL,
    qty integer NOT NULL
);
CREATE TABLE pantry.temp_product_backup (
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
CREATE TABLE test.kiosk_20190918 (
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
CREATE TABLE inm_beta.pick_list (
    pick_date date NOT NULL,
    create_ts timestamp with time zone,
    finish_ts timestamp with time zone,
    status text,
    log text,
    url text
);
CREATE TABLE mixalot.inm_gsheets_kiosk_restriction (
    kiosk_id integer NOT NULL,
    restriction character varying(512) NOT NULL
);
CREATE TABLE pantry.campus_attribute (
    id integer NOT NULL,
    campus_id bigint NOT NULL,
    key_id integer NOT NULL,
    value character varying(150) NOT NULL
);
CREATE TABLE pantry.transact_fp (
    id bigint NOT NULL,
    order_id character varying(93),
    result character varying(3069),
    "time" bigint
);
CREATE TABLE rptg.temp_yann_q1 (
    year double precision,
    month double precision,
    month_year text,
    kiosk_id bigint,
    title character varying(138),
    client_name character varying(765),
    geo character varying(9),
    monthly_subscription bigint,
    coalesced_sales_list_price numeric,
    byte_discount double precision,
    sales_after_discount double precision,
    coalesced_total_food_cost numeric,
    coalesced_total_unsold_cost numeric,
    coalesced_total_lost_cost numeric,
    subsidy character varying(150)
);
CREATE TABLE inm_backup.product_property (
    product_id bigint,
    property_id integer
);
CREATE TABLE pantry.tmp_process_order_txt (
    amount_paid character varying(15),
    approval_code character varying(45),
    batch_id character varying(15),
    state character varying(15),
    status character varying(45),
    status_code character varying(45),
    status_message character varying(45),
    transaction_id character varying(45),
    order_id character varying(45) NOT NULL,
    id integer NOT NULL
);
CREATE TABLE test.accounting_partial_bkup_20200131 (
    id bigint,
    date character varying(45),
    kiosk_id bigint,
    campus_id bigint,
    sales_ipc numeric(6,2),
    sales_fp numeric(6,2),
    sales_cs numeric(6,2),
    sales_cp numeric(6,2),
    tags_got bigint,
    tags_spent bigint,
    timezone smallint,
    sales_tax numeric(4,2),
    sales_tax_ipc numeric(6,2),
    sales_tax_fp numeric(6,2),
    sales_tax_cs numeric(6,2),
    sales_tax_cp numeric(6,2),
    prepaid bigint,
    current_fee bigint,
    next_fee bigint,
    recalculated_fee numeric(6,2),
    prepaid_day bigint,
    next_fee_from character varying(45),
    fee_connectivity numeric(5,2)
);
CREATE TABLE test.kiosk_20190611 (
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
CREATE TABLE test.kiosk_serial_20190916 (
    id bigint NOT NULL,
    serial character varying(45)
);
CREATE TABLE develop.transact_fp (
    id bigint NOT NULL,
    order_id character varying(93),
    result character varying(3069),
    "time" bigint
);
CREATE TABLE inm_test.inm_kiosk_skugroup_sale (
    key text,
    kiosk_id bigint,
    sku_group character varying(765),
    sku_group_contribution numeric(28,6)
);
CREATE TABLE mixalot.tmp_unit (
    id integer NOT NULL,
    order_id character varying(135),
    epc character varying(135),
    product_id integer,
    name text,
    discounts json,
    price numeric(28,6),
    list_price numeric(28,6),
    cost numeric(28,6),
    create_dt timestamp(6) with time zone,
    modify_dt timestamp(6) with time zone
);
CREATE TABLE pantry.contract (
    id bigint NOT NULL,
    url character varying(255) NOT NULL,
    user_id integer,
    name character varying(127),
    email character varying(127),
    payment_type character varying(50),
    pantry_quantity bigint,
    step smallint,
    paid smallint,
    archived smallint,
    initials character varying(50),
    total bigint,
    pricing_structure smallint,
    payment_transaction_id character varying(255),
    fee_monthly numeric(8,2),
    fee_6_month_pre_payment numeric(8,2),
    fee_12_month_pre_payment numeric(8,2),
    fee_label numeric(3,2),
    fee_transact numeric(5,4),
    fee_deposit numeric(8,2),
    logo character varying(255),
    terms character varying(255),
    requester_id bigint,
    monthly_allowed smallint NOT NULL
);
CREATE TABLE beta.temp_test2 (
    id integer NOT NULL,
    value integer
);
CREATE TABLE develop.event (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    params character varying(6141) NOT NULL,
    action character varying(45) NOT NULL,
    options character varying(6141) NOT NULL,
    archived smallint NOT NULL
);
CREATE TABLE develop."user" (
    id bigint NOT NULL,
    login character varying(135) NOT NULL,
    first_name character varying(381),
    last_name character varying(381),
    password character varying(264) NOT NULL,
    email character varying(381),
    role_id bigint NOT NULL,
    group_id bigint NOT NULL,
    archived smallint NOT NULL,
    date_registered bigint NOT NULL,
    timezone character varying(150),
    email_params character varying(65535),
    token character varying(120)
);
CREATE TABLE public."pantry.kiosk" (
    id integer NOT NULL,
    title character varying(8000)
);
CREATE TABLE test.temp_pending (
    epc character varying(24) NOT NULL,
    order_id text
);
CREATE TABLE inm_backup.kiosk_sku_group_manual_scale (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2)
);
CREATE TABLE pantry.history_global_attribute_def (
    id integer NOT NULL,
    time_modified timestamp with time zone,
    key character varying(45) NOT NULL,
    value character varying(100),
    action character varying(100)
);
CREATE TABLE monitor.opt_connect (
    date_time timestamp(6) without time zone NOT NULL,
    summit_id integer NOT NULL,
    carrier text,
    customer_name text,
    customer_id integer,
    your_device_id text,
    signal_strength text,
    description text,
    device_model text,
    serial_number text,
    device_up_time text,
    static_ip text,
    snapshot_refresh_time bigint,
    last_check_in_time bigint,
    signal_quality text,
    data_plan bigint,
    data_used_date date,
    data_used bigint
);
CREATE TABLE test.order_epc_pending_sync (
    epc character varying(24) NOT NULL,
    order_id text
);
CREATE TABLE beta.kiosk_projected_stock (
    kiosk_id bigint,
    kiosk_title character varying,
    fc_title character varying(765),
    count numeric
);
CREATE TABLE dms7.awsdms_history (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    timeslot_type character varying(96) NOT NULL,
    timeslot timestamp without time zone NOT NULL,
    timeslot_duration bigint,
    timeslot_latency bigint,
    timeslot_records bigint,
    timeslot_volume bigint
);
CREATE TABLE public.byte_kp_oos_avgdowhour (
    kiosk_id integer,
    product_id integer,
    dowhour double precision,
    avgminutes double precision
);
CREATE TABLE test.vantiv_20190801 (
    "Merchant DBA" text,
    transactionid integer,
    name text,
    terminalid text,
    approvalnumber text,
    expirationmonth integer,
    expirationyear integer,
    expressresponsecode integer,
    expressresponsemessage text,
    originalauthorizedamount integer,
    referencenumber text,
    ticketnumber integer,
    transactionamount numeric,
    transactionstatus text,
    transactiontype text,
    cardnumbermasked text,
    cardlogo text,
    cardtype text,
    trackdatapresent text,
    expresstransactiondate integer,
    expresstransactiontime integer,
    merchantcategorycode integer,
    cardinputcode integer
);
CREATE TABLE develop.product (
    id bigint NOT NULL,
    title character varying(381) NOT NULL,
    description character varying(12285),
    price numeric(5,2) NOT NULL,
    cost numeric(5,2) NOT NULL,
    shelf_time integer NOT NULL,
    campus_id bigint NOT NULL,
    image smallint NOT NULL,
    last_update bigint NOT NULL,
    archived smallint,
    taxable smallint,
    allergens character varying(765),
    categories character varying(765),
    vendor character varying(6000)
);
CREATE TABLE inm_backup.kiosk_restriction_by_property (
    kiosk_id integer,
    property_id integer
);
CREATE TABLE mixalot.merchandising_slot_def (
    id integer NOT NULL,
    title character varying(512) NOT NULL
);
CREATE TABLE mixalot.gsheets_kiosk_restriction (
    kiosk_id integer NOT NULL,
    restriction character varying(512) NOT NULL
);
CREATE TABLE pantry.role_mapping (
    role_id integer NOT NULL,
    parent_id integer NOT NULL
);
CREATE TABLE public.iplanner_inventory (
    dccode character varying(250),
    dcname character varying(250),
    bytesku integer,
    product character varying(250),
    date timestamp(6) without time zone,
    lotnumber timestamp(6) without time zone,
    inventory_count numeric(28,6),
    inventory_amount numeric(28,6),
    unit_amount numeric(28,6),
    expiration_date timestamp(6) without time zone,
    id integer
);
CREATE TABLE beta.temp_test (
    id integer NOT NULL,
    name text
);
CREATE TABLE develop.transact_comp (
    id bigint NOT NULL,
    order_id character varying(93),
    result character varying(3069),
    "time" bigint
);
CREATE TABLE beta.test (
    n integer
);
CREATE TABLE inm_beta.kiosk_restriction_by_product (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL
);
CREATE TABLE test.reauth_2019_07_priced_finalized_orders (
    order_id character varying(45) NOT NULL
);
CREATE TABLE mixalot.test_time (
    id integer NOT NULL,
    ts timestamp(6) with time zone
);
CREATE TABLE pantry.transact_express (
    id bigint NOT NULL,
    order_id character varying(93),
    amount numeric(4,2),
    "time" bigint,
    ksn character varying(93),
    magne_print character varying(381),
    magne_print_status character varying(381),
    track2 character varying(381),
    transaction_id character varying(150),
    approval_code character varying(150),
    status_code character varying(150),
    status_message character varying(150),
    status character varying(150),
    batch_id character varying(45)
);
CREATE TABLE develop.feedback (
    id bigint NOT NULL,
    rate smallint NOT NULL,
    order_id character varying(135) NOT NULL,
    message character varying(1536),
    taste smallint,
    freshness smallint,
    variety smallint,
    value smallint,
    ticket_created smallint
);
CREATE TABLE inm_beta.sku_group (
    id integer NOT NULL,
    fc_title inm_beta.text_name NOT NULL,
    unit_size numeric(4,2) NOT NULL
);
CREATE TABLE test.request_log_epc_order (
    epc character varying(24) NOT NULL,
    order_id text,
    ts timestamp without time zone NOT NULL
);
CREATE TABLE test.backup_eng_2669_order (
    order_id character varying(45),
    first_name character varying(45),
    last_name character varying(45),
    kiosk_id bigint,
    kiosk_title character varying(46),
    email character varying(127),
    amount_paid numeric(6,2),
    payment_system character varying(45),
    transaction_id character varying(45),
    approval_code character varying(45),
    status_code character varying(45),
    status_message character varying(45),
    status character varying(45),
    batch_id character varying(15),
    created bigint,
    auth_amount character varying(7),
    data_token character varying(2047),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(88),
    state character varying(15),
    archived bigint,
    stamp bigint,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(4),
    coupon_id bigint,
    coupon character varying(45),
    refund numeric(6,2),
    receipt bigint,
    campus_id bigint,
    amount_list_price numeric(6,2),
    time_door_opened bigint,
    time_door_closed bigint,
    notes text
);
CREATE TABLE test.kiosk (
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
CREATE TABLE test.locked_kiosk_via_pw (
    lock_ts_string text,
    kiosk_id integer,
    lock_ts timestamp with time zone
);
CREATE TABLE pantry.tmp_payment_order_with_id (
    order_id character varying(45) NOT NULL,
    payload text,
    re_auth_attempts integer DEFAULT 0,
    id integer NOT NULL
);
CREATE TABLE inm_test.inm_kiosk_weekly_sale (
    key text,
    kiosk_id bigint,
    woy integer,
    units_sold bigint
);
CREATE TABLE pantry.kiosk_service_version (
    kiosk_id integer NOT NULL,
    service character varying(150) NOT NULL,
    version character varying(100)
);
CREATE TABLE pantry.product_stats_by_kiosk (
    kiosk_id bigint,
    product_id bigint,
    is_new integer,
    is_popular integer,
    "timestamp" integer,
    date_when_new bigint,
    popularity_ranking bigint
);
CREATE TABLE pantry.tmp_order_transaction_id_map (
    transaction_id integer NOT NULL,
    order_id character varying(45),
    amount numeric(5,2),
    direction character varying(5)
);
CREATE TABLE public.byte_kp_oos (
    hour_start timestamp(6) with time zone,
    hour_end timestamp(6) with time zone,
    kiosk_id integer,
    product_id integer,
    ts timestamp(6) with time zone,
    restock_ts timestamp(6) with time zone,
    oos_min double precision
);
CREATE TABLE public.byte_kp_sales_first (
    kiosk_id bigint,
    product_id bigint,
    first_sale_hour timestamp(6) without time zone
);
CREATE TABLE test.eng2903 (
    order_id character varying(45) NOT NULL
);
CREATE TABLE mixalot.kiosk (
    kiosk_id integer NOT NULL,
    gcm_id text,
    app_vname text,
    app_vcode text,
    last_login timestamp(6) with time zone,
    last_update timestamp(6) with time zone,
    last_inventory timestamp(6) with time zone,
    last_status timestamp(6) with time zone,
    components json
);
CREATE TABLE inm_test.test_hours (
    h smallint NOT NULL
);
CREATE TABLE mixalot.card_fact (
    id integer NOT NULL,
    hash text,
    first_name text,
    last_name text,
    email text,
    first_order_id text,
    first_order_ts timestamp(6) with time zone,
    first_order_num_items integer,
    first_order_sales_price double precision,
    first_order_list_price double precision,
    first_order_discount_amt double precision,
    last_order_id text,
    last_order_ts timestamp(6) with time zone,
    last_order_num_items integer,
    last_order_sales_price double precision,
    last_order_list_price double precision,
    last_order_discount_amt double precision,
    avg_order_list_price double precision,
    avg_order_num_items double precision,
    kiosk_ids text,
    user_cat text,
    cac double precision,
    acc_lt_total double precision,
    acc_lt_discount double precision,
    cnt_lt_orders integer,
    cnt_lt_voided integer,
    dow_0_pct double precision,
    dow_1_pct double precision,
    dow_2_pct double precision,
    dow_3_pct double precision,
    dow_4_pct double precision,
    dow_5_pct double precision,
    dow_6_pct double precision
);
CREATE TABLE mixalot.temp_kiosk_restriction (
    kiosk_id integer NOT NULL,
    restriction character varying(256) NOT NULL,
    property_id integer
);
CREATE TABLE pantry.transact_ipc (
    id bigint NOT NULL,
    order_id character varying(93),
    result character varying(12285),
    "time" bigint
);
CREATE TABLE public.int_kiosk_weekly_sale (
    key character varying(8000) NOT NULL,
    kiosk_id integer,
    woy integer,
    units_sold integer
);
CREATE TABLE develop.discount_history (
    id integer NOT NULL,
    kiosk_id integer,
    product_id integer,
    value integer,
    start_time integer,
    end_time integer,
    discount_id integer
);
CREATE TABLE inm_backup.sku_group_control (
    sku_group_id integer,
    default_level numeric(4,2),
    scale numeric(4,2),
    min_qty smallint,
    max_qty smallint
);
CREATE TABLE inm_test.kiosk_audit (
    a text,
    b text,
    kid integer NOT NULL,
    status text,
    e text,
    enable_reporting character(1),
    enable_monitoring character(1)
);
CREATE TABLE test.kiosk_payment_start (
    id integer NOT NULL,
    start_date_str text
);
CREATE TABLE fnrenames.a (
    "?column?" integer
);
CREATE TABLE pantry.tmp_cards_to_update (
    card_id bigint NOT NULL,
    c_fn character varying(135),
    c_ln character varying(135),
    email character varying(381) NOT NULL
);
CREATE TABLE inm_beta.pick_rejection (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    item_id integer NOT NULL,
    item_type character varying(32) NOT NULL,
    reason character varying(64) NOT NULL
);
CREATE TABLE mixalot.sku_group_sku (
    sku_id integer NOT NULL,
    sku_group_id integer NOT NULL
);
CREATE TABLE pantry.product_20190507 (
    id bigint DEFAULT nextval('pantry.product_id_seq'::regclass) NOT NULL,
    title character varying(127) NOT NULL,
    description character varying(4095) DEFAULT 'No description yet'::character varying,
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2) DEFAULT 0.00 NOT NULL,
    cost numeric(5,2) DEFAULT 0.00 NOT NULL,
    shelf_time integer DEFAULT 1 NOT NULL,
    campus_id bigint NOT NULL,
    image smallint DEFAULT 0 NOT NULL,
    image_time bigint,
    last_update bigint DEFAULT 0 NOT NULL,
    archived bigint DEFAULT 0,
    taxable smallint DEFAULT 0,
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
    delivery_option character varying(255) DEFAULT 'M'::character varying,
    tag_applied_by character varying(255) DEFAULT 'W'::character varying
);
CREATE TABLE develop.current_label_status_365days (
    epc character varying(72) NOT NULL,
    campus_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_title character varying(381) NOT NULL,
    price numeric(5,2) NOT NULL,
    status character varying(12) NOT NULL,
    kiosk_id bigint NOT NULL,
    order_id character varying(150) NOT NULL,
    first_timestamp bigint NOT NULL,
    last_timestamp bigint NOT NULL,
    cost numeric(5,2)
);
CREATE TABLE develop.temp (
    id bigint NOT NULL,
    date_processed character varying(135),
    date_auth character varying(135),
    type character varying(135),
    card character varying(135),
    num character varying(135),
    appcode character varying(135),
    amount character varying(135)
);
CREATE TABLE develop.discount (
    id bigint NOT NULL,
    kiosk_id bigint,
    product_id bigint,
    value integer NOT NULL
);
CREATE TABLE inm_beta.kiosk_control (
    kiosk_id integer NOT NULL,
    start_level numeric(4,2) NOT NULL,
    min_level numeric(4,2) NOT NULL,
    scale numeric(4,2) DEFAULT 1.0 NOT NULL,
    manual_multiplier numeric(4,2) DEFAULT 1.0 NOT NULL
);
CREATE TABLE public.byte_kp_sales (
    kiosk_id bigint,
    product_id bigint,
    sales_hour timestamp(6) without time zone,
    cnt bigint
);
CREATE TABLE test.november_order (
    order_id text
);
CREATE TABLE develop.spoilage (
    id integer NOT NULL,
    epc character varying(72) NOT NULL,
    kiosk_id integer NOT NULL,
    order_id character varying(135),
    time_removed integer,
    time_added integer,
    product_id integer
);
CREATE TABLE develop.tmp_watcher (
    label_id bigint,
    order_id character varying(135) NOT NULL,
    created bigint
);
CREATE TABLE public.customer_campaigns (
    customer_id integer NOT NULL,
    campaign_id integer NOT NULL,
    coupon_id character varying(14),
    status character varying(3),
    opt_out timestamp(6) with time zone,
    last_update timestamp(6) with time zone
);
CREATE TABLE mixalot.warehouse_order_history (
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
CREATE TABLE inm_beta.kiosk_sku_group_manual_scale (
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    scale numeric(4,2) NOT NULL
);
CREATE TABLE beta.temp_inv (
    kiosk_id integer,
    fc_title character varying(100),
    qty integer,
    kiosk_title character varying(60)
);
CREATE TABLE inm.kiosk_restriction_by_sku (
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL
);
CREATE TABLE develop.kiosk_status (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    kiosk_temperature numeric(6,3),
    kit_temperature numeric(6,3),
    power integer,
    battery_level smallint,
    rfid_0 integer,
    rfid_1 integer,
    rfid_2 integer,
    rfid_3 bigint NOT NULL,
    "time" bigint,
    modem_signal_percentage smallint,
    modem_signal_type character varying(81),
    ip character varying(135)
);
CREATE TABLE pantry.tmp_backup_order_before_05_03_process_will (
    order_id character varying(45),
    first_name character varying(45),
    last_name character varying(45),
    kiosk_id bigint,
    kiosk_title character varying(46),
    email character varying(127),
    amount_paid numeric(6,2),
    payment_system character varying(45),
    transaction_id character varying(45),
    approval_code character varying(45),
    status_code character varying(45),
    status_message character varying(45),
    status character varying(45),
    batch_id character varying(15),
    created bigint,
    auth_amount character varying(7),
    data_token character varying(2047),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(88),
    state character varying(15),
    archived bigint,
    stamp bigint,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(4),
    coupon_id bigint,
    coupon character varying(45),
    refund numeric(6,2),
    receipt bigint,
    campus_id bigint,
    amount_list_price numeric(6,2),
    time_door_opened bigint,
    time_door_closed bigint,
    notes text
);
CREATE TABLE inm_backup.pick_demand (
    pick_date date,
    route_date date,
    kiosk_id integer,
    sku_group_id integer,
    qty integer
);
CREATE TABLE inm_test.product_20190514 (
    id bigint,
    title character varying(127),
    description character varying(4095),
    tiny_description character varying(40),
    short_description character varying(100),
    medium_description character varying(400),
    long_description character varying(1200),
    price numeric(5,2),
    cost numeric(5,2),
    shelf_time integer,
    campus_id bigint,
    image smallint,
    image_time bigint,
    last_update bigint,
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
CREATE TABLE pantry.tmp_eng_3692 (
    order_id character varying(45) NOT NULL
);
CREATE TABLE pantry.tmp_order_eng_1915 (
    order_id character varying(45),
    campus_id bigint,
    kiosk_id bigint,
    receipt bigint,
    amount_paid numeric(6,2),
    state character varying(15),
    status character varying(45),
    created bigint,
    last_update bigint
);
CREATE TABLE test.fee_rate_bkup_20200131 (
    id bigint,
    fee_lease numeric(6,2),
    fee_tags numeric(3,2),
    fee_ipc numeric(5,4),
    bi_monthly smallint,
    archived smallint,
    custom smallint,
    prepaid_amount bigint,
    name character varying(128)
);
CREATE TABLE test.order_with_1970_and_2000_dates (
    order_id character varying(45),
    first_name character varying(45),
    last_name character varying(45),
    kiosk_id bigint,
    kiosk_title character varying(46),
    email character varying(127),
    amount_paid numeric(6,2),
    payment_system character varying(45),
    transaction_id character varying(45),
    approval_code character varying(45),
    status_code character varying(45),
    status_message character varying(45),
    status character varying(45),
    batch_id character varying(15),
    created bigint,
    auth_amount character varying(7),
    data_token character varying(2047),
    time_opened bigint,
    time_closed bigint,
    card_hash character varying(88),
    state character varying(15),
    archived bigint,
    stamp bigint,
    last_update bigint,
    balance numeric(7,2),
    delta character varying(4),
    coupon_id bigint,
    coupon character varying(45),
    refund numeric(6,2),
    receipt bigint,
    campus_id bigint,
    amount_list_price numeric(6,2),
    time_door_opened bigint,
    time_door_closed bigint,
    notes text
);
CREATE TABLE develop.history (
    id bigint NOT NULL,
    epc character varying(72) NOT NULL,
    kiosk_id bigint NOT NULL,
    user_id bigint,
    order_id character varying(135),
    direction character varying(9) NOT NULL,
    "time" bigint NOT NULL
);
CREATE TABLE fnrenames.overstock_multiplier2 (
    value character varying(100)
);
CREATE TABLE mixalot.pick_priority_sku (
    sku_id integer NOT NULL,
    priority integer
);
CREATE TABLE pantry.delivery_schedule (
    id bigint NOT NULL,
    date date,
    driver character varying(765),
    route character varying(765),
    start_time character varying(30),
    location character varying(765),
    day character varying(765),
    pull_count bigint,
    kiosk_id bigint,
    loc_name character varying(765),
    pull_date date,
    clean_list character varying(765),
    clean_key bigint,
    kiosk_for_key character varying(765)
);
CREATE TABLE public.inm_kiosk_weekly_sale (
    key character varying(8000) NOT NULL,
    kiosk_id integer,
    woy integer,
    units_sold integer
);
CREATE TABLE develop.kiosk (
    id bigint NOT NULL,
    campus_id bigint NOT NULL,
    serial character varying(135) NOT NULL,
    title character varying(138),
    address character varying(381),
    location_x numeric(9,6) NOT NULL,
    location_y numeric(9,6) NOT NULL,
    gcm_id character varying(765),
    app_vname character varying(75),
    app_vcode smallint,
    archived smallint,
    creation_time bigint,
    deployment_time bigint,
    last_update bigint,
    client_name character varying(765),
    last_status bigint,
    last_inventory bigint NOT NULL,
    kiosk_name character varying(765) NOT NULL,
    payment_start bigint,
    payment_stop bigint,
    features character varying(765) NOT NULL,
    sales_tax smallint NOT NULL,
    default_fee_plan bigint NOT NULL,
    timezone character varying(150)
);
CREATE TABLE inm.kiosk_product_disabled (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL
);
CREATE TABLE inm_backup.pick_priority_kiosk (
    kiosk_id integer,
    priority integer,
    comment text,
    end_date date
);
CREATE TABLE inm_beta.pick_demand (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    qty integer NOT NULL
);
CREATE TABLE inm_beta.warehouse_inventory (
    inventory_date date NOT NULL,
    product_id integer NOT NULL,
    stickered_units integer DEFAULT 0 NOT NULL,
    unstickered_units integer DEFAULT 0 NOT NULL,
    stickered_cases integer DEFAULT 0 NOT NULL,
    unstickered_cases integer DEFAULT 0 NOT NULL,
    spoiled_units integer DEFAULT 0 NOT NULL,
    units_per_case integer NOT NULL,
    sort_order smallint NOT NULL
);
CREATE TABLE aws_dms.awsdms_suspended_tables (
    server_name character varying(384) NOT NULL,
    task_name character varying(384) NOT NULL,
    table_owner character varying(384) NOT NULL,
    table_name character varying(384) NOT NULL,
    suspend_reason character varying(96),
    suspend_timestamp timestamp without time zone
);
CREATE TABLE develop.permission_mapping (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);
CREATE TABLE develop.timezone_mapping (
    id bigint NOT NULL,
    value smallint NOT NULL,
    name character varying(135) NOT NULL
);
CREATE TABLE pantry.history_campus_attribute (
    id integer NOT NULL,
    time_modified timestamp with time zone,
    campus_id integer,
    gad_id integer,
    value character varying(100),
    action character varying(100)
);
CREATE TABLE pantry.product_request (
    id bigint NOT NULL,
    customer character varying(765),
    request_date date,
    customer_email character varying(765),
    product_id bigint,
    product_title character varying(765),
    kiosk_id bigint,
    kiosk_title character varying(765),
    request character varying(765),
    date_item_added date,
    increase_factor bigint,
    expiry_date date,
    purchased character varying(765)
);
CREATE TABLE public.tmp_reboots_log (
    ts timestamp(6) with time zone,
    kiosk_id integer,
    ipaddr text,
    reason text
);
ALTER TABLE inm_test.inm_kiosk_restock OWNER TO dbservice;
ALTER TABLE pantry.restock_item_id_seq OWNER TO dbservice;
ALTER TABLE public.kiosk_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_30days OWNER TO dbservice;
ALTER TABLE public.dashboard_monthly_stats OWNER TO dbservice;
ALTER TABLE byte_pgdu.pgdudetail OWNER TO dbservice;
ALTER TABLE inm_backup.sku_group_def OWNER TO dbservice;
ALTER TABLE pantry.role_mapping OWNER TO dbservice;
ALTER TABLE public.awsdms_validation_failures_v1 OWNER TO dbservice;
ALTER TABLE beta.sku_group_control OWNER TO dbservice;
ALTER TABLE fnrenames.nutrition_filter_id_seq OWNER TO dbservice;
ALTER TABLE inm.view_sku_sku_group OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_weekly_product_pct OWNER TO dbservice;
ALTER TABLE develop.feedback OWNER TO dbservice;
ALTER TABLE fnrenames.overstock_multiplier OWNER TO dbservice;
ALTER TABLE develop."group" OWNER TO dbservice;
ALTER TABLE develop.kiosk_par_level OWNER TO dbservice;
ALTER TABLE mixalot.tmp_unit OWNER TO dbservice;
ALTER TABLE pantry.running_service OWNER TO dbservice;
ALTER TABLE public.byte_tickets_1year OWNER TO dbservice;
ALTER TABLE public.user_retention_6months OWNER TO dbservice;
ALTER TABLE test.accounting_bkup_20200204_partial OWNER TO dbservice;
ALTER TABLE develop.current_label_status_365days OWNER TO dbservice;
ALTER TABLE mixalot.inm_byte_kiosk OWNER TO dbservice;
ALTER TABLE pantry.facing_category_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_price_finalized_order_ids OWNER TO dbservice;
ALTER TABLE inm_beta.pick_priority_kiosk OWNER TO dbservice;
ALTER TABLE mixalot.test_time_id_seq OWNER TO dbservice;
ALTER TABLE monitor.cron_state OWNER TO dbservice;
ALTER TABLE beta.temp_pick_preference_kiosk_sku OWNER TO dbservice;
ALTER TABLE develop.tmp_watcher OWNER TO dbservice;
ALTER TABLE inm_backup.ku_group_attribute OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_6weeks OWNER TO dbservice;
ALTER TABLE develop.last_kiosk_status OWNER TO dbservice;
ALTER TABLE pantry.transact_comp OWNER TO dbservice;
ALTER TABLE public.byte_tickets_6days OWNER TO dbservice;
ALTER TABLE public.campaigns OWNER TO dbservice;
ALTER TABLE public.date_hours_2016 OWNER TO dbservice;
ALTER TABLE test.vantiv_20190801 OWNER TO dbservice;
ALTER TABLE pantry.par_history OWNER TO dbservice;
ALTER TABLE pantry.transact_express OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_2weeks OWNER TO dbservice;
ALTER TABLE test.transactions_pending_sync_id_seq OWNER TO dbservice;
ALTER TABLE rptg.current_inventory OWNER TO dbservice;
ALTER TABLE test.temp_pending OWNER TO dbservice;
ALTER TABLE fnrenames.temp_sync_order_2018_12_13 OWNER TO dbservice;
ALTER TABLE pantry.campus_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tag_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_tickets_2015 OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_6days OWNER TO dbservice;
ALTER TABLE public.byte_stockouts_by_category_week_all OWNER TO dbservice;
ALTER TABLE byt_devops.pgdu_pretty OWNER TO dbservice;
ALTER TABLE pantry.contract_id_seq OWNER TO dbservice;
ALTER TABLE public.tmp_reboots_log OWNER TO dbservice;
ALTER TABLE pantry.payment_order_id_seq OWNER TO dbservice;
ALTER TABLE public.dp_epcssold_2015 OWNER TO dbservice;
ALTER TABLE public."pantry.kiosk_id_seq" OWNER TO dbservice;
ALTER TABLE beta.temp_test3 OWNER TO dbservice;
ALTER TABLE beta.warehouse_inventory_history OWNER TO dbservice;
ALTER TABLE inm_test.inm_kiosk_weekly_sale OWNER TO dbservice;
ALTER TABLE inm_test.kiosk_audit OWNER TO dbservice;
ALTER TABLE public.track_dashboard_id_seq OWNER TO dbservice;
ALTER TABLE dms7.awsdms_status OWNER TO dbservice;
ALTER TABLE public.byte_spoilage_by_category_week_crosstab OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_weekly_kiosk_pct OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_daily_pct OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_weekly_kiosk_product_pct OWNER TO dbservice;
ALTER TABLE public.user_retention_4weeks OWNER TO dbservice;
ALTER TABLE byt_devops.pgdudetail_pretty OWNER TO dbservice;
ALTER TABLE pantry.card_id_seq OWNER TO dbservice;
ALTER TABLE public.dbg_stockout_runs_weighted OWNER TO dbservice;
ALTER TABLE mixalot.pick OWNER TO dbservice;
ALTER TABLE mixalot.tally OWNER TO dbservice;
ALTER TABLE monitor.kiosk_not_heard OWNER TO dbservice;
ALTER TABLE develop.kiosk_status OWNER TO dbservice;
ALTER TABLE fnrenames.history_id_seq OWNER TO dbservice;
ALTER TABLE inm_beta.pick_route OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_6months OWNER TO dbservice;
ALTER TABLE public.inm_kiosk_weekly_sale OWNER TO dbservice;
ALTER TABLE public.track_dashboard OWNER TO dbservice;
ALTER TABLE public.kiosk OWNER TO dbservice;
ALTER TABLE develop.cron OWNER TO dbservice;
ALTER TABLE inm_test.broken_product OWNER TO dbservice;
ALTER TABLE mixalot.gsheets_kiosk_restriction OWNER TO dbservice;
ALTER TABLE pantry.dc_inventory OWNER TO dbservice;
ALTER TABLE public.byte_tickets_365days OWNER TO dbservice;
ALTER TABLE public.byte_tickets_4days OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_90days OWNER TO dbservice;
ALTER TABLE public.user_retention_8weeks OWNER TO dbservice;
ALTER TABLE inm_beta.pick_allocation OWNER TO dbservice;
ALTER TABLE pantry.label_id_seq OWNER TO dbservice;
ALTER TABLE pantry.product_kiosk_price_offset OWNER TO dbservice;
ALTER TABLE test.eng2903 OWNER TO dbservice;
ALTER TABLE pantry.tmp_order_eng_1915 OWNER TO dbservice;
ALTER TABLE public.dowhours OWNER TO dbservice;
ALTER TABLE public."pantry.kiosk" OWNER TO dbservice;
ALTER TABLE beta.temp_sync_order_2018_12_13 OWNER TO dbservice;
ALTER TABLE pantry.manual_adjustment_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_march1_rollingback_auths OWNER TO dbservice;
ALTER TABLE inm.kiosk_projected_stock_sku_level OWNER TO dbservice;
ALTER TABLE pantry.spoilage_id_seq OWNER TO dbservice;
ALTER TABLE fnrenames.label_id_seq OWNER TO dbservice;
ALTER TABLE pantry.coupon_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_cards_to_update OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_2016 OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_2017 OWNER TO dbservice;
ALTER TABLE public.track_inventory OWNER TO dbservice;
ALTER TABLE develop.ro_order OWNER TO dbservice;
ALTER TABLE inm_test.kiosk_20190810 OWNER TO dbservice;
ALTER TABLE test.kiosk_20190611 OWNER TO dbservice;
ALTER TABLE public.byte_product_stats_by_kiosk OWNER TO dbservice;
ALTER TABLE public.byte_stockouts_by_category_week_newold OWNER TO dbservice;
ALTER TABLE public.stockout_dowhours OWNER TO dbservice;
ALTER TABLE test.fee_rate_bkup_20200131 OWNER TO dbservice;
ALTER TABLE iplanner.insync_kiosk_v1 OWNER TO dbservice;
ALTER TABLE pantry.history_kiosk_device ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.history_kiosk_device_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE pantry.product_20190507 OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_weekly_product_pct OWNER TO dbservice;
ALTER TABLE public.user_retention_52weeks OWNER TO dbservice;
ALTER TABLE test.request_log_order OWNER TO dbservice;
ALTER TABLE pantry.stockout OWNER TO dbservice;
ALTER TABLE public.byte_sales_by_week OWNER TO dbservice;
ALTER TABLE public.user_retention_2months OWNER TO dbservice;
ALTER TABLE test.request_log_sold_epc OWNER TO dbservice;
ALTER TABLE fnrenames.card_id_seq OWNER TO dbservice;
ALTER TABLE fnrenames.overstock_multiplier2 OWNER TO dbservice;
ALTER TABLE pantry.transact_fp_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_360days OWNER TO dbservice;
ALTER TABLE pantry.last_kiosk_status_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_eng_495_cards_to_update OWNER TO dbservice;
ALTER TABLE public.byte_spoilage_by_category_week_all OWNER TO dbservice;
ALTER TABLE develop.discount_history OWNER TO dbservice;
ALTER TABLE develop.transact_comp OWNER TO dbservice;
ALTER TABLE inm_backup.pick_preference_kiosk_sku_20190120 OWNER TO dbservice;
ALTER TABLE public.sys_conninfo OWNER TO dbservice;
ALTER TABLE public.dbg_stockout_dowhours_weighted OWNER TO dbservice;
ALTER TABLE public.dp_products OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_4weeks OWNER TO dbservice;
ALTER TABLE public.spoilagepct_by_shelflife_120d OWNER TO dbservice;
ALTER TABLE beta.pick_demand OWNER TO dbservice;
ALTER TABLE mixalot.server_id_seq OWNER TO dbservice;
ALTER TABLE pantry.transact_comp_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_kp_grid2 OWNER TO dbservice;
ALTER TABLE rptg.temp_yann_boardq3 OWNER TO dbservice;
ALTER TABLE public.dbg_stockout_dowhours_weighted_stats OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_daily_kiosk_pct OWNER TO dbservice;
ALTER TABLE test.order_complimentary_eng_2292 OWNER TO dbservice;
ALTER TABLE pantry.discount_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_1day OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_1month OWNER TO dbservice;
ALTER TABLE public.inventory_current OWNER TO dbservice;
ALTER TABLE beta.temp_test2 OWNER TO dbservice;
ALTER TABLE develop.unused_user_mapping OWNER TO dbservice;
ALTER TABLE fnrenames.kiosk_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_3days OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_weekly_pct OWNER TO dbservice;
ALTER TABLE public.byte_tickets_90days OWNER TO dbservice;
ALTER TABLE beta.pick_demand_id_seq OWNER TO dbservice;
ALTER TABLE pantry.product_request OWNER TO dbservice;
ALTER TABLE public.byte_dc_inventory_history OWNER TO dbservice;
ALTER TABLE byt_devops.pgdutotal_pretty OWNER TO dbservice;
ALTER TABLE develop.coupon OWNER TO dbservice;
ALTER TABLE pantry.kiosk_device OWNER TO dbservice;
ALTER TABLE pantry.kiosk_status_id_seq OWNER TO dbservice;
ALTER TABLE pantry.cron_id_seq OWNER TO dbservice;
ALTER TABLE pantry.feedback_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_process_order_txt ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.tmp_process_order_txt_d_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE public.byte_epcssold_4days OWNER TO dbservice;
ALTER TABLE beta.route OWNER TO dbservice;
ALTER TABLE beta.temp_product OWNER TO dbservice;
ALTER TABLE develop.tag OWNER TO dbservice;
ALTER TABLE mixalot.inm_warehouse_sku_enabled OWNER TO dbservice;
ALTER TABLE public.byte_tickets_60days OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_7days OWNER TO dbservice;
ALTER TABLE public.mkt_camp_20170123_whats_new_in_kiosk OWNER TO dbservice;
ALTER TABLE pantry.campus_attribute OWNER TO dbservice;
ALTER TABLE pantry.permission_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_2017 OWNER TO dbservice;
ALTER TABLE public.byte_users_products_4months OWNER TO dbservice;
ALTER TABLE aws_dms.awsdms_history OWNER TO dbservice;
ALTER TABLE byt_devops.pgdu_union_pretty OWNER TO dbservice;
ALTER TABLE inm_test.restricted OWNER TO dbservice;
ALTER TABLE mixalot.temp_test_id_seq OWNER TO dbservice;
ALTER TABLE public.dashboard_weekly_stats OWNER TO dbservice;
ALTER TABLE public.kiosk_sales_by_dayofweek OWNER TO dbservice;
ALTER TABLE public.sales_by_category_120d OWNER TO dbservice;
ALTER TABLE public.customers_customer_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_addicted_users_120days OWNER TO dbservice;
ALTER TABLE test.reauth_2019_07_priced_finalized_orders OWNER TO dbservice;
ALTER TABLE public.byte_inventory_current_lots OWNER TO dbservice;
ALTER TABLE public.byte_kp_grid OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_8weeks OWNER TO dbservice;
ALTER TABLE public.int_kiosk_weekly_sale OWNER TO dbservice;
ALTER TABLE mixalot.temp_ms_to_sg OWNER TO dbservice;
ALTER TABLE pantry.role_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_tickets_12months OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_fast OWNER TO dbservice;
ALTER TABLE inm.bringg_delivery OWNER TO dbservice;
ALTER TABLE inm_backup.kiosk_product_disabled OWNER TO dbservice;
ALTER TABLE public.byte_tickets_1day OWNER TO dbservice;
ALTER TABLE public.byte_tickets_3weeks OWNER TO dbservice;
ALTER TABLE test.campus_20190620 OWNER TO dbservice;
ALTER TABLE inm_beta.pick_list OWNER TO dbservice;
ALTER TABLE inm_test.backup_inm_data_09_16 OWNER TO dbservice;
ALTER TABLE pantry.tmp_april23_error_order_fixes OWNER TO dbservice;
ALTER TABLE public.user_retention_3weeks OWNER TO dbservice;
ALTER TABLE test.locked_kiosk_by_command OWNER TO dbservice;
ALTER TABLE develop.refunds OWNER TO dbservice;
ALTER TABLE public.sales_by_shelflife_120d OWNER TO dbservice;
ALTER TABLE public.sys_table_sizes OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_weekly_sold_join OWNER TO dbservice;
ALTER TABLE byt_devops.pgdutotal OWNER TO dbservice;
ALTER TABLE pantry.user_id_seq OWNER TO dbservice;
ALTER TABLE pantry.spoilage OWNER TO dbservice;
ALTER TABLE pantry.tmp_revert_order_status OWNER TO dbservice;
ALTER TABLE public.byte_tickets_1month OWNER TO dbservice;
ALTER TABLE public.byte_kp_oos_avgdowhour OWNER TO dbservice;
ALTER TABLE dms7.awsdms_apply_exceptions OWNER TO dbservice;
ALTER TABLE inm_backup.pick_substitution OWNER TO dbservice;
ALTER TABLE pantry.contract OWNER TO dbservice;
ALTER TABLE pantry.discount_applied_id_seq OWNER TO dbservice;
ALTER TABLE public.stockout_avg_kiosk_cat_sales_dowhour OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_2months OWNER TO dbservice;
ALTER TABLE public.byte_kiosks_with_perm_subsidy OWNER TO dbservice;
ALTER TABLE test.kiosk_20190612 OWNER TO dbservice;
ALTER TABLE test.november_order OWNER TO dbservice;
ALTER TABLE pantry.facing_category OWNER TO dbservice;
ALTER TABLE pantry.delivery_schedule OWNER TO dbservice;
ALTER TABLE public.byte_tickets_5days OWNER TO dbservice;
ALTER TABLE public.dp_inventory_current OWNER TO dbservice;
ALTER TABLE inm_beta.kiosk_restriction_by_property OWNER TO dbservice;
ALTER TABLE pantry.current_label_status_365days OWNER TO dbservice;
ALTER TABLE public.byte_tickets_1week OWNER TO dbservice;
ALTER TABLE public.byte_tickets_10weeks OWNER TO dbservice;
ALTER TABLE public.byte_kp_sales OWNER TO dbservice;
ALTER TABLE public.dp_epcssold_8weeks OWNER TO dbservice;
ALTER TABLE monitor.opt_connect OWNER TO dbservice;
ALTER TABLE public.byte_tickets_6months OWNER TO dbservice;
ALTER TABLE public.byte_tickets_8weeks OWNER TO dbservice;
ALTER TABLE public.campaigns_campaign_id_seq OWNER TO dbservice;
ALTER TABLE rptg.temp_yann_q1 OWNER TO dbservice;
ALTER TABLE byt_devops.pgdudetail OWNER TO dbservice;
ALTER TABLE inm_beta.pick_demand OWNER TO dbservice;
ALTER TABLE inm_test.kiosk_20190531_test_update OWNER TO dbservice;
ALTER TABLE pantry.tmp_eng_3692 OWNER TO dbservice;
ALTER TABLE inm.warehouse_ordering OWNER TO dbservice;
ALTER TABLE pantry.kiosk_attribute OWNER TO dbservice;
ALTER TABLE inm.kiosk_projected_minimum OWNER TO dbservice;
ALTER TABLE mixalot.sku_group_sku OWNER TO dbservice;
ALTER TABLE fnrenames.kiosk_status_id_seq OWNER TO dbservice;
ALTER TABLE public.awsdms_heartbeat_hb_key_seq OWNER TO dbservice;
ALTER TABLE public.byte_tickets_2017 OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_daily_product_pct OWNER TO dbservice;
ALTER TABLE pantry.order_meta OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_60days OWNER TO dbservice;
ALTER TABLE public.user_retention_12months OWNER TO dbservice;
ALTER TABLE test.kiosk_payment_start OWNER TO dbservice;
ALTER TABLE develop.history OWNER TO dbservice;
ALTER TABLE mixalot.card_fact OWNER TO dbservice;
ALTER TABLE test.kiosk_bkup_20200204 OWNER TO dbservice;
ALTER TABLE develop.accounting OWNER TO dbservice;
ALTER TABLE mixalot.inm_kiosk_sku_disabled OWNER TO dbservice;
ALTER TABLE test.vantiv_20190801b OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_weekly_kiosk_pct OWNER TO dbservice;
ALTER TABLE develop.product OWNER TO dbservice;
ALTER TABLE public.byte_tickets_4weeks OWNER TO dbservice;
ALTER TABLE public.byte_stockouts_by_week OWNER TO dbservice;
ALTER TABLE public.awsdms_apply_exceptions OWNER TO dbservice;
ALTER TABLE public.byte_tickets_6weeks OWNER TO dbservice;
ALTER TABLE public.byte_tickets_9months OWNER TO dbservice;
ALTER TABLE pantry.kiosk_audit_log_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_watcher OWNER TO dbservice;
ALTER TABLE test.order_epc_pending_sync OWNER TO dbservice;
ALTER TABLE inm.sku_def OWNER TO dbservice;
ALTER TABLE mixalot.warehouse_order_history OWNER TO dbservice;
ALTER TABLE pantry.product_kiosk_price_offset_id_seq OWNER TO dbservice;
ALTER TABLE public.customer_campaigns OWNER TO dbservice;
ALTER TABLE mixalot.inm_gsheets_kiosk_restriction OWNER TO dbservice;
ALTER TABLE public.byte_tickets_180days OWNER TO dbservice;
ALTER TABLE public.track_inventory_id_seq OWNER TO dbservice;
ALTER TABLE test.cron_broken OWNER TO dbservice;
ALTER TABLE inm_backup.pick_priority_kiosk OWNER TO dbservice;
ALTER TABLE mixalot.product_kiosk_fact_id_seq OWNER TO dbservice;
ALTER TABLE mixalot.temp_sku_to_skugroup OWNER TO dbservice;
ALTER TABLE public.byte_tickets_5weeks OWNER TO dbservice;
ALTER TABLE inm_test.tag_2019_05_15 OWNER TO dbservice;
ALTER TABLE mixalot.kiosk_restriction OWNER TO dbservice;
ALTER TABLE pantry.tmp_order_transaction_id_map OWNER TO dbservice;
ALTER TABLE public.category_stats_120d OWNER TO dbservice;
ALTER TABLE public.dp_inventory_history OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_weekly_sold_join OWNER TO dbservice;
ALTER TABLE develop.group_campus OWNER TO dbservice;
ALTER TABLE public.iplanner_inventory OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_9months OWNER TO dbservice;
ALTER TABLE pantry.group_id_seq OWNER TO dbservice;
ALTER TABLE beta.missing_hash OWNER TO dbservice;
ALTER TABLE inm_test.product_20190508 OWNER TO dbservice;
ALTER TABLE mixalot.v_kiosk_inventory_log OWNER TO dbservice;
ALTER TABLE inm.sku_property OWNER TO dbservice;
ALTER TABLE public.stockout_weighted OWNER TO dbservice;
ALTER TABLE test.lost_wall_clock_orders OWNER TO dbservice;
ALTER TABLE public.dp_epcssold_2016 OWNER TO dbservice;
ALTER TABLE test.kiosk_20200304 OWNER TO dbservice;
ALTER TABLE mixalot.product_kiosk_fact OWNER TO dbservice;
ALTER TABLE pantry.temp_product_backup OWNER TO dbservice;
ALTER TABLE pantry.transact_fp OWNER TO dbservice;
ALTER TABLE public.awsdms_history OWNER TO dbservice;
ALTER TABLE public.byte_tickets_2days OWNER TO dbservice;
ALTER TABLE public.spoilage_by_shelflife_30d OWNER TO dbservice;
ALTER TABLE develop.contract OWNER TO dbservice;
ALTER TABLE develop."user" OWNER TO dbservice;
ALTER TABLE public.byte_kp_sales_grid OWNER TO dbservice;
ALTER TABLE public.latest_label_records OWNER TO dbservice;
ALTER TABLE public.user_retention_3months OWNER TO dbservice;
ALTER TABLE beta.sku_group_attribute OWNER TO dbservice;
ALTER TABLE public.dp_stockouts OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_weekly_pct OWNER TO dbservice;
ALTER TABLE public.user_retention_10weeks OWNER TO dbservice;
ALTER TABLE develop.product_history OWNER TO dbservice;
ALTER TABLE inm_backup.kiosk_sku_group_manual_scale OWNER TO dbservice;
ALTER TABLE mixalot.v_kiosk_status_log OWNER TO dbservice;
ALTER TABLE public.byte_tickets_3days OWNER TO dbservice;
ALTER TABLE mixalot.merchandising_slot_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_12months OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_4months OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_2016 OWNER TO dbservice;
ALTER TABLE beta.temp_fc_default_level OWNER TO dbservice;
ALTER TABLE mixalot.merchandising_slot_def OWNER TO dbservice;
ALTER TABLE pantry.permission OWNER TO dbservice;
ALTER TABLE pantry.tmp_process_order_vantiv ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.tmp_process_order_vantiv_d_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE public.spoilagepct_by_shelflife_30d OWNER TO dbservice;
ALTER TABLE public.sys_activity OWNER TO dbservice;
ALTER TABLE inm_backup.pick_allocation OWNER TO dbservice;
ALTER TABLE inm_backup.sku_velocity_20190120 OWNER TO dbservice;
ALTER TABLE pantry.campus_attribute_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_spoilage OWNER TO dbservice;
ALTER TABLE beta.card OWNER TO dbservice;
ALTER TABLE beta.temp_nutrition_filter OWNER TO dbservice;
ALTER TABLE develop.role OWNER TO dbservice;
ALTER TABLE public.valid_bytecodes OWNER TO dbservice;
ALTER TABLE test.kiosk_20190918 OWNER TO dbservice;
ALTER TABLE fnrenames.discount_history_id_seq OWNER TO dbservice;
ALTER TABLE inm_backup.pick_route OWNER TO dbservice;
ALTER TABLE mixalot.card_fact_id_seq OWNER TO dbservice;
ALTER TABLE public.dp_epcssold_4weeks OWNER TO dbservice;
ALTER TABLE beta.kiosk_projected_stock OWNER TO dbservice;
ALTER TABLE develop.inventory_history OWNER TO dbservice;
ALTER TABLE test.accounting_partial_backup_20191101 OWNER TO dbservice;
ALTER TABLE pantry.global_attribute_def OWNER TO dbservice;
ALTER TABLE public.byte_kp_oos OWNER TO dbservice;
ALTER TABLE test.accounting_partial_bkup_20200131 OWNER TO dbservice;
ALTER TABLE beta.temp_sku_group_attribute OWNER TO dbservice;
ALTER TABLE inm_beta.sku_group OWNER TO dbservice;
ALTER TABLE mixalot.kiosk OWNER TO dbservice;
ALTER TABLE test.order_with_1970_and_2000_dates OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_1week OWNER TO dbservice;
ALTER TABLE public.dp_spoilage OWNER TO dbservice;
ALTER TABLE develop.transact_fp OWNER TO dbservice;
ALTER TABLE inm_test.kiosk_20190508 OWNER TO dbservice;
ALTER TABLE pantry.history_global_attribute_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.history_global_attribute_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE develop.history_epc_order OWNER TO dbservice;
ALTER TABLE inm_beta.pick_inventory OWNER TO dbservice;
ALTER TABLE inm_test.plan_kiosks OWNER TO dbservice;
ALTER TABLE mixalot.v_kiosk_request_log OWNER TO dbservice;
ALTER TABLE pantry.fee_rates_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_180days OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_4weeks OWNER TO dbservice;
ALTER TABLE develop.transact_ipc OWNER TO dbservice;
ALTER TABLE inm_beta.pick_priority_sku OWNER TO dbservice;
ALTER TABLE inm_test.inm_kiosk_skugroup_sale OWNER TO dbservice;
ALTER TABLE inm_test.kiosk_par_level_bkup OWNER TO dbservice;
ALTER TABLE test.request_log_sold_epc_id_seq OWNER TO dbservice;
ALTER TABLE develop.permission_mapping OWNER TO dbservice;
ALTER TABLE develop.timezone_mapping OWNER TO dbservice;
ALTER TABLE inm.kiosk_restriction_by_sku OWNER TO dbservice;
ALTER TABLE inm_test.kiosk_software OWNER TO dbservice;
ALTER TABLE public.byte_kp_sales_first OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_monthly_product_pct OWNER TO dbservice;
ALTER TABLE develop.kiosk OWNER TO dbservice;
ALTER TABLE mixalot.v_node_kiosk_status_log OWNER TO dbservice;
ALTER TABLE pantry.product_request_id_seq OWNER TO dbservice;
ALTER TABLE pantry.bad_timestamp_id_seq OWNER TO dbservice;
ALTER TABLE beta.route_stop OWNER TO dbservice;
ALTER TABLE develop.spoilage OWNER TO dbservice;
ALTER TABLE mixalot.inm_kiosk_restriction_list OWNER TO dbservice;
ALTER TABLE public.user_retention_tickets OWNER TO dbservice;
ALTER TABLE inm_backup.sku_group_control OWNER TO dbservice;
ALTER TABLE inm_test.inm_kiosk_hourly_sale OWNER TO dbservice;
ALTER TABLE public.byte_tickets_2016 OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_120days OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_10weeks OWNER TO dbservice;
ALTER TABLE public.byte_spoilage_by_sku_2months OWNER TO dbservice;
ALTER TABLE develop.permission OWNER TO dbservice;
ALTER TABLE pantry.delivery_schedule_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_orderstoerror OWNER TO dbservice;
ALTER TABLE public.dbg_stockout_weighted OWNER TO dbservice;
ALTER TABLE public.tmp_dormant2 OWNER TO dbservice;
ALTER TABLE develop.manual_adjustment OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_3weeks OWNER TO dbservice;
ALTER TABLE public.byte_restockings OWNER TO dbservice;
ALTER TABLE beta.kiosk_sku_group_manual_scale OWNER TO dbservice;
ALTER TABLE beta.test OWNER TO dbservice;
ALTER TABLE byt_devops.pgdu OWNER TO dbservice;
ALTER TABLE develop.discount OWNER TO dbservice;
ALTER TABLE public.spoilage_by_category_120d OWNER TO dbservice;
ALTER TABLE public.user_retention_9months OWNER TO dbservice;
ALTER TABLE mixalot.sku_def OWNER TO dbservice;
ALTER TABLE pantry.transact_ipc OWNER TO dbservice;
ALTER TABLE pantry.discount_history_id_seq OWNER TO dbservice;
ALTER TABLE pantry.history_campus_attribute ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.history_campus_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE develop.temp OWNER TO dbservice;
ALTER TABLE inm_beta.warehouse_inventory OWNER TO dbservice;
ALTER TABLE mixalot.inm_sku_enabled OWNER TO dbservice;
ALTER TABLE public.byte_tickets_120days OWNER TO dbservice;
ALTER TABLE public.inventory_current_lots OWNER TO dbservice;
ALTER TABLE beta.temp_inv OWNER TO dbservice;
ALTER TABLE inm.kiosk_attribute OWNER TO dbservice;
ALTER TABLE pantry.stockout_id_seq OWNER TO dbservice;
ALTER TABLE pantry.transact_ipc_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_2015 OWNER TO dbservice;
ALTER TABLE public.byte_kiosks_by_week OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_monthly_kiosk_pct OWNER TO dbservice;
ALTER TABLE beta.temp_test2_id_seq OWNER TO dbservice;
ALTER TABLE mixalot.pick_priority_sku OWNER TO dbservice;
ALTER TABLE pantry.tmp_process_order OWNER TO dbservice;
ALTER TABLE public.customers OWNER TO dbservice;
ALTER TABLE test.discount_20190614 OWNER TO dbservice;
ALTER TABLE develop.card OWNER TO dbservice;
ALTER TABLE develop.par_history OWNER TO dbservice;
ALTER TABLE inm_beta.allocable_inventory OWNER TO dbservice;
ALTER TABLE public.byte_kp_sales_avgdowhour OWNER TO dbservice;
ALTER TABLE public.byte_stockouts_by_category_week OWNER TO dbservice;
ALTER TABLE public.spoilage_by_shelflife_120d OWNER TO dbservice;
ALTER TABLE pantry.product_history_id_seq OWNER TO dbservice;
ALTER TABLE public.mkt_camp_20170111_sku_revival_sonoma OWNER TO dbservice;
ALTER TABLE mixalot.sku_attribute_def_id_seq OWNER TO dbservice;
ALTER TABLE pantry.nutrition_filter_id_seq OWNER TO dbservice;
ALTER TABLE public.user_retention_26weeks OWNER TO dbservice;
ALTER TABLE public.awsdms_heartbeat OWNER TO dbservice;
ALTER TABLE fnrenames.product_id_seq OWNER TO dbservice;
ALTER TABLE mixalot.inm_dc_inventory OWNER TO dbservice;
ALTER TABLE mixalot.v_kiosk_item_log OWNER TO dbservice;
ALTER TABLE pantry.currency_symbol OWNER TO dbservice;
ALTER TABLE public.byte_label_product_fast OWNER TO dbservice;
ALTER TABLE pantry.history_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_45days OWNER TO dbservice;
ALTER TABLE public.lastwk_hrs OWNER TO dbservice;
ALTER TABLE develop.label OWNER TO dbservice;
ALTER TABLE mixalot.inm_demand OWNER TO dbservice;
ALTER TABLE pantry.par_history_id_seq OWNER TO dbservice;
ALTER TABLE aws_dms.awsdms_status OWNER TO dbservice;
ALTER TABLE inm_beta.pick_rejection OWNER TO dbservice;
ALTER TABLE mixalot.kiosk_restriction_by_property OWNER TO dbservice;
ALTER TABLE mixalot.kiosk_status OWNER TO dbservice;
ALTER TABLE public.awsdms_status OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_monthly_kiosk_product_pct OWNER TO dbservice;
ALTER TABLE report.dependency OWNER TO dbservice;
ALTER TABLE public.dbg_stockout_weighted_stats OWNER TO dbservice;
ALTER TABLE beta.kiosks OWNER TO dbservice;
ALTER TABLE pantry.kiosk_cd_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_restockings_labels OWNER TO dbservice;
ALTER TABLE public.byte_tickets_yesterday OWNER TO dbservice;
ALTER TABLE pantry.component_history_id_seq OWNER TO dbservice;
ALTER TABLE public.awsdms_suspended_tables OWNER TO dbservice;
ALTER TABLE test.kiosk_20190606 OWNER TO dbservice;
ALTER TABLE inm_backup.kiosk_restriction_by_product OWNER TO dbservice;
ALTER TABLE inm_beta.pick_substitution OWNER TO dbservice;
ALTER TABLE mixalot.merchandising_slot_def_id_seq OWNER TO dbservice;
ALTER TABLE inm_beta.pick_preference_kiosk_sku OWNER TO dbservice;
ALTER TABLE pantry.event OWNER TO dbservice;
ALTER TABLE pantry.restock_item OWNER TO dbservice;
ALTER TABLE public.stockout_dowhours_weighted OWNER TO dbservice;
ALTER TABLE develop.campus OWNER TO dbservice;
ALTER TABLE pantry.product_categories_id_seq OWNER TO dbservice;
ALTER TABLE pantry.kiosk_service_version OWNER TO dbservice;
ALTER TABLE pantry.tmp_payment_order OWNER TO dbservice;
ALTER TABLE public.sys_uptime OWNER TO dbservice;
ALTER TABLE dms7.awsdms_history OWNER TO dbservice;
ALTER TABLE dms7.awsdms_suspended_tables OWNER TO dbservice;
ALTER TABLE pantry.history_kiosk_service_version ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.history_kiosk_service_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE public.tmp_dormant OWNER TO dbservice;
ALTER TABLE public.byte_spoilage_stockouts_by_week OWNER TO dbservice;
ALTER TABLE public.byte_tickets_7days OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_4weeks OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_daily_sold_join OWNER TO dbservice;
ALTER TABLE public.kiosk_first_seen OWNER TO dbservice;
ALTER TABLE beta.temp_test_id_seq OWNER TO dbservice;
ALTER TABLE mixalot.temp_sku_group_volume OWNER TO dbservice;
ALTER TABLE pantry.inventory_history_id_seq OWNER TO dbservice;
ALTER TABLE public.user_retention_1week OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_monthly_sold_join OWNER TO dbservice;
ALTER TABLE mixalot.history_order_id_seq OWNER TO dbservice;
ALTER TABLE pantry.kiosk_id_seq OWNER TO dbservice;
ALTER TABLE inm_beta.sku_group_control OWNER TO dbservice;
ALTER TABLE mixalot.merchandising_slot OWNER TO dbservice;
ALTER TABLE mixalot.test_time OWNER TO dbservice;
ALTER TABLE pantry.product_id_seq OWNER TO dbservice;
ALTER TABLE byt_devops.pgdu_union OWNER TO dbservice;
ALTER TABLE inm_beta.kiosk_restriction_by_product OWNER TO dbservice;
ALTER TABLE pantry.tmp_order_may_6_preapr23 OWNER TO dbservice;
ALTER TABLE public.byte_tickets_2weeks OWNER TO dbservice;
ALTER TABLE public.dp_epcssold_2017 OWNER TO dbservice;
ALTER TABLE inm_test.kiosk_20190531 OWNER TO dbservice;
ALTER TABLE inm_test.product_20190514 OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_365days OWNER TO dbservice;
ALTER TABLE develop.event OWNER TO dbservice;
ALTER TABLE inm.temp_velocity OWNER TO dbservice;
ALTER TABLE inm_backup.kiosk_restriction_by_property OWNER TO dbservice;
ALTER TABLE public.byte_tickets_today OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_monthly_pct OWNER TO dbservice;
ALTER TABLE public.user_retention_6weeks OWNER TO dbservice;
ALTER TABLE test.kiosk_serial_20190916 OWNER TO dbservice;
ALTER TABLE aws_dms.awsdms_suspended_tables OWNER TO dbservice;
ALTER TABLE public.dp_kiosks OWNER TO dbservice;
ALTER TABLE mixalot.temp_test OWNER TO dbservice;
ALTER TABLE public.sys_slow_queries OWNER TO dbservice;
ALTER TABLE fnrenames.tag_id_seq OWNER TO dbservice;
ALTER TABLE inm_backup.product_property OWNER TO dbservice;
ALTER TABLE inm_beta.product_property OWNER TO dbservice;
ALTER TABLE inm_test.test_hours OWNER TO dbservice;
ALTER TABLE public.spoilagepct_by_shelflife_45d OWNER TO dbservice;
ALTER TABLE beta.temp_sync_label_2018_12_13 OWNER TO dbservice;
ALTER TABLE pantry.permission_mapping OWNER TO dbservice;
ALTER TABLE public.sales_by_shelflife_30d OWNER TO dbservice;
ALTER TABLE pantry.tmp_payment_order_with_id ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.tmp_payment_order_with_id_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE public.byte_epcssold_8weeks OWNER TO dbservice;
ALTER TABLE public.cogs_by_category_120d OWNER TO dbservice;
ALTER TABLE mixalot.kiosk_restriction_by_sku OWNER TO dbservice;
ALTER TABLE pantry.cron OWNER TO dbservice;
ALTER TABLE pantry.history_kiosk_attribute ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME pantry.history_kiosk_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE public.byte_inventory_current OWNER TO dbservice;
ALTER TABLE public.byte_spoilage_by_category_week_newold OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_2017 OWNER TO dbservice;
ALTER TABLE public.user_retention_2weeks OWNER TO dbservice;
ALTER TABLE mixalot.pgdu_bytes OWNER TO dbservice;
ALTER TABLE mixalot.v_node_kiosk_request_log OWNER TO dbservice;
ALTER TABLE pantry.event_id_seq OWNER TO dbservice;
ALTER TABLE pantry.order_meta_id_seq OWNER TO dbservice;
ALTER TABLE test.campus_20190605 OWNER TO dbservice;
ALTER TABLE test.transactions_pending_sync OWNER TO dbservice;
ALTER TABLE public.stockout_runs_weighted OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_monthly_calc OWNER TO dbservice;
ALTER TABLE mixalot.server OWNER TO dbservice;
ALTER TABLE pantry.tmp_backup_order_before_05_03_process_will OWNER TO dbservice;
ALTER TABLE pantry.transact_express_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_users_multiple_fridges OWNER TO dbservice;
ALTER TABLE public.byte_raw_orders OWNER TO dbservice;
ALTER TABLE public.byte_spoilage_by_week OWNER TO dbservice;
ALTER TABLE public.byte_stockouts_by_category_week_crosstab OWNER TO dbservice;
ALTER TABLE public.dp_epcssold OWNER TO dbservice;
ALTER TABLE beta.temp_test OWNER TO dbservice;
ALTER TABLE develop.label_order OWNER TO dbservice;
ALTER TABLE develop."order" OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_1year OWNER TO dbservice;
ALTER TABLE pantry.currency_symbol_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_tickets_45days OWNER TO dbservice;
ALTER TABLE public.byte_spoilage_by_category_week OWNER TO dbservice;
ALTER TABLE public.byte_tickets_2months OWNER TO dbservice;
ALTER TABLE public.byte_kiosks_date_non_new OWNER TO dbservice;
ALTER TABLE public.byte_tickets_labels OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_8weeks OWNER TO dbservice;
ALTER TABLE develop.transact_cs OWNER TO dbservice;
ALTER TABLE inm.sku_property_def OWNER TO dbservice;
ALTER TABLE public.user_retention_4months OWNER TO dbservice;
ALTER TABLE test.kiosk OWNER TO dbservice;
ALTER TABLE test.request_log_epc_order OWNER TO dbservice;
ALTER TABLE public.byte_tickets_4months OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_5days OWNER TO dbservice;
ALTER TABLE inm_beta.kiosk_sku_group_manual_scale OWNER TO dbservice;
ALTER TABLE pantry.accounting_id_seq OWNER TO dbservice;
ALTER TABLE test.locked_kiosk_via_pw OWNER TO dbservice;
ALTER TABLE pantry.product_stats_by_kiosk OWNER TO dbservice;
ALTER TABLE public.sales_by_shelflife_45d OWNER TO dbservice;
ALTER TABLE test.backup_eng_2669_order OWNER TO dbservice;
ALTER TABLE inm_backup.kiosk_control OWNER TO dbservice;
ALTER TABLE inm_backup.pick_inventory OWNER TO dbservice;
ALTER TABLE inm_beta.kiosk_control OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_daily_kiosk_product_pct OWNER TO dbservice;
ALTER TABLE develop.role_mapping OWNER TO dbservice;
ALTER TABLE fnrenames.a OWNER TO dbservice;
ALTER TABLE inm_backup.pick_demand OWNER TO dbservice;
ALTER TABLE pantry.temp_kiosk_backup OWNER TO dbservice;
ALTER TABLE mixalot.lineitem_id_seq OWNER TO dbservice;
ALTER TABLE pantry.kiosks_date_non_new_id_seq OWNER TO dbservice;
ALTER TABLE public.spoilage_by_shelflife_45d OWNER TO dbservice;
ALTER TABLE develop.sessions OWNER TO dbservice;
ALTER TABLE inm_beta.kiosk_product_disabled OWNER TO dbservice;
ALTER TABLE public.user_retention_12weeks OWNER TO dbservice;
ALTER TABLE public.user_retention_1month OWNER TO dbservice;
ALTER TABLE develop.fee_rates OWNER TO dbservice;
ALTER TABLE public.byte_tickets_360days OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_5weeks OWNER TO dbservice;
ALTER TABLE public.dp_spoilage_weekly_kiosk_product_pct OWNER TO dbservice;
ALTER TABLE test.kiosk_20190605 OWNER TO dbservice;
ALTER TABLE iplanner.facing_category_v1 OWNER TO dbservice;
ALTER TABLE pantry.kiosk_attribute_id_seq OWNER TO dbservice;
ALTER TABLE public.byte_tickets_30days OWNER TO dbservice;
ALTER TABLE public.byte_epcssold_2days OWNER TO dbservice;
ALTER TABLE public.byte_stockouts OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_2016 OWNER TO dbservice;
ALTER TABLE inm.temp_pick_order OWNER TO dbservice;
ALTER TABLE inm_test.route_stop OWNER TO dbservice;
ALTER TABLE mixalot.temp_kiosk_restriction OWNER TO dbservice;
ALTER TABLE pantry.global_attribute_def_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_may4_pricefinalize_order_fixes OWNER TO dbservice;
ALTER TABLE public.byte_kp_oos_grid OWNER TO dbservice;
ALTER TABLE public.dp_stockouts_weekly_calc OWNER TO dbservice;
ALTER TABLE fnrenames.tmp_payment_information OWNER TO dbservice;
ALTER TABLE mixalot.discount_rule OWNER TO dbservice;
ALTER TABLE pantry.kiosk_device_id_seq OWNER TO dbservice;
ALTER TABLE pantry.tmp_may4_error_order_fixes OWNER TO dbservice;