
CREATE VIEW fnrenames.v_warehouse_ordering_rec AS
 SELECT stats.sku_group,
    stats.sku,
    stats.name,
    stats.vendor,
    ceiling(sum((stats.d0_plan_demand_ratio * (stats.sku_demand + stats.sku_overstock)))) AS su,
    ceiling(sum((stats.d1_plan_demand_ratio * (stats.sku_demand + stats.sku_overstock)))) AS mo,
    ceiling(sum((stats.d2_plan_demand_ratio * (stats.sku_demand + stats.sku_overstock)))) AS tu,
    ceiling(sum((stats.d3_plan_demand_ratio * (stats.sku_demand + stats.sku_overstock)))) AS we,
    ceiling(sum((stats.d4_plan_demand_ratio * (stats.sku_demand + stats.sku_overstock)))) AS th,
    ceiling(sum(stats.sku_demand)) AS demand_week,
    ceiling(sum(stats.sku_overstock)) AS overstock_week,
    max(stats.sku_shelf_time) AS shelf_time
   FROM ( SELECT stats_1.kiosk_id,
            stats_1.sku_group,
            stats_1.sku_group_id,
            stats_1.sku,
            stats_1.name,
            stats_1.enabled,
            stats_1.sku_sample_size,
            stats_1.sku_departure_time,
            stats_1.sku_preference,
            stats_1.sku_group_sample_size,
            stats_1.sku_group_preference,
            stats_1.kiosk_start_level,
            stats_1.kiosk_min_level,
            stats_1.kiosk_manual_multiplier,
            stats_1.sku_group_default_level,
            stats_1.sku_group_scale,
            stats_1.kiosk_sku_group_scale,
            stats_1.sku_group_start_count,
            stats_1.sku_group_min_count,
            stats_1.sku_group_preference_count,
            stats_1.sku_group_stock_avg,
            stats_1.sku_group_stock_std,
            stats_1.sku_group_sale_avg,
            stats_1.sku_group_sale_std,
            stats_1.sku_group_spoil_avg,
            stats_1.sku_group_spoil_std,
            stats_1.kiosk_weeks_live,
            stats_1.kiosk_sale_max,
            stats_1.kiosk_stock_avg,
            stats_1.kiosk_stock_std,
            stats_1.kiosk_sale_avg,
            stats_1.kiosk_sale_std,
            stats_1.kiosk_spoil_avg,
            stats_1.kiosk_spoil_std,
            stats_1.d0_plan_demand_ratio,
            stats_1.d1_plan_demand_ratio,
            stats_1.d2_plan_demand_ratio,
            stats_1.d3_plan_demand_ratio,
            stats_1.d4_plan_demand_ratio,
            stats_1.vendor,
            stats_1.sku_shelf_time,
            stats_1.sku_pref_total_kiosk_sku_group,
            stats_1.sku_group_demand,
            stats_1.sku_group_overstock,
            round(public.if((stats_1.sku_pref_total_kiosk_sku_group <> (0)::numeric), (((stats_1.sku_group_demand * (stats_1.enabled)::numeric) * stats_1.sku_preference) / stats_1.sku_pref_total_kiosk_sku_group), 0.00), 2) AS sku_demand,
            round(public.if((stats_1.sku_pref_total_kiosk_sku_group <> (0)::numeric), ((((LEAST(1.00, (7.00 / (stats_1.sku_shelf_time)::numeric)) * stats_1.sku_group_overstock) * (stats_1.enabled)::numeric) * stats_1.sku_preference) / stats_1.sku_pref_total_kiosk_sku_group), 0.00), 2) AS sku_overstock
           FROM ( SELECT stats_2.kiosk_id,
                    stats_2.sku_group,
                    stats_2.sku_group_id,
                    stats_2.sku,
                    stats_2.name,
                    stats_2.enabled,
                    stats_2.sku_sample_size,
                    stats_2.sku_departure_time,
                    stats_2.sku_preference,
                    stats_2.sku_group_sample_size,
                    stats_2.sku_group_preference,
                    stats_2.kiosk_start_level,
                    stats_2.kiosk_min_level,
                    stats_2.kiosk_manual_multiplier,
                    stats_2.sku_group_default_level,
                    stats_2.sku_group_scale,
                    stats_2.kiosk_sku_group_scale,
                    stats_2.sku_group_start_count,
                    stats_2.sku_group_min_count,
                    stats_2.sku_group_preference_count,
                    stats_2.sku_group_stock_avg,
                    stats_2.sku_group_stock_std,
                    stats_2.sku_group_sale_avg,
                    stats_2.sku_group_sale_std,
                    stats_2.sku_group_spoil_avg,
                    stats_2.sku_group_spoil_std,
                    stats_2.kiosk_weeks_live,
                    stats_2.kiosk_sale_max,
                    stats_2.kiosk_stock_avg,
                    stats_2.kiosk_stock_std,
                    stats_2.kiosk_sale_avg,
                    stats_2.kiosk_sale_std,
                    stats_2.kiosk_spoil_avg,
                    stats_2.kiosk_spoil_std,
                    stats_2.d0_plan_demand_ratio,
                    stats_2.d1_plan_demand_ratio,
                    stats_2.d2_plan_demand_ratio,
                    stats_2.d3_plan_demand_ratio,
                    stats_2.d4_plan_demand_ratio,
                    product.vendor,
                    product.shelf_time AS sku_shelf_time,
                    sum(((stats_2.enabled)::numeric * stats_2.sku_preference)) OVER (PARTITION BY stats_2.kiosk_id, stats_2.sku_group) AS sku_pref_total_kiosk_sku_group,
                    stats_2.sku_group_preference_count AS sku_group_demand,
                    GREATEST((public.if((stats_2.kiosk_weeks_live <= 4), GREATEST(stats_2.sku_group_start_count, stats_2.sku_group_preference_count), GREATEST(stats_2.sku_group_min_count, stats_2.sku_group_preference_count)) - stats_2.sku_group_preference_count), 0.00) AS sku_group_overstock
                   FROM (inm.v_kiosk_sku_group_sku_stats stats_2
                     LEFT JOIN pantry.product product ON ((stats_2.sku = product.id)))) stats_1) stats
  GROUP BY stats.sku_group, stats.sku, stats.name, stats.vendor
  ORDER BY stats.sku_group, stats.vendor;
CREATE VIEW campus_87.kiosk_restriction_by_property AS
 SELECT kiosk_restriction_by_property.kiosk_id,
    kiosk_restriction_by_property.property_id
   FROM inm.kiosk_restriction_by_property;
CREATE VIEW campus_87."order" AS
 SELECT "order".order_id,
    "order".first_name,
    "order".last_name,
    "order".kiosk_id,
    "order".kiosk_title,
    "order".email,
    "order".amount_paid,
    "order".payment_system,
    "order".transaction_id,
    "order".approval_code,
    "order".status_code,
    "order".status_message,
    "order".status,
    "order".batch_id,
    "order".created,
    "order".auth_amount,
    "order".data_token,
    "order".time_opened,
    "order".time_closed,
    "order".card_hash,
    "order".state,
    "order".archived,
    "order".stamp,
    "order".last_update,
    "order".balance,
    "order".delta,
    "order".coupon_id,
    "order".coupon,
    "order".refund,
    "order".receipt,
    "order".campus_id,
    "order".amount_list_price,
    "order".notes,
    "order".time_door_opened,
    "order".time_door_closed
   FROM pantry."order"
  WHERE ("order".campus_id = 87);
CREATE VIEW campus_87.pick_preference_kiosk_sku AS
 SELECT pick_preference_kiosk_sku.kiosk_id,
    pick_preference_kiosk_sku.sku_id,
    pick_preference_kiosk_sku.preference
   FROM inm.pick_preference_kiosk_sku;
CREATE VIEW campus_87.sku_group_attribute AS
 SELECT sku_group_attribute.id,
    sku_group_attribute.title,
    sku_group_attribute.relative_size,
    sku_group_attribute.minimum_kiosk_qty,
    sku_group_attribute.maximum_kiosk_qty
   FROM inm.sku_group_attribute;
CREATE VIEW erp.v_product_options AS
 SELECT pcd.id,
    pcd.name,
    pcd.value,
    ''::text AS optionalvalue
   FROM erp.product_category_def pcd
UNION
 SELECT ppd.id,
    'all_prod_prop_def'::text AS name,
    ppd.name AS value,
    ppd.value AS optionalvalue
   FROM inm.product_property_def ppd
UNION
 SELECT gad.id,
    gad.name,
    gad.value,
    ''::text AS optionalvalue
   FROM erp.global_attribute_def gad;
CREATE VIEW erp.v_transaction_detail AS
 SELECT o.order_id AS id,
    o.campus_id AS campusid,
        CASE
            WHEN ("left"((o.order_id)::text, 2) = 'RE'::text) THEN 'Restock'::text
            ELSE 'Sale'::text
        END AS type,
    o.kiosk_id AS kid,
    o.kiosk_title AS kname,
    o.email,
    concat_ws(' '::text, btrim((o.first_name)::text), btrim((o.last_name)::text)) AS name,
    ( SELECT sum(label.price) AS sum
           FROM pantry.label
          WHERE (((label.order_id)::text = (o.order_id)::text) AND ((label.status)::text = ANY (ARRAY[('sold'::character varying)::text, ('out'::character varying)::text])))) AS total,
    ( SELECT string_agg(aggattr.value, '| '::text) AS string_agg
           FROM ( SELECT (((((('{"item" : "'::text || (p.title)::text) || '", "price" : '::text) || (l.price)::real) || ', "qty" : '::text) || (count(*))::smallint) || '}'::text) AS value
                   FROM (pantry.label l
                     JOIN pantry.product p ON ((l.product_id = p.id)))
                  WHERE (((l.order_id)::text = (o.order_id)::text) AND ((l.status)::text = ANY (ARRAY[('sold'::character varying)::text, ('out'::character varying)::text])))
                  GROUP BY p.title, l.price) aggattr) AS items,
    o.amount_paid AS amount,
    concat_ws('/'::text, o.state, o.status) AS status,
    o.created AS ts,
    f.rate AS feedback,
    f.message AS feedbackmsg,
    c.code AS couponcode,
    c.flat_discount AS couponamt,
    o.receipt,
    COALESCE(( SELECT (sum(da.price_before) - sum(da.price_after))
           FROM pantry.discount_applied da
          WHERE ((da.order_id)::text = (o.order_id)::text)), (0)::numeric) AS discountamt,
        CASE
            WHEN ((COALESCE(k.features, ''::character varying))::text ~~ '%no_vending%'::text) THEN 'N'::text
            ELSE 'Y'::text
        END AS paid,
    COALESCE(o.payment_system, 'N/A'::character varying) AS paymentsystem
   FROM (((pantry."order" o
     LEFT JOIN pantry.feedback f ON (((o.order_id)::text = (f.order_id)::text)))
     LEFT JOIN pantry.coupon c ON (((c.code)::text = (o.coupon)::text)))
     LEFT JOIN pantry.kiosk k ON ((o.kiosk_id = k.id)));
CREATE VIEW campus_87.byte_feedback_monthly AS
 SELECT byte_feedback_monthly.month,
    byte_feedback_monthly.avg_rating,
    byte_feedback_monthly.avg_value,
    byte_feedback_monthly.avg_taste,
    byte_feedback_monthly.avg_freshness,
    byte_feedback_monthly.avg_variety,
    byte_feedback_monthly.frac_feedbacks
   FROM public.byte_feedback_monthly;
CREATE VIEW dw.export_inventory_lots AS
 SELECT k.campus_id,
    ci.kiosk_id,
    k.title,
    k.geo,
    p.id AS product_id,
    p.title AS product_title,
    ( SELECT string_agg((t.tag)::text, ','::text) AS string_agg
           FROM pantry.tag t
          WHERE ((t.id)::text = ANY (string_to_array((p.categories)::text, ','::text)))) AS categories,
    ci.time_added,
    ((now())::date - (ci.time_added)::date) AS days_in_kiosk,
    p.shelf_time,
    count(*) AS count_,
    p.price,
    p.cost,
    p.source AS source_,
    p.consumer_category,
    date_trunc('second'::text, now()) AS now_
   FROM ((dw.current_inventory ci
     JOIN pantry.product p ON ((p.id = ci.product_id)))
     JOIN pantry.kiosk k ON (((k.id = ci.kiosk_id) AND (k.archived = 0) AND (p.price > 0.01))))
  GROUP BY k.campus_id, ci.kiosk_id, k.title, k.geo, p.id, p.title, p.categories, ci.time_added, p.shelf_time, p.price, p.cost, p.source, p.consumer_category;
CREATE VIEW campus_87.pick_priority_sku AS
 SELECT pick_priority_sku.sku_id,
    pick_priority_sku.priority,
    pick_priority_sku.start_date,
    pick_priority_sku.end_date,
    pick_priority_sku.comment
   FROM inm.pick_priority_sku;
CREATE VIEW test.sync_qa_kiosk_iotmaster AS
 SELECT kiosk.id,
    kiosk.campus_id,
    kiosk.serial,
    kiosk.title,
    kiosk.gcm_id,
    kiosk.app_vcode,
    kiosk.archived,
    kiosk.creation_time,
    kiosk.deployment_time,
    kiosk.kiosk_name,
    kiosk.features,
    kiosk.sales_tax,
    kiosk.default_fee_plan,
    kiosk.estd_num_users,
    kiosk.publicly_accessible,
    kiosk.delivery_insns,
    kiosk.fridge_loc_info,
    kiosk.byte_discount,
    kiosk.subsidy_info,
    kiosk.subsidy_notes,
    kiosk.max_subscription,
    kiosk.email_receipt_subject,
    kiosk.ops_team_notes,
    kiosk.geo,
    kiosk.server_url,
    kiosk.subscription_amount,
    kiosk.enable_reporting
   FROM pantry.kiosk;
CREATE VIEW erp.product_classic_view AS
 SELECT p.id,
    pa.title,
    pa.description,
    pa.tiny_description,
    pa.short_description,
    pa.medium_description,
    pa.long_description,
    pp.price,
    pp.cost,
    pn.shelf_time,
    p.campus_id,
    COALESCE((pa.image)::integer, 0) AS image,
    pa.image_time,
    p.last_update,
    p.archived,
    pp.taxable,
    property_tag.allergens,
    property_tag.attribute_names,
    cat.categories,
    cat.category_names,
    ps.vendor,
    ps.source,
    'fixme'::text AS notes,
    pn.total_cal,
    pn.num_servings,
    pn.ingredients,
    pn.calories,
    pn.proteins,
    pn.sugar,
    pn.carbohydrates,
    pn.fat,
    category_tag.consumer_category,
    ph.ws_case_size,
    ph.kiosk_ship_qty,
    pp.ws_case_cost,
    ph.pick_station,
    p.fc_title,
    pp.pricing_tier,
    ph.width_space,
    ph.height_space,
    ph.depth_space,
    ph.slotted_width,
    ph.tag_volume,
    ph.tag_delivery_option AS delivery_option,
    ph.tag_applied_by
   FROM ((((((((erp.product p
     JOIN erp.product_asset pa ON ((p.id = pa.product_id)))
     JOIN erp.product_pricing pp ON ((p.id = pp.product_id)))
     JOIN erp.product_nutrition pn ON ((p.id = pn.product_id)))
     JOIN erp.product_sourcing ps ON ((p.id = ps.product_id)))
     JOIN erp.product_handling ph ON ((p.id = ph.product_id)))
     LEFT JOIN ( SELECT p_1.id AS product_id,
            string_agg((pt.tag_id)::text, ','::text) AS allergens,
            string_agg((pt.tag)::text, ','::text) AS attribute_names
           FROM ((erp.product p_1
             JOIN erp.product_property pp_1 ON ((p_1.id = pp_1.product_id)))
             JOIN erp.product_property_tag pt ON ((pt.property_id = pp_1.property_id)))
          GROUP BY p_1.id) property_tag ON ((p.id = property_tag.product_id)))
     LEFT JOIN ( SELECT pc.product_id,
            pcd.value AS consumer_category
           FROM (erp.product_category pc
             JOIN erp.product_category_def pcd ON (((pc.category_id = pcd.id) AND ((pcd.name)::text = 'consumer'::text))))) category_tag ON ((p.id = category_tag.product_id)))
     LEFT JOIN ( SELECT cpct.product_id,
            string_agg((cpct.tag_id)::text, ','::text) AS categories,
            string_agg((t.tag)::text, ';'::text) AS category_names
           FROM (erp.classic_product_category_tag cpct
             JOIN pantry.tag t ON ((cpct.tag_id = t.id)))
          GROUP BY cpct.product_id) cat ON ((p.id = cat.product_id)));
CREATE VIEW erp.v_product_list AS
 SELECT p.id AS sku,
    pa.title,
    ( SELECT pcd.value
           FROM erp.product_category_def pcd
          WHERE (pcd.id = pc.category_id)) AS category,
    ps.source,
        CASE
            WHEN ((p.archived)::smallint = 0) THEN 'Live'::text
            ELSE 'Archived'::text
        END AS status,
    p.brand,
    ph.pick_station AS pickstation,
    ph.ws_case_size AS wscasesize,
    p.campus_id AS campusid,
    sg.fc_title AS skugroup,
    p.archived
   FROM (((((erp.product p
     LEFT JOIN erp.product_asset pa ON ((pa.product_id = p.id)))
     LEFT JOIN erp.product_category pc ON ((pc.product_id = p.id)))
     LEFT JOIN erp.product_sourcing ps ON ((ps.product_id = p.id)))
     LEFT JOIN erp.product_handling ph ON ((ph.product_id = p.id)))
     LEFT JOIN erp.sku_group sg ON ((p.sku_group_id = sg.id)))
  ORDER BY p.id;
CREATE VIEW migration.sync_qa_product_dest AS
 SELECT product_classic_view.id,
    product_classic_view.title,
    product_classic_view.description,
    product_classic_view.tiny_description,
    product_classic_view.short_description,
    product_classic_view.medium_description,
    product_classic_view.long_description,
    product_classic_view.price,
    product_classic_view.cost,
    product_classic_view.shelf_time,
    product_classic_view.campus_id,
    product_classic_view.image_time,
    product_classic_view.last_update,
    product_classic_view.archived,
    product_classic_view.taxable,
    product_classic_view.vendor,
    product_classic_view.source,
    product_classic_view.total_cal,
    product_classic_view.num_servings,
    product_classic_view.ingredients,
    product_classic_view.calories,
    product_classic_view.proteins,
    product_classic_view.sugar,
    product_classic_view.carbohydrates,
    product_classic_view.fat,
    product_classic_view.consumer_category,
    product_classic_view.ws_case_size,
    product_classic_view.kiosk_ship_qty,
    product_classic_view.ws_case_cost,
    product_classic_view.pick_station,
    product_classic_view.fc_title,
    product_classic_view.pricing_tier,
    product_classic_view.width_space,
    product_classic_view.height_space,
    product_classic_view.depth_space,
    product_classic_view.slotted_width,
    product_classic_view.tag_volume,
    product_classic_view.delivery_option,
    product_classic_view.tag_applied_by
   FROM erp.product_classic_view;
CREATE VIEW campus_87.pick_route AS
 SELECT pick_route.pick_date,
    pick_route.kiosk_id,
    pick_route.route_number,
    pick_route.driver_name,
    pick_route.route_time,
    pick_route.route_date,
    pick_route.delivery_order
   FROM inm.pick_route;
CREATE VIEW campus_87.label AS
 SELECT l.id,
    l.product_id,
    l.epc,
    l.is_generic_sku,
    l.kiosk_id,
    l.order_id,
    l.status,
    l.price,
    l.cost,
    l.time_created,
    l.time_added,
    l.time_updated
   FROM (pantry.label l
     JOIN pantry.kiosk k ON ((l.kiosk_id = k.id)))
  WHERE (k.campus_id = 87);
CREATE VIEW dw.last_15_months AS
 SELECT DISTINCT dim_date.year_month
   FROM dw.dim_date
  WHERE (dim_date.as_date < CURRENT_DATE)
  ORDER BY dim_date.year_month DESC
 LIMIT 15;
CREATE VIEW erp.v_kiosk_list AS
 SELECT k.id AS kid,
    k.title AS name,
        CASE
            WHEN ((k.archived)::smallint = 0) THEN 'Live'::text
            ELSE 'Archived'::text
        END AS status,
    concat_ws(', '::text, a.address1, (a.city)::text, concat_ws(' '::text, a.state, (a.zip)::text)) AS address,
    c.name AS clientname,
    k.campus_id AS campusid,
    round((date_part('epoch'::text, now()) - (COALESCE(lks."time", (0)::bigint))::double precision)) AS lasthb,
    lks.is_locked AS locked,
    lks.kiosk_temperature AS temperature,
    COALESCE(( SELECT 1
           FROM pantry.label l
          WHERE (((l.status)::text = 'ok'::text) AND (l.kiosk_id = k.id))
         LIMIT 1), 0) AS inventory,
    COALESCE(( SELECT 1
           FROM pantry."order" o
          WHERE (((o.state)::text = 'NonTrans'::text) AND (o.kiosk_id = k.id) AND ((o.created)::double precision > (date_part('epoch'::text, now()) - (1296000)::double precision)))
         LIMIT 1), 0) AS restocked,
    (((((((
        CASE
            WHEN (lks.rfid_0 < 100) THEN 1
            ELSE 0
        END +
        CASE
            WHEN (lks.rfid_1 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_2 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_3 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_4 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_5 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_6 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_7 < 100) THEN 1
            ELSE 0
        END) AS downants,
    (((((((
        CASE
            WHEN (lks.rfid_0 IS NULL) THEN 0
            ELSE 1
        END +
        CASE
            WHEN (lks.rfid_1 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_2 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_3 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_4 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_5 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_6 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_7 IS NULL) THEN 0
            ELSE 1
        END) AS totants,
    lks.kiosk_temperature_source AS tempsource,
    k.archived
   FROM (((erp.kiosk k
     LEFT JOIN erp.address a ON ((k.address_id = a.id)))
     LEFT JOIN erp.client c ON ((k.client_id = c.id)))
     LEFT JOIN pantry.last_kiosk_status lks ON ((lks.kiosk_id = k.id)));
CREATE VIEW inm.product_picking_order AS
 SELECT po.id AS product_id,
    (po.pick_order)::smallint AS pick_order
   FROM ( SELECT product.id,
            product.vendor,
            product.title,
            row_number() OVER (ORDER BY product.pick_station, product.vendor, product.title) AS pick_order
           FROM pantry.product
          WHERE ((product.campus_id = 87) AND (product.archived = 0))) po;
CREATE VIEW dw.last_30_days AS
 SELECT dim_date.date_id
   FROM dw.dim_date
  WHERE (dim_date.as_date < CURRENT_DATE)
  ORDER BY dim_date.date_id DESC
 LIMIT 30;
CREATE VIEW dw.non_byte_current_inventory AS
 WITH campus AS (
         SELECT 87 AS byte_campus
        )
 SELECT current_inventory.epc,
    current_inventory.kiosk_id,
    current_inventory.product_id,
    current_inventory.time_added,
    current_inventory.cost,
    current_inventory.price
   FROM dw.current_inventory
  WHERE (current_inventory.kiosk_campus_id <> ( SELECT campus.byte_campus
           FROM campus));
CREATE VIEW erp_test.kiosk_classic_view AS
 SELECT k.id,
    k.campus_id,
    k.serial,
    k.title,
    'fixme'::text AS address,
    addr.location_x,
    addr.location_y,
    hs.gcm_id,
    hs.app_vname,
    hs.app_vcode,
    k.archived,
    k.creation_time,
    k.deployment_time,
    ks.last_update,
    client.name AS client_name,
    ks.last_status,
    ks.last_inventory,
    k.name,
    ka.payment_start,
    ka.payment_stop,
    hs.features,
    ka.sales_tax,
    ka.default_fee_plan,
    addr.timezone,
    k.estd_num_users,
    NULL::text AS tags,
    k.publicly_accessible,
    '-1'::integer AS card_key_required,
    delivery_note.content AS delivery_insns,
    location_note.content AS fridge_loc_info,
    ka.byte_discount,
    ka.subsidy_info,
    ka.subsidy_notes,
    ka.max_subscription,
    hs.components,
    hs.email_receipt_subject,
    ops_note.content AS opt_team_notes,
    k.geo,
    'fixme'::text AS server_url,
    ka.subscription_amount,
    k.enable_reporting,
    k.enable_reporting AS enable_mornitoring,
    client.employees_num,
    kr.restrictions AS kiosk_restrictions
   FROM (((((((((erp.kiosk k
     JOIN erp.address addr ON ((k.id = addr.id)))
     JOIN erp.hardware_software hs ON ((k.id = hs.kiosk_id)))
     LEFT JOIN erp.kiosk_status ks ON ((k.id = ks.kiosk_id)))
     JOIN erp.client client ON ((k.client_id = client.id)))
     JOIN erp.kiosk_accounting ka ON ((k.id = ka.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'Delivery Instruction'::text))))) delivery_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = delivery_note.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'Location'::text))))) location_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = location_note.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'OPS'::text))))) ops_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = ops_note.kiosk_id)))
     LEFT JOIN ( SELECT pp.kiosk_id,
            string_agg(pd.value, ','::text) AS restrictions
           FROM (inm.kiosk_restriction_by_property pp
             JOIN inm.product_property_def pd ON ((pp.property_id = pd.id)))
          GROUP BY pp.kiosk_id) kr ON ((k.id = kr.kiosk_id)));
CREATE VIEW migration.kiosk_dest_to_match AS
 SELECT kiosk_classic_view.id,
    kiosk_classic_view.campus_id,
    kiosk_classic_view.serial,
    kiosk_classic_view.title,
    kiosk_classic_view.gcm_id,
    kiosk_classic_view.app_vname,
    kiosk_classic_view.app_vcode,
    kiosk_classic_view.archived,
    kiosk_classic_view.creation_time,
    kiosk_classic_view.deployment_time,
    kiosk_classic_view.last_update,
    kiosk_classic_view.last_status,
    kiosk_classic_view.last_inventory,
    kiosk_classic_view.kiosk_name,
    kiosk_classic_view.features,
    kiosk_classic_view.sales_tax,
    kiosk_classic_view.default_fee_plan,
    kiosk_classic_view.estd_num_users,
    kiosk_classic_view.publicly_accessible,
    kiosk_classic_view.delivery_insns,
    kiosk_classic_view.fridge_loc_info,
    kiosk_classic_view.byte_discount,
    kiosk_classic_view.subsidy_info,
    kiosk_classic_view.subsidy_notes,
    kiosk_classic_view.max_subscription,
    kiosk_classic_view.components,
    kiosk_classic_view.email_receipt_subject,
    kiosk_classic_view.ops_team_notes,
    kiosk_classic_view.geo,
    kiosk_classic_view.server_url,
    kiosk_classic_view.subscription_amount,
    kiosk_classic_view.enable_reporting
   FROM erp.kiosk_classic_view;
CREATE VIEW campus_87.pick_list AS
 SELECT pick_list.pick_date,
    pick_list.create_ts,
    pick_list.timeout_seconds,
    pick_list.finish_ts,
    pick_list.status,
    pick_list.log,
    pick_list.url
   FROM inm.pick_list;
CREATE VIEW campus_87.pick_rejection AS
 SELECT pick_rejection.pick_date,
    pick_rejection.route_date,
    pick_rejection.kiosk_id,
    pick_rejection.item_id,
    pick_rejection.item_type,
    pick_rejection.reason
   FROM inm.pick_rejection;
CREATE VIEW campus_87.product_property_def AS
 SELECT product_property_def.id,
    product_property_def.name,
    product_property_def.value
   FROM inm.product_property_def;
CREATE VIEW campus_87.route_stop AS
 SELECT route_stop.route_date_time,
    route_stop.driver_name,
    route_stop.location_name,
    route_stop.schedule_at,
    route_stop.longitude,
    route_stop.address,
    route_stop.latitude,
    route_stop.stop_number,
    route_stop.order_number,
    route_stop.location_number
   FROM inm.route_stop;
CREATE VIEW erp.v_campus_list AS
 SELECT campus.id,
    campus.title,
    campus.timezone,
    campus.archived,
    campus.id AS campusid
   FROM pantry.campus;
CREATE VIEW erp.v_kiosk_heartbeat AS
 SELECT ks.kiosk_id AS kid,
    ks."time" AS ts,
    ks.is_locked AS locked,
    round(ks.kiosk_temperature, 1) AS temperature,
    ks.kiosk_temperature_source AS tempsource,
    ks.rfid_0 AS rfid0,
    ks.rfid_1 AS rfid1,
    ks.rfid_2 AS rfid2,
    ks.rfid_3 AS rfid3,
    ks.rfid_4 AS rfid4,
    ks.rfid_5 AS rfid5,
    ks.rfid_6 AS rfid6,
    ks.rfid_7 AS rfid7,
    ks.battery_level AS battery,
        CASE
            WHEN (ks.power = 0) THEN 'ON'::text
            ELSE 'OFF'::text
        END AS power,
    ks.ip AS ipaddress,
    k.campus_id AS campusid
   FROM (pantry.kiosk_status ks
     JOIN pantry.kiosk k ON ((ks.kiosk_id = k.id)))
  ORDER BY ks."time" DESC;
CREATE VIEW erp.v_warehouse_inventory_entry AS
 SELECT p.id AS sku,
    pa.title AS name,
    ph.pick_station AS pickstation,
    ph.ws_case_size AS wscasesize
   FROM ((erp.product p
     JOIN erp.product_asset pa ON ((p.id = pa.product_id)))
     LEFT JOIN erp.product_handling ph ON ((p.id = ph.product_id)))
  WHERE ((p.campus_id = 87) AND ((p.archived)::smallint = 0))
  ORDER BY ph.pick_station, ( SELECT w.sort_order
           FROM inm.warehouse_inventory w
          WHERE ((p.id = w.product_id) AND (w.inventory_date = ( SELECT max(w2.inventory_date) AS max
                   FROM inm.warehouse_inventory w2
                  WHERE (p.id = w2.product_id)))));
CREATE VIEW mixalot.last_kiosk_status AS
 SELECT last_kiosk_status.id,
    last_kiosk_status.kiosk_id,
    last_kiosk_status.kiosk_temperature,
    last_kiosk_status.kiosk_temperature_count,
    last_kiosk_status.kit_temperature,
    last_kiosk_status.temperature_tags,
    last_kiosk_status.kiosk_temperature_source,
    last_kiosk_status.power,
    last_kiosk_status.battery_level,
    last_kiosk_status.rfid_0,
    last_kiosk_status.rfid_1,
    last_kiosk_status.rfid_2,
    last_kiosk_status.rfid_3,
    last_kiosk_status.rfid_4,
    last_kiosk_status.rfid_5,
    last_kiosk_status.rfid_6,
    last_kiosk_status.rfid_7,
    last_kiosk_status."time",
    last_kiosk_status.modem_signal_percentage,
    last_kiosk_status.modem_signal_type,
    last_kiosk_status.ip,
    last_kiosk_status.app_uptime,
    last_kiosk_status.system_uptime,
    last_kiosk_status.is_locked
   FROM pantry.last_kiosk_status;
CREATE VIEW campus_87.pick_allocation AS
 SELECT pick_allocation.pick_date,
    pick_allocation.route_date,
    pick_allocation.kiosk_id,
    pick_allocation.sku_id,
    pick_allocation.qty
   FROM inm.pick_allocation;
CREATE VIEW migration.kiosk_source_to_match AS
 SELECT kiosk.id,
    kiosk.campus_id,
    kiosk.serial,
    kiosk.title,
    kiosk.gcm_id,
    kiosk.app_vname,
    kiosk.app_vcode,
    kiosk.archived,
    kiosk.creation_time,
    kiosk.deployment_time,
    kiosk.last_update,
    kiosk.last_status,
    kiosk.last_inventory,
    kiosk.kiosk_name,
    kiosk.features,
    kiosk.sales_tax,
    kiosk.default_fee_plan,
    kiosk.estd_num_users,
    kiosk.publicly_accessible,
    kiosk.delivery_insns,
    kiosk.fridge_loc_info,
    kiosk.byte_discount,
    kiosk.subsidy_info,
    kiosk.subsidy_notes,
    kiosk.max_subscription,
    kiosk.components,
    kiosk.email_receipt_subject,
    kiosk.ops_team_notes,
    kiosk.geo,
    kiosk.server_url,
    kiosk.subscription_amount,
    kiosk.enable_reporting
   FROM pantry.kiosk;
CREATE VIEW campus_87.product AS
 SELECT product.id,
    product.title,
    product.description,
    product.tiny_description,
    product.short_description,
    product.medium_description,
    product.long_description,
    product.price,
    product.cost,
    product.shelf_time,
    product.campus_id,
    product.image,
    product.image_time,
    product.last_update,
    product.archived,
    product.taxable,
    product.allergens,
    product.attribute_names,
    product.categories,
    product.category_names,
    product.vendor,
    product.source,
    product.notes,
    product.total_cal,
    product.num_servings,
    product.ingredients,
    product.calories,
    product.proteins,
    product.sugar,
    product.carbohydrates,
    product.fat,
    product.consumer_category,
    product.ws_case_size,
    product.kiosk_ship_qty,
    product.ws_case_cost,
    product.pick_station,
    product.fc_title,
    product.pricing_tier,
    product.width_space,
    product.height_space,
    product.depth_space,
    product.slotted_width,
    product.tag_volume,
    product.delivery_option,
    product.tag_applied_by
   FROM pantry.product
  WHERE (product.campus_id = 87);
CREATE VIEW dw.byte_current_inventory AS
 WITH campus AS (
         SELECT 87 AS byte_campus
        )
 SELECT current_inventory.epc,
    current_inventory.kiosk_id,
    current_inventory.product_id,
    current_inventory.time_added,
    current_inventory.cost,
    current_inventory.price
   FROM dw.current_inventory
  WHERE ((current_inventory.kiosk_campus_id = ( SELECT campus.byte_campus
           FROM campus)) AND (current_inventory.enable_reporting = 1));
CREATE VIEW inm.sku_group AS
 SELECT sku_group.id,
    sku_group.fc_title,
    sku_group.unit_size
   FROM erp.sku_group;
CREATE VIEW campus_87.product_property AS
 SELECT product_property.product_id,
    product_property.property_id
   FROM inm.product_property;
CREATE VIEW dw.current_inventory AS
 SELECT current_inventory.epc,
    current_inventory.kiosk_id,
    current_inventory.product_id,
    current_inventory.time_added,
    current_inventory.cost,
    current_inventory.price,
    current_inventory.kiosk_campus_id,
    current_inventory.product_campus_id,
    current_inventory.enable_reporting
   FROM ( SELECT unique_epcs.epc,
            all_epc_data.kiosk_id,
            all_epc_data.product_id,
            to_timestamp((all_epc_data.time_added)::double precision) AS time_added,
            all_epc_data.cost,
            all_epc_data.price,
            all_epc_data.kiosk_campus_id,
            all_epc_data.product_campus_id,
            all_epc_data.enable_reporting
           FROM (( SELECT l.epc,
                    max(l.time_added) AS time_added
                   FROM ((pantry.label l
                     JOIN pantry.kiosk k ON ((k.id = l.kiosk_id)))
                     JOIN pantry.product p ON ((p.id = l.product_id)))
                  WHERE (((l.status)::text = 'ok'::text) AND (l.order_id IS NULL))
                  GROUP BY l.epc) unique_epcs
             LEFT JOIN ( SELECT l.epc,
                    l.product_id,
                    l.time_added,
                    p.cost,
                    p.price,
                    l.kiosk_id,
                    k.campus_id AS kiosk_campus_id,
                    p.campus_id AS product_campus_id,
                    k.enable_reporting
                   FROM ((pantry.label l
                     JOIN pantry.kiosk k ON ((k.id = l.kiosk_id)))
                     JOIN pantry.product p ON ((p.id = l.product_id)))
                  WHERE (((l.status)::text = 'ok'::text) AND (l.order_id IS NULL))) all_epc_data ON ((((unique_epcs.epc)::text = (all_epc_data.epc)::text) AND (unique_epcs.time_added = all_epc_data.time_added))))) current_inventory
  WHERE ((NOT ((current_inventory.epc)::text IN ( SELECT l.epc
           FROM (((pantry.label l
             JOIN pantry.kiosk k ON ((k.id = l.kiosk_id)))
             JOIN pantry.product p ON ((p.id = l.product_id)))
             JOIN pantry."order" o ON (((o.order_id)::text = (l.order_id)::text)))
          WHERE ((o.created >= (date_part('EPOCH'::text, ((now())::date - '1 mon'::interval)))::bigint) AND (o.created <= ((date_part('EPOCH'::text, ((now())::date + '1 mon'::interval)))::bigint - 1)) AND ((o.state)::text = ANY ((ARRAY['Placed'::character varying, 'Processed'::character varying, 'Refunded'::character varying, 'Adjusted'::character varying, 'Declined'::character varying, 'Error'::character varying])::text[])) AND ((l.status)::text = 'sold'::text) AND ((l.order_id)::text !~~ 'RE%'::text) AND (l.order_id IS NOT NULL))))) AND (NOT ((current_inventory.epc)::text IN ( SELECT l.epc
           FROM (((pantry.label l
             JOIN pantry.kiosk k ON ((k.id = l.kiosk_id)))
             JOIN pantry.product p ON ((p.id = l.product_id)))
             JOIN pantry."order" o ON (((o.order_id)::text = (l.order_id)::text)))
          WHERE ((o.created >= (date_part('EPOCH'::text, ((now())::date - '1 mon'::interval)))::bigint) AND (o.created <= (date_part('EPOCH'::text, ((now())::date + '1 mon'::interval)))::bigint) AND ((l.status)::text = ANY ((ARRAY['out'::character varying, 'lost'::character varying])::text[])) AND ((l.order_id)::text ~~ 'RE%'::text))))));
CREATE VIEW erp.v_client AS
 SELECT c.id AS cid,
    c.name,
    c.employees_num AS numemployees,
    c.industry,
    a.address1,
    a.address2,
    a.city,
    a.state,
    a.zip,
    ( SELECT count(*) AS count
           FROM erp.kiosk k
          WHERE (k.client_id = c.id)) AS numkiosks,
    ( SELECT min(ca.id) AS min
           FROM (erp.kiosk k
             JOIN pantry.campus ca ON ((k.campus_id = ca.id)))
          WHERE (k.client_id = c.id)) AS campusid
   FROM (erp.client c
     LEFT JOIN erp.address a ON ((c.address_id = a.id)));
CREATE VIEW dw.monthly_kpis AS
 SELECT dd.year_month,
    f.kiosk_id,
    f.product_id,
    sum(f.sales_amt) AS sales,
    sum(f.gross_margin_amt) AS gross_margin,
    sum(f.spoils_amt) AS spoils,
    sum(f.losses_amt) AS losses,
    ((COALESCE(sum(f.gross_margin_amt), (0)::numeric) - COALESCE(sum(f.spoils_amt), (0)::numeric)) - COALESCE(sum(f.losses_amt), (0)::numeric)) AS net_margin
   FROM ((dw.fact_daily_kiosk_sku_summary f
     JOIN dw.dim_date dd ON ((f.date_id = dd.date_id)))
     JOIN dw.last_15_months lfm ON ((dd.year_month = lfm.year_month)))
  WHERE (f.campus_id = 87)
  GROUP BY dd.year_month, f.kiosk_id, f.product_id;
CREATE VIEW erp.v_product AS
 SELECT p.id AS sku,
    pa.title AS name,
    pa.tiny_description AS tinydesc,
    pa.short_description AS shortdesc,
    pa.medium_description AS mediumdesc,
    pa.long_description AS longdesc,
    pa.image_url AS imageurl,
    pc.category_id AS consumercategory,
    ps.source,
    p.archived,
        CASE
            WHEN ((p.archived)::smallint = 0) THEN 'Live'::text
            ELSE 'Archived'::text
        END AS status,
    pn.num_servings AS numservings,
    pn.calories,
    pn.proteins,
    pn.sugar,
    pn.carbohydrates,
    pn.fat,
    pn.ingredients,
    pn.shelf_time AS shelflife,
    pn.sodium,
    ph.kiosk_ship_qty AS kioskshipqty,
    ph.width_space AS widthspace,
    ph.depth_space AS depthspace,
    ph.height_space AS heightspace,
    ph.pick_station AS pickstation,
    ph.ws_case_size AS wscasesize,
    ph.tag_volume AS tagvolume,
    ph.tag_applied_by AS tagappliedby,
    ph.tag_delivery_option AS deliveryoption,
    ph.preparation_instruction AS preparation,
    ph.rfid_tag_type AS labeltype,
    ph.include_microwave_warning AS microwavewarning,
    pp.ws_case_cost AS wscasecost,
    pp.price,
    ( SELECT string_agg(aggattr.value, '| '::text) AS string_agg
           FROM ( SELECT (((('{"name" : "'::text || ppd.name) || '", "value" : "'::text) || ppd.value) || '" }'::text) AS value
                   FROM (inm.product_property_def ppd
                     JOIN inm.product_property ppro ON (((ppd.id = ppro.property_id) AND (ppro.product_id = p.id))))) aggattr) AS attributes,
    p.brand,
    pa.description,
    p.sku_group_id AS skugroupid,
    pps.priority AS inmallocpriority,
    p.campus_id AS campusid
   FROM (((((((erp.product p
     LEFT JOIN erp.product_asset pa ON ((pa.product_id = p.id)))
     LEFT JOIN erp.product_category pc ON ((pc.product_id = p.id)))
     LEFT JOIN erp.product_sourcing ps ON ((ps.product_id = p.id)))
     LEFT JOIN erp.product_nutrition pn ON ((pn.product_id = p.id)))
     LEFT JOIN erp.product_handling ph ON ((ph.product_id = p.id)))
     LEFT JOIN erp.product_pricing pp ON ((pp.product_id = p.id)))
     LEFT JOIN inm.pick_priority_sku pps ON ((pps.sku_id = p.id)));
CREATE VIEW test.sync_qa_kiosk_before_2way AS
 SELECT kiosk_20190528.id,
    kiosk_20190528.campus_id,
    kiosk_20190528.serial,
    kiosk_20190528.title,
    kiosk_20190528.gcm_id,
    kiosk_20190528.app_vcode,
    kiosk_20190528.archived,
    kiosk_20190528.creation_time,
    kiosk_20190528.deployment_time,
    kiosk_20190528.kiosk_name,
    kiosk_20190528.features,
    kiosk_20190528.sales_tax,
    kiosk_20190528.default_fee_plan,
    kiosk_20190528.estd_num_users,
    kiosk_20190528.publicly_accessible,
    kiosk_20190528.delivery_insns,
    kiosk_20190528.fridge_loc_info,
    kiosk_20190528.byte_discount,
    kiosk_20190528.subsidy_info,
    kiosk_20190528.subsidy_notes,
    kiosk_20190528.max_subscription,
    kiosk_20190528.email_receipt_subject,
    kiosk_20190528.ops_team_notes,
    kiosk_20190528.geo,
    kiosk_20190528.server_url,
    kiosk_20190528.subscription_amount,
    kiosk_20190528.enable_reporting
   FROM test.kiosk_20190528;
CREATE VIEW campus_87.sku_group_control AS
 SELECT sku_group_control.sku_group_id,
    sku_group_control.default_level,
    sku_group_control.scale,
    sku_group_control.min_qty,
    sku_group_control.max_qty
   FROM inm.sku_group_control;
CREATE VIEW erp.v_client_list AS
 SELECT c.id AS cid,
    c.name,
    concat_ws(', '::text, a.address1, (a.city)::text, concat_ws(' '::text, a.state, (a.zip)::text)) AS address,
    ( SELECT count(*) AS count
           FROM erp.kiosk k
          WHERE (k.client_id = c.id)) AS numkiosks,
    ( SELECT min(ca.id) AS min
           FROM (erp.kiosk k
             JOIN pantry.campus ca ON ((k.campus_id = ca.id)))
          WHERE (k.client_id = c.id)) AS campusid
   FROM (erp.client c
     LEFT JOIN erp.address a ON ((c.address_id = a.id)));
CREATE VIEW campus_87.kiosk_restriction_by_product_ed AS
 SELECT kiosk_restriction_by_product_ed.kiosk_id,
    kiosk_restriction_by_product_ed.product_id,
    kiosk_restriction_by_product_ed.end_date,
    kiosk_restriction_by_product_ed.comment,
    kiosk_restriction_by_product_ed.record_ts
   FROM inm.kiosk_restriction_by_product_ed;
CREATE VIEW erp.v_kiosk_inventory AS
 SELECT k.campus_id AS campusid,
    l.kiosk_id AS kid,
    k.title AS kname,
    l.product_id AS sku,
    p.title AS pname,
    p.price,
    count(*) FILTER (WHERE ((l.status)::text = 'ok'::text)) AS inventory,
    count(*) FILTER (WHERE ((l.status)::text <> 'ok'::text)) AS sold
   FROM ((pantry.label l
     JOIN pantry.product p ON ((l.product_id = p.id)))
     JOIN pantry.kiosk k ON ((l.kiosk_id = k.id)))
  WHERE (((l.status)::text = 'ok'::text) OR (((l.time_updated)::double precision > (date_part('epoch'::text, now()) - (2592000)::double precision)) AND ((l.status)::text = ANY ((ARRAY['out'::character varying, 'sold'::character varying])::text[])) AND (l.order_id IS NOT NULL) AND ((l.order_id)::text !~~ 'RE%'::text)))
  GROUP BY k.campus_id, l.kiosk_id, k.title, l.product_id, p.title, p.price;
CREATE VIEW inm_test.kiosk_classic_view AS
 SELECT k.id,
    k.campus_id,
    k.serial,
    k.title,
    'fixme'::text AS address,
    addr.location_x,
    addr.location_y,
    hs.gcm_id,
    hs.app_vname,
    hs.app_vcode,
    k.archived,
    k.creation_time,
    k.deployment_time,
    ks.last_update,
    client.name AS client_name,
    ks.last_status,
    ks.last_inventory,
    k.name,
    ka.payment_start,
    ka.payment_stop,
    hs.features,
    ka.sales_tax,
    ka.default_fee_plan,
    addr.timezone,
    k.estd_num_users,
    NULL::text AS tags,
    k.publicly_accessible,
    '-1'::integer AS card_key_required,
    delivery_note.content AS delivery_insns,
    location_note.content AS fridge_loc_info,
    ka.byte_discount,
    ka.subsidy_info,
    ka.subsidy_notes,
    ka.max_subscription,
    hs.components,
    hs.email_receipt_subject,
    ops_note.content AS opt_team_notes,
    k.geo,
    'fixme'::text AS server_url,
    ka.subscription_amount,
    k.enable_reporting,
    k.enable_reporting AS enable_mornitoring,
    client.employees_num,
    kr.restrictions AS kiosk_restrictions
   FROM (((((((((erp.kiosk k
     JOIN erp.address addr ON ((k.id = addr.id)))
     JOIN erp.hardware_software hs ON ((k.id = hs.kiosk_id)))
     LEFT JOIN erp.kiosk_status ks ON ((k.id = ks.kiosk_id)))
     JOIN erp.client client ON ((k.client_id = client.id)))
     JOIN erp.kiosk_accounting ka ON ((k.id = ka.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'Delivery Instruction'::text))))) delivery_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = delivery_note.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'Location'::text))))) location_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = location_note.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'OPS'::text))))) ops_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = ops_note.kiosk_id)))
     LEFT JOIN ( SELECT pp.kiosk_id,
            string_agg(pd.value, ','::text) AS restrictions
           FROM (inm.kiosk_restriction_by_property pp
             JOIN inm.product_property_def pd ON ((pp.property_id = pd.id)))
          GROUP BY pp.kiosk_id) kr ON ((k.id = kr.kiosk_id)));
CREATE VIEW mixalot.inm_kiosk_projected_stock AS
 SELECT combined_stock.kiosk_id,
    combined_stock.kiosk_title,
    combined_stock.fc_title,
    sum(combined_stock.qty) AS count
   FROM ( SELECT l.kiosk_id,
            k.title AS kiosk_title,
            p.fc_title,
            count(l.epc) AS qty
           FROM ((pantry.label l
             JOIN pantry.product p ON ((l.product_id = p.id)))
             JOIN pantry.kiosk k ON ((l.kiosk_id = k.id)))
          WHERE (((l.status)::text ~~ 'ok'::text) AND (k.campus_id = 87) AND (k.enable_reporting = 1) AND (k.archived <> 1))
          GROUP BY l.kiosk_id, k.title, p.fc_title
        UNION ALL
         SELECT a.kiosk_id,
            k.title AS kiosk_title,
            p.fc_title,
            a.qty
           FROM (((inm.pick_allocation a
             LEFT JOIN pantry."order" o ON (((a.route_date = (to_timestamp((o.created)::double precision))::date) AND (a.kiosk_id = o.kiosk_id) AND ((o.payment_system)::text = 'Restocking'::text))))
             JOIN pantry.product p ON ((a.sku_id = p.id)))
             JOIN pantry.kiosk k ON ((a.kiosk_id = k.id)))
          WHERE ((a.route_date >= ('now'::text)::date) AND (a.pick_date = (('now'::text)::date - 1)) AND (o.kiosk_id IS NULL))
        UNION ALL
         SELECT pl.kiosk_id,
            pl.kiosk_title,
            p.fc_title,
            count(*) AS qty
           FROM (inm.get_spoilage_pull_list() pl(category, kiosk_id, kiosk_title, product_id, product_tile, epc)
             JOIN pantry.product p ON ((pl.product_id = p.id)))
          GROUP BY pl.kiosk_id, pl.kiosk_title, p.fc_title) combined_stock
  WHERE (combined_stock.fc_title IS NOT NULL)
  GROUP BY combined_stock.kiosk_id, combined_stock.kiosk_title, combined_stock.fc_title;
CREATE VIEW erp.v_transaction_list AS
 SELECT o.order_id AS id,
    o.campus_id AS campusid,
        CASE
            WHEN ("left"((o.order_id)::text, 2) = 'RE'::text) THEN 'Restock'::text
            ELSE 'Sale'::text
        END AS type,
    o.kiosk_id AS kid,
    o.kiosk_title AS kname,
    o.email,
    concat_ws(' '::text, btrim((o.first_name)::text), btrim((o.last_name)::text)) AS name,
    ( SELECT sum(label.price) AS sum
           FROM pantry.label
          WHERE (((label.order_id)::text = (o.order_id)::text) AND ((label.status)::text = ANY (ARRAY[('sold'::character varying)::text, ('out'::character varying)::text])))) AS total,
    o.amount_paid AS amount,
    concat_ws('/'::text, o.state, o.status) AS status,
    o.created AS ts,
    f.rate AS feedback,
    f.message AS feedbackmsg,
    o.receipt,
        CASE
            WHEN ((COALESCE(k.features, ''::character varying))::text ~~ '%no_vending%'::text) THEN 'N'::text
            ELSE 'Y'::text
        END AS paid
   FROM ((pantry."order" o
     LEFT JOIN pantry.feedback f ON (((o.order_id)::text = (f.order_id)::text)))
     LEFT JOIN pantry.kiosk k ON ((o.kiosk_id = k.id)));
CREATE VIEW test.sync_qa_kiosk_erp AS
 SELECT kiosk_classic_view.id,
    kiosk_classic_view.campus_id,
    kiosk_classic_view.serial,
    kiosk_classic_view.title,
    kiosk_classic_view.gcm_id,
    kiosk_classic_view.app_vcode,
    kiosk_classic_view.archived,
    kiosk_classic_view.creation_time,
    kiosk_classic_view.deployment_time,
    kiosk_classic_view.kiosk_name,
    kiosk_classic_view.features,
    kiosk_classic_view.sales_tax,
    kiosk_classic_view.default_fee_plan,
    kiosk_classic_view.estd_num_users,
    kiosk_classic_view.publicly_accessible,
    kiosk_classic_view.delivery_insns,
    kiosk_classic_view.fridge_loc_info,
    kiosk_classic_view.byte_discount,
    kiosk_classic_view.subsidy_info,
    kiosk_classic_view.subsidy_notes,
    kiosk_classic_view.max_subscription,
    kiosk_classic_view.email_receipt_subject,
    kiosk_classic_view.ops_team_notes,
    kiosk_classic_view.geo,
    kiosk_classic_view.server_url,
    kiosk_classic_view.subscription_amount,
    kiosk_classic_view.enable_reporting
   FROM erp.kiosk_classic_view;
CREATE VIEW campus_87.fact_daily_kiosk_sku_summary AS
 SELECT fact_daily_kiosk_sku_summary.campus_id,
    fact_daily_kiosk_sku_summary.product_id,
    fact_daily_kiosk_sku_summary.kiosk_id,
    fact_daily_kiosk_sku_summary.date_id,
    fact_daily_kiosk_sku_summary.sales_qty,
    fact_daily_kiosk_sku_summary.sales_amt,
    fact_daily_kiosk_sku_summary.cost_amt,
    fact_daily_kiosk_sku_summary.gross_margin_amt,
    fact_daily_kiosk_sku_summary.spoils_qty,
    fact_daily_kiosk_sku_summary.spoils_amt,
    fact_daily_kiosk_sku_summary.losses_qty,
    fact_daily_kiosk_sku_summary.losses_amt,
    fact_daily_kiosk_sku_summary.stocked_percent,
    fact_daily_kiosk_sku_summary.ip_commerce,
    fact_daily_kiosk_sku_summary.freedom_pay,
    fact_daily_kiosk_sku_summary.card_smith,
    fact_daily_kiosk_sku_summary.complimentary,
    fact_daily_kiosk_sku_summary.sales_after_discount
   FROM dw.fact_daily_kiosk_sku_summary
  WHERE (fact_daily_kiosk_sku_summary.campus_id = 87);
CREATE VIEW campus_87.pick_inventory AS
 SELECT pick_inventory.pick_date,
    pick_inventory.route_date,
    pick_inventory.kiosk_id,
    pick_inventory.sku_group_id,
    pick_inventory.qty
   FROM inm.pick_inventory;
CREATE VIEW inm.v_warehouse_order_delivered_totals AS
 SELECT warehouse_order_history.sku,
    sum(warehouse_order_history.amount_arrived) AS received_prod,
    warehouse_order_history.delivery_date
   FROM inm.warehouse_order_history
  GROUP BY warehouse_order_history.sku, warehouse_order_history.delivery_date;
CREATE VIEW campus_87.campus AS
 SELECT campus.id,
    campus.title,
    campus.timezone,
    campus.archived
   FROM pantry.campus
  WHERE (campus.id = 87);
CREATE VIEW campus_87.pick_demand AS
 SELECT pick_demand.pick_date,
    pick_demand.route_date,
    pick_demand.kiosk_id,
    pick_demand.sku_group_id,
    pick_demand.qty
   FROM inm.pick_demand;
CREATE VIEW campus_87.warehouse_inventory AS
 SELECT warehouse_inventory.inventory_date,
    warehouse_inventory.product_id,
    warehouse_inventory.stickered_units,
    warehouse_inventory.unstickered_units,
    warehouse_inventory.stickered_cases,
    warehouse_inventory.unstickered_cases,
    warehouse_inventory.spoiled_units,
    warehouse_inventory.units_per_case,
    warehouse_inventory.sort_order
   FROM inm.warehouse_inventory;
CREATE VIEW inm.kiosk_product_disabled AS
 SELECT rp.kiosk_id,
    pp.product_id
   FROM (inm.product_property pp
     JOIN inm.kiosk_restriction_by_property rp ON ((pp.property_id = rp.property_id)))
UNION
 SELECT kiosk_restriction_by_product.kiosk_id,
    kiosk_restriction_by_product.product_id
   FROM inm.kiosk_restriction_by_product
UNION
 SELECT kiosk_restriction_by_product_ed.kiosk_id,
    kiosk_restriction_by_product_ed.product_id
   FROM inm.kiosk_restriction_by_product_ed;
CREATE VIEW campus_87.dim_date AS
 SELECT dim_date.date_id,
    dim_date.as_date,
    dim_date.year_month,
    dim_date.month_num,
    dim_date.month_name,
    dim_date.month_short_name,
    dim_date.week_num,
    dim_date.day_of_year,
    dim_date.day_of_month,
    dim_date.day_of_week,
    dim_date.day_name,
    dim_date.day_short_name,
    dim_date.quarter,
    dim_date.year_quarter,
    dim_date.day_of_quarter,
    dim_date.year,
    dim_date.year_week
   FROM dw.dim_date;
CREATE VIEW dw.last_30_days_kpis AS
 SELECT f.kiosk_id,
    f.product_id,
    sum(f.sales_amt) AS sales,
    sum(f.gross_margin_amt) AS gross_margin,
    sum(f.spoils_amt) AS spoils,
    sum(f.losses_amt) AS losses,
    ((COALESCE(sum(f.gross_margin_amt), (0)::numeric) - COALESCE(sum(f.spoils_amt), (0)::numeric)) - COALESCE(sum(f.losses_amt), (0)::numeric)) AS net_margin,
    sum(f.cost_amt) AS cost
   FROM ((dw.fact_daily_kiosk_sku_summary f
     JOIN dw.dim_date dd ON ((f.date_id = dd.date_id)))
     JOIN dw.last_30_days ltd ON ((dd.date_id = ltd.date_id)))
  WHERE (f.campus_id = 87)
  GROUP BY f.kiosk_id, f.product_id;
CREATE VIEW campus_87.pick_priority_kiosk AS
 SELECT pick_priority_kiosk.kiosk_id,
    pick_priority_kiosk.priority,
    pick_priority_kiosk.start_date,
    pick_priority_kiosk.end_date,
    pick_priority_kiosk.comment
   FROM inm.pick_priority_kiosk;
CREATE VIEW erp.product_category_tag AS
 SELECT (unnest(string_to_array((product_categories.tags)::text, ','::text)))::integer AS tag_id,
    product_categories.cat_name,
    product_categories.subcat_name
   FROM pantry.product_categories;
CREATE VIEW erp.v_sku_group_list AS
 SELECT sg.id,
    sg.fc_title AS name,
    sg.unit_size AS unitsize,
    sgc.default_level AS defaultlevel,
    sgc.scale,
    sgc.min_qty AS minqty,
    sgc.max_qty AS maxqty
   FROM (inm.sku_group sg
     LEFT JOIN inm.sku_group_control sgc ON ((sg.id = sgc.sku_group_id)));
CREATE VIEW campus_87.kiosk_restriction_by_product AS
 SELECT kiosk_restriction_by_product.kiosk_id,
    kiosk_restriction_by_product.product_id,
    kiosk_restriction_by_product.end_date,
    kiosk_restriction_by_product.comment,
    kiosk_restriction_by_product.record_ts
   FROM inm.kiosk_restriction_by_product;
CREATE VIEW campus_87.kiosk_sku_group_manual_scale AS
 SELECT kiosk_sku_group_manual_scale.kiosk_id,
    kiosk_sku_group_manual_scale.sku_group_id,
    kiosk_sku_group_manual_scale.scale
   FROM inm.kiosk_sku_group_manual_scale;
CREATE VIEW campus_87.warehouse_order_history AS
 SELECT warehouse_order_history.time_added,
    warehouse_order_history.sku,
    warehouse_order_history.qty,
    warehouse_order_history.order_date,
    warehouse_order_history.delivery_date,
    warehouse_order_history.amount_arrived,
    warehouse_order_history.status,
    warehouse_order_history.warehouse_comment,
    warehouse_order_history.ordering_comment,
    warehouse_order_history.action,
    warehouse_order_history.purchase_order,
    warehouse_order_history.best_by_date
   FROM inm.warehouse_order_history;
CREATE VIEW erp.kiosk_classic_view AS
 SELECT k.id,
    k.campus_id,
    k.serial,
    k.title,
    concat_ws(', '::text, addr.address1, addr.address2, addr.city, concat_ws(' '::text, addr.state, addr.zip)) AS address,
    addr.location_x,
    addr.location_y,
    hs.gcm_id,
    hs.app_vname,
    hs.app_vcode,
    k.archived,
    k.creation_time,
    k.deployment_time,
    ks.last_update,
    client.name AS client_name,
    ks.last_status,
    ks.last_inventory,
    k.name AS kiosk_name,
    COALESCE(date_part('epoch'::text, ka.payment_start), (0)::double precision) AS payment_start,
    COALESCE(date_part('epoch'::text, ka.payment_stop), (0)::double precision) AS payment_stop,
    hs.features,
    ka.sales_tax,
    ka.default_fee_plan,
    addr.timezone,
    k.estd_num_users,
    NULL::text AS tags,
    k.publicly_accessible,
    card_key.cardkey_required,
    delivery_note.content AS delivery_insns,
    location_note.content AS fridge_loc_info,
    kiosk_contact.first_name AS contact_first_name,
    kiosk_contact.last_name AS contact_last_name,
    kiosk_contact.email AS contact_email,
    kiosk_contact.phone AS contact_phone,
    accounting_contact.email AS accounting_email,
    ka.byte_discount,
    ka.subsidy_info,
    ka.subsidy_notes,
    ka.max_subscription,
    NULL::text AS delivery_window_mon,
    NULL::text AS delivery_window_tue,
    NULL::text AS delivery_window_wed,
    NULL::text AS delivery_window_thu,
    NULL::text AS delivery_window_fri,
    NULL::text AS delivery_window_sat,
    NULL::text AS delivery_window_sun,
    ''::text AS notes,
    hs.components,
    hs.email_receipt_subject,
    ops_note.content AS ops_team_notes,
    k.geo,
    hs.server_url,
    ka.subscription_amount,
    k.enable_reporting,
    k.enable_reporting AS enable_monitoring,
    client.employees_num,
    kr.restrictions AS kiosk_restrictions
   FROM ((((((((((((erp.kiosk k
     LEFT JOIN erp.address addr ON ((k.address_id = addr.id)))
     LEFT JOIN erp.hardware_software hs ON ((k.id = hs.kiosk_id)))
     LEFT JOIN erp.kiosk_status ks ON ((k.id = ks.kiosk_id)))
     LEFT JOIN erp.client client ON ((k.client_id = client.id)))
     LEFT JOIN erp.kiosk_accounting ka ON ((k.id = ka.kiosk_id)))
     LEFT JOIN ( SELECT k_1.id AS kiosk_id,
            c.id,
            c.client_id,
            c.title,
            c.first_name,
            c.last_name,
            c.email,
            c.phone,
            c.contact_type
           FROM (((erp.kiosk k_1
             LEFT JOIN erp.kiosk_contact kc ON ((kc.kiosk_id = k_1.id)))
             JOIN erp.contact c ON ((c.id = kc.contact_id)))
             JOIN erp.global_attribute_def ga ON (((c.contact_type = ga.id) AND ((ga.value)::text = 'general'::text))))) kiosk_contact ON ((kiosk_contact.kiosk_id = k.id)))
     LEFT JOIN ( SELECT k_1.id AS kiosk_id,
            c.id,
            c.client_id,
            c.title,
            c.first_name,
            c.last_name,
            c.email,
            c.phone,
            c.contact_type
           FROM ((erp.kiosk k_1
             JOIN erp.contact c ON ((c.client_id = k_1.client_id)))
             JOIN erp.global_attribute_def ga ON (((c.contact_type = ga.id) AND ((ga.value)::text = 'accounting'::text))))) accounting_contact ON ((accounting_contact.kiosk_id = k.id)))
     LEFT JOIN ( SELECT kiosk_delivery_window.kiosk_id,
                CASE
                    WHEN (sum((kiosk_delivery_window.access_card_required)::smallint) > 0) THEN 1
                    ELSE 0
                END AS cardkey_required
           FROM erp.kiosk_delivery_window
          GROUP BY kiosk_delivery_window.kiosk_id
          ORDER BY kiosk_delivery_window.kiosk_id) card_key ON ((card_key.kiosk_id = k.id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'Delivery Instruction'::text))))) delivery_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = delivery_note.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'Location'::text))))) location_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = location_note.kiosk_id)))
     LEFT JOIN ( SELECT kn.id,
            kn.kiosk_id,
            kn.note_type,
            kn.content,
            kn.start_ts,
            kn.end_ts,
            ga.id,
            ga.name,
            ga.value,
            ga.note
           FROM (erp.kiosk_note kn
             JOIN erp.global_attribute_def ga ON (((kn.note_type = ga.id) AND ((ga.value)::text = 'OPS'::text))))) ops_note(id, kiosk_id, note_type, content, start_ts, end_ts, id_1, name, value, note) ON ((k.id = ops_note.kiosk_id)))
     LEFT JOIN ( SELECT pp.kiosk_id,
            string_agg(pd.value, ','::text) AS restrictions
           FROM (inm.kiosk_restriction_by_property pp
             JOIN inm.product_property_def pd ON ((pp.property_id = pd.id)))
          GROUP BY pp.kiosk_id) kr ON ((k.id = kr.kiosk_id)));
CREATE VIEW campus_87.kiosk_control AS
 SELECT kiosk_control.kiosk_id,
    kiosk_control.start_level,
    kiosk_control.min_level,
    kiosk_control.scale,
    kiosk_control.manual_multiplier
   FROM inm.kiosk_control;
CREATE VIEW erp.v_kiosk AS
 SELECT k.id AS kid,
    k.campus_id AS campusid,
    k.serial,
    k.client_id AS clientid,
    k.title,
    k.name,
    k.geo,
    k.address_id AS addressid,
    a.address1,
    a.address2,
    a.city,
    a.state,
    a.zip,
    a.location_x AS locationx,
    a.location_y AS locationy,
    a.timezone,
    k.publicly_accessible AS publiclyaccessible,
    k.location_type AS locationtype,
    k.estd_num_users AS estdnumusers,
    k.enable_reporting AS enablereporting,
    k.creation_time AS creationtime,
    k.deployment_time AS deploymenttime,
    k.deployment_status_id AS status,
    k.bank,
    k.archived,
    hs.server_url AS serverurl,
    hs.peekaboo_url AS peekaboourl,
    hs.app_vname AS appname,
    hs.app_vcode AS appvcode,
    hs.email_receipt_subject AS emailreceiptsubject,
    hs.features,
    ka.start_date AS accstartdate,
    ka.setup_fee AS setupfee,
    ka.byte_discount AS bytediscount,
    ka.subscription_amount AS subscriptionamt,
    ka.subsidy_info AS subsidyinfo,
    ka.subsidy_notes AS subsidyhoursnotes,
    ( SELECT kn1.content
           FROM erp.kiosk_note kn1
          WHERE ((kn1.note_type = 12) AND (kn1.kiosk_id = k.id))) AS deliveryinstructions,
    ( SELECT kn2.content
           FROM erp.kiosk_note kn2
          WHERE ((kn2.note_type = 13) AND (kn2.kiosk_id = k.id))) AS locationdetails,
    ( SELECT kn3.content
           FROM erp.kiosk_note kn3
          WHERE ((kn3.note_type = 93) AND (kn3.kiosk_id = k.id))) AS accessdetails,
    kc.start_level AS inmstartlevel,
    kc.min_level AS inmminlevel,
    kc.scale AS inmmanuallevelmultipler,
    ( SELECT string_agg(aggattr.value, '| '::text) AS string_agg
           FROM ( SELECT (((('{"name" : "'::text || ppd.name) || '", "value" : "'::text) || ppd.value) || '" }'::text) AS value
                   FROM (inm.product_property_def ppd
                     JOIN inm.kiosk_restriction_by_property krbp ON (((ppd.id = krbp.property_id) AND (krbp.kiosk_id = k.id))))) aggattr) AS restrictionsbyproperty,
    ( SELECT string_agg(aggattr.value, '| '::text) AS string_agg
           FROM ( SELECT (((('{"name" : "'::text || (gad.name)::text) || '", "value" : "'::text) || (gad.value)::text) || '" }'::text) AS value
                   FROM (erp.global_attribute_def gad
                     JOIN erp.kiosk_attribute ka_1 ON (((gad.id = ka_1.attribute_id) AND (ka_1.kiosk_id = k.id))))) aggattr) AS attributes,
    ( SELECT string_agg(aggattr.value, '| '::text) AS string_agg
           FROM ( SELECT (((((((('{"dow" : '::text || (kdw.dow)::smallint) || ', "begin" : "'::text) || to_char(((kdw.start_time)::time without time zone)::interval, 'HH24:MI'::text)) || '", "end" : "'::text) || to_char(((kdw.end_time)::time without time zone)::interval, 'HH24:MI'::text)) || '", "access" : '::text) || (kdw.access_card_required)::smallint) || ' }'::text) AS value
                   FROM erp.kiosk_delivery_window kdw
                  WHERE (kdw.kiosk_id = k.id)) aggattr) AS deliverywindow,
    ( SELECT string_agg(aggattr.value, '| '::text) AS string_agg
           FROM ( SELECT (krbp.product_id)::text AS value
                   FROM inm.kiosk_restriction_by_product krbp
                  WHERE (krbp.kiosk_id = k.id)
                  ORDER BY krbp.product_id) aggattr) AS restrictionsbysku,
    ( SELECT string_agg(aggattr.value, '| '::text) AS string_agg
           FROM ( SELECT (((('{"sgid" : '::text || (ksgms.sku_group_id)::smallint) || ', "scale" : '::text) || (ksgms.scale)::real) || ' }'::text) AS value
                   FROM inm.kiosk_sku_group_manual_scale ksgms
                  WHERE (ksgms.kiosk_id = k.id)
                  ORDER BY ksgms.sku_group_id) aggattr) AS manualscale,
    ppk.priority AS inmallocpriority,
    lks."time" AS lasthbts,
    lks.is_locked AS locked,
    lks.kiosk_temperature AS temperature,
    (((((((
        CASE
            WHEN (lks.rfid_0 < 100) THEN 1
            ELSE 0
        END +
        CASE
            WHEN (lks.rfid_1 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_2 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_3 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_4 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_5 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_6 < 100) THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (lks.rfid_7 < 100) THEN 1
            ELSE 0
        END) AS downants,
    (((((((
        CASE
            WHEN (lks.rfid_0 IS NULL) THEN 0
            ELSE 1
        END +
        CASE
            WHEN (lks.rfid_1 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_2 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_3 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_4 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_5 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_6 IS NULL) THEN 0
            ELSE 1
        END) +
        CASE
            WHEN (lks.rfid_7 IS NULL) THEN 0
            ELSE 1
        END) AS totants,
    lks.battery_level AS battery,
    lks.power,
    lks.ip AS ipaddress,
    lks.kiosk_temperature_source AS tempsource
   FROM ((((((erp.kiosk k
     LEFT JOIN erp.address a ON ((k.address_id = a.id)))
     LEFT JOIN erp.hardware_software hs ON ((k.id = hs.kiosk_id)))
     LEFT JOIN erp.kiosk_accounting ka ON ((k.id = ka.kiosk_id)))
     LEFT JOIN inm.kiosk_control kc ON ((k.id = kc.kiosk_id)))
     LEFT JOIN inm.pick_priority_kiosk ppk ON ((k.id = ppk.kiosk_id)))
     LEFT JOIN pantry.last_kiosk_status lks ON ((lks.kiosk_id = k.id)));
CREATE VIEW erp.v_tag_order_list AS
 SELECT lo.time_order AS ts,
    lo.id,
    lo.priority,
    p.id AS sku,
    p.title AS pname,
    lo.amount,
    lo.delivery_option AS delivery,
    p.campus_id AS campusid,
        CASE
            WHEN ((p.archived IS NOT NULL) AND (p.archived = 0)) THEN lo.status
            ELSE 'Cancelled'::character varying
        END AS status,
        CASE
            WHEN ((lo.priority)::text = 'high'::text) THEN 2
            ELSE
            CASE
                WHEN ((lo.priority)::text = 'medium'::text) THEN 1
                ELSE 0
            END
        END AS prioritynum
   FROM (pantry.label_order lo
     LEFT JOIN pantry.product p ON ((lo.product_id = p.id)));
CREATE VIEW erp_backup.product_classic_view AS
 SELECT p.id,
    pa.title,
    pa.description,
    pa.tiny_description,
    pa.short_description,
    pa.medium_description,
    pa.long_description,
    pp.price,
    pp.cost,
    pn.shelf_time,
    p.campus_id,
    COALESCE((pa.image)::integer, 0) AS image,
    pa.image_time,
    p.last_update,
    p.archived,
    pp.taxable,
    'fixme'::text AS allergens,
    'fixme'::text AS attribute_names,
    'fixme'::text AS categories,
    'fixme'::text AS category_names,
    ps.vendor,
    ps.source,
    'fixme'::text AS notes,
    pn.total_cal,
    pn.num_servings,
    pn.ingredients,
    pn.calories,
    pn.proteins,
    pn.sugar,
    pn.carbohydrates,
    pn.fat,
    'fixme'::text AS consumer_category,
    ph.ws_case_size,
    ph.kiosk_ship_qty,
    pp.ws_case_cost,
    ph.pick_station,
    p.fc_title,
    pp.pricing_tier,
    ph.width_space,
    ph.height_space,
    ph.depth_space,
    ph.slotted_width,
    ph.tag_volume,
    ph.tag_delivery_option AS delivery_option,
    ph.tag_applied_by
   FROM (((((erp.product p
     JOIN erp.product_asset pa ON ((p.id = pa.product_id)))
     JOIN erp.product_pricing pp ON ((p.id = pp.product_id)))
     JOIN erp.product_nutrition pn ON ((p.id = pn.product_id)))
     JOIN erp.product_sourcing ps ON ((p.id = ps.product_id)))
     JOIN erp.product_handling ph ON ((p.id = ph.product_id)));
CREATE VIEW migration.v_product AS
 SELECT p.id,
    pa.title,
    pa.description,
    pa.tiny_description,
    pa.short_description,
    pa.medium_description,
    pa.long_description,
    pp.price,
    pp.cost,
    pn.shelf_time,
    p.campus_id,
    COALESCE((pa.image)::integer, 0) AS "coalesce",
    pa.image_time,
    p.last_update,
    p.archived,
    pp.taxable,
    'fixme'::text AS allergens,
    'fixme'::text AS attribute_names,
    'fixme'::text AS categories,
    'fixme'::text AS category_names,
    ps.vendor,
    ps.source,
    'fixme'::text AS notes,
    pn.total_cal,
    pn.num_servings,
    pn.ingredients,
    pn.calories,
    pn.proteins,
    pn.sugar,
    pn.carbohydrates,
    pn.fat,
    'fixme'::text AS consumer_category,
    ph.ws_case_size,
    ph.kiosk_ship_qty,
    pp.ws_case_cost,
    ph.pick_station
   FROM (((((erp.product p
     JOIN erp.product_asset pa ON ((p.id = pa.product_id)))
     JOIN erp.product_pricing pp ON ((p.id = pp.product_id)))
     JOIN erp.product_nutrition pn ON ((p.id = pn.product_id)))
     JOIN erp.product_sourcing ps ON ((p.id = ps.product_id)))
     JOIN erp.product_handling ph ON ((p.id = ph.product_id)));
CREATE VIEW campus_87.kiosk AS
 SELECT kiosk.id,
    kiosk.campus_id,
    kiosk.serial,
    kiosk.title,
    kiosk.address,
    kiosk.location_x,
    kiosk.location_y,
    kiosk.gcm_id,
    kiosk.app_vname,
    kiosk.app_vcode,
    kiosk.archived,
    kiosk.creation_time,
    kiosk.deployment_time,
    kiosk.last_update,
    kiosk.client_name,
    kiosk.last_status,
    kiosk.last_inventory,
    kiosk.kiosk_name,
    kiosk.payment_start,
    kiosk.payment_stop,
    kiosk.features,
    kiosk.sales_tax,
    kiosk.default_fee_plan,
    kiosk.timezone,
    kiosk.estd_num_users,
    kiosk.tags,
    kiosk.publicly_accessible,
    kiosk.cardkey_required,
    kiosk.delivery_insns,
    kiosk.fridge_loc_info,
    kiosk.contact_first_name,
    kiosk.contact_last_name,
    kiosk.contact_email,
    kiosk.contact_phone,
    kiosk.accounting_email,
    kiosk.byte_discount,
    kiosk.subsidy_info,
    kiosk.subsidy_notes,
    kiosk.max_subscription,
    kiosk.delivery_window_mon,
    kiosk.delivery_window_tue,
    kiosk.delivery_window_wed,
    kiosk.delivery_window_thu,
    kiosk.delivery_window_fri,
    kiosk.delivery_window_sat,
    kiosk.delivery_window_sun,
    kiosk.notes,
    kiosk.components,
    kiosk.email_receipt_subject,
    kiosk.ops_team_notes,
    kiosk.geo,
    kiosk.server_url,
    kiosk.subscription_amount,
    kiosk.enable_reporting,
    kiosk.enable_monitoring,
    kiosk.employees_num,
    kiosk.kiosk_restrictions
   FROM pantry.kiosk
  WHERE (kiosk.campus_id = 87);
CREATE VIEW dw.last_15_weeks AS
 SELECT DISTINCT dim_date.year_week
   FROM dw.dim_date
  WHERE (dim_date.as_date < CURRENT_DATE)
  ORDER BY dim_date.year_week DESC
 LIMIT 15;
CREATE VIEW erp.v_kiosk_options AS
 SELECT gad.id,
    gad.name,
    gad.value,
    ''::text AS optionalvalue
   FROM erp.global_attribute_def gad
UNION
 SELECT ppd.id,
    'all_prod_prop_def'::text AS name,
    ppd.name AS value,
    ppd.value AS optionalvalue
   FROM inm.product_property_def ppd;
CREATE VIEW erp.v_warehouse_inventory AS
 SELECT wh.inventory_date AS invdate,
    wh.product_id AS sku,
    COALESCE((pa.title)::text, 'N/A'::text) AS name,
    wh.stickered_units AS stickeredunits,
    wh.stickered_cases AS stickeredcases,
    wh.unstickered_cases AS unstickeredcases,
    wh.spoiled_units AS spoiledunits,
    wh.units_per_case AS wscasesize
   FROM (inm.warehouse_inventory wh
     LEFT JOIN erp.product_asset pa ON ((wh.product_id = pa.product_id)))
  WHERE (((wh.stickered_units + wh.unstickered_cases) + wh.stickered_cases) > 0);
CREATE VIEW migration.sync_qa_product_source AS
 SELECT product.id,
    product.title,
    product.description,
    product.tiny_description,
    product.short_description,
    product.medium_description,
    product.long_description,
    product.price,
    product.cost,
    product.shelf_time,
    product.campus_id,
    product.image_time,
    product.last_update,
    product.archived,
    product.taxable,
    product.vendor,
    product.source,
    product.total_cal,
    product.num_servings,
    product.ingredients,
    product.calories,
    product.proteins,
    product.sugar,
    product.carbohydrates,
    product.fat,
    product.consumer_category,
    product.ws_case_size,
    product.kiosk_ship_qty,
    product.ws_case_cost,
    product.pick_station,
    product.fc_title,
    product.pricing_tier,
    product.width_space,
    product.height_space,
    product.depth_space,
    product.slotted_width,
    product.tag_volume,
    product.delivery_option,
    product.tag_applied_by
   FROM pantry.product;