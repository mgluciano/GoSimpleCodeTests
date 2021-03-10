SELECT  rl.start_ts,rl.status_code,rl.endpoint,rl.request_body,rl.request_headers,* FROM mixalot.request_log rl
WHERE rl.start_ts>'20210304' AND (rl.kiosk_id IS NULL OR rl.kiosk_id NOT IN ('3008','3009','3010','3011','3012'))
 ;
;
SELECT rl.start_ts,rl.endpoint,rl.status_code,rl.request_headers,rl.request_body,rl.status_code,rl.*
  FROM mixalot.request_log rl
  WHERE rl.start_ts >=  NOW()- interval '2 hours'
     AND rl.kiosk_id = '790'
     --AND rl.endpoint='/login';
     ;
SELECT *
FROM pantry.card d where d.email LIKE '%bytetech%';

 SELECT (EXTRACT(EPOCH FROM NOW())::bigint) as epoch,
    CONCAT((((floor(1 + random() * 3))+2)::text),((floor(100 + random() * 899))::text),((floor(100000 + random() * 899999))::text)) as "card_pan"
    ,CONCAT('Joe',((floor(100 + random() * 899))::text)) as first_name
    ,CONCAT('Tester',((floor(1000 + random() * 4899))::text))as last_name
    ,CONCAT('9011880B29A9A600',((floor(1000 + random() * 4899))::text)) as ksn
    ,CONCAT('FED69FA72D9E6E8E185E10801DF482E05BF946A10E121071CE5B9CA299A980D021BE1DFFCE8F3651EF6F5CBCA3A7897641E102FB3DAE',((floor(1000 + random() * 8999))::text)) as magne_print
    ,'61403000' as magne_print_status
    ,CONCAT('D3CADAA5A685929BD03E7AD96D08D115464A6E8E4062684DB54B6FE29B94C31B9B7FF3B003B',((floor(1000 + random() * 8999))::text)) as track2
    ,1 as validate
    ,(floor(1 + random() * 4)) as num_items
    ,(floor(0 + random() * 15)) as item1
    ,(floor(0 + random() * 15)) as item2
    ,(floor(0 + random() * 15)) as item3
    ,(floor(0 + random() * 15)) as item4;



SELECT * FROM pantry."order" o where o.order_id='790X214Y142P1';

SELECT rl.request_body_json::json->>'order_id',rl.request_body,rl.request_body_json,rl.*
FROM mixalot.request_log rl WHERE rl.status_code=200
AND rl.endpoint='/sync_transact'
AND rl.start_ts>'2021-03-01'
AND rl.kiosk_id='790';
	
SELECT CONCAT(LPAD(p."id"::text,8,'0'),'01',((EXTRACT(EPOCH FROM NOW())::bigint)::text),((floor(1000 + random() * 8999))::text)) as epc,p.price,p.id,p.title

  
  P.Card_pan = ""
      Card_pan string `json:"card_pan"`
      Card_type string `json:"card_type"`
      First_name string `json:"first_name"`
      Ksn string `json:"ksn"`
      Last_name string `json:"last_name"`
      Magne_print string `json:"magne_print"`
      Magne_print_status string `json:"magne_print_status"`
      Track2 string `json:"track2"`
      Validate int64 `json:"validate"`	
FROM pantry.card c
WHERE c.email like '%bytetech%';

    
SELECT * FROM pantry.card c where c."id">8575929;
    
/*
012345678901234567890123
000101430116152304831245
000085110116008592410763
*/
SELECT ((floor(100 + random() * 899))::text);    

    
SELECT CONCAT(LPAD(p."id"::text,8,'0'),'01',((EXTRACT(EPOCH FROM NOW())::bigint)::text),((floor(100 + random() * 899))::text)) as epc,p.price,p.id,p.title
FROM pantry.kiosk k, pantry.product p
WHERE k.campus_id=p.campus_id AND p.archived!=1
AND k.id=790
;    
    
SELECT server_url,id FROM pantry.kiosk WHERE id=790;
UPDATE pantry.kiosk SET server_url = 'https://kiosk-stg.bytefoods.com' WHERE server_url = 'https://kiosk-prod.bytefoods.com' AND "id" = 790;    

	SELECT p.shelf_time,p.campus_id,p."id",p.title FROM pantry.product p 
	WHERE id=8792;
INSERT INTO pantry.product("id", title, description, tiny_description, short_description, medium_description, long_description, price, "cost", shelf_time, campus_id, image, image_time, last_update, archived, taxable, allergens, attribute_names, categories, category_names, vendor, "source", notes, total_cal, num_servings, ingredients, calories, proteins, sugar, carbohydrates, fat, consumer_category, ws_case_size, kiosk_ship_qty, ws_case_cost, pick_station, fc_title, pricing_tier, width_space, height_space, depth_space, slotted_width, tag_volume, delivery_option, tag_applied_by, internal_id) VALUES (1188, 'Lasagna Bolognese', 'Bolognese, Pasta, Bechamel', null, null, null, null, 8.25, 0.00, 1, 12, 1, null, 1404933054, 0, 0, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'M', 'W', null);


SELECT * FROM pantry.kiosk k where k.serial='00001cd40ee2';	
	SELECT id,serial,archived FROM pantry.kiosk k where k."id"=790;
UPDATE pantry.kiosk SET serial = '00001cd40ee2' WHERE "id" = 790 AND serial = '00001cd40ee2BLAH';


SELECT l.product_id,l.order_id FROM pantry.label l
WHERE l.order_id IS NOT NULL
ORDER by l.id DESC
LIMIT 10;


ORDER BY id DESC LIMIT 10;

SELECT ( to_date('2021-03-04', 'YYYY-MM-DD') -  COALESCE(p.shelf_time,1000))::DATE 
FROM pantry.product p where p."id"=8792;
UPDATE pantry.product SET shelf_time = 10000000 WHERE "id" = 8792;

SELECT ( to_date('2021-03-04', 'YYYY-MM-DD') -  COALESCE(p.shelf_time,1000))::DATE 
FROM pantry.product p where p."id"=8792;

SELECT
( to_date('2021-03-04', 'YYYY-MM-DD') -  COALESCE(
    	CASE WHEN MAX(p.shelf_time) >10000 THEN 10000 
    	ELSE MAX(p.shelf_time) END
    	,1000))::DATE
FROM pantry.product p where p."id"=8792;

UPDATE pantry.product SET shelf_time = 2 WHERE "id" = 8792;

SELECT ( to_date('2021-03-04', 'YYYY-MM-DD') -  COALESCE(p.shelf_time,1000))::DATE 
FROM pantry.product p where p."id"=8792;



SELECT
    COALESCE(DATE_PART('day', to_timestamp(MIN(l.time_added)) -
    ( to_date('2021-03-04', 'YYYY-MM-DD') -  COALESCE(
    	CASE WHEN MAX(p.shelf_time) >10000 THEN 10000 
    	ELSE MAX(p.shelf_time) END
    	,1000))::DATE),0)expires_in
    FROM (SELECT MIN(time_updated) tu FROM pantry."label" where order_id='2011QMTBCI') tud,
    pantry."label" l
    LEFT JOIN pantry.product p ON p."id"=l.product_id
    WHERE l.kiosk_id=2011
    AND l.product_id=8792
    AND ( l.status ='ok'  OR (l.status='out' and tud.tu<=l.time_updated ))
    AND (to_date('2021-03-04', 'YYYY-MM-DD') -1) < to_timestamp(l.time_updated)
    ;
    

SELECT
    COALESCE(DATE_PART('day', to_timestamp(MIN(l.time_added)) -
    ( to_date('2021-03-04', 'YYYY-MM-DD') -  COALESCE(MAX(p.shelf_time),1000))::DATE),0)expires_in
    FROM (SELECT MIN(time_updated) tu FROM pantry."label" where order_id='2011QMTBCI') tud,
    pantry."label" l
    LEFT JOIN pantry.product p ON p."id"=l.product_id
    WHERE l.kiosk_id=2011
    AND l.product_id=8792
    AND ( l.status ='ok'  OR (l.status='out' and tud.tu<=l.time_updated ))
    AND (to_date('2021-03-04', 'YYYY-MM-DD') -1) < to_timestamp(l.time_updated);    