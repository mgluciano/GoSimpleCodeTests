--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 12.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: aws_dms; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA aws_dms;


ALTER SCHEMA aws_dms OWNER TO erpuser;

--
-- Name: campus_87; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA campus_87;


ALTER SCHEMA campus_87 OWNER TO erpuser;

--
-- Name: dw; Type: SCHEMA; Schema: -; Owner: muriel
--

CREATE SCHEMA dw;


ALTER SCHEMA dw OWNER TO muriel;

--
-- Name: erp; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA erp;


ALTER SCHEMA erp OWNER TO erpuser;

--
-- Name: erp_backup; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA erp_backup;


ALTER SCHEMA erp_backup OWNER TO erpuser;

--
-- Name: erp_test; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA erp_test;


ALTER SCHEMA erp_test OWNER TO erpuser;

--
-- Name: fnrenames; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA fnrenames;


ALTER SCHEMA fnrenames OWNER TO erpuser;

--
-- Name: inm; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA inm;


ALTER SCHEMA inm OWNER TO erpuser;

--
-- Name: inm_restore_0625; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA inm_restore_0625;


ALTER SCHEMA inm_restore_0625 OWNER TO erpuser;

--
-- Name: inm_test; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA inm_test;


ALTER SCHEMA inm_test OWNER TO erpuser;

--
-- Name: migration; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA migration;


ALTER SCHEMA migration OWNER TO erpuser;

--
-- Name: mixalot; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA mixalot;


ALTER SCHEMA mixalot OWNER TO erpuser;

--
-- Name: pantry; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA pantry;


ALTER SCHEMA pantry OWNER TO erpuser;

--
-- Name: test; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA test;


ALTER SCHEMA test OWNER TO erpuser;

--
-- Name: type; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA type;


ALTER SCHEMA type OWNER TO erpuser;

--
-- Name: util; Type: SCHEMA; Schema: -; Owner: erpuser
--

CREATE SCHEMA util;


ALTER SCHEMA util OWNER TO erpuser;

--
-- Name: dow; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.dow AS smallint
	CONSTRAINT dow_check CHECK (((VALUE >= 0) AND (VALUE <= 6)));


ALTER DOMAIN type.dow OWNER TO erpuser;

--
-- Name: email; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.email AS text
	CONSTRAINT email_check CHECK (((length(VALUE) <= 100) AND (VALUE ~ '^\w+@[0-9a-zA-Z_]+?\.[a-zA-Z]{2,3}$'::text)));


ALTER DOMAIN type.email OWNER TO erpuser;

--
-- Name: money_max_10k; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.money_max_10k AS numeric(6,2);


ALTER DOMAIN type.money_max_10k OWNER TO erpuser;

--
-- Name: money_max_1k; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.money_max_1k AS numeric(5,2);


ALTER DOMAIN type.money_max_1k OWNER TO erpuser;

--
-- Name: money_max_1m; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.money_max_1m AS numeric(8,2);


ALTER DOMAIN type.money_max_1m OWNER TO erpuser;

--
-- Name: phone; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.phone AS text
	CONSTRAINT phone_check CHECK ((length(VALUE) <= 40));


ALTER DOMAIN type.phone OWNER TO erpuser;

--
-- Name: tag_applied_by; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.tag_applied_by AS text
	CONSTRAINT tag_applied_by_check CHECK ((VALUE = ANY (ARRAY['V'::text, 'W'::text])));


ALTER DOMAIN type.tag_applied_by OWNER TO erpuser;

--
-- Name: tag_delivery_option; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.tag_delivery_option AS text
	CONSTRAINT tag_delivery_option_check CHECK ((VALUE = ANY (ARRAY['M'::text, 'P'::text])));


ALTER DOMAIN type.tag_delivery_option OWNER TO erpuser;

--
-- Name: text100; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text100 AS text
	CONSTRAINT text100_check CHECK ((length(VALUE) <= 100));


ALTER DOMAIN type.text100 OWNER TO erpuser;

--
-- Name: text10k; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text10k AS text
	CONSTRAINT text10k_check CHECK ((length(VALUE) <= 10000));


ALTER DOMAIN type.text10k OWNER TO erpuser;

--
-- Name: text1k; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text1k AS text
	CONSTRAINT text1k_check CHECK ((length(VALUE) <= 1000));


ALTER DOMAIN type.text1k OWNER TO erpuser;

--
-- Name: text200; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text200 AS text
	CONSTRAINT text200_check CHECK ((length(VALUE) <= 200));


ALTER DOMAIN type.text200 OWNER TO erpuser;

--
-- Name: text2k; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text2k AS text
	CONSTRAINT text2k_check CHECK ((length(VALUE) <= 2000));


ALTER DOMAIN type.text2k OWNER TO erpuser;

--
-- Name: text40; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text40 AS text
	CONSTRAINT text40_check CHECK ((length(VALUE) <= 100));


ALTER DOMAIN type.text40 OWNER TO erpuser;

--
-- Name: text400; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text400 AS text
	CONSTRAINT text400_check CHECK ((length(VALUE) <= 400));


ALTER DOMAIN type.text400 OWNER TO erpuser;

--
-- Name: text4k; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text4k AS text
	CONSTRAINT text4k_check CHECK ((length(VALUE) <= 4000));


ALTER DOMAIN type.text4k OWNER TO erpuser;

--
-- Name: text_name; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.text_name AS text
	CONSTRAINT text_name_check CHECK ((length(VALUE) <= 500));


ALTER DOMAIN type.text_name OWNER TO erpuser;

--
-- Name: zero_or_one; Type: DOMAIN; Schema: type; Owner: erpuser
--

CREATE DOMAIN type.zero_or_one AS smallint
	CONSTRAINT zero_or_one_check CHECK (((VALUE >= 0) AND (VALUE <= 1)));


ALTER DOMAIN type.zero_or_one OWNER TO erpuser;

--
-- Name: byte_losses(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
            --- Get discount for the entire kiosk, not a specific product.
            --- product_id needs to be NULL
            LEFT JOIN pantry.discount d
            ON k.id = d.kiosk_id
            AND d.product_id IS NULL
            WHERE (value != 100 OR value IS NULL)
            AND enable_reporting_ = 1
            AND kiosk_campus_id_ = BYTE_CAMPUS;
    END;
$$;


ALTER FUNCTION dw.byte_losses(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION byte_losses(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.byte_losses(beginning_date date, ending_date date) IS 'returns campus 87 losses';


--
-- Name: byte_restocks(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.byte_restocks(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: byte_sales(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
            --- This subquery is used to get the sum price of sold items in free kiosks
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
                --- Get discount for the entire kiosk, not a specific product.
                --- product_id needs to be NULL
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND enable_reporting_ = 1
                AND kiosk_campus_id_ = BYTE_CAMPUS
            UNION
            --- This subquery is used to get all lost items in free kiosks
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
                --- Get discount for the entire kiosk, not a specific product.
                --- product_id needs to be NULL
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND enable_reporting_ = 1
                AND kiosk_campus_id_ = BYTE_CAMPUS
            UNION
            --- This subquery is used to get all sold items in non-free kiosks
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
                --- Get discount for the entire kiosk, not a specific product.
                --- product_id needs to be NULL
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE (value != 100 OR value IS NULL)
                AND enable_reporting_ = 1
                AND kiosk_campus_id_ = BYTE_CAMPUS
            ) as all_kiosk_sale;
    END;
$$;


ALTER FUNCTION dw.byte_sales(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION byte_sales(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.byte_sales(beginning_date date, ending_date date) IS 'returns campus 87 sales';


--
-- Name: byte_spoils(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.byte_spoils(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION byte_spoils(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.byte_spoils(beginning_date date, ending_date date) IS 'returns campus 87 spoils';


--
-- Name: calculate_prorated_fee(numeric, date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) RETURNS TABLE(prorated_fee numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        --- This function is used to calculate prorated monthly fees if month_date =
        --- deployment_date. Otherwise, it returns fee.
        SELECT CASE WHEN date_trunc('month', month_date) = date_trunc('month', deployment_date)
            THEN ROUND(
                (
                    --- prorated fee = number of days live * daily fee
                    --- Number of days live = number of days in month - deployment day + 1
                    (   --- number days in month
                        (DATE_PART('days', DATE_TRUNC('month', month_date)
                            + '1 MONTH - 1 DAY'::INTERVAL))
                        --- deployment day
                        -  (EXTRACT(DAY FROM deployment_date))
                        + 1
                    )
                    *
                    --- daily fee = monthly fee / number of days in month
                    (
                         fee
                         /
                         --number of days in month
                         DATE_PART('days', DATE_TRUNC('month', month_date)
                            + '1 MONTH - 1 DAY'::INTERVAL)
                    )
                )::numeric, 2)
             ELSE fee
             END AS prorated_fee;
    END;
$$;


ALTER FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) OWNER TO erpuser;

--
-- Name: clear_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

CREATE FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    --- Delete record for given range
    DELETE FROM dw.fact_daily_kiosk_sku_summary 
    WHERE date_id >= TO_CHAR(beginning_date, 'YYYYMMDD')::int 
    AND date_id <= TO_CHAR(ending_date, 'YYYYMMDD')::int ;
END;
$$;


ALTER FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION clear_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'clears dw.fact_daily_kiosk_sku_summary';


--
-- Name: clear_fact_monthly_kiosk_summary(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    --- Delete record for specified month
    DELETE FROM dw.fact_monthly_kiosk_summary 
    WHERE date_id = TO_CHAR(date_trunc('month', month_date ), 'YYYYMMDD')::int;
END;
$$;


ALTER FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) OWNER TO erpuser;

--
-- Name: FUNCTION clear_fact_monthly_kiosk_summary(month_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) IS 'clears dw.fact_monthly_kiosk_summary';


--
-- Name: export_consolidated_remittance(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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
                --- new tag fee
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
                    --- Per our meeting from https://bytetechnology.atlassian.net/browse/ENG-2291,
                    --- we decided to take the max tag_price for each campus.
                    --- All kiosks are supposed to have the same tag_price within
                    --- a campus, but that's not the case due to data entry errors.
                    max(er.tag_price) as tag_price,
                    sum(er.manual_adjustment) as manual_adjustment,
                    STRING_AGG(er.details, ' | ') as details
                    FROM dw.export_remittance(month_date) er
                    GROUP BY er.name, er.campus_id, er.campus_title, er.email
                ) r
                ON r.campus_id = c.campus_id
                LEFT JOIN
                --- Get the tag pricing / number of tags obtained
                --- for each campus using new Tags UI
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


ALTER FUNCTION dw.export_consolidated_remittance(month_date date) OWNER TO erpuser;

--
-- Name: export_feedback(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_feedback(beginning_date date, ending_date date) RETURNS TABLE(order_id character varying, created timestamp with time zone, first_name character varying, last_name character varying, amount_list_price numeric, amount_paid numeric, campus_id bigint, kiosk_id bigint, kiosk_title character varying, geo character varying, message character varying, rate bigint, taste bigint, freshness bigint, variety bigint, value bigint, product_id_list text, product_title_list text)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        --- This query is used to get feedback for a given date range.
        --- The originial query is found
        --- https://github.com/PantryLabs/PantryWeb/blob/8bc2c5281de13cabfc2ad73fcec837d162bbb8b3/models/feedback.js#L55
        --- SEE ENG-1989
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


ALTER FUNCTION dw.export_feedback(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION export_feedback(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.export_feedback(beginning_date date, ending_date date) IS 'returns feedback info';


--
-- Name: export_kiosk_performance(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) RETURNS TABLE(kiosk_id bigint, kiosk_title character varying, campus_id bigint, campus_title character varying, geo character varying, client_name character varying, byte_discount character varying, subsidy_info character varying, subscription_amount numeric, amount_list_price numeric, credit_card numeric, food_cost numeric, spoilage numeric, losses numeric, margin numeric, deliveries numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        --- This query is used to give kiosk information for the given date range
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
            --- This subquery is used to get the number of deliveries for the given day
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


ALTER FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: export_kiosk_status(bigint); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_kiosk_status(kiosk_number bigint) RETURNS TABLE(kiosk_id_ bigint, geo_ character varying, kiosk_temperature_ numeric, kiosk_temperature_count_ smallint, kiosk_temperature_source_ character varying, temperature_tags_ character varying, kit_temperature_ numeric, power_ integer, battery_level_ smallint, rfid_0_ integer, rfid_1_ integer, rfid_2_ integer, rfid_3_ integer, rfid_4_ integer, rfid_5_ integer, rfid_6_ integer, rfid_7_ integer, modem_signal_percentage_ smallint, modem_signal_type_ character varying, ip_ character varying, time_ timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
    --- This query is used to get the last 3 months worth of status.
    --- This original query is found here
    --- https://github.com/PantryLabs/PantryWeb/blob/8bc2c5281de13cabfc2ad73fcec837d162bbb8b3/models/kiosk-export.js#L10
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


ALTER FUNCTION dw.export_kiosk_status(kiosk_number bigint) OWNER TO erpuser;

--
-- Name: FUNCTION export_kiosk_status(kiosk_number bigint); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.export_kiosk_status(kiosk_number bigint) IS 'returns kiosk status info';


--
-- Name: export_licensee_fee(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_licensee_fee(month_date date) RETURNS TABLE(kiosk_id bigint, kiosk_title character varying, campus_id bigint, campus_title character varying, deployment_date date, fee_plan_name text, licensing_subscription_fee numeric, tag_price numeric, payment_processing_rate character varying, connectivity_fee numeric, prepaid_number_of_months bigint, prepaid_until character varying)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        --- This query is used to get licensee fee summary
        --- SEE ENG-2103
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


ALTER FUNCTION dw.export_licensee_fee(month_date date) OWNER TO erpuser;

--
-- Name: export_losses(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_losses(beginning_date date, ending_date date) RETURNS TABLE(as_date date, campus_id integer, campus_title character varying, kiosk_id bigint, kiosk_title character varying, product_id bigint, product_title character varying, menu_category character varying, product_group character varying, product_cost numeric, losses_qty integer, losses_cost numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        --- This query returns losses for the selected dates
        SELECT dd.as_date,
        fd.campus_id,
        c.title as campus_title,
        fd.kiosk_id,
        k.title as kiosk_title,
        fd.product_id,
        p.title as product_title,
        p.consumer_category as menu_category,
        p.fc_title as product_group,
        --- Cost is the current product cost
        p.cost as product_cost,
        fd.losses_qty,
        --- losses_amt is (product cost at the time of purchase) * (losses quantity).
        --- Note that losses_amt might not always equal (current product cost) * (losses quantity)
        --- if the product cost was different at the time of purchase.
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


ALTER FUNCTION dw.export_losses(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: export_remittance(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_remittance(month_date date) RETURNS TABLE(name character varying, email character varying, account_type text, kiosk_id bigint, kiosk_title character varying, campus_id bigint, campus_title character varying, deployment_time timestamp with time zone, payment_start timestamp with time zone, client_type text, sales_after_discount numeric, sales_list_price numeric, credit_card numeric, monthly_lease numeric, connectivity_fee numeric, payment_processing_fee numeric, manual_adjustment numeric, prepaid_until character varying, freedom_pay numeric, complimentary numeric, tag_price numeric, details text)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        --- This query is used to get remittance info by kiosk
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
            -- The following subquery is used to get users' info.
            -- Because there are duplicated users per each first_name, last_name, role_id, group_id
            --- combination, we filter for the most recent user created with the highest role.
            LEFT JOIN (SELECT ranked_duplicated_users.name,
                user_id,
                ranked_duplicated_users.email,
                group_id
                -- Use the window function to group duplicate user names (partition by g.name)
                -- and rank them by descending role_id and descending date_registered
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
                -- filter out all but the top rank
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


ALTER FUNCTION dw.export_remittance(month_date date) OWNER TO erpuser;

--
-- Name: export_spoilage(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_spoilage(beginning_date date, ending_date date) RETURNS TABLE(as_date date, campus_id integer, campus_title character varying, kiosk_id bigint, kiosk_title character varying, product_id bigint, product_title character varying, menu_category character varying, product_group character varying, product_cost numeric, spoils_qty integer, spoilage_cost numeric)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        --- This query returns spoilage for the selected dates
        SELECT dd.as_date,
            fd.campus_id,
            c.title as campus_title,
            fd.kiosk_id,
            k.title as kiosk_title,
            fd.product_id,
            p.title as product_title,
            p.consumer_category as menu_category,
            p.fc_title as product_group,
            --- Cost is the current product cost
            p.cost as product_cost,
            fd.spoils_qty,
            --- spoils_amt is (product cost at the time of purchase) * (spoils quantity).
            --- Note that spoils_amt might not always equal (current product cost) * (spoils quantity)
            --- if the product cost was different at the time of purchase.
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


ALTER FUNCTION dw.export_spoilage(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: export_transaction(timestamp without time zone, timestamp without time zone, character varying); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) RETURNS TABLE(order_id character varying, date_time timestamp with time zone, state character varying, campus_title character varying, campus_id bigint, client_name character varying, kiosk_title character varying, kiosk_id bigint, uid bigint, email character varying, customer_first_name character varying, customer_last_name character varying, vendor character varying, product_tile character varying, sku bigint, menu_category character varying, product_group character varying, qty bigint, total_list_price numeric, price_after_discounts numeric, total_price_after_discounts numeric, total_coupon_value numeric, total_cost numeric, margin numeric, credit_card text, credit_card_number text, approval_code character varying, geo character varying, coupon_code character varying, coupon_campaign character varying, time_door_closed bigint, time_door_opened bigint)
    LANGUAGE plpgsql
    AS $_$
    BEGIN
        RETURN QUERY
        --- This query returns a list of transactions for the selected date range
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
            --- Price after discount = l.price - discounts
            --- Set price to zero if it is negative.
            GREATEST(COALESCE((l.price),0) - COALESCE((CASE WHEN real_discount != 0 AND real_discount
                IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
                price_after_discounts,
            --- Total price after discount. For example, if more than 1 of the item was purchased
            --- Set total to zero if it is negative.
            GREATEST(COALESCE(sum(l.price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
                total_after_discounts,
            --- Total $ coupon value
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

--
-- Name: export_unconsolidated_remittance(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.export_unconsolidated_remittance(month_date date) OWNER TO erpuser;

--
-- Name: insert_hb_stat_in_daily_byte_foods_summary(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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
            --- This subquery is used to get the number of heart beats per kiosk
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


ALTER FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'inserts heart beat info in dw.fact_daily_byte_foods_summary';


--
-- Name: insert_in_monthly_kiosk_summary(date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
                --- Get all kiosks
                FROM (SELECT id as kiosk_id,
                    campus_id
                    FROM pantry.kiosk
                ) as kiosks
                --- The following query is used to get sales totals from the daily fact table at
                --- a kiosk level
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
                --- The following subquery is used to get manual adjustments at a kiosk level
                LEFT JOIN (SELECT kiosk_id,
                    campus_id,
                    sum(sum) as manual_adjustment,
                    --- A list of all manual adjustments along with the reasons and kiosk
                    STRING_AGG( CASE WHEN sum IS NOT NULL
                        THEN CONCAT(
                            --- Add a $ in front of the sum. If it's a negative number, add the
                            --- sign after the "-"
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
                    --- date in pantry.manual_adjustment is not an actual date. It’s a period
                    --- accounting numbers were calculated for with format: "YYYY-MM-H".
                    --- H can be either "1" for the first half of month and "2" for the entire month
                    WHERE date = TO_CHAR(date_trunc('month', month_date::date) + interval '1' day,
                        'YYYY-MM-fmDD')
                    AND ma.archived = 0
                    GROUP BY campus_id, kiosk_id
                ) as manual_adjust
                ON manual_adjust.kiosk_id = kiosks.kiosk_id
                --- The following subquery is used to get the monthly_lease and connectivity
                --- at a kiosk level for all kiosks that were deployed before or at
                --- the remittance month.
                LEFT JOIN (SELECT deployed_kiosks.kiosk_id,
                    deployed_kiosks.campus_id,
                    COALESCE(monthly_lease, 0) as monthly_lease,
                    COALESCE(connectivity, 0) as connectivity
                    --- ALl kiosks deployed at or before the remittance month
                    FROM (SELECT id as kiosk_id,
                        campus_id
                        FROM pantry.kiosk
                        WHERE to_timestamp(deployment_time)::date <=
                        --- the last day of the given month
                        (date_trunc('month', month_date) + interval '1 month'
                            - interval '1 day')::date
                    ) as deployed_kiosks
                    LEFT JOIN (SELECT kiosk_id,
                        campus_id,
                        monthly_lease,
                        connectivity
                        FROM (SELECT a.campus_id,
                            kiosk_id,
                            --- If prepaid = 0, get the monthly_lease. Prepaid represents the amount
                            --- of months  already paid for at the time. If prepaid is greater than
                            --- 1, then the client pays $0 for the given month. The monthly_lease
                            --- obtained from dw.calculate_prorated_fee returns fee_lease if the
                            --- deployment_time != the current month, otherwise, it calculates
                            --- and returns the prorated fee based on deployment_time.
                            (SELECT prorated_fee FROM dw.calculate_prorated_fee(fee_lease,
                                month_date, to_timestamp(k.deployment_time)::date))
                                as monthly_lease,
                            --- If the deployment date was this month, prorate the connectivity fee,
                            --- if not, give the normal fee
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
                --- The following subquery is used to get other kiosk related fees and info
                LEFT JOIN (SELECT kiosk_id,
                    a.campus_id,
                    r.name as fee_plan_name,
                    a.prepaid as prepaid_number_of_months,
                    --- licensing_subscription_fee is the set regular licensing fee for each kiosk.
                    --- This is different from monthly_lease which is the re-calculated licensing
                    --- fee for a given month. This means that the monhtly_lease
                    --- can be different for any two given months while the
                    --- licensing_subscription_fee is set.
                    fee_lease as licensing_subscription_fee,
                    r.fee_tags as tag_price,
                    CONCAT(ROUND(fee_ipc * 100, 2), '%') as payment_processing_rate,
                    --- prepaid_until = month_date + the number of months left
                    --- a.prepaid represents the number of months paid in advance, including the
                    --- current month.
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
                    --- date in pantry.accounting is not an actual date. It’s a period accounting
                    --- numbers  were calculated for with format: "YYYY-MM-H".
                    --- H can be either "1" for the first half of month and "2" for the entire month
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

--
-- Name: FUNCTION insert_in_monthly_kiosk_summary(month_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.insert_in_monthly_kiosk_summary(month_date date) IS 'inserts key metrics in dw.fact_monthly_kiosk_summary';


--
-- Name: insert_inv_snapshot_in_daily_byte_foods_summary(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'inserts 10am inventory snapshot in dw.fact_daily_byte_foods_summary';


--
-- Name: insert_losses_in_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
        --- Non-Byte losses
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


ALTER FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts losses in dw.fact_daily_kiosk_sku_summary';


--
-- Name: insert_sales_after_discount_in_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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
                --- The following subquery is used to get the total amount of $ customers paid. Unlike
                --- sales_amount_list_price, which is the price tag on an item, this query factors in all discounts
                --- and coupons applied to a sale. The price on the label table already includes all
                --- coupons. Discounts need to be subtracted from the total label.price.
                --- In addition, this query only filters for order states
                --- ('Placed', 'Processed' ,'Refunded' ) and label status 'sold' OR order state 'PriceFinalized'
                --- and payment_system  'Complimentary'. The reason is because
                --- those are the only orders that generated a payment. Amount_list_price on the other
                --- hand, includes other states regardless of if we received a payment or not.
                --- Also see ENG-1922 and
                --- https://docs.google.com/presentation/d/1A9xYMop8u1NR6O5DmcYK8asauV9R-0eiXNiyKpUb6dQ/edit#slide=id.p
                FROM (SELECT (TO_CHAR(date_, 'YYYYMMDD'))::int AS date_id,
                    kiosk_id,
                    product_id,
                    kiosk_campus_id,
                    payment_system,

                    -- make sure price after discount is at least zero
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
                        --- Between the first second of the month and the last second of the month
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

--
-- Name: FUNCTION insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts sales after discount in dw.fact_daily_kiosk_sku_summary';


--
-- Name: insert_sales_daily_byte_foods_summary(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'inserts sales in dw.fact_daily_byte_foods_summary';


--
-- Name: insert_sales_in_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
        --- Non-Byte sales
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


ALTER FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts sales in dw.fact_daily_kiosk_sku_summary';


--
-- Name: insert_sales_monthly_byte_foods_summary(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.insert_sales_monthly_byte_foods_summary(month_date date) OWNER TO erpuser;

--
-- Name: insert_spoils_in_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
        --- Non-Byte spoilage
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


ALTER FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts spoils in dw.fact_daily_kiosk_sku_summary';


--
-- Name: insert_stock_in_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
    --- NEEDS TO BE CHANGED if the frequency of running inventory_history.js changes 
--- See https://github.com/PantryLabs/Utilities/blob/develop/cron/scripts.crontab
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
 --- Inventory history is recorded every hour so there’s a total of 24 readings a day.
 --- The stocked percentage is calculated by counting the number of times an item
 --- appeared in a kiosk, and dividing that number by INVENTORY_HISTORY_FREQUENCY.
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


ALTER FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'inserts stock ins in dw.fact_daily_kiosk_sku_summary';


--
-- Name: losses(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
                --- There are duplicated EPCs. This subquery selects the most recent distinct out EPC
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
                    --- Get the cost from label, if NULL, get cost from product_history, if NULL get cost
                    --- from product, if NULL get 0. label has the most accurate cost info for
                    --- the specific epc, then product_history, then product.
                    COALESCE(l.cost, ph.cost, p.cost,0) as cost,
                    --- Get the price from product_history, if NULL, get price from label, if NULL get price
                    --- from product, if NULL get 0. product_history has the most accurate price info for
                    --- that time, then label, then product.
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


ALTER FUNCTION dw.losses(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION losses(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.losses(beginning_date date, ending_date date) IS 'returns losses';


--
-- Name: non_byte_losses(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
            --- Get discount for the entire kiosk, not a specific product.
            --- product_id needs to be NULL
            LEFT JOIN pantry.discount d
            ON k.id = d.kiosk_id
            AND d.product_id IS NULL
            WHERE (value != 100 OR value IS NULL)
            AND kiosk_campus_id_ != BYTE_CAMPUS;
    END;
$$;


ALTER FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION non_byte_losses(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) IS 'returns non campus 87 losses';


--
-- Name: non_byte_restocks(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.non_byte_restocks(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: non_byte_sales(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
            --- This subquery is used to get the sum price of sold items in free kiosks
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
                --- Get discount for the entire kiosk, not a specific product.
                --- product_id needs to be NULL
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND kiosk_campus_id_ != BYTE_CAMPUS
            UNION
            --- This subquery is used to get all lost items in free kiosks
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
                --- Get discount for the entire kiosk, not a specific product.
                --- product_id needs to be NULL
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE value = 100
                AND kiosk_campus_id_ != BYTE_CAMPUS
            UNION
            --- This subquery is used to get all sold items in non-free kiosks
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
                --- Get discount for the entire kiosk, not a specific product.
                --- product_id needs to be NULL
                LEFT JOIN pantry.discount d
                ON k.id = d.kiosk_id
                AND d.product_id IS NULL
                WHERE (value != 100 OR value IS NULL)
                AND kiosk_campus_id_ != BYTE_CAMPUS
            ) as all_kiosk_sale;
    END;
$$;


ALTER FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION non_byte_sales(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) IS 'returns non campus 87 sales';


--
-- Name: non_byte_spoils(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

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


ALTER FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION non_byte_spoils(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) IS 'returns non campus 87 spoils';


--
-- Name: refresh_daily_byte_foods_summary(date, date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date, ending_date);
        PERFORM dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date, ending_date);
        PERFORM dw.insert_sales_daily_byte_foods_summary(beginning_date, ending_date);
    END;
$$;


ALTER FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: FUNCTION refresh_daily_byte_foods_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) IS 'updates dw.fact_daily_byte_foods_summary';


--
-- Name: refresh_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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


ALTER FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) IS 'updates dw.fact_daily_kiosk_sku_summary';


--
-- Name: refresh_dim_kiosk(); Type: FUNCTION; Schema: dw; Owner: muriel
--

CREATE FUNCTION dw.refresh_dim_kiosk() RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        --- Refresh kiosks
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


ALTER FUNCTION dw.refresh_dim_kiosk() OWNER TO muriel;

--
-- Name: FUNCTION refresh_dim_kiosk(); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.refresh_dim_kiosk() IS 'updates dw.dim_kiosk';


--
-- Name: refresh_dim_product(); Type: FUNCTION; Schema: dw; Owner: muriel
--

CREATE FUNCTION dw.refresh_dim_product() RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
         --- Refresh products
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


ALTER FUNCTION dw.refresh_dim_product() OWNER TO muriel;

--
-- Name: FUNCTION refresh_dim_product(); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.refresh_dim_product() IS 'updates dw.dim_product';


--
-- Name: refresh_monthly_byte_foods_summary(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM dw.insert_sales_monthly_byte_foods_summary(month_date);
    END;
$$;


ALTER FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) OWNER TO erpuser;

--
-- Name: refresh_monthly_kiosk_summary(date); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
    PERFORM dw.clear_fact_monthly_kiosk_summary(month_date);
    PERFORM dw.insert_in_monthly_kiosk_summary(month_date);
END;
$$;


ALTER FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) OWNER TO erpuser;

--
-- Name: FUNCTION refresh_monthly_kiosk_summary(month_date date); Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) IS 'updates dw.fact_monthly_kiosk_summary';


--
-- Name: restocks(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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

		-- Use a window function to group duplicate epc and rank them by time_added,
		-- then pick the latest one within each group (r = 1).
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


ALTER FUNCTION dw.restocks(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION restocks(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.restocks(beginning_date date, ending_date date) IS 'returns restocks';


--
-- Name: sales(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
                    --- Get the cost from label, if NULL, get cost from product_history, if NULL get cost
                    --- from product, if NULL get 0. label has the most accurate cost info for
                    --- the specific epc, then product_history, then product.
                    COALESCE(l.cost, ph.cost, p.cost,0) as cost,
                    --- Get the price from product_history, if NULL, get price
                    --- from product, if NULL get 0. product_history has the most accurate price info for
                    --- that time then product.
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


ALTER FUNCTION dw.sales(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION sales(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.sales(beginning_date date, ending_date date) IS 'returns sales';


--
-- Name: spoils(date, date); Type: FUNCTION; Schema: dw; Owner: muriel
--

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
            -- spoils may have duplicates so use rank() to get the latest updated item within duplicate epc's
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
                -- sold items to be excluded
                (select epc from pantry.label l
                    join pantry.order o on l.order_id = o.order_id
                 where to_timestamp(created)::date between beginning_date - interval '1 months'
                   and ending_date + interval '1 months'
                   and l.status='sold'
                )sold_items on l.epc = sold_items.epc

                join pantry.product p on p.id = l.product_id

                join pantry.order o on l.order_id = o.order_id

                -- get the actual price at order time
                left join pantry.product_history ph on ph.product_id = p.id
                  and o.created >= ph.start_time AND (ph.end_time is null or o.created < ph.end_time)

                join pantry.kiosk k on l.kiosk_id = k.id

        where sold_items.epc is null and l.latest_time_update_rank = 1;
end;
$$;


ALTER FUNCTION dw.spoils(beginning_date date, ending_date date) OWNER TO muriel;

--
-- Name: FUNCTION spoils(beginning_date date, ending_date date); Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON FUNCTION dw.spoils(beginning_date date, ending_date date) IS 'returns spoils';


--
-- Name: stockout(date, date, bigint); Type: FUNCTION; Schema: dw; Owner: erpuser
--

CREATE FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) RETURNS TABLE(kiosk_id bigint, kiosk_title character varying, campus_id bigint, product_id bigint, product_title character varying, sales bigint, spoils bigint, losses bigint, stockout_percent numeric)
    LANGUAGE plpgsql
    AS $$
   DECLARE
       DATE_DIFFERENCE bigint := ending_date - beginning_date + 1 ;
   BEGIN
     -- force Postgres to use indexes if available
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
           --- IF NULL, than it's a 100% stockout
           coalesce(stockouts.stockout_percent, 100.00) as stockout_percent
           --- This subquery is used to get a complete list of all products for the chosen kiosk's campus
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
           --- This subquery is used to calculate the stockout_percent from the stocked_percent.
           --- stockout_percent = number of days selected - total stocked_percent
           --- stocked_percent is the percentage at which a given item was present in a given kiosk
           --- for a given day.
           --- dw.fact_daily_kiosk_sku_summary only contains non NULL stocked_percent values for
           --- items that were stocked. If an item was not stocked at all for a given day,
           --- dw.fact_daily_kiosk_sku_summary.stocked_percent will contain a NULL value. For this
           --- reason, we turn any NULL values to 0.
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


ALTER FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) OWNER TO erpuser;

--
-- Name: parse_address(text); Type: FUNCTION; Schema: erp; Owner: erpuser
--

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

  -- trim leading and trailing spaces
  for i in 1..4 loop
      address_fields[i] = trim(address_fields[i]);
      address_fields[i] = trim(address_fields[i], chr(160));
  end loop;

  -- format: 123 Maple Street, San Francisco CA 94965
  if address_fields[3] is null
  then
    remainder = address_fields[2];
    zip = regexp_replace(remainder, '^.* ', '');
    remainder = trim(substring(remainder from 1 for length(remainder) - length(zip)));
    state = regexp_replace(remainder, '^.* ', '');
    city = trim(substring(remainder from 1 for length(remainder) - length(state)));
    address2 = '';
    address1 = address_fields[1];

    -- format: 123 Maple Street, San Francisco, CA 94965
    -- if there is no address2, then insert '' into address2 and shift the rest of address_fields down
  elseif address_fields[4] is null then
    zip = split_part(trim(address_fields[3]), ' ', 2);
    state = split_part(trim(address_fields[3]), ' ', 1);
    city = address_fields[2];
    address2 = '';
    address1 = address_fields[1];

    -- has address2: 123 Maple Street, Apartment A, San Francisco, CA 94965
  else
    -- split address_fields[4] into address_fields[4] and address_fields[5] to handle 'state zip'
    zip = split_part(trim(address_fields[4]), ' ', 2);
    state = split_part(trim(address_fields[4]), ' ', 1);
    city = address_fields[3];
    address2 = address_fields[2];
    address1 = address_fields[1];

  end if;

  return query
    select address1, address2, city, state, zip;
    -- select coalesce(address1, ''), coalesce(address2, ''), coalesce(city, ''),  coalesce(state, ''), coalesce(zip, '');
end;

$$;


ALTER FUNCTION erp.parse_address(address_str text) OWNER TO erpuser;

--
-- Name: parse_phone(text); Type: FUNCTION; Schema: erp; Owner: erpuser
--

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


ALTER FUNCTION erp.parse_phone(text_to_parse text) OWNER TO erpuser;

--
-- Name: reverse_sync_kiosk(); Type: FUNCTION; Schema: erp; Owner: erpuser
--

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
  -- calculate skip trigger flag
  _skip_trigger = (coalesce(current_setting(SKIP_SYNC_PARAM_NAME, true), '') = REVERSE_SYNC);

  if _skip_trigger
  then
    -- skip reverse sync
    -- (don't do  a reverse sync because changes were caused by a forward sync)
    return null;
  else
    -- do reverse sync
    -- disable the forward sync
    set local pantry.kiosk.skip_sync = FORWARD_SYNC;

    if tg_op in ('UPDATE', 'INSERT') then
      -- Calculate record id.
      -- Triggered record may have either `id` or `kiosk_id` as the primary key.
      -- Either case, assign its value to _record_id
      _record_id = null;
      begin
        _record_id = new.id;
      exception
        when undefined_column then
          _record_id = new.kiosk_id;
      end;

      -- compute last_inventory and last_update
      select max(time) from pantry.last_kiosk_status where kiosk_id = _record_id into _last_status;
      select max(time) from pantry.inventory_history where kiosk_id = _record_id into _last_inventory;

    end if;

    case
      when tg_op = 'UPDATE' then

        -- Triggered record may have either `id` or `kiosk_id` as the primary key.
        -- Either case, assign its value to _record_id
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

        -- fixme remove logging when done
        insert into test.kiosk_log(id, update_count) values(_record_id, 1)
          on conflict(id) do
            update set update_count = test.kiosk_log.update_count + 1, ts = current_timestamp;

        return new;

      when tg_op = 'INSERT' then
        -- erp.kiosk_classic_view contains the pantry.kiosk equivalent version of kiosk
        -- data of erp.kiosk and related tables
        insert into pantry.kiosk select * from erp.kiosk_classic_view where id = _record_id;

        -- fixme remove logging when done
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


ALTER FUNCTION erp.reverse_sync_kiosk() OWNER TO erpuser;

--
-- Name: sync_kiosk(); Type: FUNCTION; Schema: erp; Owner: erpuser
--

CREATE FUNCTION erp.sync_kiosk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  -- Insert/update/delete erp.kiosk and related tables when a pantry.kiosk record is changed

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
  -- 1 Prepare relational data for erp.kiosk and related tables based on the triggered pantry.kiosk record
  -- this task consists of looking up existing or inserting a new relational record to support the triggered
  -- pantry.kiosk record, for example, adding a new client record.
  if tg_op in  ('INSERT', 'UPDATE')
    then

      select exists(select 1 from erp.kiosk where id = new.id) into _record_exists ;

      -- There are many existing client_name = Byte kiosk with bad addresses. Overwrite these with the correct info.
      -- This code is needed for all such kiosk records until after the data have gone through a two way sync cycle
      -- and correction applied.
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

      -- look up contact type
      select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
      select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';

      -- prepare address
      select address1, address2, city, state, zip from erp.parse_address(new.address)
                                                    into _address1, _address2, _city, _state, _zip;
      -- look up address id
      select address.id into _address_id from erp.address
      where address1 = _address1 and address2 = _address2 and city = _city and state = _state and zip = _zip;

      -- if there is no client name, use address
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);

      -- lookup client industry
      select coalesce(ga.id, -1) into _industry
      from erp.client_industry ci
             left join (select * from erp.global_attribute_def ga where ga.name = 'industry') ga
                       on ci.industry = ga.value
      where ci.client_name = new.client_name;
      if _industry is null
        then _industry = -1;
      end if;

      -- insert into reference tables: client, address, contact

      -- insert client if not exists
      insert into erp.client(name, employees_num, industry)
        values(_client_name, new.employees_num, _industry)
        on conflict(name) do nothing;

      -- look up client id
      select id into _client_id from erp.client c where c.name = _client_name;

      -- insert address
      insert into erp.address(client_id, address1, address2, city, state, zip, location_x, location_y, timezone)
        values(_client_id, _address1, _address2, _city, _state, _zip, new.location_x, new.location_y, new.timezone)
        returning id into _address_id;

      -- insert contact
      select phone into _phone from erp.parse_phone(new.contact_phone);

      -- only use new.contact_email if it is compatitble with _email whose type is type.email
      begin
        _email = new.contact_email;
        exception
          when others then _email = null;
      end;

      -- insert general contact for kiosk contact
      insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
        values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
        on conflict do nothing;

      -- if this is also an accounting contact, insert an accounting contact record
      if new.accounting_email = 'same'
        then
          insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
            values(_client_id, new.contact_first_name, new.contact_last_name,
                   _email, _phone, _accounting_contact_type)
            on conflict do nothing;
      end if;

      -- look up client id
      select id into _client_id from erp.client where name = _client_name;

      -- look up general contact_id
      select contact.id into _general_contact_id from erp.contact
        where first_name = new.contact_first_name and last_name = new.contact_last_name
          and contact_type = _general_contact_type;

      -- look up accounting contact_id
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

  -- 2 Insert erp.kiosk and relational records
  case
    when tg_op = 'INSERT' and not _record_exists
      then
        -- insert kiosk
        insert into erp.kiosk(id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
                              location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
                              deployment_status_id, bank, archived)
        values (new.id, new.campus_id, new.serial, _client_id,
                new.title, new.kiosk_name, new.geo, _address_id, new.publicly_accessible, _location_type,
                new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
                0, 0, new.archived);

        -- insert hardware_software
        insert into erp.hardware_software(kiosk_id, gcm_id, app_vname, app_vcode, features, components,
                                          server_url, peekaboo_url, email_receipt_subject)
        values(new.id, new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
               '', new.email_receipt_subject);

        -- insert kiosk_accounting
        insert into erp.kiosk_accounting(kiosk_id, start_date, payment_start, payment_stop, sales_tax,
                                         default_fee_plan, byte_discount, subsidy_info, max_subscription,
                                         subscription_amount, setup_fee, subsidy_notes)
        values (new.id,
                null, -- start_date,
                _payment_start_date, _payment_stop_date, new.sales_tax, new.default_fee_plan, new.byte_discount,
                new.subsidy_info, new.max_subscription, new.subscription_amount,
                null, -- new.setup_fee,
                new.subsidy_notes);

        -- insert location notes
        if new.fridge_loc_info is not null and new.fridge_loc_info <> ''
        then
          select id into _note_type from erp.global_attribute_def where name = 'note_type' and value = 'Location';
          insert into erp.kiosk_note(kiosk_id, note_type, content)
          values(new.id, _note_type, new.fridge_loc_info);
        end if;

        -- insert Delivery Instruction notes
        if new.delivery_insns is not null and new.delivery_insns <> ''
        then
          select id into _note_type from erp.global_attribute_def where name = 'note_type' and value = 'Delivery Instruction';
          insert into erp.kiosk_note(kiosk_id, note_type, content)
          values(new.id, _note_type, new.delivery_insns);
        end if;

        -- insert OPS notes
        if new.ops_team_notes is not null and new.ops_team_notes <> ''
        then
          select id into _note_type from erp.global_attribute_def where name = 'note_type' and value = 'OPS';
          insert into erp.kiosk_note(kiosk_id, note_type, content)
          values(new.id, _note_type, new.ops_team_notes);
        end if;

        -- insert kiosk status
        insert into erp.kiosk_status(kiosk_id, last_update, last_status, last_inventory)
        values(new.id, new.last_update, new.last_status, new.last_inventory);

        -- insert kiosk_contact
        if _general_contact_id is not null
        then
          insert into erp.kiosk_contact(kiosk_id, contact_id) values(new.id, _general_contact_id)
          on conflict do nothing;
        end if;

        -- insert inm.kiosk_control for Byte campus INM operation
        if new.campus_id = BYTE_CAMPUS then
          insert into inm.kiosk_control(kiosk_id) values(new.id)
            on conflict do nothing;
        end if;

    -- 3. Update erp.kiosk and relational records
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

  -- 4. return the appropriate record (new or old) so that changes to pantry.product can be carried out
  if tg_op in ('INSERT', 'UPDATE')
    then return new;
    else return old;
  end if;

end;

$$;


ALTER FUNCTION erp.sync_kiosk() OWNER TO erpuser;

--
-- Name: sync_kiosk_reference(); Type: FUNCTION; Schema: erp; Owner: erpuser
--

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
  -- look up contact type
  select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
  select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';

  -- look up location type
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
      -- 1. import kiosk and client

      -- prepare addresses
      -- there are many client_name=Byte kiosk with bad addresses
      -- there are many client_name=Byte kiosk with bad addresses
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

      -- prepare address
      select address1, address2, city, state, zip from erp.parse_address(new.address)
        into _address1, _address2, _city, _state, _zip;

      -- if there is no client name, use address
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);

      select coalesce(ga.id, -1) into _industry
      from erp.client_industry ci
             left join (select * from erp.global_attribute_def ga where ga.name = 'industry') ga
                       on ci.industry = ga.value
      where ci.client_name = new.client_name;
      if _industry is null then
        _industry = -1;
      end if;

      -- insert client
      insert into erp.client(name, employees_num, industry)
        values(_client_name, new.employees_num, _industry)
        on conflict(name) do nothing;

      -- look up client id
      select id into _client_id from erp.client c where c.name = _client_name;

      -- insert address
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

      -- insert contact
      select phone into _phone from erp.parse_phone(new.contact_phone);

      if new.contact_email ~ '^\w+@[0-9a-zA-Z_]+?\.[0-9a-zA-Z]{2,3}$'
      then _email = new.contact_email;
      else _email = null;
      end if;

      -- insert general contact for kiosk contact
      insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
      values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
      on conflict do nothing;

      -- if this is also an accounting contact, insert an accounting contact record
      if new.accounting_email = 'same'
      then insert into erp.contact(client_id, first_name, last_name, email, phone, contact_type)
           values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _accounting_contact_type)
           on conflict do nothing;
      end if;

    -- don't insert or update pantry.kiosk - let sync_kiosk does that
    return null;
  end if;
end;

$_$;


ALTER FUNCTION erp.sync_kiosk_reference() OWNER TO erpuser;

--
-- Name: sync_kiosk_tables(); Type: FUNCTION; Schema: erp; Owner: erpuser
--

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
  -- look up contact type
  select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
  select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';

  -- look up location type
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
      -- prepare addresses
      select address1, address2, city, state, zip from erp.parse_address(new.address)
                                                       into _address1, _address2, _city, _state, _zip;
      -- look up address id
      select address.id into _address_id from erp.address
      where address1 = _address1 and address2 = _address2 and city = _city and state = _state and zip = _zip;

      -- if there is no client name, use address
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);

      -- look up client id
      select id into _client_id from erp.client where name = _client_name;

      -- look up general contact_id
      select contact.id into _general_contact_id from erp.contact
      where first_name = new.contact_first_name and last_name = new.contact_last_name and contact_type = _general_contact_type;

      -- look up accounting contact_id
      select contact.id into _accounting_contact_id from erp.contact
      where first_name = new.contact_first_name and last_name = new.contact_last_name and contact_type = _accounting_contact_type;

      -- current kiosk_name is not correct. Set name as concat of 'KID' and kiosk_id.
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
      -- insert kiosk
      insert into erp.kiosk(id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
                            location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
                            deployment_status_id, bank, archived)
        values (new.id, new.campus_id, new.serial,
                _client_id,
                new.title, _kiosk_name, new.geo, _address_id, new.publicly_accessible,
                _location_type,
                new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
        --deployment_status_id
                0,
        --	new.bank,
                0,
                new.archived);

      -- insert hardware_software
      insert into erp.hardware_software(kiosk_id, gcm_id, app_vname, app_vcode, features, components, server_url, peekaboo_url, email_receipt_subject)
        values(new.id, new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
               '', --new.peekaboo_url,
               new.email_receipt_subject);
               
      -- insert kiosk_accounting
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


ALTER FUNCTION erp.sync_kiosk_tables() OWNER TO erpuser;

--
-- Name: sync_product(); Type: FUNCTION; Schema: erp; Owner: erpuser
--

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
  -- Calculate the flag which indicate if the sync should be skipped
  _skip_trigger = (coalesce(current_setting(SKIP_SYNC_PARAM_NAME, true), '') = FORWARD_SYNC);

  -- calculate sync status of the triggered record
  if tg_op in ('INSERT', 'UPDATE')
    then
      select * from pantry.product where id = new.id into _target_record;

      -- is the new version of record the same as the current record
      _insync = (_target_record = new);
    -- tg_op is 'DELETE'
    else
      _insync = false;
  end if;

  -- Process the trigger according to record sync state and skip trigger param
  if _insync
    -- record is already in sync, so return null to cancel any subsequent trigger processing
    then return null;

    -- record is not in sync, so process the current trigger
    else
      -- Disable the reverse sync
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

          -- insert data if trigger is insert and product does not exists
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

              -- for each attribute in comma separated allergens, look up corresponding property id
              -- and insert a product_id, property_id in the product_property table
              insert into erp.product_property(product_id, property_id)
                select new.id, def.id
                  from (select unnest(string_to_array(new.allergens, ','))::int a_id) allergen_list
                         join pantry.tag t on allergen_list.a_id = t.id
                         join erp.product_property_def def on t.tag = def.value
                    on conflict do nothing;

              -- write consumer_category to erp.product related table
              if _consumer_category_id is not null
                then insert into erp.product_category(product_id, category_id) values(new.id, _consumer_category_id);
              end if;

              -- Write categories to erp.product related table
              -- erp.classic_product_category_tag contains tagging used by the tablet for product filtering
              -- overwrite erp.classic_product_category_tag with new tags
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

            -- update data if either trigger is insert or if product exits
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

              -- First delete all the corresponding property product_property for the product_id = new.id
              -- Then for each attribute in comma separated allergens, look up corresponding property id
              -- and insert a product_id, property_id in the product_property table
              delete from erp.product_property where product_id=new.id;

              insert into erp.product_property(product_id, property_id)
              select new.id, def.id
              from (select unnest(string_to_array(new.allergens, ','))::int a_id) allergen_list
                     join pantry.tag t on allergen_list.a_id = t.id
                     join erp.product_property_def def on t.tag = def.value
              on conflict do nothing;

              -- upsert consumer category by deleting existing then inserting new
              -- remove existing consumer categery
              delete from erp.product_category where product_id = new.id
                and category_id in (select id from erp.product_category_def where name = 'consumer');
              -- insert new consumer category only if it exists
              if _consumer_category_id is not null
                then insert into erp.product_category(product_id, category_id) values(new.id, _consumer_category_id);
              end if;

              -- write updated categories to erp.product related table.
              -- erp.classic_product_category_tag contains tagging used by the tablet for product filtering
              -- overwrite erp.classic_product_category_tag with new tags
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

      -- return the appropriate record (new or old) so that changes to pantry.product can be carried out
      if tg_op in ('INSERT', 'UPDATE')
        then return new;
        else return old;
      end if;

  end if; -- in sync?
end;
$$;


ALTER FUNCTION erp.sync_product() OWNER TO erpuser;

--
-- Name: fn_ro_order_update_full_price(character varying); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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


ALTER FUNCTION erp_test.fn_ro_order_update_full_price(orderid character varying) OWNER TO erpuser;

--
-- Name: parse_address(text); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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

  -- trim leading and trailing spaces
  for i in 1..4 loop
      address_fields[i] = trim(address_fields[i]);
      address_fields[i] = trim(address_fields[i], chr(160));
  end loop;

  -- format: 123 Maple Street, San Francisco CA 94965
  if address_fields[3] is null
  then
    remainder = address_fields[2];
    zip = regexp_replace(remainder, '^.* ', '');
    remainder = trim(substring(remainder from 1 for length(remainder) - length(zip)));
    state = regexp_replace(remainder, '^.* ', '');
    city = trim(substring(remainder from 1 for length(remainder) - length(state)));
    address2 = '';
    address1 = address_fields[1];

    -- format: 123 Maple Street, San Francisco, CA 94965
    -- if there is no address2, then insert '' into address2 and shift the rest of address_fields down
  elseif address_fields[4] is null then
    zip = split_part(trim(address_fields[3]), ' ', 2);
    state = split_part(trim(address_fields[3]), ' ', 1);
    city = address_fields[2];
    address2 = '';
    address1 = address_fields[1];

    -- has address2: 123 Maple Street, Apartment A, San Francisco, CA 94965
  else
    -- split address_fields[4] into address_fields[4] and address_fields[5] to handle 'state zip'
    zip = split_part(trim(address_fields[4]), ' ', 2);
    state = split_part(trim(address_fields[4]), ' ', 1);
    city = address_fields[3];
    address2 = address_fields[2];
    address1 = address_fields[1];

  end if;

  return query
    select address1, address2, city, state, zip;
  -- select coalesce(address1, ''), coalesce(address2, ''), coalesce(city, ''),  coalesce(state, ''), coalesce(zip, '');
end;

$$;


ALTER FUNCTION erp_test.parse_address(address_str text) OWNER TO erpuser;

--
-- Name: parse_phone(text); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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


ALTER FUNCTION erp_test.parse_phone(text_to_parse text) OWNER TO erpuser;

--
-- Name: reverse_sync_kiosk(); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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
    -- skip reverse sync because _skip_trigger flag is on
    -- (don't do  a reverse sync erp_to_pantry because the changes originated from pantry_to_erp sync)
    return null;
  else
    -- do reverse sync
    -- set transaction scope var to indicate that forward trigger should be skipped as no additional changes needed
    set local erp_test.kiosk.skip_forward_trigger='true';

    case
      when tg_op = 'UPDATE' then

        -- Triggered record may have either `id` or `kiosk_id` as the primary key.
        -- Either case, assign its value to _record_id
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
        -- erp_test.kiosk_classic_view contains the pantry.kiosk equivalent version of kiosk
        -- data of erp_test.kiosk and related tables
        insert into pantry.temp_kiosk select * from erp_test.kiosk_classic_view where id = _record_id;
        return new;

      when tg_op = 'DELETE' then
        delete from pantry.kiosk where id = old.id;
        return old;
      end case;
  end if;
end;
$$;


ALTER FUNCTION erp_test.reverse_sync_kiosk() OWNER TO erpuser;

--
-- Name: sync_kiosk(); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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

  -- sync control variables
  _record_exists BOOLEAN;
  _target_record record;
  _insync BOOLEAN;
  _skip_trigger boolean;

begin
  -- 1. Analyze overall trigger and record states

  -- transaction scope parameter
  _skip_trigger = (coalesce(current_setting('erp_test.kiosk.skip_forward_trigger', true), '') = 'true');

  -- calculate sync status of the triggered record
  if tg_op in ('INSERT', 'UPDATE')
  then
    select * from pantry.temp_kiosk where id = new.id into _target_record;

    -- is the new version of record the same as the current record?
    _insync = (_target_record = new);
  else
    _insync = false;
  end if;

  -- 2. Process the trigger according to the overall trigger and record states
  if _skip_trigger or _insync
  then
    -- don't process the current trigger because either _skip_trigger is set, or the record is already in sync
    return null;
  else
    -- record is not in sync, so process the current trigger

    -- 2.1 Disable reverse trigger
    -- set transaction scope var to disable the reverse trigger, otherwise this change will
    -- needlessly trigger the reverse trigger and start an infinite cycle of data sync
    set local erp_test.kiosk.skip_reverse_trigger='true';

    -- 2.2 Prepare relational data for erp_test.kiosk and related tables based on the triggered pantry.kiosk record
    -- this task consists of looking up existing or inserting a new relational record to support the triggered
    -- pantry.kiosk record, for example, adding a new client record.
    if tg_op in  ('INSERT', 'UPDATE')
      then
        select exists(select 1 from erp_test.kiosk where id = new.id) into _record_exists ;

        -- There are many existing client_name=Byte kiosk with bad addresses. Overwrite these with the correct info.
        -- This code is needed for all such kiosk records until after the data have gone through a two way sync cycle
        -- and correction applied.
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

        -- look up contact type
        select id into _general_contact_type from erp_test.global_attribute_def where name = 'contact_type' and value = 'general';
        select id into _accounting_contact_type from erp_test.global_attribute_def where name = 'contact_type' and value = 'accounting';

        -- prepare address
        select address1, address2, city, state, zip from erp_test.parse_address(new.address)
          into _address1, _address2, _city, _state, _zip;
        -- look up address id
        select address.id into _address_id from erp_test.address
        where address1 = _address1 and address2 = _address2 and city = _city and state = _state and zip = _zip;

        -- if there is no client name, use address
        _client_name = coalesce(new.client_name, 'Address: ' || new.address);

        -- lookup client industry
        select coalesce(ga.id, -1) into _industry
        from erp_test.client_industry ci
               left join (select * from erp_test.global_attribute_def ga where ga.name = 'industry') ga
                         on ci.industry = ga.value
        where ci.client_name = new.client_name;
        if _industry is null then
          _industry = -1;
        end if;

        -- insert into reference tables: client, address, contact

        -- insert client if not exists
        insert into erp_test.client(name, employees_num, industry)
          values(_client_name, new.employees_num, _industry)
          on conflict(name) do nothing;

        -- look up client id
        select id into _client_id from erp_test.client c where c.name = _client_name;

        -- insert address
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

        -- insert contact
        select phone into _phone from erp_test.parse_phone(new.contact_phone);

        if new.contact_email ~ '^\w+@[0-9a-zA-Z_]+?\.[0-9a-zA-Z]{2,3}$'
        then _email = new.contact_email;
        else _email = null;
        end if;

        -- insert general contact for kiosk contact
        insert into erp_test.contact(client_id, first_name, last_name, email, phone, contact_type)
        values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
        on conflict do nothing;

        -- if this is also an accounting contact, insert an accounting contact record
        if new.accounting_email = 'same'
        then insert into erp_test.contact(client_id, first_name, last_name, email, phone, contact_type)
        values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _accounting_contact_type)
        on conflict do nothing;
        end if;

        -- look up client id
        select id into _client_id from erp_test.client where name = _client_name;

        -- look up general contact_id
        select contact.id into _general_contact_id from erp_test.contact
        where first_name = new.contact_first_name and last_name = new.contact_last_name and contact_type = _general_contact_type;

        -- look up accounting contact_id
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


    -- 2.3 Insert erp_test.kiosk and relational records
    case
      when tg_op = 'INSERT' and not _record_exists
        then
          -- insert kiosk
          insert into erp_test.kiosk(id, campus_id, serial, client_id, title, name, geo, address_id, publicly_accessible,
                                location_type, estd_num_users, enable_reporting, creation_time, deployment_time,
                                deployment_status_id, bank, archived)
            values (new.id, new.campus_id, new.serial, _client_id,
                    new.title, new.kiosk_name, new.geo, _address_id, new.publicly_accessible, _location_type,
                    new.estd_num_users, new.enable_reporting, new.creation_time, new.deployment_time,
                    0, 0, new.archived);

          -- insert hardware_software
          insert into erp_test.hardware_software(kiosk_id, gcm_id, app_vname, app_vcode, features, components,
                                                 server_url, peekaboo_url, email_receipt_subject)
            values(new.id, new.gcm_id, new.app_vname, new.app_vcode, new.features, new.components, new.server_url,
                   '', new.email_receipt_subject);

          -- insert kiosk_accounting
          insert into erp_test.kiosk_accounting(kiosk_id, start_date, payment_start, payment_stop, sales_tax,
                                                default_fee_plan, byte_discount, subsidy_info, max_subscription,
                                                subscription_amount, setup_fee, subsidy_notes)
            values (new.id,
                    null, -- start_date,
                    _payment_start_date, _payment_stop_date, new.sales_tax, new.default_fee_plan, new.byte_discount,
                    new.subsidy_info, new.max_subscription, new.subscription_amount,
                    null, -- new.setup_fee,
                    new.subsidy_notes);

          -- insert location notes
          if new.fridge_loc_info is not null and new.fridge_loc_info <> ''
          then
            select id into _note_type from erp_test.global_attribute_def where name = 'note_type' and value = 'Location';
            insert into erp_test.kiosk_note(kiosk_id, note_type, content)
            values(new.id, _note_type, new.fridge_loc_info);
          end if;

          -- insert Delivery Instruction notes
          if new.delivery_insns is not null and new.delivery_insns <> ''
          then
            select id into _note_type from erp_test.global_attribute_def where name = 'note_type' and value = 'Delivery Instruction';
            insert into erp_test.kiosk_note(kiosk_id, note_type, content)
            values(new.id, _note_type, new.delivery_insns);
          end if;

          -- insert OPS notes
          if new.ops_team_notes is not null and new.ops_team_notes <> ''
          then
            select id into _note_type from erp_test.global_attribute_def where name = 'note_type' and value = 'OPS';
            insert into erp_test.kiosk_note(kiosk_id, note_type, content)
              values(new.id, _note_type, new.ops_team_notes);
          end if;

          -- insert kiosk status
          insert into erp_test.kiosk_status(kiosk_id, last_update, last_status, last_inventory)
            values(new.id, new.last_update, new.last_status, new.last_inventory);

          -- insert kiosk_contact
          if _general_contact_id is not null
            then
              insert into erp_test.kiosk_contact(kiosk_id, contact_id) values(new.id, _general_contact_id)
                on conflict do nothing;
          end if;

          return new;

      -- 2.4 Update erp_test.kiosk and relational records
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

      -- fixme delete other foreign relation tables refering to this kiosk_id
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

--
-- Name: sync_kiosk_reference(); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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
  -- look up contact type
  select id into _general_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'general';
  select id into _accounting_contact_type from erp.global_attribute_def where name = 'contact_type' and value = 'accounting';

  -- look up location type
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
      -- 1. import kiosk and client

      -- prepare addresses
      -- there are many client_name=Byte kiosk with bad addresses
      -- there are many client_name=Byte kiosk with bad addresses
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

      -- if there is no client name, use address
      _client_name = coalesce(new.client_name, 'Address: ' || new.address);

      select coalesce(ga.id, -1) into _industry
      from erp.client_industry ci
             left join (select * from erp.global_attribute_def ga where ga.name = 'industry') ga
                       on ci.industry = ga.value
      where ci.client_name = new.client_name;
      if _industry is null then
        _industry = -1;
      end if;

      -- insert client
      insert into erp_test.client(name, employees_num, industry)
        values(_client_name, new.employees_num, _industry)
        on conflict(name) do nothing;

      -- look up client id
      select id into _client_id from erp_test.client c where c.name = _client_name;

      -- insert address
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

      -- insert contact
      select phone into _phone from erp.parse_phone(new.contact_phone);

      if new.contact_email ~ '^\w+@[0-9a-zA-Z_]+?\.[0-9a-zA-Z]{2,3}$'
      then _email = new.contact_email;
      else _email = null;
      end if;

      -- insert general contact for kiosk contact
      insert into erp_test.contact(client_id, first_name, last_name, email, phone, contact_type)
      values(_client_id, new.contact_first_name, new.contact_last_name, _email, _phone, _general_contact_type)
      on conflict do nothing;

      -- if this is also an accounting contact, insert an accounting contact record
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

--
-- Name: sync_product(); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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
  -- check for transaction scope skip trigger flag from run-time configuration parameters
  _skip_trigger = (coalesce(current_setting('erp_test.product.skip_forward_trigger', true), '') = 'true');

  -- calculate sync status of the triggered record
  if tg_op in ('INSERT', 'UPDATE')
  then
    select * from pantry.product where id = new.id into _target_record;

    -- is the new version of record the same as the current record
    _insync = (_target_record = new);
  else
    _insync = false;
  end if;

  if _skip_trigger -- or _insync
  then
    -- don't process the current trigger because either _skip_trigger is set, or the record is already in sync
    return null;
  else
    -- record is not in sync, and _skip_trigger is false, so disable other triggers for current transaction and
    -- process the current trigger

    -- transaction scope variable to skip reverse trigger
    set local erp_test.product.skip_reverse_trigger='true';

    if tg_op in ('INSERT', 'UPDATE')
    then
      select id from erp_test.sku_group where fc_title = new.fc_title into _sku_group_id;
      select into _product_exists exists(select 1 from erp_test.product where id = new.id);
      select into _consumer_category_id id from product_category_def where name = 'consumer' and value = new.consumer_category;
    end if;

    -- insert data if trigger is insert and product does not exists
    case when tg_op = 'INSERT' and not _product_exists
      then
        -- check if product already exists
        select into _product_exists True from erp_test.product where id = new.id;

        insert into erp_test.product(id, brand, campus_id, sku_group_id, fc_title, archived, last_update)
        values(new.id, new.vendor, new.campus_id, _sku_group_id, new.fc_title, new.archived, new.last_update);

        insert into erp_test.product_asset(product_id, title, description, tiny_description, short_description, medium_description, long_description, image_time)
        values (new.id, new.title, new.description, new.tiny_description, new.short_description, new.medium_description, new.long_description, new.image_time);

        insert into erp_test.product_pricing(product_id,price,cost,ws_case_cost,pricing_tier,taxable)
        values(new.id,new.price,new.cost,new.ws_case_cost,new.pricing_tier,new.taxable);

        insert into erp_test.product_nutrition(product_id,total_cal,num_servings,calories,proteins,sugar,carbohydrates,fat,ingredients,shelf_time)
        values(new.id,new.total_cal,new.num_servings,new.calories,new.proteins,new.sugar,new.carbohydrates,new.fat,new.ingredients,new.shelf_time);

        -- for each attribute in semicolon separated attribute_names, look up corresponding property id
        -- and insert a product_id, property_id in the product_property table
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

      -- update data if either trigger is insert or if product exits
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

        -- First delete all the corresponding property product_property for the product_id = new.id
        -- Then for each attribute in semicolon separated attribute_names, look up corresponding property id
        -- and insert a product_id, property_id in the product_property table
        delete from erp_test.product_property where product_id=new.id;
        insert into erp_test.product_property(product_id, property_id)
        select p.id, def.id from
          (select id, unnest(string_to_array(attribute_names, ';')) attrib
           from pantry.product) p
            join erp_test.product_property_def def
                 on p.attrib = def.value and p.id = new.id;

        -- update consumer category
        -- use `insert...on conflict update` in case there was no existing consumer category record
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


ALTER FUNCTION erp_test.sync_product() OWNER TO erpuser;

--
-- Name: test(integer); Type: FUNCTION; Schema: erp_test; Owner: erpuser
--

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


ALTER FUNCTION erp_test.test(_id integer) OWNER TO erpuser;

--
-- Name: parse_address(text); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

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

  -- trim leading and trailing spaces
  for i in 1..4 loop
      address_fields[i] = trim(address_fields[i]);
      address_fields[i] = trim(address_fields[i], chr(160));
  end loop;

  -- format: 123 Maple Street, San Francisco CA 94965
  if address_fields[3] is null
  then
    remainder = address_fields[2];
    zip = regexp_replace(remainder, '^.* ', '');
    remainder = trim(substring(remainder from 1 for length(remainder) - length(zip)));
    state = regexp_replace(remainder, '^.* ', '');
    city = trim(substring(remainder from 1 for length(remainder) - length(state)));
    address2 = '';
    address1 = address_fields[1];

    -- format: 123 Maple Street, San Francisco, CA 94965
    -- if there is no address2, then insert '' into address2 and shift the rest of address_fields down
  elseif address_fields[4] is null then
    zip = split_part(trim(address_fields[3]), ' ', 2);
    state = split_part(trim(address_fields[3]), ' ', 1);
    city = address_fields[2];
    address2 = '';
    address1 = address_fields[1];

    -- has address2: 123 Maple Street, Apartment A, San Francisco, CA 94965
  else
    -- split address_fields[4] into address_fields[4] and address_fields[5] to handle 'state zip'
    zip = split_part(trim(address_fields[4]), ' ', 2);
    state = split_part(trim(address_fields[4]), ' ', 1);
    city = address_fields[3];
    address2 = address_fields[2];
    address1 = address_fields[1];

  end if;

  return query
    select address1, address2, city, state, zip;
    -- select coalesce(address1, ''), coalesce(address2, ''), coalesce(city, ''),  coalesce(state, ''), coalesce(zip, '');
end;

$$;


ALTER FUNCTION fnrenames.parse_address(address_str text) OWNER TO erpuser;

--
-- Name: parse_phone(text); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

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


ALTER FUNCTION fnrenames.parse_phone(text_to_parse text) OWNER TO erpuser;

--
-- Name: pg_create_logical_replication_slot(name, name, boolean); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_create_logical_replication_slot(slot_name name, plugin name, temporary boolean DEFAULT false, OUT slot_name name, OUT xlog_position pg_lsn) RETURNS record
    LANGUAGE sql
    AS $$
   SELECT slot_name::NAME, lsn::pg_lsn FROM pg_catalog.pg_create_logical_replication_slot(slot_name, plugin,
   temporary); $$;


ALTER FUNCTION fnrenames.pg_create_logical_replication_slot(slot_name name, plugin name, temporary boolean, OUT slot_name name, OUT xlog_position pg_lsn) OWNER TO erpuser;

--
-- Name: pg_current_xlog_flush_location(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_current_xlog_flush_location() RETURNS pg_lsn
    LANGUAGE sql
    AS $$
   SELECT pg_current_wal_flush_lsn(); $$;


ALTER FUNCTION fnrenames.pg_current_xlog_flush_location() OWNER TO erpuser;

--
-- Name: pg_current_xlog_insert_location(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_current_xlog_insert_location() RETURNS pg_lsn
    LANGUAGE sql
    AS $$
   SELECT pg_current_wal_insert_lsn(); $$;


ALTER FUNCTION fnrenames.pg_current_xlog_insert_location() OWNER TO erpuser;

--
-- Name: pg_current_xlog_location(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_current_xlog_location() RETURNS pg_lsn
    LANGUAGE sql
    AS $$
   SELECT pg_current_wal_lsn(); $$;


ALTER FUNCTION fnrenames.pg_current_xlog_location() OWNER TO erpuser;

--
-- Name: pg_is_xlog_replay_paused(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_is_xlog_replay_paused() RETURNS boolean
    LANGUAGE sql
    AS $$
   SELECT pg_is_wal_replay_paused(); $$;


ALTER FUNCTION fnrenames.pg_is_xlog_replay_paused() OWNER TO erpuser;

--
-- Name: pg_last_xlog_receive_location(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_last_xlog_receive_location() RETURNS pg_lsn
    LANGUAGE sql
    AS $$
   SELECT pg_last_wal_receive_lsn(); $$;


ALTER FUNCTION fnrenames.pg_last_xlog_receive_location() OWNER TO erpuser;

--
-- Name: pg_last_xlog_replay_location(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_last_xlog_replay_location() RETURNS pg_lsn
    LANGUAGE sql
    AS $$
   SELECT pg_last_wal_replay_lsn(); $$;


ALTER FUNCTION fnrenames.pg_last_xlog_replay_location() OWNER TO erpuser;

--
-- Name: pg_switch_xlog(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_switch_xlog() RETURNS pg_lsn
    LANGUAGE sql
    AS $$
   SELECT pg_switch_wal(); $$;


ALTER FUNCTION fnrenames.pg_switch_xlog() OWNER TO erpuser;

--
-- Name: pg_xlog_location_diff(pg_lsn, pg_lsn); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_xlog_location_diff(lsn1 pg_lsn, lsn2 pg_lsn) RETURNS numeric
    LANGUAGE sql
    AS $$
   SELECT pg_wal_lsn_diff(lsn1, lsn2); $$;


ALTER FUNCTION fnrenames.pg_xlog_location_diff(lsn1 pg_lsn, lsn2 pg_lsn) OWNER TO erpuser;

--
-- Name: pg_xlog_replay_pause(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_xlog_replay_pause() RETURNS void
    LANGUAGE sql
    AS $$
   SELECT pg_wal_replay_pause(); $$;


ALTER FUNCTION fnrenames.pg_xlog_replay_pause() OWNER TO erpuser;

--
-- Name: pg_xlog_replay_resume(); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_xlog_replay_resume() RETURNS void
    LANGUAGE sql
    AS $$
   SELECT pg_wal_replay_resume(); $$;


ALTER FUNCTION fnrenames.pg_xlog_replay_resume() OWNER TO erpuser;

--
-- Name: pg_xlogfile_name(pg_lsn); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_xlogfile_name(lsn pg_lsn) RETURNS text
    LANGUAGE sql
    AS $$
   SELECT pg_walfile_name(lsn); $$;


ALTER FUNCTION fnrenames.pg_xlogfile_name(lsn pg_lsn) OWNER TO erpuser;

--
-- Name: pg_xlogfile_name_offset(pg_lsn); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.pg_xlogfile_name_offset(lsn pg_lsn, OUT text, OUT integer) RETURNS record
    LANGUAGE sql
    AS $$
   SELECT pg_walfile_name_offset(lsn); $$;


ALTER FUNCTION fnrenames.pg_xlogfile_name_offset(lsn pg_lsn, OUT text, OUT integer) OWNER TO erpuser;

--
-- Name: some_f(character varying); Type: FUNCTION; Schema: fnrenames; Owner: erpuser
--

CREATE FUNCTION fnrenames.some_f(param character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

BEGIN
      EXECUTE 'select id FROM ' || quote_ident(param);
END;
$$;


ALTER FUNCTION fnrenames.some_f(param character varying) OWNER TO erpuser;

--
-- Name: f_kiosk_sku_group_sku_pick_stats(timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) RETURNS TABLE(kiosk_id integer, sku_group character varying, sku_group_id integer, sku integer, kiosk_on_route integer, kiosk_sku_enabled integer, kiosk_priority integer, sku_priority integer, sku_group_demand_week integer, kiosk_demand_plan_ratio numeric, sku_group_inventory_qty integer, sku_inventory_actual_qty integer, sku_group_inventory_actual_qty integer, sku_group_min_qty integer, sku_group_order_qty integer, sku_group_allocation_total integer, sku_allocation_qty integer, fleet_sku_group_order_total integer, fleet_sku_group_allocation_total integer, fleet_sku_allocation_total integer, warehouse_sku_inventory_stickered integer, warehouse_sku_inventory_unstickered integer, warehouse_sku_group_inventory_stickered integer, warehouse_sku_group_inventory_unstickered integer, substituted character varying, substituted_qty character varying, substituting character varying, substituting_qty character varying, sku_rejection integer, sku_preference_velocity numeric, sku_preference_normalized integer)
    LANGUAGE plpgsql
    AS $$
begin
  -- author: Art
  -- summarize allocation factors and results
  return query
    -- TODO: improve inventory actual computation
    select k.kiosk_id::int kiosk_id,
      p.sku_group sku_group,
      sg.sku_group_id sku_group_id,
      p.sku::int sku,
      coalesce(pr.on_route, 0) kiosk_on_route,
      coalesce(kpd.enabled, 1) kiosk_sku_enabled,
      coalesce(ppk.priority, 100) kiosk_priority,
      coalesce(pps.priority, 100) sku_priority,
      coalesce(pgo.demand_week, 0) sku_group_demand_week,
      coalesce(kdpr.kiosk_demand_plan_ratio, 0) kiosk_demand_plan_ratio,
      coalesce(pi.inventory_qty, 0) sku_group_inventory_qty,
      coalesce(l.stock_count, 0)::int sku_inventory_actual_qty,
      coalesce(sum(l.stock_count) over (partition by sg.sku_group, k.kiosk_id), 0)::int
        sku_group_inventory_actual_qty,
      coalesce(sga.sku_group_min_qty, 0) sku_group_min_qty,
      coalesce(pd.order_qty, 0) sku_group_order_qty,
      coalesce(sum(pa.allocation_qty) over (partition by sg.sku_group, k.kiosk_id), 0)::int sku_group_allocation_total,
      coalesce(pa.allocation_qty, 0) sku_allocation_qty,
      coalesce((sum(pd.order_qty) over (partition by sg.sku_group))/(count(p.sku)
        over (partition by sg.sku_group, k.kiosk_id)), 0)::int fleet_sku_group_order_total,
      coalesce(sum(pa.allocation_qty) over (partition by sg.sku_group), 0)::int fleet_sku_group_allocation_total,
      coalesce(sum(pa.allocation_qty) over (partition by p.sku), 0)::int fleet_sku_allocation_total,
      coalesce(wi.inventory_stickered, 0) warehouse_sku_inventory_stickered,
      coalesce(wi.inventory_unstickered, 0) warehouse_sku_inventory_unstickered,
      coalesce(sum(wi.inventory_stickered) over (partition by sg.sku_group, k.kiosk_id), 0)::int
        warehouse_sku_group_inventory_stickered,
      coalesce(sum(wi.inventory_unstickered) over (partition by sg.sku_group, k.kiosk_id), 0)::int
        warehouse_sku_group_inventory_unstickered,
      ps.substituted::varchar substituted,
      ps.substituted_qty::varchar substituted_qty,
      ps2.substituting::varchar substituting,
      ps2.substituting_qty::varchar substituting_qty,
      coalesce(pre.rejection, 0)::int sku_rejection,
      ksv.preference sku_preference_velocity,
      ppks.preference::int sku_preference_normalized
    from (
      select k.id as kiosk_id
      from pantry.kiosk k
      where k.campus_id=87
      and k.archived=0
    ) k

           cross join (
        select p.fc_title sku_group,
          p.id sku
        from pantry.product p
        where p.campus_id=87
        and p.archived=0
        and p.fc_title is not null
        and p.fc_title!='N/A'
      ) p

           left join (
        select sg.fc_title sku_group,
          sg.id sku_group_id
        from inm.sku_group sg
      ) sg on p.sku_group=sg.sku_group

           left join (
        select pr.kiosk_id kiosk_id,
          1 on_route
        from inm.pick_route pr
        where pr.pick_date=pick_time::date
      ) pr on k.kiosk_id=pr.kiosk_id

           left join (
        -- warehouse inventory
        select wi.product_id sku,
              wi.units_per_case*wi.stickered_cases+wi.stickered_units inventory_stickered,
              wi.units_per_case*wi.unstickered_cases+wi.unstickered_units inventory_unstickered
        from inm.warehouse_inventory wi
        where wi.inventory_date=pick_time::date
      ) wi on p.sku=wi.sku

           left join (
        --  demand_week
        select pgo.kiosk_id kiosk_id,
          pgo.fc_title sku_group,
          pgo.week_qty demand_week
        from inm.pick_get_order(pick_time::date+interval '21 hours', pick_time::date+interval '43 hours') pgo
      ) pgo on k.kiosk_id=pgo.kiosk_id and p.sku_group=pgo.sku_group

           left join (
        -- kiosk inventory
        select pi.kiosk_id kiosk_id,
          pi.sku_group_id sku_group_id,
          pi.qty inventory_qty
        from inm.pick_inventory pi
        where pi.pick_date=pick_time::date
      ) pi on k.kiosk_id=pi.kiosk_id and sg.sku_group_id=pi.sku_group_id

           left join (
        -- order
        select pd.kiosk_id kiosk_id,
          pd.sku_group_id sku_group_id,
          pd.qty order_qty
        from inm.pick_demand pd
        where pd.pick_date=pick_time::date
      ) pd on k.kiosk_id=pd.kiosk_id and sg.sku_group_id=pd.sku_group_id

           left join (
        -- allocation
        select pa.kiosk_id kiosk_id,
          pa.sku_id sku,
          pa.qty allocation_qty
        from inm.pick_allocation pa
        where pa.pick_date=pick_time::date
      ) pa on k.kiosk_id=pa.kiosk_id and p.sku=pa.sku

           left join (
        select ppk.kiosk_id kiosk_id,
          ppk.priority priority
        from inm.pick_priority_kiosk ppk
      ) ppk on k.kiosk_id=ppk.kiosk_id

           left join (
        select pps.sku_id sku,
          pps.priority priority
        from inm.pick_priority_sku pps
      ) pps on p.sku=pps.sku

           left join (
        select kpd.kiosk_id kiosk_id,
          kpd.product_id sku,
          case when kpd.product_id is not null then 0
               else 1
            end as enabled
        from inm.kiosk_product_disabled kpd
      ) kpd on k.kiosk_id=kpd.kiosk_id and p.sku=kpd.sku

           left join (
        select l.kiosk_id as kiosk_id,
          p.fc_title as sku_group,
          l.product_id as sku,
          count(*) as stock_count
        from pantry.label l
               left join pantry.product p
                         on l.product_id=p.id
        where to_timestamp(time_added) < pick_time
        and to_timestamp(time_updated) > pick_time
        and p.campus_id=87
        and p.archived=0
        and p.fc_title is not null
        and p.fc_title!='N/A'
        group by l.kiosk_id,
          p.fc_title,
          l.product_id
      ) l on k.kiosk_id=l.kiosk_id and p.sku=l.sku

           left join (
        select ps.substituting_sku_group_id sku_group_id,
          string_agg(ps.substituted_sku_group_id::text, ',' order by ps.substituted_sku_group_id asc) substituted,
          string_agg(ps.qty::text, ',' order by ps.substituted_sku_group_id) substituted_qty
        from inm.pick_substitution ps
        where ps.pick_date=pick_time::date
        group by ps.substituting_sku_group_id
      ) ps on sg.sku_group_id=ps.sku_group_id

           left join (
        select ps.substituted_sku_group_id sku_group_id,
          string_agg(ps.substituting_sku_group_id::text, ',' order by ps.substituting_sku_group_id asc) substituting,
          string_agg(ps.qty::text, ',' order by ps.substituting_sku_group_id) substituting_qty
        from inm.pick_substitution ps
        where ps.pick_date=pick_time::date
        group by ps.substituted_sku_group_id
      ) ps2 on sg.sku_group_id=ps2.sku_group_id

           left join (
        select pre.kiosk_id kiosk_id,
          pre.item_id  sku,
          count(pre.reason) as rejection
        from inm.pick_rejection pre
        where pre.pick_date=pick_time::date
        and item_type = 'sku_id'
        group by pre.kiosk_id,
          pre.item_id
      ) pre on k.kiosk_id=pre.kiosk_id and p.sku=pre.sku

           left join (
        select ksv.kiosk_id kiosk_id,
          ksv.sku sku,
          ksv.preference preference
        from inm.v_kiosk_sku_velocity ksv
      ) ksv on k.kiosk_id=ksv.kiosk_id and p.sku=ksv.sku

           left join (
        select ppks.kiosk_id kiosk_id,
          ppks.sku_id sku,
          ppks.preference preference
        from mixalot.pick_preference_kiosk_sku ppks
      ) ppks on k.kiosk_id=ppks.kiosk_id and p.sku=ppks.sku

           left join (
        select sga.id as sku_group_id,
          sga.minimum_kiosk_qty as sku_group_min_qty
        from inm.sku_group_attribute sga
      ) sga on sg.sku_group_id=sga.sku_group_id

           left join (
        select kdpr.kiosk_id kiosk_id,
          case when extract(dow from pick_time)=0 then d0_plan_demand_ratio
               when extract(dow from pick_time)=1 then d1_plan_demand_ratio
               when extract(dow from pick_time)=2 then d2_plan_demand_ratio
               when extract(dow from pick_time)=3 then d3_plan_demand_ratio
               when extract(dow from pick_time)=4 then d4_plan_demand_ratio
               else 0
            end kiosk_demand_plan_ratio
        from inm.v_kiosk_demand_plan_ratio kdpr
      ) kdpr on k.kiosk_id=kdpr.kiosk_id

    order by k.kiosk_id asc,
      p.sku_group asc,
      p.sku asc;

end;

$$;


ALTER FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) OWNER TO erpuser;

--
-- Name: FUNCTION f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone); Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) IS 'summarize allocation settings, input, and results';


--
-- Name: get_pull_date(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, delivery_date date, pull_date date)
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
      -- delivery date
      dd as
        (select t.kiosk_id, t.delivery_date_time as delivery_dt from
          (select location_number as kiosk_id, rs.route_date_time as delivery_date_time,
                  dense_rank() over (partition by location_number order by rs.route_date_time) as r
           from mixalot.route_stop rs
           where rs.route_date_time >= plan_window_start -- routes starting at plan window start
             and rs.route_date_time <= plan_window_stop
             and location_number > 0) t
         where r = 1),

      -- normal pull date
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

      -- possible enhanced pull dates - start with next 7 days before narrowing down to the best day
      pepd as
        (select d as pull_date, extract(dow from d) as dow
          from (select generate_series(plan_window_start,
            plan_window_start::timestamp + interval '6 days', interval '1 days')::date as d) dates),

      -- sales_history - kiosk and dow with sales
      sales_history as
        (select v.kiosk_id, v.dow
          from inm.v_kiosk_sale_hourly v
          group by 1, 2
          having sum(units_sold_normalized) >= 0.05),

      -- kiosk_id, delivery_date, enhanced_pull_date
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

  -- return kiosk_id, delivery_date, the best pull date
  select dd.kiosk_id,
         dd.delivery_dt::date,
         coalesce(epd.pull_date, npd.pull_date::date) as pull_date
    from dd
      join npd on dd.kiosk_id = npd.kiosk_id
      left join epd on dd.kiosk_id = epd.kiosk_id;
end;

$$;


ALTER FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;

--
-- Name: FUNCTION get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone); Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) IS 'return pull_date per kiosk per pick window';


--
-- Name: get_spoilage_pull_list(); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.get_spoilage_pull_list() RETURNS TABLE(category character varying, kiosk_id bigint, kiosk_title character varying, product_id bigint, product_tile character varying, epc character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
        RETURN QUERY
/*
This query is used to identify items that will spoil before the next delivery.
This function does not use kiosk id as an input.
It return expected spoilage for the whole Byte fleet.
A spoiled item uses the following
criteria:
if ( skuShelfLife <= 7 days ) {
if ( skuEpcDateAdded + kioskNextDelvieryDate > skuShelfLife )
{Show in pull list (red);}
}
else if ( skuShelfLife > 7 days && skuShelfLife <= 30 days ){
if ( skuEpcDateAdded + kioskNextDelvieryDate > skuShelfLife )
{Show in check list (yellow);}
}
SEE ENG-555
*/
        SELECT CASE WHEN shelf_time <= 7 THEN 'SPOILAGE RED'::varchar ELSE 'SPOILAGE YELLOW'::varchar END as category,
            l.kiosk_id as kiosk_id,
            k.title as kiosk_title,
            l.product_id as product_id,
            p.title as product_tile,
            l.epc as epc
            FROM pantry.label l
            JOIN pantry.product p ON l.product_id = p.id
            JOIN pantry.kiosk k ON l.kiosk_id = k.id
            --- Get next delivery date
            JOIN (select location_number,
                min(route_date_time) as next_delivery_date
                FROM mixalot.route_stop
                WHERE route_date_time::date > now()::date
                GROUP BY location_number
            ) as next_delivery
            ON l.kiosk_id = next_delivery.location_number
            WHERE l.status = 'ok'
            AND k.archived = 0
            AND k.campus_id = 87
            AND p.campus_id = 87
            AND (
                    (
                        shelf_time <= 7
                        AND
                        (next_delivery.next_delivery_date::date - to_timestamp(l.time_added)::date) > p.shelf_time
                    )
                    OR
                    (
                        shelf_time > 7
                        AND shelf_time <= 30
                        AND
                        (next_delivery.next_delivery_date::date - to_timestamp(l.time_added)::date) > p.shelf_time
                    )
                )
            ORDER BY kiosk_id, category;
    END;
$$;


ALTER FUNCTION inm.get_spoilage_pull_list() OWNER TO erpuser;

--
-- Name: FUNCTION get_spoilage_pull_list(); Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON FUNCTION inm.get_spoilage_pull_list() IS 'return items that will spoil before the next delivery';


--
-- Name: pick_check_duplicate_stop(); Type: FUNCTION; Schema: inm; Owner: erpuser
--

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
          -- duplicate stops
         (select rs.route_date_time, rs.location_number, count(*) from mixalot.route_stop rs
          where rs.route_date_time::date >= current_date and location_number <> -1
          group by 1,2 having count(*) > 1) d
       on s.location_number=d.location_number and s.route_date_time=d.route_date_time;
end;

$$;


ALTER FUNCTION inm.pick_check_duplicate_stop() OWNER TO erpuser;

--
-- Name: pick_check_restriction(date); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_check_restriction(_pick_date date) RETURNS TABLE(kiosk_id integer, product_id integer)
    LANGUAGE plpgsql
    AS $$

/*
Purpose: return restricted products found in allocation. An empty set means no restricted products are allocated for any kiosk.
*/

begin
	return query
		select a.kiosk_id, a.sku_id
			from (select * from inm.pick_allocation a where a.pick_date = _pick_date) a
				join inm.kiosk_product_disabled d on a.kiosk_id = d.kiosk_id and a.sku_id = d.product_id;
end;

$$;


ALTER FUNCTION inm.pick_check_restriction(_pick_date date) OWNER TO erpuser;

--
-- Name: pick_get_delivery_schedule(date); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_delivery_schedule(pick_date date) RETURNS TABLE(driver_name character varying, route_date_time timestamp with time zone, kiosk_id integer, kiosk_title character varying, address character varying, delivery_order integer)
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
	if pick_date is not null
		then
			-- compose US/Pacific start window timestamp string
			pst_plan_window_start_str = cast(pick_date as text) || ' 13:00 -8';
			select into plan_window_start cast(pst_plan_window_start_str as timestamp with time zone);
			plan_window_stop = plan_window_start + interval '22 hours';

		-- fixme: remove when obsolete
		-- backward compat with run pick using inm gsheets with plan window imported into mixalot.inm_data
		else
			select max(import_ts) from mixalot.inm_data into latest_import_ts;
			select i.route_date from mixalot.inm_data i
				where import_ts = latest_import_ts and data_type = 'Plan Window Start'
				into plan_window_start;
			select i.route_date from mixalot.inm_data i
				where import_ts = latest_import_ts and data_type = 'Plan Window Stop'
				into plan_window_stop;
		end if;

	return query
		select rs.driver_name, rs.route_date_time, location_number kiosk_id, k.title kiosk_title, k.address, rs.stop_number delivery_order
			from mixalot.route_stop rs join pantry.kiosk k on rs.location_number = k.id
			where rs.route_date_time between plan_window_start and plan_window_stop;
end;

$$;


ALTER FUNCTION inm.pick_get_delivery_schedule(pick_date date) OWNER TO erpuser;

--
-- Name: pick_get_demand_weekly_by_velocity(); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_demand_weekly_by_velocity() RETURNS TABLE(kiosk_id bigint, sku_group_id integer, fc_title text, kc_start_level numeric, kc_min_level numeric, kc_manual_multiplier numeric, sgc_default_level numeric, sgc_scale numeric, ksms_scale numeric, ws_live bigint, velocity_demand numeric, demand_weekly numeric)
    LANGUAGE plpgsql
    AS $$

/*
revision date: 2019-01-09
purpose: return inm weekly demand by velocity
*/

begin
	return query
		select cast(dwwom.kiosk_id as bigint),
			dwwom.sku_group_id,
			dwwom.sku_group,
			dwwom.kc_start_level,
			dwwom.kc_min_level,
			dwwom.kc_manual_multiplier,
			dwwom.sgc_default_level,
			dwwom.sgc_scale,
			dwwom.ksms_scale,
			dwwom.ws_live,
			dwwom.preference_count,

			case when dwwom.ws_live < 4
			then greatest(dwwom.start_count, dwwom.preference_count)
			else greatest(dwwom.min_count, dwwom.preference_count)
			end as wk_demand

		from inm.pick_get_demand_weekly_wo_min() dwwom;
end;

$$;


ALTER FUNCTION inm.pick_get_demand_weekly_by_velocity() OWNER TO erpuser;

--
-- Name: pick_get_demand_weekly_wo_min(); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_demand_weekly_wo_min() RETURNS TABLE(kiosk_id integer, sku_group_id integer, sku_group text, sample_size bigint, preference numeric, ws_avg numeric, ws_std numeric, ws_live bigint, kc_start_level numeric, kc_min_level numeric, kc_manual_multiplier numeric, sgc_default_level numeric, sgc_scale numeric, ksms_scale numeric, start_count numeric, min_count numeric, scaled_preference numeric, scaled_preference_total numeric, preference_count numeric)
    LANGUAGE plpgsql
    AS $$
  /*
    revision date: 2019-01-09
    author: Art
    purpose: return inm_beta weekly demand without min by velocity
    */

begin
  return query
    select kc.kiosk_id as kiosk_id,
      sg.id as sku_group_id,
      cast(sg.fc_title as text) as sku_group,
      coalesce(dwwom.sample_size, 0) as sample_size, -- dwwom missing some records for archived/old kiosks
      coalesce(dwwom.preference, 0.00) as preference, -- dwwom missing some records for archived/old kiosks
      max(coalesce(dwwom.ws_avg, 0.00)) over (partition by kc.kiosk_id) as ws_avg, --dwwom missing some records for archived/old kiosks
      max(coalesce(dwwom.ws_std, 0.00)) over (partition by kc.kiosk_id) as ws_std, --dwwom missing some records for archived/old kiosks
      max(coalesce(dwwom.ws_live, 0)) over (partition by kc.kiosk_id) as ws_live, -- dwwom missing some records for archived/old kiosks
      kc.start_level as kc_start_level,
      kc.min_level as kc_min_level,
      kc.manual_multiplier as kc_manual_multiplier,
      sgc.default_level as sgc_default_level,
      sgc.scale as sgc_scale,
      coalesce(ksms.scale, 1.00) as ksms_scale,
      round(kc.start_level*kc.manual_multiplier*sgc.scale*coalesce(ksms.scale, 1.00)*sgc.scale*sgc.default_level, 2)
        as start_count,
      round(kc.min_level*kc.manual_multiplier*sgc.scale*coalesce(ksms.scale, 1.00)*sgc.scale*sgc.default_level, 2)
        as min_count,
      round(coalesce(dwwom.preference, 0.00)*kc.manual_multiplier*sgc.scale*coalesce(ksms.scale, 1.00), 2)
        as scaled_preference,
      round(sum(coalesce(dwwom.preference, 0.00)*kc.manual_multiplier*sgc.scale*coalesce(ksms.scale, 1.00))
        over (partition by kc.kiosk_id), 2) as scaled_preference_total,
      round(coalesce(dwwom.ws_avg + dwwom.ws_std, 0.00)
              * (coalesce(dwwom.preference, 0.00)*kc.manual_multiplier*sgc.scale
                   *coalesce(ksms.scale, 1.00)
                   / greatest(0.01, sum(coalesce(dwwom.preference, 0.00)*kc.manual_multiplier*sgc.scale*coalesce(ksms.scale, 1.00))
                     over (partition by kc.kiosk_id))), 2) as preference_count
    from inm.sku_group sg
           cross join inm.kiosk_control kc
           left join inm.kiosk_sku_group_manual_scale ksms on ksms.kiosk_id=kc.kiosk_id and ksms.sku_group_id=sg.id
           left join inm.sku_group_control sgc on sgc.sku_group_id = sg.id
           left join
      (select t4.kiosk_id,
         t4.sku_group,
         t4.sample_size,
         t4.dt_avg,
         t4.dt_std,
         t4.w_departure_time,
         t4.preference,
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
            greatest(coalesce(round((t2.time_sold - greatest(t2.last_sale, t2.time_stocked))::numeric/3600, 2), 50.00), 1.00)
              as departure_time,
            0 as qty_sold,
            1 as w
          from (
            select *,
              lag(t1.time_sold, 1) over (partition by t1.kiosk_id, t1.sku_group order by t1.time_sold)
                as last_sale,
              lag(t1.purchase_index, 1) over (partition by t1.kiosk_id, t1.sku_group order by t1.time_sold)
                as last_purchase_index
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
              ) k
                     cross join (
                  select distinct fc_title as sku_group
                  from pantry.product p
                  where p.campus_id=87
                  and p.archived=0
                  and p.fc_title is not null
                  and p.fc_title!='n/a'
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
                  and to_timestamp(l.time_updated) at time zone 'us/pacific' > date_trunc('week', current_timestamp)
                                                                                 - interval '24 weeks'
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
        -- get sale average and standard diviation
          (select t5.kiosk_id, round(avg(units_sold), 2) ws_avg, round(stddev(units_sold), 2) ws_std, count(units_sold) ws_live
          from (
            -- get units sold per week over last 3 month
            select concat(kk.kiosk_id::character varying(4), ' ', kk.woy) as key,
              kk.kiosk_id,
              kk.woy,
              ss.units_sold
            from (
              select k.id as kiosk_id,
                generate_series(1, 52) as woy
              from pantry.kiosk k
              where k.campus_id = 87 and k.archived = 0) kk
                   left join (
                select s.kiosk_id,
                  date_part('week'::text, s.ts) as woy,
                  count(*) as units_sold
                from byte_epcssold_3months s
                group by s.kiosk_id, (date_part('week'::text, s.ts))) ss
                     on kk.kiosk_id = ss.kiosk_id and kk.woy::double precision = ss.woy
            order by ss.kiosk_id, ss.woy) t5
          group by t5.kiosk_id
          order by t5.kiosk_id asc
          ) t6 on t4.kiosk_id=t6.kiosk_id) dwwom on dwwom.kiosk_id = kc.kiosk_id and dwwom.sku_group = sg.fc_title;


end;

$$;


ALTER FUNCTION inm.pick_get_demand_weekly_wo_min() OWNER TO erpuser;

--
-- Name: FUNCTION pick_get_demand_weekly_wo_min(); Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON FUNCTION inm.pick_get_demand_weekly_wo_min() IS 'return inm_beta weekly demand without min by velocity';


--
-- Name: pick_get_order(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_qty integer, plan_qty integer)
    LANGUAGE plpgsql ROWS 10000
    AS $$
  /*
    purpose - return inm order for the next sale period which is the time between the deliveries of this pick and the next pick
    comment - why go through this function and not call pick_get_order_with_velocity(start_date, end_date) directly? there are 2 reasons:
      1. we can replace pick_get_order_with_velocity with a newer fucntion here and not having to change the client code to test the new function.
      2. pick_get_order_with_velocity returns richer data that can be used for troubleshooting which is not necessary for production.
    
    input -
      start_ts: plan window start date time with time zone
      end_ts: plan window end date time with time zone
    return -
      kiosk_id: together with route_date_time is unique for the plan window
      route_date_time: route starting date time
      fc_title: sku group name
      plan_qty: order quantity for the above fc_title for the next sale period
    */

declare latest_import_ts_for_pick_window timestamp with time zone;
begin
	return query
		-- seletively comment to use week order calc or between delivery order calc

		-- sales ratio
		-- select osr.kiosk_id, osr.route_date_time, osr.sku_group_id, osr.fc_title, osr.week_demand_qty, cast(osr.plan_order_qty as integer) from inm.hh_sales_ratio(start_ts, end_ts) osr;

		-- with sales ratio and velocity
		select distinct ov.kiosk_id, ov.route_date_time, ov.sku_group_id, ov.fc_title,
			cast(ceiling(ov.week_demand_qty) as integer), cast(ceiling(ov.plan_order_qty) as integer)
			from inm.pick_get_order_with_velocity(start_ts, end_ts) ov;

end;

$$;


ALTER FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO erpuser;

--
-- Name: pick_get_order_with_velocity(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sku_group_id integer, fc_title text, week_demand_qty numeric, plan_demand_qty numeric, plan_order_qty numeric)
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
declare overstock_multiplier numeric;

begin
	select c.value into overstock_multiplier from inm.configuration c where c.setting = 'overstock_multiplier';

	return query
		--  Given
		--		sales period = time between this pick delivery and next pick delivery (may be changed to pick times in the future)
		--		inm.demand_weekly = week demand
		--		sr.sales_ratio = sale ratio for this sum items sold for pick sales period for the last 4 weeks vs items sold for the last 4 weeks
		-- 	if item is restricted (inm_qty=0), then set demand to 0.
		--  else
		--		if item doesn't exist in the kiosk (inv.count is null), set its inv count to 0
		-- 		order_before_min_max = overstock_multiplier * sr.sales_ratio * inm.demand_weekly - inv.count
		-- 		final_order = min + order_before_min_max, capped by max as defined for each sku group

		select sr.kiosk_id, sr.route_date_time, sga.id, dwbv.fc_title, dwbv.demand_weekly as week_demand_qty,
					 cast(overstock_multiplier * sr.sales_ratio * dwbv.demand_weekly as numeric (8,2)) plan_demand_qty,
					 case
						 -- restricted item if demand_weekly is 0 or kiosk_sku_group manual scale is zero
						 when dwbv.demand_weekly = 0 or ksms.scale = 0.0 then 0
						 else
							 ceiling(
								 -- change minimum is 0 (don't remove from a kiosk)
									 least(greatest(least(overstock_multiplier * sr.sales_ratio * dwbv.demand_weekly, dwbv.demand_weekly) + sga.minimum_kiosk_qty - coalesce(inv.count, 0),
																	0) /* change negative demand to 0 */
										 , sga.maximum_kiosk_qty))
						 end as plan_order_qty -- end case

		from inm.pick_get_sales_period_ratio(start_ts, end_ts) sr

					 join inm.pick_get_demand_weekly_by_velocity() dwbv
								on sr.kiosk_id = dwbv.kiosk_id

					 join inm.sku_group_attribute sga
								on sga.title = dwbv.fc_title
					 left join inm.kiosk_projected_stock inv
										 on dwbv.kiosk_id = inv.kiosk_id and dwbv.fc_title = inv.fc_title
					 left join inm.kiosk_sku_group_manual_scale ksms
										 on sr.kiosk_id = ksms.kiosk_id and sga.id = ksms.sku_group_id;
end;
$$;


ALTER FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO erpuser;

--
-- Name: pick_get_plan_kiosk(date); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_plan_kiosk(pick_date date) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, driver_name character varying, location_name character varying, next_delivery_ts timestamp with time zone, time_to_next_delivery interval, days_to_next_delivery double precision, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$

declare
	pst_plan_window_start_str text;
	plan_window_start timestamp with time zone;
	plan_window_stop timestamp with time zone;
/*
purpose: return inm plan kiosks for a pick date.
*/

begin
	-- compose us/pacific start window timestamp string
	pst_plan_window_start_str = cast(pick_date as text) || ' 13:00 -8';

	select into plan_window_start cast(pst_plan_window_start_str as timestamp with time zone);
	plan_window_stop = plan_window_start + interval '22 hours';
	return query
		select * from inm.pick_get_plan_kiosk(plan_window_start, plan_window_stop);
end;

$$;


ALTER FUNCTION inm.pick_get_plan_kiosk(pick_date date) OWNER TO erpuser;

--
-- Name: pick_get_plan_kiosk(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, driver_name character varying, location_name character varying, next_delivery_ts timestamp with time zone, time_to_next_delivery interval, days_to_next_delivery double precision, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$

/*
purpose: return inm plan kiosks for a pick window.
*/

begin
	return query
		select * from inm.pick_get_plan_kiosk_optimo(plan_window_start, plan_window_stop);
end;

$$;


ALTER FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;

--
-- Name: pick_get_plan_kiosk_disabled_product(date); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) RETURNS TABLE(kiosk_id bigint, product_id bigint)
    LANGUAGE plpgsql
    AS $$
  /*
    purpose: return disabled products for kiosks on the pick for a pick date.
    */

begin
	return query
		select dp.kiosk_id, dp.product_id
		from inm.pick_get_plan_kiosk(pick_date) pk
			join inm.kiosk_product_disabled dp on pk.kiosk_id = dp.kiosk_id;
end;

$$;


ALTER FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) OWNER TO erpuser;

--
-- Name: pick_get_plan_kiosk_optimo(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, driver_name character varying, location_name character varying, next_delivery_ts timestamp with time zone, time_to_next_delivery interval, days_to_next_delivery double precision, delivery_order bigint)
    LANGUAGE plpgsql
    AS $$

/*
purpose: return inm plan kiosks for a pick window.
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
		-- kiosk_id, delivery_date
		(select t.kiosk_id, t.route_date_time, t.driver_name, t.location_name from
			(select location_number as kiosk_id, rs.route_date_time, rs.driver_name, rs.location_name,
				rank() over (partition by location_number, rs.route_date_time order by rs.route_date_time) as r
				from mixalot.route_stop rs
				where rs.route_date_time >= plan_window_start -- look at routes starting at plan winddow start
				and location_number > 0) t
				where r = 1) ds

		left join
		-- kiosk_id, pull_date
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


ALTER FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;

--
-- Name: pick_get_plan_kiosk_projected_stock(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) RETURNS TABLE(kiosk_id integer, fc_title character varying, qty integer)
    LANGUAGE plpgsql COST 1000 ROWS 10000
    AS $$

  /*
    purpose: return projected stock for plan kiosks for a pick window.
    */

begin
	return query
		select pk.kiosk_id, kps.fc_title, cast(kps.count as integer) from inm.pick_get_plan_kiosk(plan_window_start, plan_window_stop) pk
		join inm.kiosk_projected_stock kps on pk.kiosk_id = kps.kiosk_id;
end;

$$;


ALTER FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;

--
-- Name: pick_get_sales_period_ratio(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sales_ratio numeric)
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

  -- FIX ME:
  -- handle missing past data
  -- check kid with multiple deliveries
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
          -- count of sales for the whole previous 4 weeks
          (select pk.kiosk_id, pk.route_date_time, count(*) qty
           from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
                  join pantry.label l on pk.kiosk_id=l.kiosk_id
           where l.status in ('sold') -- 20190213 changed from ('out', 'sold')
             and to_timestamp(l.time_updated) between
               pk.next_delivery_ts - interval '91 days'
             and pk.next_delivery_ts - interval '7 days'
           group by 1, 2
          ) whole_12_weeks

            join

          -- count of sales for the sales peiod of previous 4 weeks
            (
              select pk.kiosk_id, pk.route_date_time, count(*) qty
              from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
                     join pantry.label l on pk.kiosk_id=l.kiosk_id
              where l.status in ('sold') and  -- 20190213 changed from ('out', 'sold')
                (
                    to_timestamp(l.time_updated) between now() - interval '7 days'  + interval '4 hours' and pk.next_delivery_ts - interval '7 days'  + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '14 days' + interval '4 hours' and pk.next_delivery_ts - interval '14 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '21 days' + interval '4 hours' and pk.next_delivery_ts - interval '21 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '28 days' + interval '4 hours' and pk.next_delivery_ts - interval '28 days' + interval '4 hours' or

                    to_timestamp(l.time_updated) between now() - interval '35 days' + interval '4 hours' and pk.next_delivery_ts - interval '35 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '42 days' + interval '4 hours' and pk.next_delivery_ts - interval '42 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '49 days' + interval '4 hours' and pk.next_delivery_ts - interval '49 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '56 days' + interval '4 hours' and pk.next_delivery_ts - interval '56 days' + interval '4 hours' or

                    to_timestamp(l.time_updated) between now() - interval '63 days' + interval '4 hours' and pk.next_delivery_ts - interval '63 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '70 days' + interval '4 hours' and pk.next_delivery_ts - interval '70 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '77 days' + interval '4 hours' and pk.next_delivery_ts - interval '77 days' + interval '4 hours' or
                    to_timestamp(l.time_updated) between now() - interval '84 days' + interval '4 hours' and pk.next_delivery_ts - interval '84 days' + interval '4 hours'
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '7 days'  + interval '4 hours' and pk.next_delivery_ts - interval '7 days'  + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '14 days' + interval '4 hours' and pk.next_delivery_ts - interval '14 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '21 days' + interval '4 hours' and pk.next_delivery_ts - interval '21 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '28 days' + interval '4 hours' and pk.next_delivery_ts - interval '28 days' + interval '4 hours' or
                  --
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '35 days' + interval '4 hours' and pk.next_delivery_ts - interval '35 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '42 days' + interval '4 hours' and pk.next_delivery_ts - interval '42 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '49 days' + interval '4 hours' and pk.next_delivery_ts - interval '49 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '56 days' + interval '4 hours' and pk.next_delivery_ts - interval '56 days' + interval '4 hours' or
                  --
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '63 days' + interval '4 hours' and pk.next_delivery_ts - interval '63 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '70 days' + interval '4 hours' and pk.next_delivery_ts - interval '70 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '77 days' + interval '4 hours' and pk.next_delivery_ts - interval '77 days' + interval '4 hours' or
                  -- 									 to_timestamp(l.time_updated) between pk.route_date_time - interval '84 days' + interval '4 hours' and pk.next_delivery_ts - interval '84 days' + interval '4 hours'
                  )
              group by 1, 2
            ) period_12_weeks

          on whole_12_weeks.kiosk_id = period_12_weeks.kiosk_id
      ) existing_kiosk_with_sales_ratio

                     on scheduled_kiosks.kiosk_id = existing_kiosk_with_sales_ratio.kiosk_id and scheduled_kiosks.route_date_time = existing_kiosk_with_sales_ratio.route_date_time;

end;

$$;


ALTER FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO erpuser;

--
-- Name: pick_get_summary(date); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_summary(target_date date) RETURNS TABLE(property text, name text, value text)
    LANGUAGE plpgsql
    AS $$

/*
returns pick summary for a given date.
*/

declare
	pick_tickets_generated integer;
	-- one-based arrays of 3 numbers, 1 for target date and 2 for the same weekday one and two weeks ago
	ticket integer array;
	demand integer array;
	allocation integer array;
	property text;
	name text;
	value text;
	total integer;
	result_row record;
	kiosks_added text;
	kiosks_removed text;
	percentage integer;

begin

	for i in 0..2 loop
 		select count(*) from inm.pick_route where pick_date = target_date - 7*i  into total;
		ticket[i+1] = total; -- convert to one-based index
		select sum(qty) from inm.pick_demand where pick_date = target_date - 7*i into total;
		demand[i+1] = total;
		select sum(qty) from inm.pick_allocation where pick_date = target_date - 7*i into total;
		allocation[i+1] = total;
   	end loop;

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
	value = coalesce(demand[1], 0) || '/' || coalesce(demand[2],0) || '/' || coalesce(demand[3],0);
	return query select property, name, value;

	property = 'stats';
	name = 'allocation qty today/ -7 days/ -14 days: ';
	value = coalesce(allocation[1], 0) || '/' || coalesce(allocation[2], 0) || '/' || coalesce(allocation[3], 0);
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


ALTER FUNCTION inm.pick_get_summary(target_date date) OWNER TO erpuser;

--
-- Name: pick_get_ticket(date); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_get_ticket(target_date date) RETURNS TABLE(pick_station bigint, vendor character varying, item_code bigint, item_name character varying, site_code bigint, site_name character varying, proposed_supply integer, total_pick_qty bigint, total_pick_sku integer, driver_name character varying, route_date date, route_time time without time zone, route_date_time timestamp without time zone, route_number character varying, restrictions text, address character varying, pull_date date, delivery_order integer, pick_order smallint)
    LANGUAGE plpgsql
    AS $$
declare
  pst_plan_window_start_str text;
  latest_import_ts timestamp;
  plan_window_start timestamp;
  plan_window_stop timestamp;
begin
  /*
  Return pick ticket records
  Last modified 2019-02-28: get pick_order from allocable inventory instead of inm_data
   */

  if target_date is not null
    then
      -- compose US/Pacific start window timestamp string
      pst_plan_window_start_str = cast(target_date as text) || ' 13:00 -8';
      select into plan_window_start cast(pst_plan_window_start_str as timestamp with time zone);
      plan_window_stop = plan_window_start + interval '22 hours';

      -- fixme: remove when obsolete
      -- backward compat with run pick using inm gsheets with plan window imported into mixalot.inm_data
    else
      select max(import_ts) from mixalot.inm_data into latest_import_ts;
      select i.route_date from mixalot.inm_data i
      where import_ts = latest_import_ts and data_type = 'Plan Window Start'
        into plan_window_start;
      select i.route_date from mixalot.inm_data i
      where import_ts = latest_import_ts and data_type = 'Plan Window Stop'
        into plan_window_stop;
      target_date = plan_window_start::date;
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

           --  old: use mixalot.inm_data
           -- left join mixalot.sku_pick_order(latest_import_ts) spo on p.id = spo.sku_id

          left join
            (select a.product_id, a.pick_order from inm.allocable_inventory a where inventory_date = target_date) spo on p.id=spo.product_id

    where k.campus_id = 87
      and a.pick_date = target_date;
end

$$;


ALTER FUNCTION inm.pick_get_ticket(target_date date) OWNER TO erpuser;

--
-- Name: pick_submit(date, integer, integer); Type: FUNCTION; Schema: inm; Owner: erpuser
--

CREATE FUNCTION inm.pick_submit(target_date date, overwrite integer DEFAULT 0, wait_time_seconds integer DEFAULT 300, OUT submit_status text) RETURNS text
    LANGUAGE plpgsql
    AS $$

/*
purpose - submit a pick with task_option controlling how to deal with conflict.

input -
  target_date: pick date
  overwrite: 0 or 1. if 1, overwrite old pick.
  timeout_seconds: minimum amount of time the task can be in status = "started" before it's considered timed out
return -
  submitted_status:
  	submitted - pick submitted.
	started - a pick already in progress for target date.
	ready - a completed pick already existed (and overwrite=0)
*/

declare
	_status text;

begin
	-- delete existing pick for target date if overwrite=1
	if overwrite = 1
		then delete from inm.pick_list where pick_date = target_date;
	-- delete failed and timed out items
	else
		delete from inm.pick_list p
			-- where (pick_date = target_date and create_ts + wait_time_seconds < now())
			where (pick_date = target_date
				   	and extract(epoch from now() - create_ts) > timeout_seconds)
				or status = 'failed';
	end if;

	-- remaining pick_list entry for target date is a pick that is in progress and should not be deleted
	select status
		from inm.pick_list where pick_date = target_date
		into _status;

	if _status is null
		then insert into inm.pick_list(pick_date, timeout_seconds) values(target_date, wait_time_seconds);
		submit_status = 'submitted';
	else submit_status = _status;
	end if;
end;

$$;


ALTER FUNCTION inm.pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text) OWNER TO erpuser;

--
-- Name: get_pull_date(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm_test; Owner: erpuser
--

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
      -- delivery date
      dd as
        (select t.kiosk_id, t.delivery_date_time as delivery_dt from
          (select location_number as kiosk_id, rs.route_date_time as delivery_date_time,
                  dense_rank() over (partition by location_number order by rs.route_date_time) as r
           from mixalot.route_stop rs
           where rs.route_date_time >= plan_window_start -- routes starting at plan window start
             and rs.route_date_time <= plan_window_stop
             and location_number > 0) t
         where r = 1),

      -- normal pull date
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

      -- possible enhanced pull dates - start with next 7 days before narrowing down to the best day
      pepd as
        (select d as pull_date, extract(dow from d) as dow
          from (select generate_series(plan_window_start,
            plan_window_start::timestamp + interval '6 days', interval '1 days')::date as d) dates),

      -- sales_history - kiosk and dow with sales
      sales_history as
        (select v.kiosk_id, v.dow
          from inm.v_kiosk_sale_hourly v
          group by 1, 2
          having sum(units_sold_normalized) >= 0.05),

      -- kiosk_id, delivery_date, enhanced_pull_date
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

  -- return kiosk_id, delivery_date, the best pull date
  select dd.kiosk_id, 
         dd.delivery_dt::date, 
         coalesce(epd.pull_date, npd.pull_date::date) as pull_date
    from dd
      join npd on dd.kiosk_id = npd.kiosk_id
      left join epd on dd.kiosk_id = epd.kiosk_id;
end;

$$;


ALTER FUNCTION inm_test.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;

--
-- Name: get_pull_date_enhanced(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm_test; Owner: erpuser
--

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
      -- kiosk_id, delivery_date
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
              --o.pull_date_time as pull_date_time_old,
              if(o.os = 0, o.pull_date_time,
                 (o.pull_date_time - interval '1 day' * (o.os + 1))) pull_date_time
              --if(o.os=0, o.os, o.os+1) as offset

       -- what is this o table?
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

              -- next delivery date
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
        -- kiosk_id, pull_date
        -- 			(select t.kiosk_id, t.delivery_date_time - interval '1 day' pull_date_time from
        -- 				(select location_number as kiosk_id, rs.route_date_time::date as delivery_date_time,
        -- 					rank() over (partition by location_number order by rs.route_date_time) as r
        -- 					from mixalot.route_stop rs
        -- 					where rs.route_date_time >= plan_window_start -- look at routes starting at plan window start
        -- 					and location_number > 0) t
        -- 					where r = 2) ps

      on ds.kiosk_id = ps.kiosk_id
        join pantry.kiosk k on ds.kiosk_id = k.id
    where ds.delivery_date_time between plan_window_start and plan_window_stop
      and k.campus_id = 87;
end;

$$;


ALTER FUNCTION inm_test.get_pull_date_enhanced(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) OWNER TO erpuser;

--
-- Name: pick_get_delivery_schedule(date); Type: FUNCTION; Schema: inm_test; Owner: erpuser
--

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
    -- compose US/Pacific start window timestamp string
    pst_plan_window_start_str = cast(pick_date as text) || ' 13:00 -8';
    select into plan_window_start cast(pst_plan_window_start_str as timestamp with time zone);
    plan_window_stop = plan_window_start + interval '22 hours';

    -- fixme: remove when obsolete
    -- backward compat with run pick using inm gsheets with plan window imported into mixalot.inm_data

  return query
    select rs.driver_name, rs.route_date_time, location_number kiosk_id, k.title kiosk_title, k.address, rs.stop_number delivery_order
    from mixalot.route_stop rs join pantry.kiosk k on rs.location_number = k.id
    where rs.route_date_time between plan_window_start and plan_window_stop;
end;

$$;


ALTER FUNCTION inm_test.pick_get_delivery_schedule(pick_date date) OWNER TO erpuser;

--
-- Name: sales_ratio_debug(timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: inm_test; Owner: erpuser
--

CREATE FUNCTION inm_test.sales_ratio_debug(start_ts timestamp with time zone, end_ts timestamp with time zone) RETURNS TABLE(kiosk_id integer, route_date_time timestamp with time zone, sales_ratio numeric, whole_qty bigint, period_qty bigint)
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

  -- FIX ME:
  -- handle missing past data
  -- check kid with multiple deliveries
begin
  return query
    select scheduled_kiosks.kiosk_id, scheduled_kiosks.route_date_time, coalesce(existing_kiosk_with_sales_ratio.ratio, 1.0/3.0),
           existing_kiosk_with_sales_ratio.whole_qty, existing_kiosk_with_sales_ratio.period_qty
    from inm.pick_get_plan_kiosk(start_ts, end_ts) scheduled_kiosks -- all the kiosks on route
           left join -- kiosks with sales history
      (
        select whole_12_weeks.kiosk_id, whole_12_weeks.route_date_time,
               case when whole_12_weeks.qty < 5 then 1.0/3.0 -- new kiosk, assume period sale is 1/3 of total week
                    else cast(period_12_weeks.qty as decimal)/cast(whole_12_weeks.qty as decimal)
                 end ratio, whole_12_weeks.qty whole_qty, period_12_weeks.qty period_qty
        from
          -- count of sales for the whole previous 12 weeks
          (select pk.kiosk_id, pk.route_date_time, count(*) qty
           from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
                  join pantry.label l on pk.kiosk_id=l.kiosk_id
           where l.status in ('out', 'sold')
             and to_timestamp(l.time_updated) between
               pk.next_delivery_ts - interval '91 days'
             and pk.next_delivery_ts - interval '7 days'
           group by 1, 2
          ) whole_12_weeks

            join

          -- count of sales for the sales peiod of previous 4 weeks
            (
              select pk.kiosk_id, pk.route_date_time, count(*) qty
              from inm.pick_get_plan_kiosk(start_ts, end_ts) pk
                     join pantry.label l on pk.kiosk_id=l.kiosk_id
              where l.status in ('out', 'sold') and
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


ALTER FUNCTION inm_test.sales_ratio_debug(start_ts timestamp with time zone, end_ts timestamp with time zone) OWNER TO erpuser;

--
-- Name: test_get_product_record(integer); Type: FUNCTION; Schema: migration; Owner: erpuser
--

CREATE FUNCTION migration.test_get_product_record(pid integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
declare
  result record;
begin

      select * from migration.product where id=pid;

end;

$$;


ALTER FUNCTION migration.test_get_product_record(pid integer) OWNER TO erpuser;

--
-- Name: get_label_order_epc(); Type: FUNCTION; Schema: pantry; Owner: erpuser
--

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


ALTER FUNCTION pantry.get_label_order_epc() OWNER TO erpuser;

--
-- Name: FUNCTION get_label_order_epc(); Type: COMMENT; Schema: pantry; Owner: erpuser
--

COMMENT ON FUNCTION pantry.get_label_order_epc() IS 'retrieves tag data and generates epc for scheduled label orders';


--
-- Name: sync_campus(); Type: FUNCTION; Schema: pantry; Owner: erpuser
--

CREATE FUNCTION pantry.sync_campus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  _target_record record;
  _insync BOOLEAN;

  -- Define same table two-way sync trigger function. To prevent circular sync,
  -- compare incoming record with existing record and cancel the trigger if
  -- the two are exactly the same.
begin
  -- calculate sync status of the triggered record
  if tg_op in ('INSERT', 'UPDATE')
    then
      select * from pantry.campus where id = new.id into _target_record;
      -- is the new version of record the same as the current record
      _insync = (_target_record = new);
    else
      _insync = false;
  end if;

  if _insync
    -- don't process the current trigger because the record is already in sync
    then
      return null;
    -- record is not in sync, so process the current trigger
    else
      -- return appropriate value for insert/update/delete to be performed by the system trigger handler
      if tg_op in ('INSERT', 'UPDATE')
        then
          return new;
        else
          return old;
      end if;
  end if;
end;
$$;


ALTER FUNCTION pantry.sync_campus() OWNER TO erpuser;

--
-- Name: sync_label_order(); Type: FUNCTION; Schema: pantry; Owner: erpuser
--

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
  -- calculate sync status of the triggered record
  if tg_op in ('INSERT', 'UPDATE')
  then
    select * from pantry.label_order where id = new.id into _target_record;
    -- is the new version of record the same as the current record
    _insync = (_target_record = new);
  else
    _insync = false;
  end if;

  if _insync
    -- don't process the current trigger because either _skip_trigger is set, or the record is already in sync
  then
    return null;
    -- record is not in sync, so process the current trigger
  else
    -- return appropriate value for insert/update/delete to be performed by the system trigger handler
    if tg_op in ('INSERT', 'UPDATE')
    then
      return new;
    else
      return old;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pantry.sync_label_order() OWNER TO erpuser;

--
-- Name: awsdms_intercept_ddl(); Type: FUNCTION; Schema: public; Owner: erpuser
--

CREATE FUNCTION public.awsdms_intercept_ddl() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
  declare _qry text;
BEGIN
  if (tg_tag='CREATE TABLE' or tg_tag='ALTER TABLE' or tg_tag='DROP TABLE') then
	    SELECT current_query() into _qry;
	    insert into public.awsdms_ddl_audit
	    values
	    (
	    default,current_timestamp,current_user,cast(TXID_CURRENT()as varchar(16)),tg_tag,0,'',current_schema,_qry
	    );
	    delete from public.awsdms_ddl_audit;
 end if;
END;
$$;


ALTER FUNCTION public.awsdms_intercept_ddl() OWNER TO erpuser;

--
-- Name: dowhour(timestamp with time zone); Type: FUNCTION; Schema: public; Owner: erpuser
--

CREATE FUNCTION public.dowhour(timestamp with time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT ((1+extract(DOW FROM $1))*100 + extract(hour from $1))::int
$_$;


ALTER FUNCTION public.dowhour(timestamp with time zone) OWNER TO erpuser;

--
-- Name: if(boolean, anyelement, anyelement); Type: FUNCTION; Schema: public; Owner: erpuser
--

CREATE FUNCTION public.if(boolean, anyelement, anyelement) RETURNS anyelement
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CASE WHEN ($1) THEN ($2) ELSE ($3) END
$_$;


ALTER FUNCTION public.if(boolean, anyelement, anyelement) OWNER TO erpuser;

--
-- Name: make_odd_or_even_sequence(text, text, text); Type: FUNCTION; Schema: public; Owner: erpuser
--

CREATE FUNCTION public.make_odd_or_even_sequence(table_name text, sequence_field_name text, odd_or_even text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
  sequence_name text;
  max_id integer;

  -- Modify table sequence to generate only odd or even id
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


ALTER FUNCTION public.make_odd_or_even_sequence(table_name text, sequence_field_name text, odd_or_even text) OWNER TO erpuser;

--
-- Name: export_consolidated_remittance(date); Type: FUNCTION; Schema: test; Owner: erpuser
--

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
                --- Calculate old tag fees + new tag fees
                (COALESCE(tags_obtained.tags_got, 0) * COALESCE(r.tag_price, 0) +
                 COALESCE(new_tags_obtained.total_price, 0)) as tag_fee,
                ---Combine old tag amount with new tag amount
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
                    --- Per our meeting from https://bytetechnology.atlassian.net/browse/ENG-2291,
                    --- we decided to take the max tag_price for each campus.
                    --- All kiosks are supposed to have the same tag_price within
                    --- a campus, but that's not the case due to data entry errors.
                    max(er.tag_price) as tag_price,
                    sum(er.manual_adjustment) as manual_adjustment,
                    STRING_AGG(er.details, ' | ') as details
                    FROM dw.export_remittance(month_date) er
                    GROUP BY er.name, er.campus_id, er.campus_title, er.email
                ) r
                ON r.campus_id = c.campus_id
                LEFT JOIN
                --- Get the number of tags obtained for each campus
                (SELECT p.campus_id,
                    sum(lo.amount)::int tags_got
                    FROM pantry.label_order lo
                    JOIN pantry.product p
                    ON lo.product_id = p.id
                    WHERE lo.status = 'Fulfilled'
                    --- From the first second of the month
                    AND lo.time_delivery >= extract('EPOCH'
                        FROM ( date_trunc('month', month_date)))::BIGINT
                    --- To the last second of the month
                    AND lo.time_delivery <= extract('EPOCH'
                        FROM (date_trunc('month', month_date + INTERVAL '1 month')))::BIGINT - 1
                    GROUP BY p.campus_id
                ) as tags_obtained
                ON tags_obtained.campus_id = c.campus_id
                LEFT JOIN
                --- Get the tag pricing / number of tags obtained
                --- for each campus using new Tags UI
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


ALTER FUNCTION test.export_consolidated_remittance(month_date date) OWNER TO erpuser;

--
-- Name: export_transaction(timestamp without time zone, timestamp without time zone, character varying); Type: FUNCTION; Schema: test; Owner: erpuser
--

CREATE FUNCTION test.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) RETURNS TABLE(order_id character varying, date_time timestamp with time zone, state character varying, campus_title character varying, campus_id bigint, client_name character varying, kiosk_title character varying, kiosk_id bigint, uid bigint, email character varying, customer_first_name character varying, customer_last_name character varying, vendor character varying, product_tile character varying, sku bigint, menu_category character varying, product_group character varying, qty bigint, total_list_price numeric, price_after_discounts numeric, total_price_after_discounts numeric, total_coupon_value numeric, total_cost numeric, margin numeric, credit_card text, credit_card_number text, approval_code character varying, geo character varying, coupon_code character varying, coupon_campaign character varying)
    LANGUAGE plpgsql
    AS $_$
BEGIN
  RETURN QUERY
    --- This query returns a list of transactions for the selected date range
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
           --- Price after discount = l.price - discounts
           --- Set price to zero if it is negative.
           GREATEST(COALESCE((l.price),0) - COALESCE((CASE WHEN real_discount != 0 AND real_discount
             IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
             price_after_discounts,
           --- Total price after discount. For example, if more than 1 of the item was purchased
           --- Set total to zero if it is negative.
           GREATEST(COALESCE(sum(l.price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
             IS NOT NULL THEN real_discount ELSE  flat_discount END), 0), 0) as
             total_after_discounts,
           --- Total $ coupon value
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

--
-- Name: insert_in_monthly_kiosk_summary(date); Type: FUNCTION; Schema: test; Owner: erpuser
--

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
             --- Get all kiosks
           FROM (SELECT id as kiosk_id,
                        campus_id
                 FROM pantry.kiosk
                ) as kiosks
                  --- The following query is used to get sales totals from the daily fact table at
                  --- a kiosk level
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
             --- The following subquery is used to get manual adjustments at a kiosk level
                  LEFT JOIN (SELECT kiosk_id,
                                    campus_id,
                                    sum(sum) as manual_adjustment,
                                    --- A list of all manual adjustments along with the reasons and kiosk
                                    STRING_AGG( CASE WHEN sum IS NOT NULL
                                                       THEN CONCAT(
                                        --- Add a $ in front of the sum. If it's a negative number, add the
                                        --- sign after the "-"
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
                                  --- date in pantry.manual_adjustment is not an actual date. It’s a period
                                  --- accounting numbers were calculated for with format: "YYYY-MM-H".
                                  --- H can be either "1" for the first half of month and "2" for the entire month
                             WHERE date = TO_CHAR(date_trunc('month', month_date::date) + interval '1' day,
                                                  'YYYY-MM-fmDD')
                               AND ma.archived = 0
                             GROUP BY campus_id, kiosk_id
           ) as manual_adjust
                            ON manual_adjust.kiosk_id = kiosks.kiosk_id
             --- The following subquery is used to get the monthly_lease and connectivity
             --- at a kiosk level for all kiosks that were deployed before or at
             --- the remittance month.
                  LEFT JOIN (SELECT deployed_kiosks.kiosk_id,
                                    deployed_kiosks.campus_id,
                                    COALESCE(monthly_lease, 0) as monthly_lease,
                                    COALESCE(connectivity, 0) as connectivity
                                    --- ALl kiosks deployed at or before the remittance month
                             FROM (SELECT id as kiosk_id,
                                          campus_id
                                   FROM pantry.kiosk
                                   WHERE to_timestamp(deployment_time)::date <=
                                           --- the last day of the given month
                                         (date_trunc('month', month_date) + interval '1 month'
                                           - interval '1 day')::date
                                  ) as deployed_kiosks
                                    LEFT JOIN (SELECT kiosk_id,
                                                      campus_id,
                                                      monthly_lease,
                                                      connectivity
                                               FROM (SELECT a.campus_id,
                                                            kiosk_id,
                                                            --- If prepaid = 0, get the monthly_lease. Prepaid represents the amount
                                                            --- of months  already paid for at the time. If prepaid is greater than
                                                            --- 1, then the client pays $0 for the given month. The monthly_lease
                                                            --- obtained from dw.calculate_prorated_fee returns fee_lease if the
                                                            --- deployment_time != the current month, otherwise, it calculates
                                                            --- and returns the prorated fee based on deployment_time.
                                                            (SELECT prorated_fee FROM dw.calculate_prorated_fee(fee_lease,
                                                                                                                month_date, to_timestamp(k.deployment_time)::date))
                                                              as monthly_lease,
                                                            --- If the deployment date was this month, prorate the connectivity fee,
                                                            --- if not, give the normal fee
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
             --- The following subquery is used to get other kiosk related fees and info
                  LEFT JOIN (SELECT kiosk_id,
                                    a.campus_id,
                                    r.name as fee_plan_name,
                                    a.prepaid as prepaid_number_of_months,
                                    --- licensing_subscription_fee is the set regular licensing fee for each kiosk.
                                    --- This is different from monthly_lease which is the re-calculated licensing
                                    --- fee for a given month. This means that the monhtly_lease
                                    --- can be different for any two given months while the
                                    --- licensing_subscription_fee is set.
                                    fee_lease as licensing_subscription_fee,
                                    r.fee_tags as tag_price,
                                    CONCAT(ROUND(fee_ipc * 100, 2), '%') as payment_processing_rate,
                                    --- prepaid_until = month_date + the number of months left
                                    --- a.prepaid represents the number of months paid in advance, including the
                                    --- current month.
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
                                  --- date in pantry.accounting is not an actual date. It’s a period accounting
                                  --- numbers  were calculated for with format: "YYYY-MM-H".
                                  --- H can be either "1" for the first half of month and "2" for the entire month
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

--
-- Name: FUNCTION insert_in_monthly_kiosk_summary(month_date date); Type: COMMENT; Schema: test; Owner: erpuser
--

COMMENT ON FUNCTION test.insert_in_monthly_kiosk_summary(month_date date) IS 'inserts key metrics in dw.fact_monthly_kiosk_summary';


--
-- Name: insert_sales_after_discount_in_daily_kiosk_sku_summary(date, date); Type: FUNCTION; Schema: test; Owner: erpuser
--

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
                   --- The following subquery is used to get the total amount of $ customers paid. Unlike
                   --- sales_amount_list_price, which is the price tag on an item, this query factors in all discounts
                   --- and coupons applied to a sale. The price on the label table already includes all
                   --- coupons. Discounts need to be subtracted from the total label.price.
                   --- In addition, this query only filters for order states
                   --- ('Placed', 'Processed' ,'Refunded' ) and label status 'sold' OR order state 'PriceFinalized'
                   --- and payment_system  'Complimentary'. The reason is because
                   --- those are the only orders that generated a payment. Amount_list_price on the other
                   --- hand, includes other states regardless of if we received a payment or not.
                   --- Also see ENG-1922 and
                   --- https://docs.google.com/presentation/d/1A9xYMop8u1NR6O5DmcYK8asauV9R-0eiXNiyKpUb6dQ/edit#slide=id.p
           FROM (SELECT (TO_CHAR(date_, 'YYYYMMDD'))::int AS date_id,
                        kiosk_id,
                        product_id,
                        kiosk_campus_id,
                        payment_system,

                        CASE WHEN
                          -- is price positive?
                          COALESCE(sum(price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                            IS NOT NULL THEN real_discount ELSE  flat_discount END), 0) >= 0
                            -- then use it
                            THEN
                              COALESCE(sum(price),0) - COALESCE(sum(CASE WHEN real_discount != 0 AND real_discount
                                IS NOT NULL THEN real_discount ELSE  flat_discount END), 0)
                            -- else use zero
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
                            --- Between the first second of the month and the last second of the month
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

--
-- Name: spoils(date, date); Type: FUNCTION; Schema: test; Owner: erpuser
--

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
                 --- There are duplicated EPCs. This subquery selects the most recent distinct spoiled EPC
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
                                  --- Get the cost from label, if NULL, get cost from product_history, if NULL get cost
                                  --- from product, if NULL get 0. label has the most accurate cost info for
                                  --- the specific epc, then product_history, then product.
                                  COALESCE(l.cost, ph.cost, p.cost,0) as cost,
                                  --- Get the price from product_history, if NULL, get price from label, if NULL get price
                                  --- from product, if NULL get 0. product_history has the most accurate price info for
                                  --- that time, then label, then product.
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


ALTER FUNCTION test.spoils(beginning_date date, ending_date date) OWNER TO erpuser;

--
-- Name: uptime_percentage(date, date); Type: FUNCTION; Schema: test; Owner: erpuser
--

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

    -- where heart_beats > 700
    into total_active_kiosks, measured_heartbeats;

  select 144 * total_active_kiosks *  (end_date - start_date) into expected_heartbeats;

  return query
    select (100 * measured_heartbeats::decimal/expected_heartbeats)::decimal(4,2);

end

$$;


ALTER FUNCTION test.uptime_percentage(start_date date, end_date date) OWNER TO erpuser;

--
-- Name: uptime_ratio(date, date); Type: FUNCTION; Schema: test; Owner: erpuser
--

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

    -- where heart_beats > 700
    into total_active_kiosks, measured_heartbeats;

  select 144 * total_active_kiosks *  (end_date - start_date) into expected_heartbeats;

  return query
    select (measured_heartbeats::decimal/expected_heartbeats)::decimal(6,4);

end

$$;


ALTER FUNCTION test.uptime_ratio(start_date date, end_date date) OWNER TO erpuser;

--
-- Name: deps_restore_dependencies(character varying, character varying); Type: FUNCTION; Schema: util; Owner: erpuser
--

CREATE FUNCTION util.deps_restore_dependencies(p_view_schema character varying, p_view_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
  v_curr record;
begin
  for v_curr in
    (
      select deps_ddl_to_run
      from util.deps_saved_ddl
      where deps_view_schema = p_view_schema and deps_view_name = p_view_name
      order by deps_id desc
    ) loop
    execute v_curr.deps_ddl_to_run;
  end loop;
  delete from util.deps_saved_ddl
  where deps_view_schema = p_view_schema and deps_view_name = p_view_name;
end;
$$;


ALTER FUNCTION util.deps_restore_dependencies(p_view_schema character varying, p_view_name character varying) OWNER TO erpuser;

--
-- Name: FUNCTION deps_restore_dependencies(p_view_schema character varying, p_view_name character varying); Type: COMMENT; Schema: util; Owner: erpuser
--

COMMENT ON FUNCTION util.deps_restore_dependencies(p_view_schema character varying, p_view_name character varying) IS 'part of save/drop/restore dependent views suite: restore previously saved dependent views';


--
-- Name: deps_save_and_drop_dependencies(character varying, character varying); Type: FUNCTION; Schema: util; Owner: erpuser
--

CREATE FUNCTION util.deps_save_and_drop_dependencies(p_view_schema character varying, p_view_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
  v_curr record;
begin
  for v_curr in
    -- return a set of records of schema name, view name, view type (normal or materialized view)
    (
      select obj_schema, obj_name, obj_type from
        (
          with recursive recursive_deps(obj_schema, obj_name, obj_type, depth) as
            (
              select p_view_schema, p_view_name, null::varchar, 0
              union
              select dep_schema::varchar, dep_name::varchar, dep_type::varchar,
                     recursive_deps.depth + 1 from
                (
                  select ref_nsp.nspname ref_schema, ref_cl.relname ref_name,
                    rwr_cl.relkind dep_type,
                    rwr_nsp.nspname dep_schema,
                    rwr_cl.relname dep_name
                  from pg_depend dep
                         join pg_class ref_cl on dep.refobjid = ref_cl.oid
                         join pg_namespace ref_nsp on ref_cl.relnamespace = ref_nsp.oid
                         join pg_rewrite rwr on dep.objid = rwr.oid
                         join pg_class rwr_cl on rwr.ev_class = rwr_cl.oid
                         join pg_namespace rwr_nsp on rwr_cl.relnamespace = rwr_nsp.oid
                  where dep.deptype = 'n'
                  and dep.classid = 'pg_rewrite'::regclass
                ) deps
                  join recursive_deps on deps.ref_schema = recursive_deps.obj_schema
                                           and deps.ref_name = recursive_deps.obj_name
              where (deps.ref_schema != deps.dep_schema or deps.ref_name != deps.dep_name)
            )
          select obj_schema, obj_name, obj_type, depth
          from recursive_deps
          where depth > 0
        ) t
      group by obj_schema, obj_name, obj_type
      order by max(depth) desc
    ) loop

    insert into util.deps_saved_ddl(deps_view_schema, deps_view_name, deps_ddl_to_run)
      select p_view_schema, p_view_name, 'COMMENT ON '
        ||  case
             when c.relkind = 'v' then 'VIEW'
             when c.relkind = 'm' then 'MATERIALIZED VIEW'
             else ''
             end
        || ' ' || n.nspname || '.' || c.relname || ' IS '''
        || replace(d.description, '''', '''''') || ''';'
      from pg_class c
             join pg_namespace n on n.oid = c.relnamespace
             join pg_description d on d.objoid = c.oid and d.objsubid = 0
      where n.nspname = v_curr.obj_schema
        and c.relname = v_curr.obj_name and d.description is not null;

    insert into util.deps_saved_ddl(deps_view_schema, deps_view_name, deps_ddl_to_run)
      select p_view_schema, p_view_name, 'COMMENT ON COLUMN ' || n.nspname || '.' || c.relname
         || '.' || a.attname || ' IS ''' || replace(d.description, '''', '''''') || ''';'
      from pg_class c
             join pg_attribute a on c.oid = a.attrelid
             join pg_namespace n on n.oid = c.relnamespace
             join pg_description d on d.objoid = c.oid and d.objsubid = a.attnum
      where n.nspname = v_curr.obj_schema
        and c.relname = v_curr.obj_name and d.description is not null;

    insert into util.deps_saved_ddl(deps_view_schema, deps_view_name, deps_ddl_to_run)
      select p_view_schema, p_view_name, 'GRANT ' || privilege_type || ' ON ' || table_schema || '.'
         || table_name || ' TO ' || grantee
      from information_schema.role_table_grants
      where table_schema = v_curr.obj_schema and table_name = v_curr.obj_name;

    -- generate statement to create normal view
    if v_curr.obj_type = 'v' then
      insert into util.deps_saved_ddl(deps_view_schema, deps_view_name, deps_ddl_to_run)
        select p_view_schema, p_view_name, 'CREATE VIEW ' || v_curr.obj_schema || '.'
           || v_curr.obj_name || ' AS ' || view_definition
        from information_schema.views
        where table_schema = v_curr.obj_schema and table_name = v_curr.obj_name;

    -- generate statement to create materialized view
    elsif v_curr.obj_type = 'm' then
      insert into util.deps_saved_ddl(deps_view_schema, deps_view_name, deps_ddl_to_run)
        select p_view_schema, p_view_name, 'CREATE MATERIALIZED VIEW ' || v_curr.obj_schema
           || '.' || v_curr.obj_name || ' AS ' || definition
        from pg_matviews
        where schemaname = v_curr.obj_schema and matviewname = v_curr.obj_name;
    end if;

    execute 'DROP ' ||
            case
              when v_curr.obj_type = 'v' then 'VIEW'
              when v_curr.obj_type = 'm' then 'MATERIALIZED VIEW'
              end
      || ' ' || v_curr.obj_schema || '.' || v_curr.obj_name;

  end loop;
end;
$$;


ALTER FUNCTION util.deps_save_and_drop_dependencies(p_view_schema character varying, p_view_name character varying) OWNER TO erpuser;

--
-- Name: FUNCTION deps_save_and_drop_dependencies(p_view_schema character varying, p_view_name character varying); Type: COMMENT; Schema: util; Owner: erpuser
--

COMMENT ON FUNCTION util.deps_save_and_drop_dependencies(p_view_schema character varying, p_view_name character varying) IS 'part of save/drop/restore dependent views suite: store DDL of dependent views then drop the views';


SET default_tablespace = '';

--
-- Name: awsdms_apply_exceptions; Type: TABLE; Schema: aws_dms; Owner: erpuser
--

CREATE TABLE aws_dms.awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);


ALTER TABLE aws_dms.awsdms_apply_exceptions OWNER TO erpuser;

--
-- Name: feedback; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.feedback (
    id bigint NOT NULL,
    rate bigint NOT NULL,
    order_id character varying(45) NOT NULL,
    message character varying(512),
    taste bigint,
    freshness bigint,
    variety bigint,
    value bigint,
    ticket_created bigint
);


ALTER TABLE pantry.feedback OWNER TO erpuser;

--
-- Name: kiosk; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.kiosk (
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


ALTER TABLE pantry.kiosk OWNER TO erpuser;

--
-- Name: order; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry."order" (
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


ALTER TABLE pantry."order" OWNER TO erpuser;

--
-- Name: all_raw_orders; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.all_raw_orders AS
 SELECT o.order_id,
    o.first_name,
    o.last_name,
    o.kiosk_id,
    o.kiosk_title,
    o.email,
    o.amount_paid,
    o.payment_system,
    o.transaction_id,
    o.approval_code,
    o.status_code,
    o.status_message,
    o.status,
    o.batch_id,
    o.created,
    o.auth_amount,
    o.data_token,
    o.time_opened,
    o.time_closed,
    o.card_hash,
    o.state,
    o.archived,
    o.stamp,
    o.last_update,
    o.balance,
    o.delta,
    o.coupon_id,
    o.coupon,
    o.refund,
    o.receipt,
    o.campus_id,
    o.amount_list_price,
    o.notes,
    o.time_door_opened,
    o.time_door_closed,
    k.client_name,
    k.estd_num_users,
    to_timestamp((o.created)::double precision) AS ts,
    concat(btrim((o.first_name)::text), ' ', btrim((o.last_name)::text)) AS full_name,
    (o.time_closed - o.time_opened) AS door_opened_secs
   FROM (pantry."order" o
     JOIN pantry.kiosk k ON ((o.kiosk_id = k.id)));


ALTER TABLE public.all_raw_orders OWNER TO erpuser;

--
-- Name: _all_orders; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public._all_orders AS
 SELECT all_raw_orders.order_id,
    all_raw_orders.first_name,
    all_raw_orders.last_name,
    all_raw_orders.kiosk_id,
    all_raw_orders.kiosk_title,
    all_raw_orders.email,
    all_raw_orders.amount_paid,
    all_raw_orders.payment_system,
    all_raw_orders.transaction_id,
    all_raw_orders.approval_code,
    all_raw_orders.status_code,
    all_raw_orders.status_message,
    all_raw_orders.status,
    all_raw_orders.batch_id,
    all_raw_orders.created,
    all_raw_orders.auth_amount,
    all_raw_orders.data_token,
    all_raw_orders.time_opened,
    all_raw_orders.time_closed,
    all_raw_orders.card_hash,
    all_raw_orders.state,
    all_raw_orders.archived,
    all_raw_orders.stamp,
    all_raw_orders.last_update,
    all_raw_orders.balance,
    all_raw_orders.delta,
    all_raw_orders.coupon_id,
    all_raw_orders.coupon,
    all_raw_orders.refund,
    all_raw_orders.receipt,
    all_raw_orders.campus_id,
    all_raw_orders.amount_list_price,
    all_raw_orders.notes,
    all_raw_orders.time_door_opened,
    all_raw_orders.time_door_closed,
    all_raw_orders.client_name,
    all_raw_orders.estd_num_users,
    all_raw_orders.ts,
    all_raw_orders.full_name,
    all_raw_orders.door_opened_secs,
    date_trunc('month'::text, all_raw_orders.ts) AS month,
    date_trunc('week'::text, all_raw_orders.ts) AS week,
    date_trunc('day'::text, all_raw_orders.ts) AS date,
    date_part('dow'::text, all_raw_orders.ts) AS dayofweek,
    date_trunc('hour'::text, all_raw_orders.ts) AS hour
   FROM public.all_raw_orders;


ALTER TABLE public._all_orders OWNER TO erpuser;

--
-- Name: all_orders; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.all_orders AS
 SELECT _all_orders.order_id,
    _all_orders.first_name,
    _all_orders.last_name,
    _all_orders.kiosk_id,
    _all_orders.kiosk_title,
    _all_orders.email,
    _all_orders.amount_paid,
    _all_orders.payment_system,
    _all_orders.transaction_id,
    _all_orders.approval_code,
    _all_orders.status_code,
    _all_orders.status_message,
    _all_orders.status,
    _all_orders.batch_id,
    _all_orders.created,
    _all_orders.auth_amount,
    _all_orders.data_token,
    _all_orders.time_opened,
    _all_orders.time_closed,
    _all_orders.card_hash,
    _all_orders.state,
    _all_orders.archived,
    _all_orders.stamp,
    _all_orders.last_update,
    _all_orders.balance,
    _all_orders.delta,
    _all_orders.coupon_id,
    _all_orders.coupon,
    _all_orders.refund,
    _all_orders.receipt,
    _all_orders.campus_id,
    _all_orders.amount_list_price,
    _all_orders.notes,
    _all_orders.time_door_opened,
    _all_orders.time_door_closed,
    _all_orders.client_name,
    _all_orders.estd_num_users,
    _all_orders.ts,
    _all_orders.full_name,
    _all_orders.door_opened_secs,
    _all_orders.month,
    _all_orders.week,
    _all_orders.date,
    _all_orders.dayofweek,
    _all_orders.hour,
    public.dowhour(_all_orders.hour) AS dowhour
   FROM public._all_orders;


ALTER TABLE public.all_orders OWNER TO erpuser;

--
-- Name: byte_orders; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_orders AS
 SELECT all_orders.order_id,
    all_orders.first_name,
    all_orders.last_name,
    all_orders.kiosk_id,
    all_orders.kiosk_title,
    all_orders.email,
    all_orders.amount_paid,
    all_orders.payment_system,
    all_orders.transaction_id,
    all_orders.approval_code,
    all_orders.status_code,
    all_orders.status_message,
    all_orders.status,
    all_orders.batch_id,
    all_orders.created,
    all_orders.auth_amount,
    all_orders.data_token,
    all_orders.time_opened,
    all_orders.time_closed,
    all_orders.card_hash,
    all_orders.state,
    all_orders.archived,
    all_orders.stamp,
    all_orders.last_update,
    all_orders.balance,
    all_orders.delta,
    all_orders.coupon_id,
    all_orders.coupon,
    all_orders.refund,
    all_orders.receipt,
    all_orders.campus_id,
    all_orders.amount_list_price,
    all_orders.notes,
    all_orders.time_door_opened,
    all_orders.time_door_closed,
    all_orders.client_name,
    all_orders.estd_num_users,
    all_orders.ts,
    all_orders.full_name,
    all_orders.door_opened_secs,
    all_orders.month,
    all_orders.week,
    all_orders.date,
    all_orders.dayofweek,
    all_orders.hour,
    all_orders.dowhour
   FROM (public.all_orders all_orders
     JOIN pantry.kiosk kiosk ON ((all_orders.kiosk_id = kiosk.id)))
  WHERE ((all_orders.campus_id = 87) AND (kiosk.enable_reporting = 1));


ALTER TABLE public.byte_orders OWNER TO erpuser;

--
-- Name: byte_tickets; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_tickets AS
 SELECT byte_orders.order_id,
    byte_orders.first_name,
    byte_orders.last_name,
    byte_orders.kiosk_id,
    byte_orders.kiosk_title,
    byte_orders.email,
    byte_orders.amount_paid,
    byte_orders.payment_system,
    byte_orders.transaction_id,
    byte_orders.approval_code,
    byte_orders.status_code,
    byte_orders.status_message,
    byte_orders.status,
    byte_orders.batch_id,
    byte_orders.created,
    byte_orders.auth_amount,
    byte_orders.data_token,
    byte_orders.time_opened,
    byte_orders.time_closed,
    byte_orders.card_hash,
    byte_orders.state,
    byte_orders.archived,
    byte_orders.stamp,
    byte_orders.last_update,
    byte_orders.balance,
    byte_orders.delta,
    byte_orders.coupon_id,
    byte_orders.coupon,
    byte_orders.refund,
    byte_orders.receipt,
    byte_orders.campus_id,
    byte_orders.amount_list_price,
    byte_orders.notes,
    byte_orders.time_door_opened,
    byte_orders.time_door_closed,
    byte_orders.client_name,
    byte_orders.estd_num_users,
    byte_orders.ts,
    byte_orders.full_name,
    byte_orders.door_opened_secs,
    byte_orders.month,
    byte_orders.week,
    byte_orders.date,
    byte_orders.dayofweek,
    byte_orders.hour,
    byte_orders.dowhour,
    btrim(concat("left"(btrim((byte_orders.first_name)::text), 1), '.', btrim((byte_orders.last_name)::text))) AS uniq_user
   FROM public.byte_orders
  WHERE ((byte_orders.state)::text <> 'NonTrans'::text);


ALTER TABLE public.byte_tickets OWNER TO erpuser;

--
-- Name: byte_feedback; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_feedback AS
 SELECT f.id,
    f.rate,
    f.order_id,
    f.message,
    f.taste,
    f.freshness,
    f.variety,
    f.value,
    f.ticket_created,
    date_trunc('month'::text, t.ts) AS month,
    date_trunc('week'::text, t.ts) AS week,
    date_trunc('day'::text, t.ts) AS date,
    date_trunc('hour'::text, t.ts) AS hour
   FROM (pantry.feedback f
     JOIN public.byte_tickets t ON (((f.order_id)::text = (t.order_id)::text)));


ALTER TABLE public.byte_feedback OWNER TO erpuser;

--
-- Name: byte_feedback_monthly; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_feedback_monthly AS
 SELECT t1.month,
    t1.avg_rating,
    t1.avg_value,
    t1.avg_taste,
    t1.avg_freshness,
    t1.avg_variety,
    ((1.0 * (t1.feedbacks)::numeric) / (t2.tix)::numeric) AS frac_feedbacks
   FROM (( SELECT byte_feedback.month,
            avg((1.0 * (byte_feedback.rate)::numeric)) AS avg_rating,
            avg(public.if((byte_feedback.value > 0), (1.0 * (byte_feedback.value)::numeric), NULL::numeric)) AS avg_value,
            avg(public.if((byte_feedback.taste > 0), (1.0 * (byte_feedback.taste)::numeric), NULL::numeric)) AS avg_taste,
            avg(public.if((byte_feedback.freshness > 0), (1.0 * (byte_feedback.freshness)::numeric), NULL::numeric)) AS avg_freshness,
            avg(public.if((byte_feedback.variety > 0), (1.0 * (byte_feedback.variety)::numeric), NULL::numeric)) AS avg_variety,
            count(*) AS feedbacks
           FROM public.byte_feedback
          WHERE (byte_feedback.month >= '2016-01-01 08:00:00+00'::timestamp with time zone)
          GROUP BY byte_feedback.month
          ORDER BY byte_feedback.month) t1
     JOIN ( SELECT byte_tickets.month,
            count(*) AS tix
           FROM public.byte_tickets
          GROUP BY byte_tickets.month) t2 ON ((t1.month = t2.month)));


ALTER TABLE public.byte_feedback_monthly OWNER TO erpuser;

--
-- Name: byte_feedback_monthly; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.byte_feedback_monthly AS
 SELECT byte_feedback_monthly.month,
    byte_feedback_monthly.avg_rating,
    byte_feedback_monthly.avg_value,
    byte_feedback_monthly.avg_taste,
    byte_feedback_monthly.avg_freshness,
    byte_feedback_monthly.avg_variety,
    byte_feedback_monthly.frac_feedbacks
   FROM public.byte_feedback_monthly;


ALTER TABLE campus_87.byte_feedback_monthly OWNER TO erpuser;

--
-- Name: campus; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.campus (
    id bigint NOT NULL,
    title character varying(45) NOT NULL,
    timezone character varying(50),
    archived integer
);


ALTER TABLE pantry.campus OWNER TO erpuser;

--
-- Name: campus; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.campus AS
 SELECT campus.id,
    campus.title,
    campus.timezone,
    campus.archived
   FROM pantry.campus
  WHERE (campus.id = 87);


ALTER TABLE campus_87.campus OWNER TO erpuser;

--
-- Name: dim_date; Type: TABLE; Schema: dw; Owner: muriel
--

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


ALTER TABLE dw.dim_date OWNER TO muriel;

--
-- Name: TABLE dim_date; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON TABLE dw.dim_date IS 'date values from 2012 through 2039';


--
-- Name: dim_date; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.dim_date OWNER TO erpuser;

--
-- Name: fact_daily_kiosk_sku_summary; Type: TABLE; Schema: dw; Owner: muriel
--

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


ALTER TABLE dw.fact_daily_kiosk_sku_summary OWNER TO muriel;

--
-- Name: TABLE fact_daily_kiosk_sku_summary; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON TABLE dw.fact_daily_kiosk_sku_summary IS 'key metrics per kiosk, SKU and day';


--
-- Name: fact_daily_kiosk_sku_summary; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.fact_daily_kiosk_sku_summary OWNER TO erpuser;

--
-- Name: kiosk; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.kiosk OWNER TO erpuser;

--
-- Name: kiosk_control; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.kiosk_control (
    kiosk_id integer NOT NULL,
    start_level numeric(4,2) DEFAULT 1.5 NOT NULL,
    min_level numeric(4,2) DEFAULT 0.5 NOT NULL,
    scale numeric(4,2) DEFAULT 1.0 NOT NULL,
    manual_multiplier numeric(4,2) DEFAULT 1.0 NOT NULL
);


ALTER TABLE inm.kiosk_control OWNER TO erpuser;

--
-- Name: TABLE kiosk_control; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.kiosk_control IS 'kiosk settings';


--
-- Name: kiosk_control; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.kiosk_control AS
 SELECT kiosk_control.kiosk_id,
    kiosk_control.start_level,
    kiosk_control.min_level,
    kiosk_control.scale,
    kiosk_control.manual_multiplier
   FROM inm.kiosk_control;


ALTER TABLE campus_87.kiosk_control OWNER TO erpuser;

--
-- Name: kiosk_restriction_by_product; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.kiosk_restriction_by_product (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL,
    end_date date DEFAULT '2050-01-01'::date,
    comment type.text400,
    record_ts timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE inm.kiosk_restriction_by_product OWNER TO erpuser;

--
-- Name: TABLE kiosk_restriction_by_product; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.kiosk_restriction_by_product IS 'one kiosk, many restricted products';


--
-- Name: kiosk_restriction_by_product; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.kiosk_restriction_by_product AS
 SELECT kiosk_restriction_by_product.kiosk_id,
    kiosk_restriction_by_product.product_id,
    kiosk_restriction_by_product.end_date,
    kiosk_restriction_by_product.comment,
    kiosk_restriction_by_product.record_ts
   FROM inm.kiosk_restriction_by_product;


ALTER TABLE campus_87.kiosk_restriction_by_product OWNER TO erpuser;

--
-- Name: kiosk_restriction_by_product_ed; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.kiosk_restriction_by_product_ed (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL,
    end_date date,
    comment type.text400,
    record_ts timestamp with time zone
);


ALTER TABLE inm.kiosk_restriction_by_product_ed OWNER TO erpuser;

--
-- Name: kiosk_restriction_by_product_ed; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.kiosk_restriction_by_product_ed AS
 SELECT kiosk_restriction_by_product_ed.kiosk_id,
    kiosk_restriction_by_product_ed.product_id,
    kiosk_restriction_by_product_ed.end_date,
    kiosk_restriction_by_product_ed.comment,
    kiosk_restriction_by_product_ed.record_ts
   FROM inm.kiosk_restriction_by_product_ed;


ALTER TABLE campus_87.kiosk_restriction_by_product_ed OWNER TO erpuser;

--
-- Name: kiosk_restriction_by_property; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.kiosk_restriction_by_property (
    kiosk_id integer NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE inm.kiosk_restriction_by_property OWNER TO erpuser;

--
-- Name: TABLE kiosk_restriction_by_property; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.kiosk_restriction_by_property IS 'one kiosk, many restricted properties';


--
-- Name: kiosk_restriction_by_property; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.kiosk_restriction_by_property AS
 SELECT kiosk_restriction_by_property.kiosk_id,
    kiosk_restriction_by_property.property_id
   FROM inm.kiosk_restriction_by_property;


ALTER TABLE campus_87.kiosk_restriction_by_property OWNER TO erpuser;

--
-- Name: kiosk_sku_group_manual_scale; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.kiosk_sku_group_manual_scale (
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    scale numeric(4,2) NOT NULL
);


ALTER TABLE inm.kiosk_sku_group_manual_scale OWNER TO erpuser;

--
-- Name: TABLE kiosk_sku_group_manual_scale; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.kiosk_sku_group_manual_scale IS 'control sku_group scale per kiosk';


--
-- Name: kiosk_sku_group_manual_scale; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.kiosk_sku_group_manual_scale AS
 SELECT kiosk_sku_group_manual_scale.kiosk_id,
    kiosk_sku_group_manual_scale.sku_group_id,
    kiosk_sku_group_manual_scale.scale
   FROM inm.kiosk_sku_group_manual_scale;


ALTER TABLE campus_87.kiosk_sku_group_manual_scale OWNER TO erpuser;

--
-- Name: label; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.label (
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
    time_updated bigint
);


ALTER TABLE pantry.label OWNER TO erpuser;

--
-- Name: label; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.label OWNER TO erpuser;

--
-- Name: order; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87."order" OWNER TO erpuser;

--
-- Name: pick_allocation; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_allocation (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL,
    qty integer NOT NULL
);


ALTER TABLE inm.pick_allocation OWNER TO erpuser;

--
-- Name: TABLE pick_allocation; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_allocation IS 'items allocated per kiosk';


--
-- Name: pick_allocation; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_allocation AS
 SELECT pick_allocation.pick_date,
    pick_allocation.route_date,
    pick_allocation.kiosk_id,
    pick_allocation.sku_id,
    pick_allocation.qty
   FROM inm.pick_allocation;


ALTER TABLE campus_87.pick_allocation OWNER TO erpuser;

--
-- Name: pick_demand; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_demand (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    qty integer NOT NULL
);


ALTER TABLE inm.pick_demand OWNER TO erpuser;

--
-- Name: TABLE pick_demand; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_demand IS 'sku_groups requested per kiosk';


--
-- Name: pick_demand; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_demand AS
 SELECT pick_demand.pick_date,
    pick_demand.route_date,
    pick_demand.kiosk_id,
    pick_demand.sku_group_id,
    pick_demand.qty
   FROM inm.pick_demand;


ALTER TABLE campus_87.pick_demand OWNER TO erpuser;

--
-- Name: pick_inventory; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_inventory (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    qty integer NOT NULL
);


ALTER TABLE inm.pick_inventory OWNER TO erpuser;

--
-- Name: TABLE pick_inventory; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_inventory IS 'projected kiosk inventory at pick time';


--
-- Name: pick_inventory; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_inventory AS
 SELECT pick_inventory.pick_date,
    pick_inventory.route_date,
    pick_inventory.kiosk_id,
    pick_inventory.sku_group_id,
    pick_inventory.qty
   FROM inm.pick_inventory;


ALTER TABLE campus_87.pick_inventory OWNER TO erpuser;

--
-- Name: pick_list; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_list (
    pick_date date NOT NULL,
    create_ts timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    timeout_seconds smallint DEFAULT 360,
    finish_ts timestamp with time zone,
    status text DEFAULT 'started'::text,
    log text,
    url text,
    CONSTRAINT pick_list_status_check CHECK ((status = ANY (ARRAY['started'::text, 'ready'::text, 'failed'::text])))
);


ALTER TABLE inm.pick_list OWNER TO erpuser;

--
-- Name: TABLE pick_list; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_list IS 'completed picks';


--
-- Name: pick_list; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_list AS
 SELECT pick_list.pick_date,
    pick_list.create_ts,
    pick_list.timeout_seconds,
    pick_list.finish_ts,
    pick_list.status,
    pick_list.log,
    pick_list.url
   FROM inm.pick_list;


ALTER TABLE campus_87.pick_list OWNER TO erpuser;

--
-- Name: pick_preference_kiosk_sku; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_preference_kiosk_sku (
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL,
    preference smallint NOT NULL
);


ALTER TABLE inm.pick_preference_kiosk_sku OWNER TO erpuser;

--
-- Name: TABLE pick_preference_kiosk_sku; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_preference_kiosk_sku IS 'kiosk preference factor of skus';


--
-- Name: pick_preference_kiosk_sku; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_preference_kiosk_sku AS
 SELECT pick_preference_kiosk_sku.kiosk_id,
    pick_preference_kiosk_sku.sku_id,
    pick_preference_kiosk_sku.preference
   FROM inm.pick_preference_kiosk_sku;


ALTER TABLE campus_87.pick_preference_kiosk_sku OWNER TO erpuser;

--
-- Name: pick_priority_kiosk; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_priority_kiosk (
    kiosk_id integer NOT NULL,
    priority integer,
    start_date date,
    end_date date,
    comment text
);


ALTER TABLE inm.pick_priority_kiosk OWNER TO erpuser;

--
-- Name: TABLE pick_priority_kiosk; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_priority_kiosk IS 'higher priority get first pick';


--
-- Name: pick_priority_kiosk; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_priority_kiosk AS
 SELECT pick_priority_kiosk.kiosk_id,
    pick_priority_kiosk.priority,
    pick_priority_kiosk.start_date,
    pick_priority_kiosk.end_date,
    pick_priority_kiosk.comment
   FROM inm.pick_priority_kiosk;


ALTER TABLE campus_87.pick_priority_kiosk OWNER TO erpuser;

--
-- Name: pick_priority_sku; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_priority_sku (
    sku_id integer NOT NULL,
    priority integer,
    start_date date,
    end_date date,
    comment text
);


ALTER TABLE inm.pick_priority_sku OWNER TO erpuser;

--
-- Name: TABLE pick_priority_sku; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_priority_sku IS 'lower priority get distributed first';


--
-- Name: pick_priority_sku; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_priority_sku AS
 SELECT pick_priority_sku.sku_id,
    pick_priority_sku.priority,
    pick_priority_sku.start_date,
    pick_priority_sku.end_date,
    pick_priority_sku.comment
   FROM inm.pick_priority_sku;


ALTER TABLE campus_87.pick_priority_sku OWNER TO erpuser;

--
-- Name: pick_rejection; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_rejection (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    item_id integer NOT NULL,
    item_type character varying(32) NOT NULL,
    reason character varying(64) NOT NULL
);


ALTER TABLE inm.pick_rejection OWNER TO erpuser;

--
-- Name: TABLE pick_rejection; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_rejection IS 'items rejects by kiosk';


--
-- Name: pick_rejection; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_rejection AS
 SELECT pick_rejection.pick_date,
    pick_rejection.route_date,
    pick_rejection.kiosk_id,
    pick_rejection.item_id,
    pick_rejection.item_type,
    pick_rejection.reason
   FROM inm.pick_rejection;


ALTER TABLE campus_87.pick_rejection OWNER TO erpuser;

--
-- Name: pick_route; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_route (
    pick_date date NOT NULL,
    kiosk_id integer NOT NULL,
    route_number character varying(256),
    driver_name character varying(64) NOT NULL,
    route_time time(6) without time zone NOT NULL,
    route_date date NOT NULL,
    delivery_order smallint NOT NULL
);


ALTER TABLE inm.pick_route OWNER TO erpuser;

--
-- Name: TABLE pick_route; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_route IS 'route details including driver name';


--
-- Name: pick_route; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.pick_route AS
 SELECT pick_route.pick_date,
    pick_route.kiosk_id,
    pick_route.route_number,
    pick_route.driver_name,
    pick_route.route_time,
    pick_route.route_date,
    pick_route.delivery_order
   FROM inm.pick_route;


ALTER TABLE campus_87.pick_route OWNER TO erpuser;

--
-- Name: product; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.product (
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
    tag_applied_by character varying(255),
    internal_id text
);


ALTER TABLE pantry.product OWNER TO erpuser;

--
-- Name: product; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.product OWNER TO erpuser;

--
-- Name: product_property; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.product_property (
    product_id bigint NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE inm.product_property OWNER TO erpuser;

--
-- Name: TABLE product_property; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.product_property IS 'one product - many properties';


--
-- Name: product_property; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.product_property AS
 SELECT product_property.product_id,
    product_property.property_id
   FROM inm.product_property;


ALTER TABLE campus_87.product_property OWNER TO erpuser;

--
-- Name: product_property_def; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.product_property_def (
    id integer NOT NULL,
    name text NOT NULL,
    value text
);


ALTER TABLE inm.product_property_def OWNER TO erpuser;

--
-- Name: TABLE product_property_def; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.product_property_def IS 'Defines properties identified by id. `name` = property type, `value` = display text';


--
-- Name: product_property_def; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.product_property_def AS
 SELECT product_property_def.id,
    product_property_def.name,
    product_property_def.value
   FROM inm.product_property_def;


ALTER TABLE campus_87.product_property_def OWNER TO erpuser;

--
-- Name: route_stop; Type: TABLE; Schema: inm; Owner: erpuser
--

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


ALTER TABLE inm.route_stop OWNER TO erpuser;

--
-- Name: TABLE route_stop; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.route_stop IS 'delivery schedule for kiosks';


--
-- Name: route_stop; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.route_stop OWNER TO erpuser;

--
-- Name: sku_group_attribute; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.sku_group_attribute (
    id integer NOT NULL,
    title character varying(512) NOT NULL,
    relative_size numeric(4,2) NOT NULL,
    minimum_kiosk_qty smallint NOT NULL,
    maximum_kiosk_qty smallint
);


ALTER TABLE inm.sku_group_attribute OWNER TO erpuser;

--
-- Name: TABLE sku_group_attribute; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.sku_group_attribute IS 'Defines sku_groups';


--
-- Name: sku_group_attribute; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.sku_group_attribute AS
 SELECT sku_group_attribute.id,
    sku_group_attribute.title,
    sku_group_attribute.relative_size,
    sku_group_attribute.minimum_kiosk_qty,
    sku_group_attribute.maximum_kiosk_qty
   FROM inm.sku_group_attribute;


ALTER TABLE campus_87.sku_group_attribute OWNER TO erpuser;

--
-- Name: sku_group_control; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.sku_group_control (
    sku_group_id integer NOT NULL,
    default_level numeric(4,2) DEFAULT '-1'::integer NOT NULL,
    scale numeric(4,2) DEFAULT 1.0 NOT NULL,
    min_qty smallint,
    max_qty smallint
);


ALTER TABLE inm.sku_group_control OWNER TO erpuser;

--
-- Name: TABLE sku_group_control; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.sku_group_control IS 'allocation control for sku_groups';


--
-- Name: sku_group_control; Type: VIEW; Schema: campus_87; Owner: erpuser
--

CREATE VIEW campus_87.sku_group_control AS
 SELECT sku_group_control.sku_group_id,
    sku_group_control.default_level,
    sku_group_control.scale,
    sku_group_control.min_qty,
    sku_group_control.max_qty
   FROM inm.sku_group_control;


ALTER TABLE campus_87.sku_group_control OWNER TO erpuser;

--
-- Name: warehouse_inventory; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.warehouse_inventory (
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


ALTER TABLE inm.warehouse_inventory OWNER TO erpuser;

--
-- Name: TABLE warehouse_inventory; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.warehouse_inventory IS 'daily warehouse inventory';


--
-- Name: warehouse_inventory; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.warehouse_inventory OWNER TO erpuser;

--
-- Name: warehouse_order_history; Type: TABLE; Schema: inm; Owner: erpuser
--

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


ALTER TABLE inm.warehouse_order_history OWNER TO erpuser;

--
-- Name: TABLE warehouse_order_history; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.warehouse_order_history IS 'product orders for the warehouse';


--
-- Name: warehouse_order_history; Type: VIEW; Schema: campus_87; Owner: erpuser
--

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


ALTER TABLE campus_87.warehouse_order_history OWNER TO erpuser;

--
-- Name: current_inventory; Type: VIEW; Schema: dw; Owner: erpuser
--

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


ALTER TABLE dw.current_inventory OWNER TO erpuser;

--
-- Name: VIEW current_inventory; Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON VIEW dw.current_inventory IS 'returns current inventory';


--
-- Name: byte_current_inventory; Type: VIEW; Schema: dw; Owner: erpuser
--

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


ALTER TABLE dw.byte_current_inventory OWNER TO erpuser;

--
-- Name: VIEW byte_current_inventory; Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON VIEW dw.byte_current_inventory IS 'returns campus 87 current inventory';


--
-- Name: dim_campus; Type: TABLE; Schema: dw; Owner: muriel
--

CREATE TABLE dw.dim_campus (
    id bigint NOT NULL,
    title character varying(135) NOT NULL,
    timezone character varying(150),
    archived integer
);


ALTER TABLE dw.dim_campus OWNER TO muriel;

--
-- Name: TABLE dim_campus; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON TABLE dw.dim_campus IS 'campus info';


--
-- Name: dim_kiosk; Type: TABLE; Schema: dw; Owner: muriel
--

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


ALTER TABLE dw.dim_kiosk OWNER TO muriel;

--
-- Name: TABLE dim_kiosk; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON TABLE dw.dim_kiosk IS 'kiosk info';


--
-- Name: dim_product; Type: TABLE; Schema: dw; Owner: muriel
--

CREATE TABLE dw.dim_product (
    id bigint NOT NULL,
    title text,
    campus_id integer NOT NULL,
    fc_title text,
    archived smallint NOT NULL,
    consumer_category text
);


ALTER TABLE dw.dim_product OWNER TO muriel;

--
-- Name: TABLE dim_product; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON TABLE dw.dim_product IS 'product info';


--
-- Name: tag; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.tag (
    id bigint NOT NULL,
    tag character varying(100)
);


ALTER TABLE pantry.tag OWNER TO erpuser;

--
-- Name: export_inventory_lots; Type: VIEW; Schema: dw; Owner: erpuser
--

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


ALTER TABLE dw.export_inventory_lots OWNER TO erpuser;

--
-- Name: VIEW export_inventory_lots; Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON VIEW dw.export_inventory_lots IS 'returns detailed current inventory';


--
-- Name: fact_daily_byte_foods_summary; Type: TABLE; Schema: dw; Owner: erpuser
--

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


ALTER TABLE dw.fact_daily_byte_foods_summary OWNER TO erpuser;

--
-- Name: TABLE fact_daily_byte_foods_summary; Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON TABLE dw.fact_daily_byte_foods_summary IS 'campus 87 key metrics per day';


--
-- Name: fact_monthly_byte_foods_summary; Type: TABLE; Schema: dw; Owner: erpuser
--

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


ALTER TABLE dw.fact_monthly_byte_foods_summary OWNER TO erpuser;

--
-- Name: fact_monthly_kiosk_summary; Type: TABLE; Schema: dw; Owner: erpuser
--

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


ALTER TABLE dw.fact_monthly_kiosk_summary OWNER TO erpuser;

--
-- Name: TABLE fact_monthly_kiosk_summary; Type: COMMENT; Schema: dw; Owner: erpuser
--

COMMENT ON TABLE dw.fact_monthly_kiosk_summary IS 'key metrics per kiosk and month';


--
-- Name: last_15_months; Type: VIEW; Schema: dw; Owner: muriel
--

CREATE VIEW dw.last_15_months AS
 SELECT DISTINCT dim_date.year_month
   FROM dw.dim_date
  WHERE (dim_date.as_date < CURRENT_DATE)
  ORDER BY dim_date.year_month DESC
 LIMIT 15;


ALTER TABLE dw.last_15_months OWNER TO muriel;

--
-- Name: VIEW last_15_months; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON VIEW dw.last_15_months IS 'returns the last 15 months';


--
-- Name: last_15_weeks; Type: VIEW; Schema: dw; Owner: muriel
--

CREATE VIEW dw.last_15_weeks AS
 SELECT DISTINCT dim_date.year_week
   FROM dw.dim_date
  WHERE (dim_date.as_date < CURRENT_DATE)
  ORDER BY dim_date.year_week DESC
 LIMIT 15;


ALTER TABLE dw.last_15_weeks OWNER TO muriel;

--
-- Name: VIEW last_15_weeks; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON VIEW dw.last_15_weeks IS 'returns the last 15 weeks';


--
-- Name: last_30_days; Type: VIEW; Schema: dw; Owner: muriel
--

CREATE VIEW dw.last_30_days AS
 SELECT dim_date.date_id
   FROM dw.dim_date
  WHERE (dim_date.as_date < CURRENT_DATE)
  ORDER BY dim_date.date_id DESC
 LIMIT 30;


ALTER TABLE dw.last_30_days OWNER TO muriel;

--
-- Name: VIEW last_30_days; Type: COMMENT; Schema: dw; Owner: muriel
--

COMMENT ON VIEW dw.last_30_days IS 'returns the last 30 days';


--
-- Name: last_30_days_kpis; Type: VIEW; Schema: dw; Owner: muriel
--

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


ALTER TABLE dw.last_30_days_kpis OWNER TO muriel;

--
-- Name: monthly_kpis; Type: VIEW; Schema: dw; Owner: muriel
--

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


ALTER TABLE dw.monthly_kpis OWNER TO muriel;

--
-- Name: non_byte_current_inventory; Type: VIEW; Schema: dw; Owner: erpuser
--

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


ALTER TABLE dw.non_byte_current_inventory OWNER TO erpuser;

--
-- Name: address; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.address OWNER TO erpuser;

--
-- Name: TABLE address; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.address IS 'addresses and geographical information including latitude and longitude';


--
-- Name: address_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.address ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: awsdms_apply_exceptions; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);


ALTER TABLE erp.awsdms_apply_exceptions OWNER TO erpuser;

--
-- Name: classic_product_allergen_tag; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.classic_product_allergen_tag (
    product_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE erp.classic_product_allergen_tag OWNER TO erpuser;

--
-- Name: classic_product_category_tag; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.classic_product_category_tag (
    product_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE erp.classic_product_category_tag OWNER TO erpuser;

--
-- Name: TABLE classic_product_category_tag; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.classic_product_category_tag IS 'product tag compatible with pantry.kiosk';


--
-- Name: client; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.client (
    id integer NOT NULL,
    name type.text_name,
    address_id integer,
    employees_num integer,
    industry integer
);


ALTER TABLE erp.client OWNER TO erpuser;

--
-- Name: TABLE client; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.client IS 'client data';


--
-- Name: client_campus; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.client_campus (
    client_id integer NOT NULL,
    campus_id integer NOT NULL
);


ALTER TABLE erp.client_campus OWNER TO erpuser;

--
-- Name: TABLE client_campus; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.client_campus IS 'one client, many campuses';


--
-- Name: client_contact; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.client_contact (
    contact_id integer NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE erp.client_contact OWNER TO erpuser;

--
-- Name: TABLE client_contact; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.client_contact IS 'one client, many contacts';


--
-- Name: client_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.client ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: client_industry; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.client_industry (
    client_name type.text400 NOT NULL,
    industry type.text40 NOT NULL
);


ALTER TABLE erp.client_industry OWNER TO erpuser;

--
-- Name: TABLE client_industry; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.client_industry IS 'one client, one industry';


--
-- Name: contact; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.contact OWNER TO erpuser;

--
-- Name: TABLE contact; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.contact IS 'contacts catalog';


--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fcm_repeater; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.fcm_repeater OWNER TO erpuser;

--
-- Name: fcm_repeater_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

CREATE SEQUENCE erp.fcm_repeater_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp.fcm_repeater_id_seq OWNER TO erpuser;

--
-- Name: fcm_repeater_id_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: erpuser
--

ALTER SEQUENCE erp.fcm_repeater_id_seq OWNED BY erp.fcm_repeater.id;


--
-- Name: global_attribute_def; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.global_attribute_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text200 NOT NULL,
    note type.text200
);


ALTER TABLE erp.global_attribute_def OWNER TO erpuser;

--
-- Name: TABLE global_attribute_def; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.global_attribute_def IS 'Defines attributes identified by id. `name` = attribute type, `value` = display text';


--
-- Name: global_attribute_def_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.global_attribute_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.global_attribute_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: hardware_software; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.hardware_software OWNER TO erpuser;

--
-- Name: TABLE hardware_software; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.hardware_software IS 'kiosk hardware and software versions';


--
-- Name: kiosk; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.kiosk OWNER TO erpuser;

--
-- Name: TABLE kiosk; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk IS 'main table for kiosk data';


--
-- Name: kiosk_access_card; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_access_card (
    id integer NOT NULL,
    card_id type.text400 NOT NULL,
    client_id integer NOT NULL,
    expiration_date date
);


ALTER TABLE erp.kiosk_access_card OWNER TO erpuser;

--
-- Name: TABLE kiosk_access_card; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_access_card IS 'kiosk physical location access card';


--
-- Name: kiosk_access_card_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.kiosk_access_card ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.kiosk_access_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: kiosk_accounting; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.kiosk_accounting OWNER TO erpuser;

--
-- Name: TABLE kiosk_accounting; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_accounting IS 'one kiosk_accounting, one kiosk';


--
-- Name: kiosk_attribute; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_attribute (
    kiosk_id bigint NOT NULL,
    attribute_id integer NOT NULL
);


ALTER TABLE erp.kiosk_attribute OWNER TO erpuser;

--
-- Name: TABLE kiosk_attribute; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_attribute IS 'one kiosk, many attributes';


--
-- Name: kiosk_contact; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_contact (
    contact_id integer NOT NULL,
    kiosk_id integer NOT NULL
);


ALTER TABLE erp.kiosk_contact OWNER TO erpuser;

--
-- Name: TABLE kiosk_contact; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_contact IS 'one kiosk, many contacts';


--
-- Name: kiosk_delivery_window; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_delivery_window (
    kiosk_id bigint NOT NULL,
    dow type.dow NOT NULL,
    start_time time with time zone NOT NULL,
    end_time time with time zone NOT NULL,
    access_card_required type.zero_or_one
);


ALTER TABLE erp.kiosk_delivery_window OWNER TO erpuser;

--
-- Name: TABLE kiosk_delivery_window; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_delivery_window IS 'one kiosk, many delivery time blocks';


--
-- Name: kiosk_note; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_note (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    note_type integer NOT NULL,
    content type.text10k NOT NULL,
    start_ts timestamp with time zone,
    end_ts timestamp with time zone
);


ALTER TABLE erp.kiosk_note OWNER TO erpuser;

--
-- Name: TABLE kiosk_note; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_note IS 'one kiosk, many notes, with possible start/end time';


--
-- Name: kiosk_status; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_status (
    kiosk_id integer NOT NULL,
    last_update bigint,
    last_status bigint,
    last_inventory bigint NOT NULL
);


ALTER TABLE erp.kiosk_status OWNER TO erpuser;

--
-- Name: TABLE kiosk_status; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_status IS 'last update timestamps';


--
-- Name: kiosk_classic_view; Type: VIEW; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.kiosk_classic_view OWNER TO erpuser;

--
-- Name: kiosk_note_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.kiosk_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.kiosk_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: kiosk_restriction_by_product; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_restriction_by_product (
    kiosk_id bigint NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE erp.kiosk_restriction_by_product OWNER TO erpuser;

--
-- Name: TABLE kiosk_restriction_by_product; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_restriction_by_product IS 'one kiosk, many restricted products';


--
-- Name: kiosk_restriction_by_property; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.kiosk_restriction_by_property (
    kiosk_id bigint NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE erp.kiosk_restriction_by_property OWNER TO erpuser;

--
-- Name: TABLE kiosk_restriction_by_property; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.kiosk_restriction_by_property IS 'one kiosk, many restricted properties';


--
-- Name: product; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product (
    id bigint NOT NULL,
    brand type.text400,
    campus_id integer NOT NULL,
    sku_group_id integer,
    fc_title type.text_name,
    archived type.zero_or_one NOT NULL,
    last_update bigint NOT NULL
);


ALTER TABLE erp.product OWNER TO erpuser;

--
-- Name: TABLE product; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product IS 'main table for product data';


--
-- Name: product_asset; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.product_asset OWNER TO erpuser;

--
-- Name: TABLE product_asset; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_asset IS 'product display values';


--
-- Name: product_category; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product_category (
    product_id bigint NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE erp.product_category OWNER TO erpuser;

--
-- Name: TABLE product_category; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_category IS 'one product, many categories';


--
-- Name: product_category_def; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product_category_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text100 NOT NULL
);


ALTER TABLE erp.product_category_def OWNER TO erpuser;

--
-- Name: TABLE product_category_def; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_category_def IS 'Defines categories identified by id. `name` = category type, `value` = display text';


--
-- Name: product_category_def_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.product_category_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.product_category_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_categories; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.product_categories (
    id bigint NOT NULL,
    cat_name character varying(150) NOT NULL,
    cat_name_tiny character varying(150),
    subcat_name character varying(150) NOT NULL,
    subcat_name_tiny character varying(150),
    tags character varying(765) NOT NULL,
    no_image_placeholder character varying(765),
    icon character varying(765)
);


ALTER TABLE pantry.product_categories OWNER TO erpuser;

--
-- Name: product_category_tag; Type: VIEW; Schema: erp; Owner: erpuser
--

CREATE VIEW erp.product_category_tag AS
 SELECT (unnest(string_to_array((product_categories.tags)::text, ','::text)))::integer AS tag_id,
    product_categories.cat_name,
    product_categories.subcat_name
   FROM pantry.product_categories;


ALTER TABLE erp.product_category_tag OWNER TO erpuser;

--
-- Name: product_handling; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.product_handling OWNER TO erpuser;

--
-- Name: TABLE product_handling; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_handling IS 'Product physical characteristics. Product rfid tags order handling options';


--
-- Name: product_nutrition; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.product_nutrition OWNER TO erpuser;

--
-- Name: TABLE product_nutrition; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_nutrition IS 'one product, one product_nutrition record';


--
-- Name: product_pricing; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product_pricing (
    product_id bigint NOT NULL,
    price type.money_max_1k NOT NULL,
    cost type.money_max_10k NOT NULL,
    ws_case_cost type.money_max_10k,
    pricing_tier type.text40,
    taxable type.zero_or_one
);


ALTER TABLE erp.product_pricing OWNER TO erpuser;

--
-- Name: TABLE product_pricing; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_pricing IS 'unit and case price, cost, tax info';


--
-- Name: product_property; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product_property (
    product_id bigint NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE erp.product_property OWNER TO erpuser;

--
-- Name: TABLE product_property; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_property IS 'one product, many properties';


--
-- Name: product_property_tag; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product_property_tag (
    property_id integer NOT NULL,
    tag_id integer NOT NULL,
    tag type.text_name NOT NULL
);


ALTER TABLE erp.product_property_tag OWNER TO erpuser;

--
-- Name: TABLE product_property_tag; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_property_tag IS 'translates between product property and pantry.tag';


--
-- Name: product_sourcing; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product_sourcing (
    product_id bigint NOT NULL,
    vendor type.text400,
    source type.text400
);


ALTER TABLE erp.product_sourcing OWNER TO erpuser;

--
-- Name: TABLE product_sourcing; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_sourcing IS 'product vendor and source';


--
-- Name: product_classic_view; Type: VIEW; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.product_classic_view OWNER TO erpuser;

--
-- Name: product_property_def; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.product_property_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text100
);


ALTER TABLE erp.product_property_def OWNER TO erpuser;

--
-- Name: TABLE product_property_def; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.product_property_def IS 'Defines properties identified by id. `name` = property type, `value` = display text';


--
-- Name: product_property_def_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.product_property_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.product_property_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sku_group; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.sku_group (
    id integer NOT NULL,
    fc_title type.text_name NOT NULL,
    unit_size numeric(4,2) NOT NULL
);


ALTER TABLE erp.sku_group OWNER TO erpuser;

--
-- Name: TABLE sku_group; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.sku_group IS 'Defines facing categories title and physical size';


--
-- Name: tag_order; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.tag_order OWNER TO erpuser;

--
-- Name: TABLE tag_order; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.tag_order IS 'order data for tags';


--
-- Name: tag_order_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.tag_order ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.tag_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tag_order_stats; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.tag_order_stats (
    product_id bigint NOT NULL,
    used_since_last_delivery bigint,
    used_total bigint,
    last_delivery_date timestamp with time zone,
    last_delivery bigint,
    delivered_total bigint
);


ALTER TABLE erp.tag_order_stats OWNER TO erpuser;

--
-- Name: TABLE tag_order_stats; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.tag_order_stats IS 'stats for fulfilled tag orders';


--
-- Name: tag_price; Type: TABLE; Schema: erp; Owner: erpuser
--

CREATE TABLE erp.tag_price (
    campus_id integer NOT NULL,
    tag_type type.text100 NOT NULL,
    price numeric(6,2)
);


ALTER TABLE erp.tag_price OWNER TO erpuser;

--
-- Name: TABLE tag_price; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.tag_price IS 'tag price per campus';


--
-- Name: tag_type; Type: TABLE; Schema: erp; Owner: erpuser
--

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


ALTER TABLE erp.tag_type OWNER TO erpuser;

--
-- Name: TABLE tag_type; Type: COMMENT; Schema: erp; Owner: erpuser
--

COMMENT ON TABLE erp.tag_type IS 'types for tags a.k.a. labels';


--
-- Name: tag_type_id_seq; Type: SEQUENCE; Schema: erp; Owner: erpuser
--

ALTER TABLE erp.tag_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp.tag_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v_campus_list; Type: VIEW; Schema: erp; Owner: lambdazen
--

CREATE VIEW erp.v_campus_list AS
 SELECT campus.id,
    campus.title,
    campus.timezone,
    campus.archived,
    campus.id AS campusid
   FROM pantry.campus;


ALTER TABLE erp.v_campus_list OWNER TO lambdazen;

--
-- Name: v_client; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_client OWNER TO lambdazen;

--
-- Name: v_client_list; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_client_list OWNER TO lambdazen;

--
-- Name: last_kiosk_status; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.last_kiosk_status (
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
    is_locked smallint,
    num_payment_messages_pending_sync integer
);


ALTER TABLE pantry.last_kiosk_status OWNER TO erpuser;

--
-- Name: v_kiosk; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_kiosk OWNER TO lambdazen;

--
-- Name: kiosk_status; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.kiosk_status (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    kiosk_temperature numeric(6,3),
    kiosk_temperature_count smallint,
    kit_temperature numeric(6,3),
    temperature_tags character varying(2047),
    kiosk_temperature_source character varying(31),
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
    modem_signal_type character varying(27),
    ip character varying(45),
    app_uptime bigint,
    system_uptime bigint,
    is_locked smallint,
    num_payment_messages_pending_sync integer,
    offline smallint
);


ALTER TABLE pantry.kiosk_status OWNER TO erpuser;

--
-- Name: v_kiosk_heartbeat; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_kiosk_heartbeat OWNER TO lambdazen;

--
-- Name: v_kiosk_inventory; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_kiosk_inventory OWNER TO lambdazen;

--
-- Name: v_kiosk_list; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_kiosk_list OWNER TO lambdazen;

--
-- Name: v_kiosk_options; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_kiosk_options OWNER TO lambdazen;

--
-- Name: v_product; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_product OWNER TO lambdazen;

--
-- Name: v_product_list; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_product_list OWNER TO lambdazen;

--
-- Name: v_product_options; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_product_options OWNER TO lambdazen;

--
-- Name: sku_group; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.sku_group AS
 SELECT sku_group.id,
    sku_group.fc_title,
    sku_group.unit_size
   FROM erp.sku_group;


ALTER TABLE inm.sku_group OWNER TO erpuser;

--
-- Name: v_sku_group_list; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_sku_group_list OWNER TO lambdazen;

--
-- Name: label_order; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.label_order (
    id bigint NOT NULL,
    product_id bigint,
    group_id bigint,
    box_id character varying(16),
    amount bigint NOT NULL,
    time_order bigint NOT NULL,
    time_encoded bigint,
    time_delivery bigint,
    time_updated bigint,
    status character varying(15),
    delivery_option character varying(255),
    priority character varying(255)
);


ALTER TABLE pantry.label_order OWNER TO erpuser;

--
-- Name: v_tag_order_list; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_tag_order_list OWNER TO lambdazen;

--
-- Name: coupon; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.coupon (
    id bigint NOT NULL,
    code character varying(45) NOT NULL,
    flat_discount numeric(5,2) NOT NULL,
    real_discount numeric(5,2) NOT NULL,
    used bigint NOT NULL,
    kiosk_list character varying(255),
    campaign character varying(255),
    created_by character varying(255)
);


ALTER TABLE pantry.coupon OWNER TO erpuser;

--
-- Name: discount_applied; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.discount_applied (
    id integer NOT NULL,
    order_id character varying(135),
    sequence integer,
    epc character varying(135),
    product_id integer,
    discount character varying(65535),
    price_before numeric(6,2),
    price_after numeric(6,2),
    sponsor character varying(135),
    ts integer,
    notes text
);


ALTER TABLE pantry.discount_applied OWNER TO erpuser;

--
-- Name: v_transaction_detail; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_transaction_detail OWNER TO lambdazen;

--
-- Name: v_transaction_list; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_transaction_list OWNER TO lambdazen;

--
-- Name: v_warehouse_inventory; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_warehouse_inventory OWNER TO lambdazen;

--
-- Name: v_warehouse_inventory_entry; Type: VIEW; Schema: erp; Owner: lambdazen
--

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


ALTER TABLE erp.v_warehouse_inventory_entry OWNER TO lambdazen;

--
-- Name: address; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

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


ALTER TABLE erp_backup.address OWNER TO erpuser;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE erp_backup.address ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);


--
-- Name: client; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

CREATE TABLE erp_backup.client (
    id integer NOT NULL,
    name type.text_name,
    address_id integer,
    employees_num integer,
    industry integer
);


ALTER TABLE erp_backup.client OWNER TO erpuser;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE erp_backup.client ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);


--
-- Name: contact; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

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


ALTER TABLE erp_backup.contact OWNER TO erpuser;

--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE erp_backup.contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);


--
-- Name: hardware_software; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

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


ALTER TABLE erp_backup.hardware_software OWNER TO erpuser;

--
-- Name: kiosk; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

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


ALTER TABLE erp_backup.kiosk OWNER TO erpuser;

--
-- Name: kiosk_accounting; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

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


ALTER TABLE erp_backup.kiosk_accounting OWNER TO erpuser;

--
-- Name: kiosk_note; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

CREATE TABLE erp_backup.kiosk_note (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    note_type integer NOT NULL,
    content type.text10k NOT NULL,
    start_ts timestamp with time zone,
    end_ts timestamp with time zone
);


ALTER TABLE erp_backup.kiosk_note OWNER TO erpuser;

--
-- Name: kiosk_note_id_seq; Type: SEQUENCE; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE erp_backup.kiosk_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.kiosk_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);


--
-- Name: product_classic_view; Type: VIEW; Schema: erp_backup; Owner: erpuser
--

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


ALTER TABLE erp_backup.product_classic_view OWNER TO erpuser;

--
-- Name: product_property; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

CREATE TABLE erp_backup.product_property (
    product_id bigint NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE erp_backup.product_property OWNER TO erpuser;

--
-- Name: product_property_def; Type: TABLE; Schema: erp_backup; Owner: erpuser
--

CREATE TABLE erp_backup.product_property_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text100
);


ALTER TABLE erp_backup.product_property_def OWNER TO erpuser;

--
-- Name: product_property_def_id_seq; Type: SEQUENCE; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE erp_backup.product_property_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_backup.product_property_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);


--
-- Name: address; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.address OWNER TO erpuser;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: erp_test; Owner: erpuser
--

ALTER TABLE erp_test.address ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: client; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.client (
    id integer NOT NULL,
    name type.text_name,
    address_id integer,
    employees_num integer,
    industry integer
);


ALTER TABLE erp_test.client OWNER TO erpuser;

--
-- Name: client_campus; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.client_campus (
    client_id integer NOT NULL,
    campus_id integer NOT NULL
);


ALTER TABLE erp_test.client_campus OWNER TO erpuser;

--
-- Name: client_contact; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.client_contact (
    contact_id integer NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE erp_test.client_contact OWNER TO erpuser;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: erp_test; Owner: erpuser
--

ALTER TABLE erp_test.client ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: client_industry; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.client_industry (
    client_name type.text400,
    industry type.text40
);


ALTER TABLE erp_test.client_industry OWNER TO erpuser;

--
-- Name: contact; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.contact OWNER TO erpuser;

--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: erp_test; Owner: erpuser
--

ALTER TABLE erp_test.contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: global_attribute_def; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.global_attribute_def (
    id integer NOT NULL,
    name type.text_name NOT NULL,
    value type.text200 NOT NULL,
    note type.text200
);


ALTER TABLE erp_test.global_attribute_def OWNER TO erpuser;

--
-- Name: global_attribute_def_id_seq; Type: SEQUENCE; Schema: erp_test; Owner: erpuser
--

ALTER TABLE erp_test.global_attribute_def ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.global_attribute_def_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);


--
-- Name: hardware_software; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.hardware_software OWNER TO erpuser;

--
-- Name: kiosk; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.kiosk OWNER TO erpuser;

--
-- Name: kiosk_accounting; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.kiosk_accounting OWNER TO erpuser;

--
-- Name: kiosk_audit; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.kiosk_audit (
    a text,
    b text,
    kid integer NOT NULL,
    status text,
    e text,
    enable_reporting character(1),
    enable_monitoring character(1)
);


ALTER TABLE erp_test.kiosk_audit OWNER TO erpuser;

--
-- Name: kiosk_classic_view; Type: VIEW; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.kiosk_classic_view OWNER TO erpuser;

--
-- Name: kiosk_contact; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.kiosk_contact (
    contact_id integer NOT NULL,
    kiosk_id integer NOT NULL
);


ALTER TABLE erp_test.kiosk_contact OWNER TO erpuser;

--
-- Name: kiosk_note; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.kiosk_note (
    id integer NOT NULL,
    kiosk_id bigint NOT NULL,
    note_type integer NOT NULL,
    content type.text10k NOT NULL,
    start_ts timestamp with time zone,
    end_ts timestamp with time zone
);


ALTER TABLE erp_test.kiosk_note OWNER TO erpuser;

--
-- Name: kiosk_note_id_seq; Type: SEQUENCE; Schema: erp_test; Owner: erpuser
--

ALTER TABLE erp_test.kiosk_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME erp_test.kiosk_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);


--
-- Name: kiosk_status; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.kiosk_status (
    kiosk_id integer NOT NULL,
    last_update bigint,
    last_status bigint,
    last_inventory bigint NOT NULL
);


ALTER TABLE erp_test.kiosk_status OWNER TO erpuser;

--
-- Name: product; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.product (
    id bigint NOT NULL,
    brand type.text400,
    campus_id integer NOT NULL,
    sku_group_id integer,
    fc_title type.text_name,
    archived type.zero_or_one NOT NULL,
    last_update bigint NOT NULL
);


ALTER TABLE erp_test.product OWNER TO erpuser;

--
-- Name: product_asset; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.product_asset OWNER TO erpuser;

--
-- Name: product_handling; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.product_handling OWNER TO erpuser;

--
-- Name: product_nutrition; Type: TABLE; Schema: erp_test; Owner: erpuser
--

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


ALTER TABLE erp_test.product_nutrition OWNER TO erpuser;

--
-- Name: product_pricing; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.product_pricing (
    product_id bigint NOT NULL,
    price type.money_max_1k NOT NULL,
    cost type.money_max_10k NOT NULL,
    ws_case_cost type.money_max_10k,
    pricing_tier type.text40,
    taxable type.zero_or_one
);


ALTER TABLE erp_test.product_pricing OWNER TO erpuser;

--
-- Name: product_property; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.product_property (
    product_id bigint NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE erp_test.product_property OWNER TO erpuser;

--
-- Name: product_sourcing; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.product_sourcing (
    product_id bigint NOT NULL,
    vendor type.text400,
    source type.text400
);


ALTER TABLE erp_test.product_sourcing OWNER TO erpuser;

--
-- Name: sku_group; Type: TABLE; Schema: erp_test; Owner: erpuser
--

CREATE TABLE erp_test.sku_group (
    id integer,
    fc_title type.text_name,
    unit_size numeric(4,2)
);


ALTER TABLE erp_test.sku_group OWNER TO erpuser;

--
-- Name: awsdms_apply_exceptions; Type: TABLE; Schema: fnrenames; Owner: erpuser
--

CREATE TABLE fnrenames.awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);


ALTER TABLE fnrenames.awsdms_apply_exceptions OWNER TO erpuser;

--
-- Name: awsdms_validation_failures_v1; Type: TABLE; Schema: fnrenames; Owner: erpuser
--

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


ALTER TABLE fnrenames.awsdms_validation_failures_v1 OWNER TO erpuser;

--
-- Name: kiosk_product_disabled; Type: VIEW; Schema: inm; Owner: erpuser
--

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


ALTER TABLE inm.kiosk_product_disabled OWNER TO erpuser;

--
-- Name: byte_products_fast; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_products_fast AS
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
    product.shelf_time AS shelf_life_days
   FROM pantry.product
  WHERE (product.campus_id = 87);


ALTER TABLE public.byte_products_fast OWNER TO erpuser;

--
-- Name: byte_products; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_products AS
 SELECT byte_products_fast.id,
    byte_products_fast.title,
    byte_products_fast.vendor,
    byte_products_fast.price,
    byte_products_fast.cost,
    byte_products_fast.shelf_time AS shelf_life_days,
    byte_products_fast.archived,
    byte_products_fast.attribute_names AS attributes,
    byte_products_fast.category_names AS categories,
    byte_products_fast.consumer_category,
    byte_products_fast.source,
    byte_products_fast.ws_case_size,
    byte_products_fast.kiosk_ship_qty,
    byte_products_fast.ws_case_cost,
    byte_products_fast.pick_station,
    byte_products_fast.allergens AS pantry_allergens,
    byte_products_fast.categories AS pantry_categories,
    byte_products_fast.fc_title
   FROM public.byte_products_fast;


ALTER TABLE public.byte_products OWNER TO erpuser;

--
-- Name: byte_label_product; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_label_product AS
 SELECT l.epc,
    l.order_id AS label_order_id,
    l.status AS label_status,
    l.price AS label_price,
    l.time_created,
    l.time_added,
    l.time_updated,
    to_timestamp((l.time_created)::double precision) AS ts_created,
    to_timestamp((l.time_added)::double precision) AS ts_added,
    to_timestamp((l.time_updated)::double precision) AS ts_updated,
    l.kiosk_id AS label_kiosk_id,
    p.id AS product_id,
    p.title AS product_title,
    p.archived AS product_archived,
    p.vendor AS product_vendor,
    p.price AS product_price,
    p.cost AS product_cost,
    p.shelf_life_days AS product_shelf_life_days,
    p.attributes AS product_attributes,
    p.categories AS product_categories,
    p.consumer_category,
    p.source AS product_source,
    p.fc_title
   FROM (pantry.label l
     JOIN public.byte_products p ON ((l.product_id = p.id)));


ALTER TABLE public.byte_label_product OWNER TO erpuser;

--
-- Name: byte_tickets_12weeks; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_tickets_12weeks AS
 SELECT byte_tickets.order_id,
    byte_tickets.first_name,
    byte_tickets.last_name,
    byte_tickets.kiosk_id,
    byte_tickets.kiosk_title,
    byte_tickets.email,
    byte_tickets.amount_paid,
    byte_tickets.payment_system,
    byte_tickets.transaction_id,
    byte_tickets.approval_code,
    byte_tickets.status_code,
    byte_tickets.status_message,
    byte_tickets.status,
    byte_tickets.batch_id,
    byte_tickets.created,
    byte_tickets.auth_amount,
    byte_tickets.data_token,
    byte_tickets.time_opened,
    byte_tickets.time_closed,
    byte_tickets.card_hash,
    byte_tickets.state,
    byte_tickets.archived,
    byte_tickets.stamp,
    byte_tickets.last_update,
    byte_tickets.balance,
    byte_tickets.delta,
    byte_tickets.coupon_id,
    byte_tickets.coupon,
    byte_tickets.refund,
    byte_tickets.receipt,
    byte_tickets.campus_id,
    byte_tickets.amount_list_price,
    byte_tickets.notes,
    byte_tickets.time_door_opened,
    byte_tickets.time_door_closed,
    byte_tickets.client_name,
    byte_tickets.estd_num_users,
    byte_tickets.ts,
    byte_tickets.full_name,
    byte_tickets.door_opened_secs,
    byte_tickets.month,
    byte_tickets.week,
    byte_tickets.date,
    byte_tickets.dayofweek,
    byte_tickets.hour,
    byte_tickets.dowhour,
    byte_tickets.uniq_user
   FROM public.byte_tickets
  WHERE (byte_tickets.ts > (now() - '84 days'::interval day));


ALTER TABLE public.byte_tickets_12weeks OWNER TO erpuser;

--
-- Name: byte_epcssold_12weeks; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_epcssold_12weeks AS
 SELECT o.order_id,
    o.first_name,
    o.last_name,
    o.kiosk_id,
    o.kiosk_title,
    o.email,
    o.amount_paid,
    o.payment_system,
    o.transaction_id,
    o.approval_code,
    o.status_code,
    o.status_message,
    o.status,
    o.batch_id,
    o.created,
    o.auth_amount,
    o.data_token,
    o.time_opened,
    o.time_closed,
    o.card_hash,
    o.state,
    o.archived,
    o.stamp,
    o.last_update,
    o.balance,
    o.delta,
    o.coupon_id,
    o.coupon,
    o.refund,
    o.receipt,
    o.campus_id,
    o.amount_list_price,
    o.notes,
    o.time_door_opened,
    o.time_door_closed,
    o.client_name,
    o.estd_num_users,
    o.ts,
    o.full_name,
    o.door_opened_secs,
    o.month,
    o.week,
    o.date,
    o.dayofweek,
    o.hour,
    o.dowhour,
    o.uniq_user,
    lp.epc,
    lp.label_order_id,
    lp.label_status,
    lp.label_price,
    lp.time_created,
    lp.time_added,
    lp.time_updated,
    lp.ts_created,
    lp.ts_added,
    lp.ts_updated,
    lp.label_kiosk_id,
    lp.product_id,
    lp.product_title,
    lp.product_archived,
    lp.product_vendor,
    lp.product_price,
    lp.product_cost,
    lp.product_shelf_life_days,
    lp.product_attributes,
    lp.product_categories,
    lp.consumer_category,
    lp.product_source,
    lp.fc_title
   FROM (public.byte_tickets_12weeks o
     JOIN public.byte_label_product lp ON (((lp.label_order_id)::text = (o.order_id)::text)))
  WHERE ((lp.label_status)::text = 'sold'::text);


ALTER TABLE public.byte_epcssold_12weeks OWNER TO erpuser;

--
-- Name: v_kiosk_sale_hourly; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.v_kiosk_sale_hourly AS
 SELECT units_sold.kiosk_id,
    units_sold.dow,
    units_sold.hod,
    units_sold.units_sold,
    round((units_sold.units_sold / GREATEST(1.00, sum(units_sold.units_sold) OVER (PARTITION BY units_sold.kiosk_id))), 4) AS units_sold_normalized
   FROM ( SELECT k.kiosk_id,
            dow.dow,
            hod.hod,
            round(COALESCE(((s.units_sold)::numeric / 12.0), 0.00), 2) AS units_sold
           FROM (((( SELECT k_1.id AS kiosk_id
                   FROM pantry.kiosk k_1
                  WHERE ((k_1.campus_id = 87) AND (k_1.archived = 0) AND (k_1.enable_reporting = 1))) k
             CROSS JOIN ( SELECT generate_series.generate_series AS dow
                   FROM generate_series(0, 6) generate_series(generate_series)) dow)
             CROSS JOIN ( SELECT generate_series.generate_series AS hod
                   FROM generate_series(0, 23) generate_series(generate_series)) hod)
             LEFT JOIN ( SELECT byte_epcssold_12weeks.kiosk_id,
                    date_part('dow'::text, timezone('US/Pacific'::text, byte_epcssold_12weeks.ts)) AS dow,
                    date_part('hour'::text, timezone('US/Pacific'::text, byte_epcssold_12weeks.ts)) AS hod,
                    count(*) AS units_sold
                   FROM public.byte_epcssold_12weeks
                  GROUP BY byte_epcssold_12weeks.kiosk_id, (date_part('dow'::text, timezone('US/Pacific'::text, byte_epcssold_12weeks.ts))), (date_part('hour'::text, timezone('US/Pacific'::text, byte_epcssold_12weeks.ts)))
                  ORDER BY byte_epcssold_12weeks.kiosk_id, (date_part('dow'::text, timezone('US/Pacific'::text, byte_epcssold_12weeks.ts))), (date_part('hour'::text, timezone('US/Pacific'::text, byte_epcssold_12weeks.ts)))) s ON (((k.kiosk_id = s.kiosk_id) AND ((dow.dow)::double precision = s.dow) AND ((hod.hod)::double precision = s.hod))))
          ORDER BY k.kiosk_id, dow.dow, hod.hod) units_sold;


ALTER TABLE inm.v_kiosk_sale_hourly OWNER TO erpuser;

--
-- Name: route_stop; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.route_stop (
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


ALTER TABLE mixalot.route_stop OWNER TO erpuser;

--
-- Name: v_kiosk_demand_plan_ratio; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.v_kiosk_demand_plan_ratio AS
 SELECT ksh.kiosk_id,
        CASE
            WHEN (rdt.d0_delivery = 1) THEN (ksh.d0_demand +
            CASE
                WHEN (rdt.d1_delivery = 0) THEN (ksh.d1_demand +
                CASE
                    WHEN (rdt.d2_delivery = 0) THEN (ksh.d2_demand +
                    CASE
                        WHEN (rdt.d3_delivery = 0) THEN (ksh.d3_demand +
                        CASE
                            WHEN (rdt.d4_delivery = 0) THEN ksh.d4_demand
                            ELSE (0)::numeric
                        END)
                        ELSE (0)::numeric
                    END)
                    ELSE (0)::numeric
                END)
                ELSE (0)::numeric
            END)
            ELSE (0)::numeric
        END AS d0_plan_demand_ratio,
        CASE
            WHEN (rdt.d1_delivery = 1) THEN (ksh.d1_demand +
            CASE
                WHEN (rdt.d2_delivery = 0) THEN (ksh.d2_demand +
                CASE
                    WHEN (rdt.d3_delivery = 0) THEN (ksh.d3_demand +
                    CASE
                        WHEN (rdt.d4_delivery = 0) THEN (ksh.d4_demand +
                        CASE
                            WHEN (rdt.d0_delivery = 0) THEN ksh.d0_demand
                            ELSE (0)::numeric
                        END)
                        ELSE (0)::numeric
                    END)
                    ELSE (0)::numeric
                END)
                ELSE (0)::numeric
            END)
            ELSE (0)::numeric
        END AS d1_plan_demand_ratio,
        CASE
            WHEN (rdt.d2_delivery = 1) THEN (ksh.d2_demand +
            CASE
                WHEN (rdt.d3_delivery = 0) THEN (ksh.d3_demand +
                CASE
                    WHEN (rdt.d4_delivery = 0) THEN (ksh.d4_demand +
                    CASE
                        WHEN (rdt.d1_delivery = 0) THEN (ksh.d1_demand +
                        CASE
                            WHEN (rdt.d2_delivery = 0) THEN ksh.d2_demand
                            ELSE (0)::numeric
                        END)
                        ELSE (0)::numeric
                    END)
                    ELSE (0)::numeric
                END)
                ELSE (0)::numeric
            END)
            ELSE (0)::numeric
        END AS d2_plan_demand_ratio,
        CASE
            WHEN (rdt.d3_delivery = 1) THEN (ksh.d3_demand +
            CASE
                WHEN (rdt.d4_delivery = 0) THEN (ksh.d4_demand +
                CASE
                    WHEN (rdt.d0_delivery = 0) THEN (ksh.d0_demand +
                    CASE
                        WHEN (rdt.d1_delivery = 0) THEN (ksh.d1_demand +
                        CASE
                            WHEN (rdt.d2_delivery = 0) THEN ksh.d2_demand
                            ELSE (0)::numeric
                        END)
                        ELSE (0)::numeric
                    END)
                    ELSE (0)::numeric
                END)
                ELSE (0)::numeric
            END)
            ELSE (0)::numeric
        END AS d3_plan_demand_ratio,
        CASE
            WHEN (rdt.d4_delivery = 1) THEN (ksh.d4_demand +
            CASE
                WHEN (rdt.d0_delivery = 0) THEN (ksh.d0_demand +
                CASE
                    WHEN (rdt.d1_delivery = 0) THEN (ksh.d1_demand +
                    CASE
                        WHEN (rdt.d2_delivery = 0) THEN (ksh.d2_demand +
                        CASE
                            WHEN (rdt.d3_delivery = 0) THEN ksh.d3_demand
                            ELSE (0)::numeric
                        END)
                        ELSE (0)::numeric
                    END)
                    ELSE (0)::numeric
                END)
                ELSE (0)::numeric
            END)
            ELSE (0)::numeric
        END AS d4_plan_demand_ratio
   FROM (( SELECT ksh_1.kiosk_id,
            sum(ksh_1.units_sold_normalized) FILTER (WHERE ((ksh_1.how >= 34) AND (ksh_1.how < 58))) AS d0_demand,
            sum(ksh_1.units_sold_normalized) FILTER (WHERE ((ksh_1.how >= 58) AND (ksh_1.how < 82))) AS d1_demand,
            sum(ksh_1.units_sold_normalized) FILTER (WHERE ((ksh_1.how >= 82) AND (ksh_1.how < 106))) AS d2_demand,
            sum(ksh_1.units_sold_normalized) FILTER (WHERE ((ksh_1.how >= 106) AND (ksh_1.how < 130))) AS d3_demand,
            sum(ksh_1.units_sold_normalized) FILTER (WHERE ((ksh_1.how >= 130) OR (ksh_1.how < 34))) AS d4_demand
           FROM ( SELECT ksh_2.kiosk_id,
                    ksh_2.dow,
                    ksh_2.hod,
                    ksh_2.units_sold,
                    ksh_2.units_sold_normalized,
                    ((24 * ksh_2.dow) + ksh_2.hod) AS how
                   FROM inm.v_kiosk_sale_hourly ksh_2) ksh_1
          GROUP BY ksh_1.kiosk_id) ksh
     LEFT JOIN ( SELECT rdt_1.kiosk_id,
            count(rdt_1.d) FILTER (WHERE (rdt_1.d = (0)::double precision)) AS d0_delivery,
            count(rdt_1.d) FILTER (WHERE (rdt_1.d = (1)::double precision)) AS d1_delivery,
            count(rdt_1.d) FILTER (WHERE (rdt_1.d = (2)::double precision)) AS d2_delivery,
            count(rdt_1.d) FILTER (WHERE (rdt_1.d = (3)::double precision)) AS d3_delivery,
            count(rdt_1.d) FILTER (WHERE (rdt_1.d = (4)::double precision)) AS d4_delivery
           FROM ( SELECT route_stop.location_number AS kiosk_id,
                    date_part('dow'::text, (timezone('US/Pacific'::text, route_stop.route_date_time) - ('11:00:00'::time without time zone)::interval)) AS d
                   FROM mixalot.route_stop
                  WHERE (date_trunc('week'::text, route_stop.route_date_time) = date_trunc('week'::text, now()))
                  ORDER BY route_stop.route_date_time, route_stop.schedule_at) rdt_1
          GROUP BY rdt_1.kiosk_id) rdt ON ((ksh.kiosk_id = rdt.kiosk_id)))
  ORDER BY ksh.kiosk_id;


ALTER TABLE inm.v_kiosk_demand_plan_ratio OWNER TO erpuser;

--
-- Name: v_kiosk_sku_enabled; Type: VIEW; Schema: inm; Owner: dbservice
--

CREATE VIEW inm.v_kiosk_sku_enabled AS
 SELECT k.kiosk_id,
    p.sku_group,
    p.sku,
    public.if((kpd.product_id IS NOT NULL), 0, 1) AS enabled
   FROM ((( SELECT k_1.id AS kiosk_id
           FROM pantry.kiosk k_1
          WHERE ((k_1.campus_id = 87) AND (k_1.archived = 0) AND (k_1.enable_reporting = 1))) k
     CROSS JOIN ( SELECT p_1.id AS sku,
            p_1.fc_title AS sku_group
           FROM pantry.product p_1
          WHERE ((p_1.campus_id = 87) AND (p_1.archived = 0) AND (p_1.fc_title IS NOT NULL) AND ((p_1.fc_title)::text <> 'N/A'::text))
          ORDER BY p_1.fc_title) p)
     LEFT JOIN inm.kiosk_product_disabled kpd ON (((k.kiosk_id = kpd.kiosk_id) AND (p.sku = kpd.product_id))))
  ORDER BY k.kiosk_id, p.sku_group, p.sku;


ALTER TABLE inm.v_kiosk_sku_enabled OWNER TO dbservice;

--
-- Name: v_kiosk_sku_group_stock_sale_spoil_history; Type: VIEW; Schema: inm; Owner: dbservice
--

CREATE VIEW inm.v_kiosk_sku_group_stock_sale_spoil_history AS
 SELECT t3.kiosk_id,
    t3.sku_group,
    round(avg(t3.stock_count), 2) AS stock_avg,
    round(stddev(t3.stock_count), 2) AS stock_std,
    round(avg(t3.sale_count), 2) AS sale_avg,
    round(stddev(t3.sale_count), 2) AS sale_std,
    round(avg(t3.spoil_count), 2) AS spoil_avg,
    round(stddev(t3.spoil_count), 2) AS spoil_std,
    round(avg(t3.week_stock), 2) AS week_stock_avg,
    round(stddev(t3.week_stock), 2) AS week_stock_std,
    round(avg(t3.week_sale), 2) AS week_sale_avg,
    round(stddev(t3.week_sale), 2) AS week_sale_std,
    round(avg(t3.week_spoil), 2) AS week_spoil_avg,
    round(stddev(t3.week_spoil), 2) AS week_spoil_std
   FROM ( SELECT t2.kiosk_id,
            t2.week,
            t2.sku_group,
            t2.stock_count,
            t2.sale_count,
            t2.spoil_count,
            sum(t2.stock_count) OVER (PARTITION BY t2.kiosk_id, t2.week) AS week_stock,
            sum(t2.sale_count) OVER (PARTITION BY t2.kiosk_id, t2.week) AS week_sale,
            sum(t2.spoil_count) OVER (PARTITION BY t2.kiosk_id, t2.week) AS week_spoil
           FROM ( SELECT t1.kiosk_id,
                    t1.week,
                    t1.sku_group,
                    sum(t1.stock_count) AS stock_count,
                    sum(t1.sale_count) AS sale_count,
                    sum(t1.spoil_count) AS spoil_count
                   FROM ( SELECT kk.kiosk_id,
                            kk.week,
                            pp.sku_group,
                            sss.product_id,
                            COALESCE(sss.stock_count, (0)::bigint) AS stock_count,
                            COALESCE(sss.sale_count, (0)::bigint) AS sale_count,
                            COALESCE(sss.spoil_count, (0)::bigint) AS spoil_count
                           FROM ((( SELECT k.id AS kiosk_id,
                                    (date_trunc('week'::text, generate_series((now() - '3 mons'::interval month), now(), '7 days'::interval)))::date AS week
                                   FROM pantry.kiosk k
                                  WHERE ((k.campus_id = 87) AND (k.archived = 0) AND (k.enable_reporting = 1) AND (k.enable_monitoring = 1))) kk
                             CROSS JOIN ( SELECT DISTINCT p.fc_title AS sku_group
                                   FROM pantry.product p
                                  WHERE ((p.campus_id = 87) AND (p.archived = 0) AND (p.fc_title IS NOT NULL) AND ((p.fc_title)::text <> 'N/A'::text))) pp)
                             LEFT JOIN ( SELECT COALESCE(stock.kiosk_id, sale.kiosk_id, spoil.kiosk_id) AS kiosk_id,
                                    COALESCE(stock.week, sale.week, spoil.week) AS week,
                                    COALESCE(stock.sku_group, sale.sku_group, spoil.sku_group) AS sku_group,
                                    COALESCE(stock.product_id, sale.product_id, spoil.product_id) AS product_id,
                                    COALESCE(stock.stock_count, (0)::bigint) AS stock_count,
                                    COALESCE(sale.sale_count, (0)::bigint) AS sale_count,
                                    COALESCE(spoil.spoil_count, (0)::bigint) AS spoil_count
                                   FROM ((( SELECT l.kiosk_id,
    p.fc_title AS sku_group,
    l.product_id,
    (date_trunc('week'::text, to_timestamp((l.time_updated)::double precision)))::date AS week,
    count(*) AS stock_count
   FROM (pantry.label l
     LEFT JOIN pantry.product p ON ((l.product_id = p.id)))
  WHERE ((to_timestamp((l.time_added)::double precision) > (now() - '3 mons'::interval month)) AND (p.campus_id = 87) AND (p.archived = 0) AND (p.fc_title IS NOT NULL) AND ((p.fc_title)::text <> 'N/A'::text))
  GROUP BY l.kiosk_id, p.fc_title, l.product_id, ((date_trunc('week'::text, to_timestamp((l.time_updated)::double precision)))::date)) stock
                                     FULL JOIN ( SELECT l.kiosk_id,
    p.fc_title AS sku_group,
    l.product_id,
    (date_trunc('week'::text, to_timestamp((l.time_updated)::double precision)))::date AS week,
    count(*) AS sale_count
   FROM (pantry.label l
     LEFT JOIN pantry.product p ON ((l.product_id = p.id)))
  WHERE ((to_timestamp((l.time_updated)::double precision) > (now() - '3 mons'::interval month)) AND ((l.status)::text = 'sold'::text) AND (l.order_id IS NOT NULL) AND (p.campus_id = 87) AND (p.archived = 0) AND (p.fc_title IS NOT NULL) AND ((p.fc_title)::text <> 'N/A'::text))
  GROUP BY l.kiosk_id, p.fc_title, l.product_id, ((date_trunc('week'::text, to_timestamp((l.time_updated)::double precision)))::date)) sale ON (((stock.kiosk_id = sale.kiosk_id) AND (stock.week = sale.week) AND ((stock.sku_group)::text = (sale.sku_group)::text) AND (stock.product_id = sale.product_id))))
                                     FULL JOIN ( SELECT l.kiosk_id,
    p.fc_title AS sku_group,
    l.product_id,
    (date_trunc('week'::text, to_timestamp((l.time_updated)::double precision)))::date AS week,
    count(*) AS spoil_count
   FROM (pantry.label l
     LEFT JOIN pantry.product p ON ((l.product_id = p.id)))
  WHERE ((to_timestamp((l.time_updated)::double precision) > (now() - '3 mons'::interval month)) AND ((l.status)::text = 'out'::text) AND ((l.order_id)::text ~~ 'RE%'::text) AND (p.campus_id = 87) AND (p.archived = 0) AND (p.fc_title IS NOT NULL) AND ((p.fc_title)::text <> 'N/A'::text))
  GROUP BY l.kiosk_id, p.fc_title, l.product_id, ((date_trunc('week'::text, to_timestamp((l.time_updated)::double precision)))::date)) spoil ON (((stock.kiosk_id = spoil.kiosk_id) AND (stock.week = spoil.week) AND ((stock.sku_group)::text = (spoil.sku_group)::text) AND (stock.product_id = spoil.product_id))))) sss ON (((kk.kiosk_id = sss.kiosk_id) AND (kk.week = sss.week) AND ((pp.sku_group)::text = (sss.sku_group)::text))))
                          ORDER BY kk.kiosk_id, kk.week, pp.sku_group) t1
                  GROUP BY t1.kiosk_id, t1.week, t1.sku_group) t2) t3
  GROUP BY t3.kiosk_id, t3.sku_group
  ORDER BY t3.kiosk_id, t3.sku_group;


ALTER TABLE inm.v_kiosk_sku_group_stock_sale_spoil_history OWNER TO dbservice;

--
-- Name: byte_tickets_3months; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_tickets_3months AS
 SELECT byte_tickets.order_id,
    byte_tickets.first_name,
    byte_tickets.last_name,
    byte_tickets.kiosk_id,
    byte_tickets.kiosk_title,
    byte_tickets.email,
    byte_tickets.amount_paid,
    byte_tickets.payment_system,
    byte_tickets.transaction_id,
    byte_tickets.approval_code,
    byte_tickets.status_code,
    byte_tickets.status_message,
    byte_tickets.status,
    byte_tickets.batch_id,
    byte_tickets.created,
    byte_tickets.auth_amount,
    byte_tickets.data_token,
    byte_tickets.time_opened,
    byte_tickets.time_closed,
    byte_tickets.card_hash,
    byte_tickets.state,
    byte_tickets.archived,
    byte_tickets.stamp,
    byte_tickets.last_update,
    byte_tickets.balance,
    byte_tickets.delta,
    byte_tickets.coupon_id,
    byte_tickets.coupon,
    byte_tickets.refund,
    byte_tickets.receipt,
    byte_tickets.campus_id,
    byte_tickets.amount_list_price,
    byte_tickets.notes,
    byte_tickets.time_door_opened,
    byte_tickets.time_door_closed,
    byte_tickets.client_name,
    byte_tickets.estd_num_users,
    byte_tickets.ts,
    byte_tickets.full_name,
    byte_tickets.door_opened_secs,
    byte_tickets.month,
    byte_tickets.week,
    byte_tickets.date,
    byte_tickets.dayofweek,
    byte_tickets.hour,
    byte_tickets.dowhour,
    byte_tickets.uniq_user
   FROM public.byte_tickets
  WHERE (byte_tickets.ts > (now() - '3 mons'::interval month));


ALTER TABLE public.byte_tickets_3months OWNER TO erpuser;

--
-- Name: byte_epcssold_3months; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_epcssold_3months AS
 SELECT o.order_id,
    o.first_name,
    o.last_name,
    o.kiosk_id,
    o.kiosk_title,
    o.email,
    o.amount_paid,
    o.payment_system,
    o.transaction_id,
    o.approval_code,
    o.status_code,
    o.status_message,
    o.status,
    o.batch_id,
    o.created,
    o.auth_amount,
    o.data_token,
    o.time_opened,
    o.time_closed,
    o.card_hash,
    o.state,
    o.archived,
    o.stamp,
    o.last_update,
    o.balance,
    o.delta,
    o.coupon_id,
    o.coupon,
    o.refund,
    o.receipt,
    o.campus_id,
    o.amount_list_price,
    o.notes,
    o.time_door_opened,
    o.time_door_closed,
    o.client_name,
    o.estd_num_users,
    o.ts,
    o.full_name,
    o.door_opened_secs,
    o.month,
    o.week,
    o.date,
    o.dayofweek,
    o.hour,
    o.dowhour,
    o.uniq_user,
    lp.epc,
    lp.label_order_id,
    lp.label_status,
    lp.label_price,
    lp.time_created,
    lp.time_added,
    lp.time_updated,
    lp.ts_created,
    lp.ts_added,
    lp.ts_updated,
    lp.label_kiosk_id,
    lp.product_id,
    lp.product_title,
    lp.product_archived,
    lp.product_vendor,
    lp.product_price,
    lp.product_cost,
    lp.product_shelf_life_days,
    lp.product_attributes,
    lp.product_categories,
    lp.consumer_category,
    lp.product_source
   FROM (public.byte_tickets_3months o
     JOIN public.byte_label_product lp ON (((lp.label_order_id)::text = (o.order_id)::text)))
  WHERE ((lp.label_status)::text = 'sold'::text);


ALTER TABLE public.byte_epcssold_3months OWNER TO erpuser;

--
-- Name: v_kiosk_sku_group_velocity_demand_week; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.v_kiosk_sku_group_velocity_demand_week AS
 SELECT kc.kiosk_id,
    sg.id AS sku_group_id,
    (sg.fc_title)::text AS sku_group,
    COALESCE(dwwom.sample_size, (0)::bigint) AS sample_size,
    COALESCE(dwwom.preference, 0.00) AS preference,
    max(COALESCE(dwwom.ws_avg, 0.00)) OVER (PARTITION BY kc.kiosk_id) AS ws_avg,
    max(COALESCE(dwwom.ws_std, 0.00)) OVER (PARTITION BY kc.kiosk_id) AS ws_std,
    max(COALESCE(dwwom.ws_max, 0.00)) OVER (PARTITION BY kc.kiosk_id) AS ws_max,
    max(COALESCE(dwwom.ws_live, (0)::bigint)) OVER (PARTITION BY kc.kiosk_id) AS ws_live,
    kc.start_level AS kc_start_level,
    kc.min_level AS kc_min_level,
    kc.manual_multiplier AS kc_manual_multiplier,
    sgc.default_level AS sgc_default_level,
    sgc.scale AS sgc_scale,
    COALESCE(ksms.scale, 1.00) AS ksms_scale,
    round(((((kc.start_level * kc.manual_multiplier) * sgc.scale) * COALESCE(ksms.scale, 1.00)) * sgc.default_level), 2) AS start_count,
    round(((((kc.min_level * kc.manual_multiplier) * sgc.scale) * COALESCE(ksms.scale, 1.00)) * sgc.default_level), 2) AS min_count,
    round((((COALESCE(dwwom.preference, 0.00) * kc.manual_multiplier) * sgc.scale) * COALESCE(ksms.scale, 1.00)), 2) AS scaled_preference,
    round(sum((((COALESCE(dwwom.preference, 0.00) * kc.manual_multiplier) * sgc.scale) * COALESCE(ksms.scale, 1.00))) OVER (PARTITION BY kc.kiosk_id), 2) AS scaled_preference_total,
    round((COALESCE(dwwom.ws_max, 0.00) * ((((COALESCE(dwwom.preference, 0.00) * kc.manual_multiplier) * sgc.scale) * COALESCE(ksms.scale, 1.00)) / GREATEST(0.01, sum((((COALESCE(dwwom.preference, 0.00) * kc.manual_multiplier) * sgc.scale) * COALESCE(ksms.scale, 1.00))) OVER (PARTITION BY kc.kiosk_id)))), 2) AS preference_count
   FROM ((((inm.sku_group sg
     CROSS JOIN inm.kiosk_control kc)
     LEFT JOIN inm.kiosk_sku_group_manual_scale ksms ON (((ksms.kiosk_id = kc.kiosk_id) AND (ksms.sku_group_id = sg.id))))
     LEFT JOIN inm.sku_group_control sgc ON ((sgc.sku_group_id = sg.id)))
     LEFT JOIN ( SELECT t4.kiosk_id,
            t4.sku_group,
            t4.sample_size,
            t4.dt_avg,
            t4.dt_std,
            t4.w_departure_time,
            t4.preference,
            t6.ws_avg,
            t6.ws_std,
            t6.ws_max,
            t6.ws_live
           FROM (( SELECT t3.kiosk_id,
                    t3.sku_group,
                    count(t3.purchase_index) AS sample_size,
                    round(avg(t3.departure_time), 2) AS dt_avg,
                    COALESCE(round(stddev(t3.departure_time), 2), (0)::numeric) AS dt_std,
                    round((sum((t3.departure_time * (t3.w)::numeric)) / (sum(t3.w))::numeric), 2) AS w_departure_time,
                    LEAST(round((1.00 / (sum((t3.departure_time * (t3.w)::numeric)) / (sum(t3.w))::numeric)), 2), 0.20) AS preference
                   FROM ( SELECT t2.kiosk_id,
                            t2.sku_group,
                            t2.time_stocked,
                            t2.time_sold,
                            t2.purchase_index,
                            t2.last_sale,
                            t2.last_purchase_index,
                            GREATEST(COALESCE(round((((t2.time_sold - GREATEST(t2.last_sale, t2.time_stocked)))::numeric / (3600)::numeric), 2), 50.00), 1.00) AS departure_time,
                            0 AS qty_sold,
                            1 AS w
                           FROM ( SELECT t1.kiosk_id,
                                    t1.sku_group,
                                    t1.time_stocked,
                                    t1.time_sold,
                                    t1.purchase_index,
                                    lag(t1.time_sold, 1) OVER (PARTITION BY t1.kiosk_id, t1.sku_group ORDER BY t1.time_sold) AS last_sale,
                                    lag(t1.purchase_index, 1) OVER (PARTITION BY t1.kiosk_id, t1.sku_group ORDER BY t1.time_sold) AS last_purchase_index
                                   FROM ( SELECT k.kiosk_id,
    p.sku_group,
    l.time_stocked,
    l.time_sold,
    l.purchase_index
   FROM ((( SELECT k_1.id AS kiosk_id
     FROM pantry.kiosk k_1
    WHERE ((k_1.campus_id = 87) AND (k_1.archived = 0) AND (k_1.enable_reporting = 1))) k
     CROSS JOIN ( SELECT DISTINCT p_1.fc_title AS sku_group
     FROM pantry.product p_1
    WHERE ((p_1.campus_id = 87) AND (p_1.archived = 0) AND (p_1.fc_title IS NOT NULL) AND ((p_1.fc_title)::text <> 'N/A'::text))
    ORDER BY p_1.fc_title) p)
     LEFT JOIN ( SELECT l_1.kiosk_id,
      p_1.fc_title AS sku_group,
      l_1.time_created AS time_stocked,
      l_1.time_updated AS time_sold,
      row_number() OVER (PARTITION BY l_1.kiosk_id ORDER BY l_1.time_updated) AS purchase_index
     FROM (pantry.label l_1
       JOIN pantry.product p_1 ON ((l_1.product_id = p_1.id)))
    WHERE ((l_1.kiosk_id IS NOT NULL) AND ((l_1.status)::text = 'sold'::text) AND (timezone('US/Pacific'::text, to_timestamp((l_1.time_updated)::double precision)) > (date_trunc('week'::text, CURRENT_TIMESTAMP) - '168 days'::interval)) AND (p_1.campus_id = 87) AND (p_1.archived = 0) AND (p_1.fc_title IS NOT NULL))) l ON (((k.kiosk_id = l.kiosk_id) AND ((p.sku_group)::text = (l.sku_group)::text))))
  ORDER BY k.kiosk_id, p.sku_group, l.purchase_index) t1) t2) t3
                  GROUP BY t3.kiosk_id, t3.sku_group) t4
             JOIN ( SELECT t5.kiosk_id,
                    round(avg(t5.units_sold), 2) AS ws_avg,
                    round(stddev(t5.units_sold), 2) AS ws_std,
                    round((max(t5.units_sold))::numeric, 2) AS ws_max,
                    count(t5.units_sold) AS ws_live
                   FROM ( SELECT concat((kk.kiosk_id)::character varying(4), ' ', kk.woy) AS key,
                            kk.kiosk_id,
                            kk.woy,
                            ss.units_sold
                           FROM (( SELECT k.id AS kiosk_id,
                                    generate_series(1, 52) AS woy
                                   FROM pantry.kiosk k
                                  WHERE ((k.campus_id = 87) AND (k.archived = 0) AND (k.enable_reporting = 1) AND (k.enable_monitoring = 1))) kk
                             LEFT JOIN ( SELECT s.kiosk_id,
                                    date_part('week'::text, s.ts) AS woy,
                                    count(*) AS units_sold
                                   FROM public.byte_epcssold_3months s
                                  GROUP BY s.kiosk_id, (date_part('week'::text, s.ts))) ss ON (((kk.kiosk_id = ss.kiosk_id) AND ((kk.woy)::double precision = ss.woy))))
                          ORDER BY ss.kiosk_id, ss.woy) t5
                  GROUP BY t5.kiosk_id
                  ORDER BY t5.kiosk_id) t6 ON ((t4.kiosk_id = t6.kiosk_id)))) dwwom ON (((dwwom.kiosk_id = kc.kiosk_id) AND ((dwwom.sku_group)::text = (sg.fc_title)::text))));


ALTER TABLE inm.v_kiosk_sku_group_velocity_demand_week OWNER TO erpuser;

--
-- Name: v_kiosk_sku_velocity; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.v_kiosk_sku_velocity AS
 SELECT t3.kiosk_id,
    t3.sku_group,
    t3.sku,
    t3.name,
    count(t3.purchase_index) AS sample_size,
    round(avg(t3.departure_time), 2) AS dt_avg,
    COALESCE(round(stddev(t3.departure_time), 2), (0)::numeric) AS dt_std,
    round((sum((t3.departure_time * (t3.w)::numeric)) / (sum(t3.w))::numeric), 2) AS w_departure_time,
    LEAST(round((1.00 / (sum((t3.departure_time * (t3.w)::numeric)) / (sum(t3.w))::numeric)), 2), 0.20) AS preference
   FROM ( SELECT t2.kiosk_id,
            t2.sku_group,
            t2.sku,
            t2.name,
            t2.time_stocked,
            t2.time_sold,
            t2.purchase_index,
            t2.last_sale,
            t2.last_purchase_index,
            GREATEST(COALESCE(round((((t2.time_sold - GREATEST(t2.last_sale, t2.time_stocked)))::numeric / (3600)::numeric), 2), 50.00), 1.00) AS departure_time,
            0 AS qty_sold,
            1 AS w
           FROM ( SELECT t1.kiosk_id,
                    t1.sku_group,
                    t1.sku,
                    t1.name,
                    t1.time_stocked,
                    t1.time_sold,
                    t1.purchase_index,
                    lag(t1.time_sold, 1) OVER (PARTITION BY t1.kiosk_id, t1.sku ORDER BY t1.time_sold) AS last_sale,
                    lag(t1.purchase_index, 1) OVER (PARTITION BY t1.kiosk_id, t1.sku ORDER BY t1.time_sold) AS last_purchase_index
                   FROM ( SELECT k.kiosk_id,
                            p.sku_group,
                            p.sku,
                            p.name,
                            l.time_stocked,
                            l.time_sold,
                            l.purchase_index
                           FROM ((( SELECT k_1.id AS kiosk_id
                                   FROM pantry.kiosk k_1
                                  WHERE ((k_1.campus_id = 87) AND (k_1.archived = 0) AND (k_1.enable_reporting = 1))) k
                             CROSS JOIN ( SELECT p_1.fc_title AS sku_group,
                                    p_1.id AS sku,
                                    p_1.title AS name
                                   FROM pantry.product p_1
                                  WHERE ((p_1.campus_id = 87) AND (p_1.archived = 0) AND ((p_1.fc_title)::text <> 'N/A'::text) AND (p_1.fc_title IS NOT NULL))
                                  ORDER BY p_1.fc_title, p_1.id) p)
                             LEFT JOIN ( SELECT l_1.kiosk_id,
                                    p_1.fc_title AS sku_group,
                                    p_1.id AS sku,
                                    l_1.time_created AS time_stocked,
                                    l_1.time_updated AS time_sold,
                                    row_number() OVER (PARTITION BY l_1.kiosk_id ORDER BY l_1.time_updated) AS purchase_index
                                   FROM (pantry.label l_1
                                     JOIN pantry.product p_1 ON ((l_1.product_id = p_1.id)))
                                  WHERE ((l_1.kiosk_id IS NOT NULL) AND ((l_1.status)::text = 'sold'::text) AND (timezone('US/Pacific'::text, to_timestamp((l_1.time_updated)::double precision)) > (date_trunc('week'::text, CURRENT_TIMESTAMP) - '168 days'::interval)) AND (p_1.campus_id = 87) AND (p_1.archived = 0) AND ((p_1.fc_title)::text <> 'N/A'::text) AND (p_1.fc_title IS NOT NULL))) l ON (((k.kiosk_id = l.kiosk_id) AND (p.sku = l.sku))))
                          ORDER BY k.kiosk_id, p.sku_group, p.sku, l.purchase_index) t1) t2) t3
  GROUP BY t3.kiosk_id, t3.sku_group, t3.sku, t3.name
  ORDER BY t3.kiosk_id, t3.sku_group, t3.sku;


ALTER TABLE inm.v_kiosk_sku_velocity OWNER TO erpuser;

--
-- Name: v_kiosk_sku_group_sku_stats; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.v_kiosk_sku_group_sku_stats AS
 SELECT enabled.kiosk_id,
    enabled.sku_group,
    demand.sku_group_id,
    enabled.sku,
    velocity.name,
    enabled.enabled,
    velocity.sample_size AS sku_sample_size,
    velocity.w_departure_time AS sku_departure_time,
    velocity.preference AS sku_preference,
    demand.sample_size AS sku_group_sample_size,
    demand.preference AS sku_group_preference,
    demand.kc_start_level AS kiosk_start_level,
    demand.kc_min_level AS kiosk_min_level,
    demand.kc_manual_multiplier AS kiosk_manual_multiplier,
    demand.sgc_default_level AS sku_group_default_level,
    demand.sgc_scale AS sku_group_scale,
    demand.ksms_scale AS kiosk_sku_group_scale,
    demand.start_count AS sku_group_start_count,
    demand.min_count AS sku_group_min_count,
    demand.preference_count AS sku_group_preference_count,
    history.stock_avg AS sku_group_stock_avg,
    history.stock_std AS sku_group_stock_std,
    history.sale_avg AS sku_group_sale_avg,
    history.sale_std AS sku_group_sale_std,
    history.spoil_avg AS sku_group_spoil_avg,
    history.spoil_std AS sku_group_spoil_std,
    demand.ws_live AS kiosk_weeks_live,
    demand.ws_max AS kiosk_sale_max,
    history.week_stock_avg AS kiosk_stock_avg,
    history.week_stock_std AS kiosk_stock_std,
    history.week_sale_avg AS kiosk_sale_avg,
    history.week_sale_std AS kiosk_sale_std,
    history.week_spoil_avg AS kiosk_spoil_avg,
    history.week_spoil_std AS kiosk_spoil_std,
    plan.d0_plan_demand_ratio,
    plan.d1_plan_demand_ratio,
    plan.d2_plan_demand_ratio,
    plan.d3_plan_demand_ratio,
    plan.d4_plan_demand_ratio
   FROM ((((inm.v_kiosk_sku_enabled enabled
     LEFT JOIN inm.v_kiosk_sku_velocity velocity ON (((enabled.kiosk_id = velocity.kiosk_id) AND (enabled.sku = velocity.sku))))
     LEFT JOIN inm.v_kiosk_sku_group_velocity_demand_week demand ON (((enabled.kiosk_id = demand.kiosk_id) AND ((enabled.sku_group)::text = demand.sku_group))))
     LEFT JOIN inm.v_kiosk_sku_group_stock_sale_spoil_history history ON (((enabled.kiosk_id = history.kiosk_id) AND ((enabled.sku_group)::text = (history.sku_group)::text))))
     LEFT JOIN inm.v_kiosk_demand_plan_ratio plan ON ((enabled.kiosk_id = plan.kiosk_id)))
  ORDER BY enabled.kiosk_id, enabled.sku_group, enabled.sku;


ALTER TABLE inm.v_kiosk_sku_group_sku_stats OWNER TO erpuser;

--
-- Name: v_warehouse_ordering_rec; Type: VIEW; Schema: fnrenames; Owner: erpuser
--

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


ALTER TABLE fnrenames.v_warehouse_ordering_rec OWNER TO erpuser;

--
-- Name: product_picking_order; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.product_picking_order AS
 SELECT po.id AS product_id,
    (po.pick_order)::smallint AS pick_order
   FROM ( SELECT product.id,
            product.vendor,
            product.title,
            row_number() OVER (ORDER BY product.pick_station, product.vendor, product.title) AS pick_order
           FROM pantry.product
          WHERE ((product.campus_id = 87) AND (product.archived = 0))) po;


ALTER TABLE inm.product_picking_order OWNER TO erpuser;

--
-- Name: allocable_inventory; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.allocable_inventory AS
 SELECT i.inventory_date,
    i.product_id,
    ((i.stickered_units + (i.stickered_cases * i.units_per_case)) - i.spoiled_units) AS qty,
    p.pick_station,
    p.title,
    p.fc_title,
    p.vendor,
    COALESCE(po.pick_order, (0)::smallint) AS pick_order
   FROM ((inm.warehouse_inventory i
     JOIN pantry.product p ON ((i.product_id = p.id)))
     LEFT JOIN inm.product_picking_order po ON ((i.product_id = po.product_id)))
  WHERE (((i.stickered_units + (i.stickered_cases * i.units_per_case)) - i.spoiled_units) > 0);


ALTER TABLE inm.allocable_inventory OWNER TO erpuser;

--
-- Name: configuration; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.configuration (
    setting character varying(100) NOT NULL,
    value numeric NOT NULL
);


ALTER TABLE inm.configuration OWNER TO erpuser;

--
-- Name: TABLE configuration; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.configuration IS 'inm configuration values';


--
-- Name: kiosk_projected_stock; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.kiosk_projected_stock AS
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
          WHERE (((l.status)::text ~~ 'ok'::text) AND (k.campus_id = 87) AND (k.archived <> 1))
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


ALTER TABLE inm.kiosk_projected_stock OWNER TO erpuser;

--
-- Name: VIEW kiosk_projected_stock; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON VIEW inm.kiosk_projected_stock IS 'kiosk current stock plus items on route';


--
-- Name: kiosk_restriction_list; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.kiosk_restriction_list AS
 SELECT kr.kiosk_id,
    string_agg(pp.value, ','::text) AS restrictions
   FROM (inm.kiosk_restriction_by_property kr
     JOIN inm.product_property_def pp ON ((pp.id = kr.property_id)))
  GROUP BY kr.kiosk_id;


ALTER TABLE inm.kiosk_restriction_list OWNER TO erpuser;

--
-- Name: pick_substitution; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.pick_substitution (
    substituting_sku_group_id integer NOT NULL,
    substituted_sku_group_id integer NOT NULL,
    qty integer NOT NULL,
    pick_date date NOT NULL
);


ALTER TABLE inm.pick_substitution OWNER TO erpuser;

--
-- Name: TABLE pick_substitution; Type: COMMENT; Schema: inm; Owner: erpuser
--

COMMENT ON TABLE inm.pick_substitution IS 'items substituted';


--
-- Name: product_pick_order; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.product_pick_order (
    product_id integer NOT NULL,
    pick_order smallint DEFAULT 0 NOT NULL
);


ALTER TABLE inm.product_pick_order OWNER TO erpuser;

--
-- Name: product_pick_order_temp; Type: TABLE; Schema: inm; Owner: erpuser
--

CREATE TABLE inm.product_pick_order_temp (
    product_id integer NOT NULL,
    qty integer,
    sku_group text,
    pick_order smallint DEFAULT 0 NOT NULL
);


ALTER TABLE inm.product_pick_order_temp OWNER TO erpuser;

--
-- Name: product_property_def_id_seq; Type: SEQUENCE; Schema: inm; Owner: erpuser
--

CREATE SEQUENCE inm.product_property_def_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inm.product_property_def_id_seq OWNER TO erpuser;

--
-- Name: product_property_def_id_seq; Type: SEQUENCE OWNED BY; Schema: inm; Owner: erpuser
--

ALTER SEQUENCE inm.product_property_def_id_seq OWNED BY inm.product_property_def.id;


--
-- Name: v_warehouse_order_delivered_totals; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.v_warehouse_order_delivered_totals AS
 SELECT warehouse_order_history.sku,
    sum(warehouse_order_history.amount_arrived) AS received_prod,
    warehouse_order_history.delivery_date
   FROM inm.warehouse_order_history
  GROUP BY warehouse_order_history.sku, warehouse_order_history.delivery_date;


ALTER TABLE inm.v_warehouse_order_delivered_totals OWNER TO erpuser;

--
-- Name: v_warehouse_ordering_rec; Type: VIEW; Schema: inm; Owner: erpuser
--

CREATE VIEW inm.v_warehouse_ordering_rec AS
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


ALTER TABLE inm.v_warehouse_ordering_rec OWNER TO erpuser;

--
-- Name: diff_kiosk_control; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.diff_kiosk_control (
    kiosk_id integer,
    start_level numeric(4,2),
    min_level numeric(4,2),
    scale numeric(4,2),
    manual_multiplier numeric(4,2),
    count bigint
);


ALTER TABLE inm_restore_0625.diff_kiosk_control OWNER TO erpuser;

--
-- Name: diff_kiosk_restriction_by_property; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.diff_kiosk_restriction_by_property (
    kiosk_id integer,
    property_id integer,
    count bigint
);


ALTER TABLE inm_restore_0625.diff_kiosk_restriction_by_property OWNER TO erpuser;

--
-- Name: diff_kiosk_sku_group_manual_scale; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.diff_kiosk_sku_group_manual_scale (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2),
    count bigint
);


ALTER TABLE inm_restore_0625.diff_kiosk_sku_group_manual_scale OWNER TO erpuser;

--
-- Name: kiosk_control; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.kiosk_control (
    kiosk_id integer,
    start_level numeric(4,2),
    min_level numeric(4,2),
    scale numeric(4,2),
    manual_multiplier numeric(4,2)
);


ALTER TABLE inm_restore_0625.kiosk_control OWNER TO erpuser;

--
-- Name: kiosk_control_gs; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.kiosk_control_gs (
    kiosk_id integer,
    start_level numeric(4,2),
    min_level numeric(4,2),
    scale numeric(4,2),
    manual_multiplier numeric(4,2)
);


ALTER TABLE inm_restore_0625.kiosk_control_gs OWNER TO erpuser;

--
-- Name: kiosk_restriction_by_property; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.kiosk_restriction_by_property (
    kiosk_id integer,
    property_id integer
);


ALTER TABLE inm_restore_0625.kiosk_restriction_by_property OWNER TO erpuser;

--
-- Name: kiosk_restriction_by_property_gs; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.kiosk_restriction_by_property_gs (
    kiosk_id integer,
    property_id integer
);


ALTER TABLE inm_restore_0625.kiosk_restriction_by_property_gs OWNER TO erpuser;

--
-- Name: kiosk_sku_group_manual_scale; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.kiosk_sku_group_manual_scale (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2)
);


ALTER TABLE inm_restore_0625.kiosk_sku_group_manual_scale OWNER TO erpuser;

--
-- Name: kiosk_sku_group_manual_scale_gs; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.kiosk_sku_group_manual_scale_gs (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2)
);


ALTER TABLE inm_restore_0625.kiosk_sku_group_manual_scale_gs OWNER TO erpuser;

--
-- Name: product_property; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.product_property (
    product_id bigint,
    property_id integer
);


ALTER TABLE inm_restore_0625.product_property OWNER TO erpuser;

--
-- Name: product_property_gs; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.product_property_gs (
    product_id bigint,
    property_id integer
);


ALTER TABLE inm_restore_0625.product_property_gs OWNER TO erpuser;

--
-- Name: sku_group_control; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.sku_group_control (
    sku_group_id integer,
    default_level numeric(4,2),
    scale numeric(4,2),
    min_qty smallint,
    max_qty smallint
);


ALTER TABLE inm_restore_0625.sku_group_control OWNER TO erpuser;

--
-- Name: sku_group_control_gs; Type: TABLE; Schema: inm_restore_0625; Owner: erpuser
--

CREATE TABLE inm_restore_0625.sku_group_control_gs (
    sku_group_id integer,
    default_level numeric(4,2),
    scale numeric(4,2),
    min_qty smallint,
    max_qty smallint
);


ALTER TABLE inm_restore_0625.sku_group_control_gs OWNER TO erpuser;

--
-- Name: bkup_kiosk_product_disabled; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.bkup_kiosk_product_disabled (
    kiosk_id bigint,
    product_id integer
);


ALTER TABLE inm_test.bkup_kiosk_product_disabled OWNER TO erpuser;

--
-- Name: bkup_kiosk_product_disabled_20190408; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.bkup_kiosk_product_disabled_20190408 (
    kiosk_id bigint,
    product_id bigint
);


ALTER TABLE inm_test.bkup_kiosk_product_disabled_20190408 OWNER TO erpuser;

--
-- Name: bkup_kiosk_restriction_by_product; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.bkup_kiosk_restriction_by_product (
    kiosk_id bigint,
    product_id integer,
    end_date date,
    comment type.text400,
    record_ts timestamp with time zone
);


ALTER TABLE inm_test.bkup_kiosk_restriction_by_product OWNER TO erpuser;

--
-- Name: even_id_id_seq; Type: SEQUENCE; Schema: inm_test; Owner: erpuser
--

CREATE SEQUENCE inm_test.even_id_id_seq
    START WITH 1
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inm_test.even_id_id_seq OWNER TO erpuser;

--
-- Name: even_id; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.even_id (
    id integer DEFAULT nextval('inm_test.even_id_id_seq'::regclass) NOT NULL,
    ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    comment text
);


ALTER TABLE inm_test.even_id OWNER TO erpuser;

--
-- Name: even_id_seq; Type: SEQUENCE; Schema: inm_test; Owner: erpuser
--

CREATE SEQUENCE inm_test.even_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inm_test.even_id_seq OWNER TO erpuser;

--
-- Name: kiosk_classic_view; Type: VIEW; Schema: inm_test; Owner: erpuser
--

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


ALTER TABLE inm_test.kiosk_classic_view OWNER TO erpuser;

--
-- Name: kiosk_par_level; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.kiosk_par_level (
    kiosk_id bigint NOT NULL,
    product_id bigint NOT NULL,
    amount bigint
);


ALTER TABLE inm_test.kiosk_par_level OWNER TO erpuser;

--
-- Name: kiosk_projected_stock; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.kiosk_projected_stock (
    kiosk_id bigint,
    kiosk_title character varying,
    fc_title character varying(765),
    count numeric
);


ALTER TABLE inm_test.kiosk_projected_stock OWNER TO erpuser;

--
-- Name: kiosk_sku_group_manual_scale_20190624; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.kiosk_sku_group_manual_scale_20190624 (
    kiosk_id integer,
    sku_group_id integer,
    scale numeric(4,2)
);


ALTER TABLE inm_test.kiosk_sku_group_manual_scale_20190624 OWNER TO erpuser;

--
-- Name: label; Type: TABLE; Schema: inm_test; Owner: erpuser
--

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


ALTER TABLE inm_test.label OWNER TO erpuser;

--
-- Name: odd_id; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.odd_id (
    id integer NOT NULL,
    ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    comment text
);


ALTER TABLE inm_test.odd_id OWNER TO erpuser;

--
-- Name: odd_id_id_seq; Type: SEQUENCE; Schema: inm_test; Owner: erpuser
--

ALTER TABLE inm_test.odd_id ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME inm_test.odd_id_id_seq
    START WITH 1
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order; Type: TABLE; Schema: inm_test; Owner: erpuser
--

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


ALTER TABLE inm_test."order" OWNER TO erpuser;

--
-- Name: pick_allocation; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.pick_allocation (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL,
    qty integer NOT NULL
);


ALTER TABLE inm_test.pick_allocation OWNER TO erpuser;

--
-- Name: pick_demand; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.pick_demand (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    qty integer NOT NULL
);


ALTER TABLE inm_test.pick_demand OWNER TO erpuser;

--
-- Name: pick_inventory; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.pick_inventory (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    sku_group_id integer NOT NULL,
    qty integer NOT NULL
);


ALTER TABLE inm_test.pick_inventory OWNER TO erpuser;

--
-- Name: pick_rejection; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.pick_rejection (
    pick_date date NOT NULL,
    route_date date NOT NULL,
    kiosk_id integer NOT NULL,
    item_id integer NOT NULL,
    item_type character varying(32) NOT NULL,
    reason character varying(64) NOT NULL
);


ALTER TABLE inm_test.pick_rejection OWNER TO erpuser;

--
-- Name: pick_route; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.pick_route (
    pick_date date NOT NULL,
    kiosk_id integer NOT NULL,
    route_number character varying(256),
    driver_name character varying(64) NOT NULL,
    route_time time(6) without time zone NOT NULL,
    route_date date NOT NULL,
    delivery_order smallint NOT NULL
);


ALTER TABLE inm_test.pick_route OWNER TO erpuser;

--
-- Name: pick_substitution; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.pick_substitution (
    substituting_sku_group_id integer NOT NULL,
    substituted_sku_group_id integer NOT NULL,
    qty integer NOT NULL,
    pick_date date NOT NULL
);


ALTER TABLE inm_test.pick_substitution OWNER TO erpuser;

--
-- Name: route_stop_20190616; Type: TABLE; Schema: inm_test; Owner: erpuser
--

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


ALTER TABLE inm_test.route_stop_20190616 OWNER TO erpuser;

--
-- Name: temp_a; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.temp_a (
    id integer NOT NULL,
    name text
);


ALTER TABLE inm_test.temp_a OWNER TO erpuser;

--
-- Name: temp_b; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.temp_b (
    id integer NOT NULL,
    name text
);


ALTER TABLE inm_test.temp_b OWNER TO erpuser;

--
-- Name: temp_kiosk; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.temp_kiosk (
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


ALTER TABLE inm_test.temp_kiosk OWNER TO erpuser;

--
-- Name: temp_test; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.temp_test (
    id integer NOT NULL
);


ALTER TABLE inm_test.temp_test OWNER TO erpuser;

--
-- Name: test; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.test (
    id integer NOT NULL
);


ALTER TABLE inm_test.test OWNER TO erpuser;

--
-- Name: test2; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.test2 (
    id integer NOT NULL,
    intval integer,
    strval text
);


ALTER TABLE inm_test.test2 OWNER TO erpuser;

--
-- Name: test_sequence; Type: TABLE; Schema: inm_test; Owner: erpuser
--

CREATE TABLE inm_test.test_sequence (
    id integer NOT NULL,
    name text
);


ALTER TABLE inm_test.test_sequence OWNER TO erpuser;

--
-- Name: test_sequence_id_seq; Type: SEQUENCE; Schema: inm_test; Owner: erpuser
--

ALTER TABLE inm_test.test_sequence ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME inm_test.test_sequence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: kiosk; Type: TABLE; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.kiosk OWNER TO erpuser;

--
-- Name: kiosk_dest_to_match; Type: VIEW; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.kiosk_dest_to_match OWNER TO erpuser;

--
-- Name: kiosk_source_to_match; Type: VIEW; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.kiosk_source_to_match OWNER TO erpuser;

--
-- Name: product; Type: TABLE; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.product OWNER TO erpuser;

--
-- Name: reverse_product; Type: TABLE; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.reverse_product OWNER TO erpuser;

--
-- Name: sync_qa_product_dest; Type: VIEW; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.sync_qa_product_dest OWNER TO erpuser;

--
-- Name: sync_qa_product_source; Type: VIEW; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.sync_qa_product_source OWNER TO erpuser;

--
-- Name: temp_product; Type: TABLE; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.temp_product OWNER TO erpuser;

--
-- Name: v_product; Type: VIEW; Schema: migration; Owner: erpuser
--

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


ALTER TABLE migration.v_product OWNER TO erpuser;

--
-- Name: card_product_fact; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.card_product_fact (
    id integer NOT NULL,
    card_hash text,
    product_id integer,
    sku text,
    first_available_ts timestamp(6) with time zone,
    first_purchased_ts timestamp(6) with time zone,
    acc_sales_1w double precision,
    acc_sales_30d double precision,
    acc_sales_6m double precision,
    avg_item_price double precision,
    avg_item_discount double precision,
    cnt_purchases_lt integer,
    cnt_purchased_30d integer,
    cnt_purchased_6m integer,
    cnt_purchased_1y integer,
    prob_purch_first double precision,
    prob_purch_again double precision,
    number_not_purchased_before_1st integer,
    number_available_lt integer,
    number_not_purchased_lt integer,
    number_available_after_1st integer,
    number_not_purchased_after_1st integer,
    number_stockouts_after_1st integer
);


ALTER TABLE mixalot.card_product_fact OWNER TO erpuser;

--
-- Name: card_product_fact_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.card_product_fact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.card_product_fact_id_seq OWNER TO erpuser;

--
-- Name: card_product_fact_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.card_product_fact_id_seq OWNED BY mixalot.card_product_fact.id;


--
-- Name: gsheet_cache; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.gsheet_cache (
    id character varying(50) NOT NULL,
    update_d timestamp(6) with time zone,
    email_count integer,
    email_json text,
    payload json
);


ALTER TABLE mixalot.gsheet_cache OWNER TO erpuser;

--
-- Name: history_order_pipeline; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.history_order_pipeline (
    id integer NOT NULL,
    order_id character varying(45),
    action character varying(45),
    system character varying(45),
    "user" character varying(45),
    data text,
    ts timestamp(6) with time zone
);


ALTER TABLE mixalot.history_order_pipeline OWNER TO erpuser;

--
-- Name: history_order_pipeline_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.history_order_pipeline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.history_order_pipeline_id_seq OWNER TO erpuser;

--
-- Name: history_order_pipeline_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.history_order_pipeline_id_seq OWNED BY mixalot.history_order_pipeline.id;


--
-- Name: inm_data; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.inm_data (
    id integer NOT NULL,
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


ALTER TABLE mixalot.inm_data OWNER TO erpuser;

--
-- Name: inm_data_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.inm_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.inm_data_id_seq OWNER TO erpuser;

--
-- Name: inm_data_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.inm_data_id_seq OWNED BY mixalot.inm_data.id;


--
-- Name: inm_kiosk_projected_stock; Type: VIEW; Schema: mixalot; Owner: erpuser
--

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


ALTER TABLE mixalot.inm_kiosk_projected_stock OWNER TO erpuser;

--
-- Name: merchandising_slot_sku_group; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.merchandising_slot_sku_group (
    sku_group_id integer NOT NULL,
    merchandising_slot_id integer NOT NULL
);


ALTER TABLE mixalot.merchandising_slot_sku_group OWNER TO erpuser;

--
-- Name: sku_group_def; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.sku_group_def (
    id integer NOT NULL,
    title character varying(512) NOT NULL,
    volume numeric(4,2)
);


ALTER TABLE mixalot.sku_group_def OWNER TO erpuser;

--
-- Name: inm_sku_group_title_to_merchandising_slot; Type: VIEW; Schema: mixalot; Owner: erpuser
--

CREATE VIEW mixalot.inm_sku_group_title_to_merchandising_slot AS
 SELECT sgd.title AS sku_group_title,
    mssg.merchandising_slot_id
   FROM (mixalot.merchandising_slot_sku_group mssg
     JOIN mixalot.sku_group_def sgd ON ((mssg.sku_group_id = sgd.id)))
  ORDER BY mssg.merchandising_slot_id;


ALTER TABLE mixalot.inm_sku_group_title_to_merchandising_slot OWNER TO erpuser;

--
-- Name: inm_sku_velocity; Type: VIEW; Schema: mixalot; Owner: erpuser
--

CREATE VIEW mixalot.inm_sku_velocity AS
 SELECT t3.kiosk_id,
    t3.sku_group,
    t3.sku,
    t3.name,
    count(t3.purchase_index) AS sample_size,
    round(avg(t3.departure_time), 2) AS dt_avg,
    COALESCE(round(stddev(t3.departure_time), 2), (0)::numeric) AS dt_std,
    round((sum((t3.departure_time * (t3.w)::numeric)) / (sum(t3.w))::numeric), 2) AS w_departure_time,
    LEAST(round((1.00 / (sum((t3.departure_time * (t3.w)::numeric)) / (sum(t3.w))::numeric)), 2), 0.20) AS preference
   FROM ( SELECT t2.kiosk_id,
            t2.sku_group,
            t2.sku,
            t2.name,
            t2.time_stocked,
            t2.time_sold,
            t2.purchase_index,
            t2.last_sale,
            t2.last_purchase_index,
            GREATEST(COALESCE(round((((t2.time_sold - GREATEST(t2.last_sale, t2.time_stocked)))::numeric / (3600)::numeric), 2), 50.00), 1.00) AS departure_time,
            0 AS qty_sold,
            1 AS w
           FROM ( SELECT t1.kiosk_id,
                    t1.sku_group,
                    t1.sku,
                    t1.name,
                    t1.time_stocked,
                    t1.time_sold,
                    t1.purchase_index,
                    lag(t1.time_sold, 1) OVER (PARTITION BY t1.kiosk_id, t1.sku ORDER BY t1.time_sold) AS last_sale,
                    lag(t1.purchase_index, 1) OVER (PARTITION BY t1.kiosk_id, t1.sku ORDER BY t1.time_sold) AS last_purchase_index
                   FROM ( SELECT k.kiosk_id,
                            p.sku_group,
                            p.sku,
                            p.name,
                            l.time_stocked,
                            l.time_sold,
                            l.purchase_index
                           FROM ((( SELECT k_1.id AS kiosk_id
                                   FROM pantry.kiosk k_1
                                  WHERE ((k_1.campus_id = 87) AND (k_1.archived = 0) AND (k_1.enable_reporting = 1))) k
                             CROSS JOIN ( SELECT p_1.fc_title AS sku_group,
                                    p_1.id AS sku,
                                    p_1.title AS name
                                   FROM pantry.product p_1
                                  WHERE ((p_1.campus_id = 87) AND (p_1.archived = 0) AND ((p_1.fc_title)::text <> 'N/A'::text) AND (p_1.fc_title IS NOT NULL))
                                  ORDER BY p_1.fc_title, p_1.id) p)
                             LEFT JOIN ( SELECT l_1.kiosk_id,
                                    p_1.fc_title AS sku_group,
                                    p_1.id AS sku,
                                    l_1.time_created AS time_stocked,
                                    l_1.time_updated AS time_sold,
                                    row_number() OVER (PARTITION BY l_1.kiosk_id ORDER BY l_1.time_updated) AS purchase_index
                                   FROM (pantry.label l_1
                                     JOIN pantry.product p_1 ON ((l_1.product_id = p_1.id)))
                                  WHERE ((l_1.kiosk_id IS NOT NULL) AND ((l_1.status)::text = 'sold'::text) AND (timezone('US/Pacific'::text, to_timestamp((l_1.time_updated)::double precision)) > (date_trunc('week'::text, CURRENT_TIMESTAMP) - '168 days'::interval)) AND (p_1.campus_id = 87) AND (p_1.archived = 0) AND ((p_1.fc_title)::text <> 'N/A'::text) AND (p_1.fc_title IS NOT NULL))) l ON (((k.kiosk_id = l.kiosk_id) AND (p.sku = l.sku))))
                          ORDER BY k.kiosk_id, p.sku_group, p.sku, l.purchase_index) t1) t2) t3
  GROUP BY t3.kiosk_id, t3.sku_group, t3.sku, t3.name
  ORDER BY t3.kiosk_id, t3.sku_group, t3.sku;


ALTER TABLE mixalot.inm_sku_velocity OWNER TO erpuser;

--
-- Name: kiosk_contents; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.kiosk_contents (
    id integer NOT NULL,
    product_id integer,
    quantity integer,
    "time" bigint
);


ALTER TABLE mixalot.kiosk_contents OWNER TO erpuser;

--
-- Name: kiosk_contents_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.kiosk_contents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.kiosk_contents_id_seq OWNER TO erpuser;

--
-- Name: kiosk_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.kiosk_contents_id_seq OWNED BY mixalot.kiosk_contents.id;


--
-- Name: kiosk_fact; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.kiosk_fact (
    id integer NOT NULL,
    kiosk_id integer,
    kiosk_title text,
    campus_id integer,
    serials text,
    current_serial text,
    archived integer,
    last_delivery_ts timestamp(6) with time zone,
    last_purchase_ts timestamp(6) with time zone,
    cnt_deliveries_1w double precision,
    cnt_deliveries_30d double precision,
    cnt_deliveries_6m double precision,
    acc_list_price_1w double precision,
    acc_list_price_30d double precision,
    acc_list_price_6m double precision,
    cnt_orders_1w double precision,
    cnt_orders_30d double precision,
    cnt_orders_6m double precision,
    cnt_unique_cards_1w double precision,
    cnt_unique_cards_30d double precision,
    cnt_unique_cards_6m double precision
);


ALTER TABLE mixalot.kiosk_fact OWNER TO erpuser;

--
-- Name: kiosk_fact_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.kiosk_fact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.kiosk_fact_id_seq OWNER TO erpuser;

--
-- Name: kiosk_fact_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.kiosk_fact_id_seq OWNED BY mixalot.kiosk_fact.id;


--
-- Name: last_kiosk_status; Type: VIEW; Schema: mixalot; Owner: erpuser
--

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


ALTER TABLE mixalot.last_kiosk_status OWNER TO erpuser;

--
-- Name: log; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.log (
    id integer NOT NULL,
    request_uuid uuid,
    endpoint text,
    version text,
    system text,
    subsystem text,
    ts timestamp(6) with time zone,
    message text,
    herenow text,
    traceback text,
    kiosk_id integer,
    order_id character varying(135),
    product_id integer,
    epc text,
    client_ip text,
    attributes json
);


ALTER TABLE mixalot.log OWNER TO erpuser;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.log_id_seq OWNER TO erpuser;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.log_id_seq OWNED BY mixalot.log.id;


--
-- Name: order_fact; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.order_fact (
    id integer NOT NULL,
    order_id text,
    hash text,
    email text,
    first_name text,
    last_name text,
    kiosk_id integer,
    kiosk_title text,
    campus_id integer,
    sales_price double precision,
    list_price double precision,
    contents_id integer
);


ALTER TABLE mixalot.order_fact OWNER TO erpuser;

--
-- Name: order_fact_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.order_fact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.order_fact_id_seq OWNER TO erpuser;

--
-- Name: order_fact_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.order_fact_id_seq OWNED BY mixalot.order_fact.id;


--
-- Name: pgdu; Type: VIEW; Schema: mixalot; Owner: erpuser
--

CREATE VIEW mixalot.pgdu AS
 SELECT pretty_sizes.table_name,
    pg_size_pretty(pretty_sizes.table_size) AS table_size,
    pg_size_pretty(pretty_sizes.indexes_size) AS indexes_size,
    pg_size_pretty(pretty_sizes.total_size) AS total_size
   FROM ( SELECT all_tables.table_name,
            pg_table_size((all_tables.table_name)::regclass) AS table_size,
            pg_indexes_size((all_tables.table_name)::regclass) AS indexes_size,
            pg_total_relation_size((all_tables.table_name)::regclass) AS total_size
           FROM ( SELECT (((('"'::text || (tables.table_schema)::text) || '"."'::text) || (tables.table_name)::text) || '"'::text) AS table_name
                   FROM information_schema.tables) all_tables
          ORDER BY (pg_total_relation_size((all_tables.table_name)::regclass)) DESC) pretty_sizes
 LIMIT 10;


ALTER TABLE mixalot.pgdu OWNER TO erpuser;

--
-- Name: pick_preference_kiosk_sku; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.pick_preference_kiosk_sku (
    kiosk_id integer NOT NULL,
    sku_id integer NOT NULL,
    preference smallint NOT NULL
);


ALTER TABLE mixalot.pick_preference_kiosk_sku OWNER TO erpuser;

--
-- Name: pick_priority_kiosk; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.pick_priority_kiosk (
    kiosk_id integer NOT NULL,
    priority integer,
    comment text,
    end_date date
);


ALTER TABLE mixalot.pick_priority_kiosk OWNER TO erpuser;

--
-- Name: product_fact; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.product_fact (
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


ALTER TABLE mixalot.product_fact OWNER TO erpuser;

--
-- Name: product_fact_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.product_fact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.product_fact_id_seq OWNER TO erpuser;

--
-- Name: product_fact_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.product_fact_id_seq OWNED BY mixalot.product_fact.id;


--
-- Name: request_log; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.request_log (
    request_uuid uuid NOT NULL,
    endpoint text,
    client_ip text,
    version text,
    cookie text,
    message text,
    request_body text,
    request_headers text,
    start_ts timestamp(6) with time zone,
    response_body text,
    response_headers text,
    status_code integer,
    end_ts timestamp(6) with time zone,
    traceback text,
    request_body_json text,
    request_headers_json text,
    response_headers_json text,
    kiosk_id character varying(50),
    source text,
    flushed timestamp(6) with time zone,
    order_id character varying(135),
    stamp bigint,
    "time" bigint,
    kid bigint,
    client_time timestamp(6) with time zone,
    rec_version integer,
    query_string text
);


ALTER TABLE mixalot.request_log OWNER TO erpuser;

--
-- Name: route; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.route (
    route_date_time timestamp(6) with time zone NOT NULL,
    duration integer,
    vehicle_label character varying(200),
    vehicle_registration character varying(200),
    driver_serial character varying(200),
    distance numeric(28,6),
    driver_name character varying(200) NOT NULL
);


ALTER TABLE mixalot.route OWNER TO erpuser;

--
-- Name: sku_group; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.sku_group (
    id integer NOT NULL,
    title character varying(50),
    group_type character varying(50),
    replacement_type character varying(50),
    created timestamp(6) with time zone,
    updated timestamp(6) with time zone
);


ALTER TABLE mixalot.sku_group OWNER TO erpuser;

--
-- Name: sku_group_def_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.sku_group_def_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.sku_group_def_id_seq OWNER TO erpuser;

--
-- Name: sku_group_def_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.sku_group_def_id_seq OWNED BY mixalot.sku_group_def.id;


--
-- Name: sku_group_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.sku_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.sku_group_id_seq OWNER TO erpuser;

--
-- Name: sku_group_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.sku_group_id_seq OWNED BY mixalot.sku_group.id;


--
-- Name: sku_group_member; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.sku_group_member (
    id integer NOT NULL,
    sku_group_id integer,
    product_id integer,
    created timestamp(6) with time zone,
    updated timestamp(6) with time zone
);


ALTER TABLE mixalot.sku_group_member OWNER TO erpuser;

--
-- Name: sku_group_member_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.sku_group_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.sku_group_member_id_seq OWNER TO erpuser;

--
-- Name: sku_group_member_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.sku_group_member_id_seq OWNED BY mixalot.sku_group_member.id;


--
-- Name: sku_property; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.sku_property (
    sku_id integer NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE mixalot.sku_property OWNER TO erpuser;

--
-- Name: sku_property_def; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.sku_property_def (
    id integer NOT NULL,
    attribute character varying(256),
    title character varying(512) NOT NULL
);


ALTER TABLE mixalot.sku_property_def OWNER TO erpuser;

--
-- Name: TABLE sku_property_def; Type: COMMENT; Schema: mixalot; Owner: erpuser
--

COMMENT ON TABLE mixalot.sku_property_def IS 'property_id, attribute, value.
Example:
1234 | container | glass
1235 | allergen | peanut
';


--
-- Name: sku_property_def_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.sku_property_def_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.sku_property_def_id_seq OWNER TO erpuser;

--
-- Name: sku_property_def_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.sku_property_def_id_seq OWNED BY mixalot.sku_property_def.id;


--
-- Name: tmp_discount_applied; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.tmp_discount_applied (
    id integer NOT NULL,
    order_id character varying(135),
    sequence integer,
    epc character varying(135),
    product_id integer,
    discount json,
    price_before numeric(28,6),
    price_after numeric(28,6),
    sponsor character varying(135),
    ts timestamp(6) with time zone
);


ALTER TABLE mixalot.tmp_discount_applied OWNER TO erpuser;

--
-- Name: tmp_discount_applied_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.tmp_discount_applied_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.tmp_discount_applied_id_seq OWNER TO erpuser;

--
-- Name: tmp_discount_applied_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.tmp_discount_applied_id_seq OWNED BY mixalot.tmp_discount_applied.id;


--
-- Name: tmp_kiosk_status; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.tmp_kiosk_status (
    id integer NOT NULL,
    kiosk_id integer NOT NULL,
    kiosk_temperature numeric(6,3),
    kit_temperature numeric(6,3),
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
    notes text
);


ALTER TABLE mixalot.tmp_kiosk_status OWNER TO erpuser;

--
-- Name: tmp_kiosk_status_id_seq; Type: SEQUENCE; Schema: mixalot; Owner: erpuser
--

CREATE SEQUENCE mixalot.tmp_kiosk_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mixalot.tmp_kiosk_status_id_seq OWNER TO erpuser;

--
-- Name: tmp_kiosk_status_id_seq; Type: SEQUENCE OWNED BY; Schema: mixalot; Owner: erpuser
--

ALTER SEQUENCE mixalot.tmp_kiosk_status_id_seq OWNED BY mixalot.tmp_kiosk_status.id;


--
-- Name: tmp_transact; Type: TABLE; Schema: mixalot; Owner: erpuser
--

CREATE TABLE mixalot.tmp_transact (
    order_id character varying(135) NOT NULL,
    first_name text,
    last_name text,
    kiosk_id integer,
    kiosk_title text,
    email text,
    amount_paid numeric(28,6),
    payment_system text,
    transaction_id text,
    approval_code text,
    status_code text,
    status_message text,
    created timestamp(6) with time zone,
    time_opened timestamp(6) with time zone,
    time_closed timestamp(6) with time zone,
    card_hash text,
    card_number text,
    card_type text,
    state text,
    stamp integer,
    last_update timestamp(6) with time zone,
    balance numeric(28,6),
    coupon_id integer,
    coupon text,
    refund numeric(28,6),
    receipt integer,
    campus_id integer,
    amount_list_price numeric(28,6),
    flushed timestamp(6) with time zone,
    create_dt timestamp(6) with time zone,
    modify_dt timestamp(6) with time zone,
    finalized integer
);


ALTER TABLE mixalot.tmp_transact OWNER TO erpuser;

--
-- Name: accounting; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.accounting (
    id bigint NOT NULL,
    date character varying(45) NOT NULL,
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
    next_fee_from character varying(45),
    fee_connectivity numeric(5,2) NOT NULL
);


ALTER TABLE pantry.accounting OWNER TO erpuser;

--
-- Name: awsdms_apply_exceptions; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);


ALTER TABLE pantry.awsdms_apply_exceptions OWNER TO erpuser;

--
-- Name: bad_timestamp; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.bad_timestamp (
    id bigint NOT NULL,
    kiosk_id bigint,
    endpoint character varying(93),
    server_time bigint,
    data character varying(3069)
);


ALTER TABLE pantry.bad_timestamp OWNER TO erpuser;

--
-- Name: campus_assets; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.campus_assets (
    campus_id bigint NOT NULL,
    logo character varying(255),
    background_image character varying(255),
    background_color character varying(50),
    receipt_header_text character varying(300),
    receipt_footer_text character varying(300)
);


ALTER TABLE pantry.campus_assets OWNER TO erpuser;

--
-- Name: card; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.card (
    id bigint NOT NULL,
    hash character varying(88) NOT NULL,
    first_name character varying(45),
    last_name character varying(45),
    type character varying(15),
    number character varying(31),
    email character varying(127) NOT NULL,
    notes text,
    created bigint,
    last_update bigint
);


ALTER TABLE pantry.card OWNER TO erpuser;

--
-- Name: discount; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.discount (
    id bigint NOT NULL,
    kiosk_id bigint,
    product_id bigint,
    value integer NOT NULL,
    type character varying(10),
    end_time integer,
    cron_task_id integer
);


ALTER TABLE pantry.discount OWNER TO erpuser;

--
-- Name: discount_history; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.discount_history (
    id integer NOT NULL,
    kiosk_id integer,
    product_id integer,
    value integer,
    start_time integer,
    end_time integer,
    discount_id integer
);


ALTER TABLE pantry.discount_history OWNER TO erpuser;

--
-- Name: email; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.email (
    id integer NOT NULL,
    hash character varying(100),
    "timestamp" integer NOT NULL,
    "from" character varying(200),
    "to" character varying(200),
    cc character varying(200),
    bcc character varying(200),
    subject character varying(200),
    body character varying(65535),
    order_id character varying(12),
    kiosk_id integer,
    type character varying(100) NOT NULL
);


ALTER TABLE pantry.email OWNER TO erpuser;

--
-- Name: email_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.email_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.email_id_seq OWNER TO erpuser;

--
-- Name: email_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.email_id_seq OWNED BY pantry.email.id;


--
-- Name: empty_transaction; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.empty_transaction (
    id integer NOT NULL,
    order_id character varying(36),
    kiosk_name character varying(192),
    email character varying(384),
    created character varying(384),
    representative character varying(384),
    notes character varying(65535),
    fixed character varying(90),
    status character varying(150)
);


ALTER TABLE pantry.empty_transaction OWNER TO erpuser;

--
-- Name: empty_transaction_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.empty_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.empty_transaction_id_seq OWNER TO erpuser;

--
-- Name: empty_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.empty_transaction_id_seq OWNED BY pantry.empty_transaction.id;


--
-- Name: fee_rates; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.fee_rates (
    id bigint NOT NULL,
    fee_lease numeric(6,2) NOT NULL,
    fee_tags numeric(3,2) NOT NULL,
    fee_ipc numeric(5,4) NOT NULL,
    bi_monthly smallint NOT NULL,
    archived smallint NOT NULL,
    custom smallint NOT NULL,
    prepaid_amount bigint NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE pantry.fee_rates OWNER TO erpuser;

--
-- Name: group; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry."group" (
    id bigint NOT NULL,
    name character varying(45) NOT NULL,
    title character varying(45) NOT NULL,
    notes character varying(2000) NOT NULL,
    archived integer
);


ALTER TABLE pantry."group" OWNER TO erpuser;

--
-- Name: group_campus; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.group_campus (
    group_id bigint NOT NULL,
    campus_id bigint NOT NULL,
    owner smallint NOT NULL,
    archived integer
);


ALTER TABLE pantry.group_campus OWNER TO erpuser;

--
-- Name: history; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.history (
    id bigint NOT NULL,
    epc character varying(24) NOT NULL,
    kiosk_id bigint NOT NULL,
    user_id bigint,
    order_id character varying(45),
    direction character varying(3) NOT NULL,
    "time" bigint NOT NULL
);


ALTER TABLE pantry.history OWNER TO erpuser;

--
-- Name: history_epc_order; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.history_epc_order (
    id bigint NOT NULL,
    epc character varying(72) NOT NULL,
    kiosk_id bigint NOT NULL,
    order_id character varying(135),
    "time" bigint NOT NULL,
    product_id integer,
    price numeric(5,2),
    action character varying(135),
    system character varying(135),
    "user" character varying(135)
);


ALTER TABLE pantry.history_epc_order OWNER TO erpuser;

--
-- Name: history_epc_order_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.history_epc_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.history_epc_order_id_seq OWNER TO erpuser;

--
-- Name: history_epc_order_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.history_epc_order_id_seq OWNED BY pantry.history_epc_order.id;


--
-- Name: inventory_history; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.inventory_history (
    id integer NOT NULL,
    "time" integer NOT NULL,
    kiosk_id integer NOT NULL,
    product_id integer NOT NULL,
    qty integer NOT NULL,
    campus_id integer NOT NULL,
    is_restored bigint NOT NULL
);


ALTER TABLE pantry.inventory_history OWNER TO erpuser;

--
-- Name: inventory_request; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.inventory_request (
    id bigint NOT NULL,
    kiosk_id bigint,
    "time" bigint,
    epc character varying(72)
);


ALTER TABLE pantry.inventory_request OWNER TO erpuser;

--
-- Name: inventory_request_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.inventory_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.inventory_request_id_seq OWNER TO erpuser;

--
-- Name: inventory_request_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.inventory_request_id_seq OWNED BY pantry.inventory_request.id;


--
-- Name: kiosk_audit_log; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.kiosk_audit_log (
    id bigint NOT NULL,
    kiosk_id integer NOT NULL,
    created_at timestamp(6) without time zone,
    archived smallint,
    enable_reporting smallint,
    enable_monitoring smallint
);


ALTER TABLE pantry.kiosk_audit_log OWNER TO erpuser;

--
-- Name: kiosk_catalog_downloads; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.kiosk_catalog_downloads (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    duration bigint NOT NULL,
    num_bytes bigint NOT NULL,
    num_products bigint NOT NULL,
    current_discounts character varying(765),
    recent_discount_history character varying(765)
);


ALTER TABLE pantry.kiosk_catalog_downloads OWNER TO erpuser;

--
-- Name: kiosk_catalog_downloads_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.kiosk_catalog_downloads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.kiosk_catalog_downloads_id_seq OWNER TO erpuser;

--
-- Name: kiosk_catalog_downloads_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.kiosk_catalog_downloads_id_seq OWNED BY pantry.kiosk_catalog_downloads.id;


--
-- Name: kiosk_components_history; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.kiosk_components_history (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    "time" bigint NOT NULL,
    type character varying(63),
    common_name character varying(63),
    version character varying(63),
    "full" character varying(255),
    notes text
);


ALTER TABLE pantry.kiosk_components_history OWNER TO erpuser;

--
-- Name: kiosk_components_history_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.kiosk_components_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.kiosk_components_history_id_seq OWNER TO erpuser;

--
-- Name: kiosk_components_history_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.kiosk_components_history_id_seq OWNED BY pantry.kiosk_components_history.id;


--
-- Name: kiosk_par_level; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.kiosk_par_level (
    kiosk_id bigint NOT NULL,
    product_id bigint NOT NULL,
    amount bigint
);


ALTER TABLE pantry.kiosk_par_level OWNER TO erpuser;

--
-- Name: kiosks_date_non_new; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.kiosks_date_non_new (
    id integer NOT NULL,
    kiosk_id integer NOT NULL,
    new_ts integer NOT NULL
);


ALTER TABLE pantry.kiosks_date_non_new OWNER TO erpuser;

--
-- Name: label_order_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.label_order_id_seq
    START WITH 1
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.label_order_id_seq OWNER TO erpuser;

--
-- Name: label_order_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.label_order_id_seq OWNED BY pantry.label_order.id;


--
-- Name: label_stats; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.label_stats (
    product_id bigint,
    used_since_last_delivery bigint,
    used_total bigint,
    last_delivery_date bigint,
    last_delivery bigint,
    delivered_total bigint
);


ALTER TABLE pantry.label_stats OWNER TO erpuser;

--
-- Name: manual_adjustment; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.manual_adjustment (
    id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    date character varying(45) NOT NULL,
    sum numeric(6,2) NOT NULL,
    reason character varying(128) NOT NULL,
    auto_generated smallint NOT NULL,
    archived bigint NOT NULL
);


ALTER TABLE pantry.manual_adjustment OWNER TO erpuser;

--
-- Name: nutrition_filter; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.nutrition_filter (
    id bigint NOT NULL,
    tag_id bigint,
    label character varying(150),
    icon character varying(381)
);


ALTER TABLE pantry.nutrition_filter OWNER TO erpuser;

--
-- Name: payment_order; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.payment_order (
    order_id character varying(45) NOT NULL,
    payload jsonb,
    re_auth_attempts integer DEFAULT 0,
    id integer NOT NULL
);


ALTER TABLE pantry.payment_order OWNER TO erpuser;

--
-- Name: payment_order_nursing; Type: VIEW; Schema: pantry; Owner: erpuser
--

CREATE VIEW pantry.payment_order_nursing AS
 SELECT payment_order.order_id,
    (payment_order.payload ->> 'nurse_id'::text) AS nurse_id,
    (payment_order.payload ->> 'patient_id'::text) AS patient_id
   FROM pantry.payment_order
  WHERE (((payment_order.payload ->> 'nurse_id'::text) IS NOT NULL) AND ((payment_order.payload ->> 'patient_id'::text) IS NOT NULL));


ALTER TABLE pantry.payment_order_nursing OWNER TO erpuser;

--
-- Name: pick_list_row; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.pick_list_row (
    id integer NOT NULL,
    "SiteCode" character varying(384),
    "SiteName" character varying(384),
    "PickStation" character varying(384),
    "Vendor" character varying(384),
    "ItemName" character varying(384),
    "ProposedSupply" integer,
    status character varying(150),
    "DriverName" character varying(384),
    "RouteTime" character varying(384),
    "RouteDate" character varying(384),
    "RouteNumber" character varying(384),
    route_time bigint,
    created bigint,
    "Refrigerated" character varying(65535),
    "TotalPickQty" character varying(65535),
    "TotalPickSKU" integer,
    "KioskInvQty" character varying(65535),
    "KioskSKUCnt" integer
);


ALTER TABLE pantry.pick_list_row OWNER TO erpuser;

--
-- Name: pick_list_row_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.pick_list_row_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.pick_list_row_id_seq OWNER TO erpuser;

--
-- Name: pick_list_row_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.pick_list_row_id_seq OWNED BY pantry.pick_list_row.id;


--
-- Name: product_history; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.product_history (
    id integer NOT NULL,
    price numeric(5,2),
    cost numeric(5,2),
    start_time integer,
    end_time integer,
    product_id integer,
    campus_id integer
);


ALTER TABLE pantry.product_history OWNER TO erpuser;

--
-- Name: recent_transactions; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.recent_transactions (
    kiosk_id integer NOT NULL,
    current_less_recent integer,
    current_most_recent integer,
    less_recent integer,
    most_recent integer
);


ALTER TABLE pantry.recent_transactions OWNER TO erpuser;

--
-- Name: refunds; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.refunds (
    order_id character varying(135) NOT NULL,
    product_id integer NOT NULL,
    price numeric(6,2) NOT NULL
);


ALTER TABLE pantry.refunds OWNER TO erpuser;

--
-- Name: ro_order; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.ro_order (
    order_id character varying(135) NOT NULL,
    campus_id bigint NOT NULL,
    kiosk_id bigint NOT NULL,
    kiosk_title character varying(138),
    created bigint,
    state character varying(45) NOT NULL,
    customer_full_name character varying(300),
    full_price numeric(6,2),
    real_full_price numeric(6,2),
    archived bigint,
    time_updated bigint
);


ALTER TABLE pantry.ro_order OWNER TO erpuser;

--
-- Name: role; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.role (
    id integer NOT NULL,
    role character varying(765)
);


ALTER TABLE pantry.role OWNER TO erpuser;

--
-- Name: temp_kiosk; Type: TABLE; Schema: pantry; Owner: erpuser
--

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


ALTER TABLE pantry.temp_kiosk OWNER TO erpuser;

--
-- Name: temp_product; Type: TABLE; Schema: pantry; Owner: erpuser
--

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


ALTER TABLE pantry.temp_product OWNER TO erpuser;

--
-- Name: temperature_tag_history; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry.temperature_tag_history (
    id bigint NOT NULL,
    kiosk_id bigint,
    "time" bigint,
    epc character varying(72),
    current numeric(5,2),
    average numeric(5,2),
    "full" character varying(381),
    read_count smallint
);


ALTER TABLE pantry.temperature_tag_history OWNER TO erpuser;

--
-- Name: temperature_tag_history_id_seq; Type: SEQUENCE; Schema: pantry; Owner: erpuser
--

CREATE SEQUENCE pantry.temperature_tag_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pantry.temperature_tag_history_id_seq OWNER TO erpuser;

--
-- Name: temperature_tag_history_id_seq; Type: SEQUENCE OWNED BY; Schema: pantry; Owner: erpuser
--

ALTER SEQUENCE pantry.temperature_tag_history_id_seq OWNED BY pantry.temperature_tag_history.id;


--
-- Name: user; Type: TABLE; Schema: pantry; Owner: erpuser
--

CREATE TABLE pantry."user" (
    id bigint NOT NULL,
    login character varying(45) NOT NULL,
    first_name character varying(127),
    last_name character varying(127),
    password character varying(88) NOT NULL,
    email character varying(127),
    role_id bigint NOT NULL,
    group_id bigint NOT NULL,
    archived bigint NOT NULL,
    date_registered bigint NOT NULL,
    timezone character varying(50),
    email_params character varying(65535),
    token character varying(40),
    notes character varying(2000)
);


ALTER TABLE pantry."user" OWNER TO erpuser;

--
-- Name: awsdms_ddl_audit; Type: TABLE; Schema: public; Owner: erpuser
--

CREATE TABLE public.awsdms_ddl_audit (
    c_key bigint NOT NULL,
    c_time timestamp without time zone,
    c_user character varying(64),
    c_txn character varying(16),
    c_tag character varying(24),
    c_oid integer,
    c_name character varying(64),
    c_schema character varying(64),
    c_ddlqry text
);


ALTER TABLE public.awsdms_ddl_audit OWNER TO erpuser;

--
-- Name: awsdms_ddl_audit_c_key_seq; Type: SEQUENCE; Schema: public; Owner: erpuser
--

CREATE SEQUENCE public.awsdms_ddl_audit_c_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.awsdms_ddl_audit_c_key_seq OWNER TO erpuser;

--
-- Name: awsdms_ddl_audit_c_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erpuser
--

ALTER SEQUENCE public.awsdms_ddl_audit_c_key_seq OWNED BY public.awsdms_ddl_audit.c_key;


--
-- Name: bak_awsdms_apply_exceptions; Type: TABLE; Schema: public; Owner: erpuser
--

CREATE TABLE public.bak_awsdms_apply_exceptions (
    "TASK_NAME" character varying(128) NOT NULL,
    "TABLE_OWNER" character varying(128) NOT NULL,
    "TABLE_NAME" character varying(128) NOT NULL,
    "ERROR_TIME" timestamp without time zone NOT NULL,
    "STATEMENT" text NOT NULL,
    "ERROR" text NOT NULL
);


ALTER TABLE public.bak_awsdms_apply_exceptions OWNER TO erpuser;

--
-- Name: bak_awsdms_validation_failures_v1; Type: TABLE; Schema: public; Owner: erpuser
--

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


ALTER TABLE public.bak_awsdms_validation_failures_v1 OWNER TO erpuser;

--
-- Name: byte_epcssold; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_epcssold AS
 SELECT o.order_id,
    o.first_name,
    o.last_name,
    o.kiosk_id,
    o.kiosk_title,
    o.email,
    o.amount_paid,
    o.payment_system,
    o.transaction_id,
    o.approval_code,
    o.status_code,
    o.status_message,
    o.status,
    o.batch_id,
    o.created,
    o.auth_amount,
    o.data_token,
    o.time_opened,
    o.time_closed,
    o.card_hash,
    o.state,
    o.archived,
    o.stamp,
    o.last_update,
    o.balance,
    o.delta,
    o.coupon_id,
    o.coupon,
    o.refund,
    o.receipt,
    o.campus_id,
    o.amount_list_price,
    o.notes,
    o.time_door_opened,
    o.time_door_closed,
    o.client_name,
    o.estd_num_users,
    o.ts,
    o.full_name,
    o.door_opened_secs,
    o.month,
    o.week,
    o.date,
    o.dayofweek,
    o.hour,
    o.dowhour,
    o.uniq_user,
    lp.epc,
    lp.label_order_id,
    lp.label_status,
    lp.label_price,
    lp.time_created,
    lp.time_added,
    lp.time_updated,
    lp.ts_created,
    lp.ts_added,
    lp.ts_updated,
    lp.label_kiosk_id,
    lp.product_id,
    lp.product_title,
    lp.product_archived,
    lp.product_vendor,
    lp.product_price,
    lp.product_cost,
    lp.product_shelf_life_days,
    lp.product_attributes,
    lp.product_categories,
    lp.consumer_category,
    lp.product_source
   FROM (public.byte_tickets o
     JOIN public.byte_label_product lp ON (((lp.label_order_id)::text = (o.order_id)::text)))
  WHERE ((lp.label_status)::text = 'sold'::text);


ALTER TABLE public.byte_epcssold OWNER TO erpuser;

--
-- Name: byte_feedback_weekly; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_feedback_weekly AS
 SELECT t1.week,
    t1.avg_rating,
    t1.avg_value,
    t1.avg_taste,
    t1.avg_freshness,
    t1.avg_variety,
    ((1.0 * (t1.feedbacks)::numeric) / (t2.tix)::numeric) AS frac_feedbacks
   FROM (( SELECT byte_feedback.week,
            avg((1.0 * (byte_feedback.rate)::numeric)) AS avg_rating,
            avg(public.if((byte_feedback.value > 0), (1.0 * (byte_feedback.value)::numeric), NULL::numeric)) AS avg_value,
            avg(public.if((byte_feedback.taste > 0), (1.0 * (byte_feedback.taste)::numeric), NULL::numeric)) AS avg_taste,
            avg(public.if((byte_feedback.freshness > 0), (1.0 * (byte_feedback.freshness)::numeric), NULL::numeric)) AS avg_freshness,
            avg(public.if((byte_feedback.variety > 0), (1.0 * (byte_feedback.variety)::numeric), NULL::numeric)) AS avg_variety,
            count(*) AS feedbacks
           FROM public.byte_feedback
          WHERE (byte_feedback.week >= '2016-01-01 08:00:00+00'::timestamp with time zone)
          GROUP BY byte_feedback.week
          ORDER BY byte_feedback.week) t1
     JOIN ( SELECT byte_tickets.week,
            count(*) AS tix
           FROM public.byte_tickets
          GROUP BY byte_tickets.week) t2 ON ((t1.week = t2.week)));


ALTER TABLE public.byte_feedback_weekly OWNER TO erpuser;

--
-- Name: byte_kiosks; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_kiosks AS
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
    kiosk.kiosk_restrictions,
    ( SELECT date(to_timestamp((min("order".created))::double precision)) AS date
           FROM pantry."order"
          WHERE (("order".kiosk_id = kiosk.id) AND (("order".order_id)::text ~~ 'RE%'::text))) AS first_restock,
    ( SELECT date_trunc('month'::text, (to_timestamp((min("order".created))::double precision) + '1 mon'::interval)) AS date_trunc
           FROM pantry."order"
          WHERE (("order".kiosk_id = kiosk.id) AND (("order".order_id)::text ~~ 'RE%'::text))) AS first_full_month
   FROM pantry.kiosk
  WHERE ((kiosk.campus_id = 87) AND (kiosk.enable_reporting = 1));


ALTER TABLE public.byte_kiosks OWNER TO erpuser;

--
-- Name: inventory_history; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.inventory_history AS
 SELECT date_trunc('month'::text, t.ts) AS month,
    date_trunc('week'::text, t.ts) AS week,
    date_trunc('day'::text, t.ts) AS date,
    date_trunc('hour'::text, t.ts) AS hour,
    date_part('dow'::text, t.ts) AS dayofweek,
    t.ts,
    t.product_id,
    t.kiosk_id,
    t.qty,
    t.product_title,
    t.kiosk_title
   FROM ( SELECT to_timestamp((ih."time")::double precision) AS ts,
            ih.product_id,
            ih.kiosk_id,
            ih.qty,
            p.title AS product_title,
            k.title AS kiosk_title
           FROM ((pantry.inventory_history ih
             JOIN pantry.product p ON ((ih.product_id = p.id)))
             JOIN pantry.kiosk k ON ((ih.kiosk_id = k.id)))) t;


ALTER TABLE public.inventory_history OWNER TO erpuser;

--
-- Name: byte_inventory_history; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_inventory_history AS
 SELECT ih.month,
    ih.week,
    ih.date,
    ih.hour,
    ih.dayofweek,
    ih.ts,
    ih.product_id,
    ih.kiosk_id,
    ih.qty,
    ih.product_title,
    ih.kiosk_title
   FROM (public.inventory_history ih
     JOIN public.byte_kiosks bk ON ((ih.kiosk_id = bk.id)));


ALTER TABLE public.byte_inventory_history OWNER TO erpuser;

--
-- Name: byte_inventory_history_eod; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_inventory_history_eod AS
 SELECT ih.month,
    ih.week,
    ih.date,
    ih.hour,
    ih.dayofweek,
    ih.ts,
    ih.product_id,
    ih.kiosk_id,
    ih.qty,
    ih.product_title,
    ih.kiosk_title
   FROM ((public.inventory_history ih
     JOIN public.byte_kiosks bk ON ((ih.kiosk_id = bk.id)))
     JOIN ( SELECT byte_inventory_history.date,
            byte_inventory_history.kiosk_id,
            byte_inventory_history.product_id,
            max(byte_inventory_history.ts) AS maxts
           FROM public.byte_inventory_history
          GROUP BY byte_inventory_history.date, byte_inventory_history.kiosk_id, byte_inventory_history.product_id) ih_eod ON (((ih_eod.kiosk_id = ih.kiosk_id) AND (ih_eod.product_id = ih.product_id) AND (ih_eod.date = ih.date))))
  WHERE (((bk.title)::text !~~* 'burn%'::text) AND ((bk.title)::text !~~* 'test%'::text));


ALTER TABLE public.byte_inventory_history_eod OWNER TO erpuser;

--
-- Name: byte_inventory_history_eod_2wks; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.byte_inventory_history_eod_2wks AS
 SELECT ih.month,
    ih.week,
    ih.date,
    ih.hour,
    ih.dayofweek,
    ih.ts,
    ih.product_id,
    ih.kiosk_id,
    ih.qty,
    ih.product_title,
    ih.kiosk_title
   FROM ((public.inventory_history ih
     JOIN public.byte_kiosks bk ON ((ih.kiosk_id = bk.id)))
     JOIN ( SELECT byte_inventory_history.date,
            byte_inventory_history.kiosk_id,
            byte_inventory_history.product_id,
            max(byte_inventory_history.ts) AS maxts
           FROM public.byte_inventory_history
          WHERE (byte_inventory_history.ts > (now() - '14 days'::interval day))
          GROUP BY byte_inventory_history.date, byte_inventory_history.kiosk_id, byte_inventory_history.product_id) ih_eod ON (((ih_eod.kiosk_id = ih.kiosk_id) AND (ih_eod.product_id = ih.product_id) AND (ih_eod.maxts = ih.ts) AND (ih.ts > (now() - '14 days'::interval day)))))
  WHERE (((bk.title)::text !~~* 'burn%'::text) AND ((bk.title)::text !~~* 'test%'::text));


ALTER TABLE public.byte_inventory_history_eod_2wks OWNER TO erpuser;

--
-- Name: bytecodelog; Type: TABLE; Schema: public; Owner: erpuser
--

CREATE TABLE public.bytecodelog (
    email text NOT NULL,
    bytecode character(6) NOT NULL,
    created_at bigint NOT NULL,
    duration integer NOT NULL,
    expires_at bigint NOT NULL
);


ALTER TABLE public.bytecodelog OWNER TO erpuser;

--
-- Name: history_order_pipeline; Type: TABLE; Schema: public; Owner: erpuser
--

CREATE TABLE public.history_order_pipeline (
    id integer NOT NULL,
    order_id character varying(45),
    action character varying(45),
    system character varying(45),
    "user" character varying(45),
    data text,
    ts timestamp(6) with time zone
);


ALTER TABLE public.history_order_pipeline OWNER TO erpuser;

--
-- Name: history_order_pipeline_id_seq; Type: SEQUENCE; Schema: public; Owner: erpuser
--

CREATE SEQUENCE public.history_order_pipeline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_order_pipeline_id_seq OWNER TO erpuser;

--
-- Name: history_order_pipeline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erpuser
--

ALTER SEQUENCE public.history_order_pipeline_id_seq OWNED BY public.history_order_pipeline.id;


--
-- Name: kiosk_status; Type: VIEW; Schema: public; Owner: erpuser
--

CREATE VIEW public.kiosk_status AS
 SELECT tmp.id,
    tmp.kiosk_id,
    tmp.kiosk_temperature,
    tmp.kiosk_temperature_count,
    tmp.kit_temperature,
    tmp.temperature_tags,
    tmp.kiosk_temperature_source,
    tmp.power,
    tmp.battery_level,
    tmp.rfid_0,
    tmp.rfid_1,
    tmp.rfid_2,
    tmp.rfid_3,
    tmp.rfid_4,
    tmp.rfid_5,
    tmp.rfid_6,
    tmp.rfid_7,
    tmp."time",
    tmp.modem_signal_percentage,
    tmp.modem_signal_type,
    tmp.ip,
    tmp.app_uptime,
    tmp.system_uptime,
    tmp.is_locked,
    tmp.campus_id,
    tmp.ts_10min,
    tmp.title,
    tmp.ts_utc,
    tmp.ts,
    date_trunc('day'::text, tmp.ts_10min) AS date
   FROM ( SELECT ks.id,
            ks.kiosk_id,
            ks.kiosk_temperature,
            ks.kiosk_temperature_count,
            ks.kit_temperature,
            ks.temperature_tags,
            ks.kiosk_temperature_source,
            ks.power,
            ks.battery_level,
            ks.rfid_0,
            ks.rfid_1,
            ks.rfid_2,
            ks.rfid_3,
            ks.rfid_4,
            ks.rfid_5,
            ks.rfid_6,
            ks.rfid_7,
            ks."time",
            ks.modem_signal_percentage,
            ks.modem_signal_type,
            ks.ip,
            ks.app_uptime,
            ks.system_uptime,
            ks.is_locked,
            k.campus_id,
            to_timestamp((ks."time")::double precision) AS ts_10min,
            k.title,
            to_timestamp((ks."time")::double precision) AS ts_utc,
            to_timestamp((ks."time")::double precision) AS ts
           FROM (pantry.kiosk_status ks
             JOIN pantry.kiosk k ON ((ks.kiosk_id = k.id)))) tmp;


ALTER TABLE public.kiosk_status OWNER TO erpuser;

--
-- Name: product_fact; Type: TABLE; Schema: public; Owner: erpuser
--

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


ALTER TABLE public.product_fact OWNER TO erpuser;

--
-- Name: product_fact_id_seq; Type: SEQUENCE; Schema: public; Owner: erpuser
--

CREATE SEQUENCE public.product_fact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_fact_id_seq OWNER TO erpuser;

--
-- Name: product_fact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erpuser
--

ALTER SEQUENCE public.product_fact_id_seq OWNED BY public.product_fact.id;


--
-- Name: fact_daily_campus_87; Type: TABLE; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.fact_daily_campus_87 OWNER TO erpuser;

--
-- Name: fact_daily_kiosk_sku_summary; Type: TABLE; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.fact_daily_kiosk_sku_summary OWNER TO erpuser;

--
-- Name: fact_monthly_kiosk_summary; Type: TABLE; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.fact_monthly_kiosk_summary OWNER TO erpuser;

--
-- Name: kiosk_20190528; Type: TABLE; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.kiosk_20190528 OWNER TO erpuser;

--
-- Name: kiosk_log; Type: TABLE; Schema: test; Owner: erpuser
--

CREATE TABLE test.kiosk_log (
    id integer NOT NULL,
    update_count integer DEFAULT 0,
    ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE test.kiosk_log OWNER TO erpuser;

--
-- Name: pick_priority_kiosk; Type: TABLE; Schema: test; Owner: erpuser
--

CREATE TABLE test.pick_priority_kiosk (
    kiosk_id integer,
    priority integer,
    start_date date,
    end_date date,
    comment text
);


ALTER TABLE test.pick_priority_kiosk OWNER TO erpuser;

--
-- Name: remittance_history; Type: TABLE; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.remittance_history OWNER TO erpuser;

--
-- Name: sync_qa_kiosk_before_2way; Type: VIEW; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.sync_qa_kiosk_before_2way OWNER TO erpuser;

--
-- Name: sync_qa_kiosk_erp; Type: VIEW; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.sync_qa_kiosk_erp OWNER TO erpuser;

--
-- Name: sync_qa_kiosk_iotmaster; Type: VIEW; Schema: test; Owner: erpuser
--

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


ALTER TABLE test.sync_qa_kiosk_iotmaster OWNER TO erpuser;

--
-- Name: deps_saved_ddl; Type: TABLE; Schema: util; Owner: erpuser
--

CREATE TABLE util.deps_saved_ddl (
    deps_id integer NOT NULL,
    deps_view_schema character varying(255),
    deps_view_name character varying(255),
    deps_ddl_to_run text
);


ALTER TABLE util.deps_saved_ddl OWNER TO erpuser;

--
-- Name: TABLE deps_saved_ddl; Type: COMMENT; Schema: util; Owner: erpuser
--

COMMENT ON TABLE util.deps_saved_ddl IS 'part of save/drop/restore dependent views suite: table to store DDL of dependent views';


--
-- Name: deps_saved_ddl_deps_id_seq; Type: SEQUENCE; Schema: util; Owner: erpuser
--

CREATE SEQUENCE util.deps_saved_ddl_deps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE util.deps_saved_ddl_deps_id_seq OWNER TO erpuser;

--
-- Name: deps_saved_ddl_deps_id_seq; Type: SEQUENCE OWNED BY; Schema: util; Owner: erpuser
--

ALTER SEQUENCE util.deps_saved_ddl_deps_id_seq OWNED BY util.deps_saved_ddl.deps_id;


--
-- Name: fcm_repeater id; Type: DEFAULT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.fcm_repeater ALTER COLUMN id SET DEFAULT nextval('erp.fcm_repeater_id_seq'::regclass);


--
-- Name: product_property_def id; Type: DEFAULT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.product_property_def ALTER COLUMN id SET DEFAULT nextval('inm.product_property_def_id_seq'::regclass);


--
-- Name: card_product_fact id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.card_product_fact ALTER COLUMN id SET DEFAULT nextval('mixalot.card_product_fact_id_seq'::regclass);


--
-- Name: history_order_pipeline id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.history_order_pipeline ALTER COLUMN id SET DEFAULT nextval('mixalot.history_order_pipeline_id_seq'::regclass);


--
-- Name: inm_data id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.inm_data ALTER COLUMN id SET DEFAULT nextval('mixalot.inm_data_id_seq'::regclass);


--
-- Name: kiosk_contents id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.kiosk_contents ALTER COLUMN id SET DEFAULT nextval('mixalot.kiosk_contents_id_seq'::regclass);


--
-- Name: kiosk_fact id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.kiosk_fact ALTER COLUMN id SET DEFAULT nextval('mixalot.kiosk_fact_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.log ALTER COLUMN id SET DEFAULT nextval('mixalot.log_id_seq'::regclass);


--
-- Name: order_fact id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.order_fact ALTER COLUMN id SET DEFAULT nextval('mixalot.order_fact_id_seq'::regclass);


--
-- Name: product_fact id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.product_fact ALTER COLUMN id SET DEFAULT nextval('mixalot.product_fact_id_seq'::regclass);


--
-- Name: sku_group id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_group ALTER COLUMN id SET DEFAULT nextval('mixalot.sku_group_id_seq'::regclass);


--
-- Name: sku_group_def id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_group_def ALTER COLUMN id SET DEFAULT nextval('mixalot.sku_group_def_id_seq'::regclass);


--
-- Name: sku_group_member id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_group_member ALTER COLUMN id SET DEFAULT nextval('mixalot.sku_group_member_id_seq'::regclass);


--
-- Name: sku_property_def id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_property_def ALTER COLUMN id SET DEFAULT nextval('mixalot.sku_property_def_id_seq'::regclass);


--
-- Name: tmp_discount_applied id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.tmp_discount_applied ALTER COLUMN id SET DEFAULT nextval('mixalot.tmp_discount_applied_id_seq'::regclass);


--
-- Name: tmp_kiosk_status id; Type: DEFAULT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.tmp_kiosk_status ALTER COLUMN id SET DEFAULT nextval('mixalot.tmp_kiosk_status_id_seq'::regclass);


--
-- Name: email id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.email ALTER COLUMN id SET DEFAULT nextval('pantry.email_id_seq'::regclass);


--
-- Name: empty_transaction id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.empty_transaction ALTER COLUMN id SET DEFAULT nextval('pantry.empty_transaction_id_seq'::regclass);


--
-- Name: history_epc_order id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.history_epc_order ALTER COLUMN id SET DEFAULT nextval('pantry.history_epc_order_id_seq'::regclass);


--
-- Name: inventory_request id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.inventory_request ALTER COLUMN id SET DEFAULT nextval('pantry.inventory_request_id_seq'::regclass);


--
-- Name: kiosk_catalog_downloads id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk_catalog_downloads ALTER COLUMN id SET DEFAULT nextval('pantry.kiosk_catalog_downloads_id_seq'::regclass);


--
-- Name: kiosk_components_history id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk_components_history ALTER COLUMN id SET DEFAULT nextval('pantry.kiosk_components_history_id_seq'::regclass);


--
-- Name: label_order id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.label_order ALTER COLUMN id SET DEFAULT nextval('pantry.label_order_id_seq'::regclass);


--
-- Name: pick_list_row id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.pick_list_row ALTER COLUMN id SET DEFAULT nextval('pantry.pick_list_row_id_seq'::regclass);


--
-- Name: temperature_tag_history id; Type: DEFAULT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.temperature_tag_history ALTER COLUMN id SET DEFAULT nextval('pantry.temperature_tag_history_id_seq'::regclass);


--
-- Name: awsdms_ddl_audit c_key; Type: DEFAULT; Schema: public; Owner: erpuser
--

ALTER TABLE ONLY public.awsdms_ddl_audit ALTER COLUMN c_key SET DEFAULT nextval('public.awsdms_ddl_audit_c_key_seq'::regclass);


--
-- Name: history_order_pipeline id; Type: DEFAULT; Schema: public; Owner: erpuser
--

ALTER TABLE ONLY public.history_order_pipeline ALTER COLUMN id SET DEFAULT nextval('public.history_order_pipeline_id_seq'::regclass);


--
-- Name: product_fact id; Type: DEFAULT; Schema: public; Owner: erpuser
--

ALTER TABLE ONLY public.product_fact ALTER COLUMN id SET DEFAULT nextval('public.product_fact_id_seq'::regclass);


--
-- Name: deps_saved_ddl deps_id; Type: DEFAULT; Schema: util; Owner: erpuser
--

ALTER TABLE ONLY util.deps_saved_ddl ALTER COLUMN deps_id SET DEFAULT nextval('util.deps_saved_ddl_deps_id_seq'::regclass);


--
-- Name: dim_campus dim_campus_pkey; Type: CONSTRAINT; Schema: dw; Owner: muriel
--

ALTER TABLE ONLY dw.dim_campus
    ADD CONSTRAINT dim_campus_pkey PRIMARY KEY (id);


--
-- Name: dim_date dim_date_pkey; Type: CONSTRAINT; Schema: dw; Owner: muriel
--

ALTER TABLE ONLY dw.dim_date
    ADD CONSTRAINT dim_date_pkey PRIMARY KEY (date_id);


--
-- Name: dim_kiosk dim_kiosk_pkey; Type: CONSTRAINT; Schema: dw; Owner: muriel
--

ALTER TABLE ONLY dw.dim_kiosk
    ADD CONSTRAINT dim_kiosk_pkey PRIMARY KEY (id);


--
-- Name: dim_product dim_product_pkey; Type: CONSTRAINT; Schema: dw; Owner: muriel
--

ALTER TABLE ONLY dw.dim_product
    ADD CONSTRAINT dim_product_pkey PRIMARY KEY (id);


--
-- Name: fact_daily_byte_foods_summary fact_daily_byte_foods_summary_pkey; Type: CONSTRAINT; Schema: dw; Owner: erpuser
--

ALTER TABLE ONLY dw.fact_daily_byte_foods_summary
    ADD CONSTRAINT fact_daily_byte_foods_summary_pkey PRIMARY KEY (date_id);


--
-- Name: fact_daily_kiosk_sku_summary fact_daily_kiosk_sku_summary_pkey; Type: CONSTRAINT; Schema: dw; Owner: muriel
--

ALTER TABLE ONLY dw.fact_daily_kiosk_sku_summary
    ADD CONSTRAINT fact_daily_kiosk_sku_summary_pkey PRIMARY KEY (campus_id, product_id, kiosk_id, date_id);


--
-- Name: fact_monthly_byte_foods_summary fact_monthly_byte_foods_summary_pkey; Type: CONSTRAINT; Schema: dw; Owner: erpuser
--

ALTER TABLE ONLY dw.fact_monthly_byte_foods_summary
    ADD CONSTRAINT fact_monthly_byte_foods_summary_pkey PRIMARY KEY (year_month);


--
-- Name: fact_monthly_kiosk_summary fact_monthly_kiosk_sku_summary_pkey; Type: CONSTRAINT; Schema: dw; Owner: erpuser
--

ALTER TABLE ONLY dw.fact_monthly_kiosk_summary
    ADD CONSTRAINT fact_monthly_kiosk_sku_summary_pkey PRIMARY KEY (campus_id, kiosk_id, date_id);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: classic_product_allergen_tag classic_product_allergen_tag_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.classic_product_allergen_tag
    ADD CONSTRAINT classic_product_allergen_tag_pkey PRIMARY KEY (product_id, tag_id);


--
-- Name: classic_product_category_tag classic_product_category_tag_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.classic_product_category_tag
    ADD CONSTRAINT classic_product_category_tag_pkey PRIMARY KEY (product_id, tag_id);


--
-- Name: client_campus client_campus_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.client_campus
    ADD CONSTRAINT client_campus_pkey PRIMARY KEY (client_id, campus_id);


--
-- Name: client_contact client_contact_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.client_contact
    ADD CONSTRAINT client_contact_pkey PRIMARY KEY (contact_id);


--
-- Name: client_industry client_industry_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.client_industry
    ADD CONSTRAINT client_industry_pkey PRIMARY KEY (client_name);


--
-- Name: client client_name_key; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.client
    ADD CONSTRAINT client_name_key UNIQUE (name);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: fcm_repeater fcm_repeater_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.fcm_repeater
    ADD CONSTRAINT fcm_repeater_pkey PRIMARY KEY (id);


--
-- Name: global_attribute_def global_attribute_def_name_value_key; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.global_attribute_def
    ADD CONSTRAINT global_attribute_def_name_value_key UNIQUE (name, value);


--
-- Name: global_attribute_def global_attribute_def_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.global_attribute_def
    ADD CONSTRAINT global_attribute_def_pkey PRIMARY KEY (id);


--
-- Name: hardware_software hardware_software_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.hardware_software
    ADD CONSTRAINT hardware_software_pkey PRIMARY KEY (kiosk_id);


--
-- Name: kiosk_access_card kiosk_access_card_card_id_client_id_key; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_access_card
    ADD CONSTRAINT kiosk_access_card_card_id_client_id_key UNIQUE (card_id, client_id);


--
-- Name: kiosk_access_card kiosk_access_card_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_access_card
    ADD CONSTRAINT kiosk_access_card_pkey PRIMARY KEY (id);


--
-- Name: kiosk_accounting kiosk_accounting_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_accounting
    ADD CONSTRAINT kiosk_accounting_pkey PRIMARY KEY (kiosk_id);


--
-- Name: kiosk_attribute kiosk_attribute_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_attribute
    ADD CONSTRAINT kiosk_attribute_pkey PRIMARY KEY (kiosk_id, attribute_id);


--
-- Name: kiosk_contact kiosk_contact_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_contact
    ADD CONSTRAINT kiosk_contact_pkey PRIMARY KEY (contact_id, kiosk_id);


--
-- Name: kiosk_note kiosk_note_kiosk_id_note_type_key; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_note
    ADD CONSTRAINT kiosk_note_kiosk_id_note_type_key UNIQUE (kiosk_id, note_type);


--
-- Name: kiosk_note kiosk_note_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_note
    ADD CONSTRAINT kiosk_note_pkey PRIMARY KEY (id);


--
-- Name: kiosk kiosk_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk
    ADD CONSTRAINT kiosk_pkey PRIMARY KEY (id);


--
-- Name: kiosk_restriction_by_product kiosk_restriction_by_product_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_restriction_by_product
    ADD CONSTRAINT kiosk_restriction_by_product_pkey PRIMARY KEY (kiosk_id, product_id);


--
-- Name: kiosk_restriction_by_property kiosk_restriction_by_property_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_restriction_by_property
    ADD CONSTRAINT kiosk_restriction_by_property_pkey PRIMARY KEY (kiosk_id, property_id);


--
-- Name: kiosk_status kiosk_status_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.kiosk_status
    ADD CONSTRAINT kiosk_status_pkey PRIMARY KEY (kiosk_id);


--
-- Name: product_asset product_asset_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_asset
    ADD CONSTRAINT product_asset_pkey PRIMARY KEY (product_id);


--
-- Name: product_category_def product_category_def_name_value_key; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_category_def
    ADD CONSTRAINT product_category_def_name_value_key UNIQUE (name, value);


--
-- Name: product_category_def product_category_def_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_category_def
    ADD CONSTRAINT product_category_def_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (product_id, category_id);


--
-- Name: product_handling product_handling_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_handling
    ADD CONSTRAINT product_handling_pkey PRIMARY KEY (product_id);


--
-- Name: product_nutrition product_nutrition_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_nutrition
    ADD CONSTRAINT product_nutrition_pkey PRIMARY KEY (product_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_pricing product_pricing_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_pricing
    ADD CONSTRAINT product_pricing_pkey PRIMARY KEY (product_id);


--
-- Name: product_property_def product_property_def_name_value_key; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_property_def
    ADD CONSTRAINT product_property_def_name_value_key UNIQUE (name, value);


--
-- Name: product_property_def product_property_def_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_property_def
    ADD CONSTRAINT product_property_def_pkey PRIMARY KEY (id);


--
-- Name: product_property product_property_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_property
    ADD CONSTRAINT product_property_pkey PRIMARY KEY (product_id, property_id);


--
-- Name: product_property_tag product_property_tag_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_property_tag
    ADD CONSTRAINT product_property_tag_pkey PRIMARY KEY (property_id, tag_id);


--
-- Name: product_sourcing product_sourcing_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.product_sourcing
    ADD CONSTRAINT product_sourcing_pkey PRIMARY KEY (product_id);


--
-- Name: sku_group sku_group_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.sku_group
    ADD CONSTRAINT sku_group_pkey PRIMARY KEY (id);


--
-- Name: tag_order tag_order_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.tag_order
    ADD CONSTRAINT tag_order_pkey PRIMARY KEY (id);


--
-- Name: tag_order_stats tag_order_stats_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.tag_order_stats
    ADD CONSTRAINT tag_order_stats_pkey PRIMARY KEY (product_id);


--
-- Name: tag_price tag_price_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.tag_price
    ADD CONSTRAINT tag_price_pkey PRIMARY KEY (campus_id, tag_type);


--
-- Name: tag_type tag_type_pkey; Type: CONSTRAINT; Schema: erp; Owner: erpuser
--

ALTER TABLE ONLY erp.tag_type
    ADD CONSTRAINT tag_type_pkey PRIMARY KEY (id);


--
-- Name: address address_address1_address2_city_state_zip_key; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.address
    ADD CONSTRAINT address_address1_address2_city_state_zip_key UNIQUE (address1, address2, city, state, zip);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: client client_name_key; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.client
    ADD CONSTRAINT client_name_key UNIQUE (name);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: contact contact_client_id_contact_type_key; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.contact
    ADD CONSTRAINT contact_client_id_contact_type_key UNIQUE (client_id, contact_type);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: hardware_software hardware_software_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.hardware_software
    ADD CONSTRAINT hardware_software_pkey PRIMARY KEY (kiosk_id);


--
-- Name: kiosk_accounting kiosk_accounting_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.kiosk_accounting
    ADD CONSTRAINT kiosk_accounting_pkey PRIMARY KEY (kiosk_id);


--
-- Name: kiosk_note kiosk_note_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.kiosk_note
    ADD CONSTRAINT kiosk_note_pkey PRIMARY KEY (id);


--
-- Name: product_property_def product_property_def_name_value_key; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.product_property_def
    ADD CONSTRAINT product_property_def_name_value_key UNIQUE (name, value);


--
-- Name: product_property_def product_property_def_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.product_property_def
    ADD CONSTRAINT product_property_def_pkey PRIMARY KEY (id);


--
-- Name: product_property product_property_pkey; Type: CONSTRAINT; Schema: erp_backup; Owner: erpuser
--

ALTER TABLE ONLY erp_backup.product_property
    ADD CONSTRAINT product_property_pkey PRIMARY KEY (product_id, property_id);


--
-- Name: address address_address1_key; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.address
    ADD CONSTRAINT address_address1_key UNIQUE (address1);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: client_campus client_campus_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.client_campus
    ADD CONSTRAINT client_campus_pkey PRIMARY KEY (client_id, campus_id);


--
-- Name: client_contact client_contact_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.client_contact
    ADD CONSTRAINT client_contact_pkey PRIMARY KEY (contact_id);


--
-- Name: client client_name_key; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.client
    ADD CONSTRAINT client_name_key UNIQUE (name);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: global_attribute_def global_attribute_def_name_value_key; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.global_attribute_def
    ADD CONSTRAINT global_attribute_def_name_value_key UNIQUE (name, value);


--
-- Name: global_attribute_def global_attribute_def_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.global_attribute_def
    ADD CONSTRAINT global_attribute_def_pkey PRIMARY KEY (id);


--
-- Name: hardware_software hardware_software_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.hardware_software
    ADD CONSTRAINT hardware_software_pkey PRIMARY KEY (kiosk_id);


--
-- Name: kiosk_accounting kiosk_accounting_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.kiosk_accounting
    ADD CONSTRAINT kiosk_accounting_pkey PRIMARY KEY (kiosk_id);


--
-- Name: kiosk_audit kiosk_audit_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.kiosk_audit
    ADD CONSTRAINT kiosk_audit_pkey PRIMARY KEY (kid);


--
-- Name: kiosk_contact kiosk_contact_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.kiosk_contact
    ADD CONSTRAINT kiosk_contact_pkey PRIMARY KEY (contact_id, kiosk_id);


--
-- Name: kiosk_note kiosk_note_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.kiosk_note
    ADD CONSTRAINT kiosk_note_pkey PRIMARY KEY (id);


--
-- Name: kiosk_status kiosk_status_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.kiosk_status
    ADD CONSTRAINT kiosk_status_pkey PRIMARY KEY (kiosk_id);


--
-- Name: product_asset product_asset_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.product_asset
    ADD CONSTRAINT product_asset_pkey PRIMARY KEY (product_id);


--
-- Name: product_handling product_handling_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.product_handling
    ADD CONSTRAINT product_handling_pkey PRIMARY KEY (product_id);


--
-- Name: product_nutrition product_nutrition_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.product_nutrition
    ADD CONSTRAINT product_nutrition_pkey PRIMARY KEY (product_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_pricing product_pricing_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.product_pricing
    ADD CONSTRAINT product_pricing_pkey PRIMARY KEY (product_id);


--
-- Name: product_property product_property_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.product_property
    ADD CONSTRAINT product_property_pkey PRIMARY KEY (product_id, property_id);


--
-- Name: product_sourcing product_sourcing_pkey; Type: CONSTRAINT; Schema: erp_test; Owner: erpuser
--

ALTER TABLE ONLY erp_test.product_sourcing
    ADD CONSTRAINT product_sourcing_pkey PRIMARY KEY (product_id);


--
-- Name: configuration configuration_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.configuration
    ADD CONSTRAINT configuration_pkey PRIMARY KEY (setting);


--
-- Name: kiosk_control kiosk_control_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.kiosk_control
    ADD CONSTRAINT kiosk_control_pkey PRIMARY KEY (kiosk_id);


--
-- Name: kiosk_restriction_by_product_ed kiosk_restriction_by_product_ed_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.kiosk_restriction_by_product_ed
    ADD CONSTRAINT kiosk_restriction_by_product_ed_pkey PRIMARY KEY (kiosk_id, product_id);


--
-- Name: kiosk_restriction_by_product kiosk_restriction_by_product_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.kiosk_restriction_by_product
    ADD CONSTRAINT kiosk_restriction_by_product_pkey PRIMARY KEY (kiosk_id, product_id);


--
-- Name: kiosk_restriction_by_property kiosk_restriction_by_property_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.kiosk_restriction_by_property
    ADD CONSTRAINT kiosk_restriction_by_property_pkey PRIMARY KEY (kiosk_id, property_id);


--
-- Name: kiosk_sku_group_manual_scale kiosk_sku_group_manual_scale_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.kiosk_sku_group_manual_scale
    ADD CONSTRAINT kiosk_sku_group_manual_scale_pkey PRIMARY KEY (kiosk_id, sku_group_id);


--
-- Name: pick_allocation pick_allocation_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_allocation
    ADD CONSTRAINT pick_allocation_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, sku_id);


--
-- Name: pick_demand pick_demand_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_demand
    ADD CONSTRAINT pick_demand_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, sku_group_id);


--
-- Name: pick_inventory pick_inventory_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_inventory
    ADD CONSTRAINT pick_inventory_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, sku_group_id);


--
-- Name: pick_list pick_list_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_list
    ADD CONSTRAINT pick_list_pkey PRIMARY KEY (pick_date);


--
-- Name: pick_preference_kiosk_sku pick_preference_kiosk_product_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_preference_kiosk_sku
    ADD CONSTRAINT pick_preference_kiosk_product_pkey PRIMARY KEY (kiosk_id, sku_id);


--
-- Name: pick_priority_kiosk pick_priority_kiosk_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_priority_kiosk
    ADD CONSTRAINT pick_priority_kiosk_pkey PRIMARY KEY (kiosk_id);


--
-- Name: pick_priority_sku pick_priority_sku_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_priority_sku
    ADD CONSTRAINT pick_priority_sku_pkey PRIMARY KEY (sku_id);


--
-- Name: pick_rejection pick_rejection_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_rejection
    ADD CONSTRAINT pick_rejection_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, item_id, item_type, reason);


--
-- Name: pick_route pick_route_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_route
    ADD CONSTRAINT pick_route_pkey PRIMARY KEY (pick_date, kiosk_id, route_date);


--
-- Name: pick_substitution pick_substitution_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.pick_substitution
    ADD CONSTRAINT pick_substitution_pkey PRIMARY KEY (substituting_sku_group_id, substituted_sku_group_id, pick_date);


--
-- Name: product_pick_order product_pick_order_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.product_pick_order
    ADD CONSTRAINT product_pick_order_pkey PRIMARY KEY (product_id);


--
-- Name: product_pick_order_temp product_pick_order_temp_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.product_pick_order_temp
    ADD CONSTRAINT product_pick_order_temp_pkey PRIMARY KEY (product_id);


--
-- Name: product_property_def product_property_def_name_value_key; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.product_property_def
    ADD CONSTRAINT product_property_def_name_value_key UNIQUE (name, value);


--
-- Name: product_property_def product_property_def_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.product_property_def
    ADD CONSTRAINT product_property_def_pkey PRIMARY KEY (id);


--
-- Name: product_property product_property_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.product_property
    ADD CONSTRAINT product_property_pkey PRIMARY KEY (product_id, property_id);


--
-- Name: route_stop route_stop_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.route_stop
    ADD CONSTRAINT route_stop_pkey PRIMARY KEY (route_date_time, driver_name, location_name, schedule_at);


--
-- Name: sku_group_attribute sku_group_attribute_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.sku_group_attribute
    ADD CONSTRAINT sku_group_attribute_pkey PRIMARY KEY (id);


--
-- Name: sku_group_attribute sku_group_attribute_title_key; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.sku_group_attribute
    ADD CONSTRAINT sku_group_attribute_title_key UNIQUE (title);


--
-- Name: sku_group_control sku_group_control_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.sku_group_control
    ADD CONSTRAINT sku_group_control_pkey PRIMARY KEY (sku_group_id);


--
-- Name: warehouse_inventory warehouse_inventory_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.warehouse_inventory
    ADD CONSTRAINT warehouse_inventory_pkey PRIMARY KEY (inventory_date, product_id);


--
-- Name: warehouse_order_history warehouse_order_history_pkey; Type: CONSTRAINT; Schema: inm; Owner: erpuser
--

ALTER TABLE ONLY inm.warehouse_order_history
    ADD CONSTRAINT warehouse_order_history_pkey PRIMARY KEY (sku, order_date, delivery_date, qty);


--
-- Name: even_id even_id_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.even_id
    ADD CONSTRAINT even_id_pkey PRIMARY KEY (id);


--
-- Name: kiosk_par_level kiosk_par_level_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.kiosk_par_level
    ADD CONSTRAINT kiosk_par_level_pkey PRIMARY KEY (kiosk_id, product_id);


--
-- Name: label label_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.label
    ADD CONSTRAINT label_pkey PRIMARY KEY (id);


--
-- Name: odd_id odd_id_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.odd_id
    ADD CONSTRAINT odd_id_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);


--
-- Name: pick_allocation pick_allocation_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.pick_allocation
    ADD CONSTRAINT pick_allocation_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, sku_id);


--
-- Name: pick_demand pick_demand_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.pick_demand
    ADD CONSTRAINT pick_demand_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, sku_group_id);


--
-- Name: pick_inventory pick_inventory_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.pick_inventory
    ADD CONSTRAINT pick_inventory_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, sku_group_id);


--
-- Name: pick_rejection pick_rejection_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.pick_rejection
    ADD CONSTRAINT pick_rejection_pkey PRIMARY KEY (pick_date, route_date, kiosk_id, item_id, item_type, reason);


--
-- Name: pick_route pick_route_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.pick_route
    ADD CONSTRAINT pick_route_pkey PRIMARY KEY (pick_date, kiosk_id, route_date);


--
-- Name: pick_substitution pick_substitution_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.pick_substitution
    ADD CONSTRAINT pick_substitution_pkey PRIMARY KEY (substituting_sku_group_id, substituted_sku_group_id, pick_date);


--
-- Name: temp_a temp_a_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.temp_a
    ADD CONSTRAINT temp_a_pkey PRIMARY KEY (id);


--
-- Name: temp_b temp_b_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.temp_b
    ADD CONSTRAINT temp_b_pkey PRIMARY KEY (id);


--
-- Name: temp_kiosk temp_kiosk_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.temp_kiosk
    ADD CONSTRAINT temp_kiosk_pkey PRIMARY KEY (id);


--
-- Name: temp_test temp_test_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.temp_test
    ADD CONSTRAINT temp_test_pkey PRIMARY KEY (id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: test_sequence test_sequence_pkey; Type: CONSTRAINT; Schema: inm_test; Owner: erpuser
--

ALTER TABLE ONLY inm_test.test_sequence
    ADD CONSTRAINT test_sequence_pkey PRIMARY KEY (id);


--
-- Name: kiosk kiosk_pkey; Type: CONSTRAINT; Schema: migration; Owner: erpuser
--

ALTER TABLE ONLY migration.kiosk
    ADD CONSTRAINT kiosk_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: migration; Owner: erpuser
--

ALTER TABLE ONLY migration.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: reverse_product reverse_product_pkey; Type: CONSTRAINT; Schema: migration; Owner: erpuser
--

ALTER TABLE ONLY migration.reverse_product
    ADD CONSTRAINT reverse_product_pkey PRIMARY KEY (id);


--
-- Name: temp_product temp_product_pkey; Type: CONSTRAINT; Schema: migration; Owner: erpuser
--

ALTER TABLE ONLY migration.temp_product
    ADD CONSTRAINT temp_product_pkey PRIMARY KEY (id);


--
-- Name: card_product_fact card_product_fact_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.card_product_fact
    ADD CONSTRAINT card_product_fact_pkey PRIMARY KEY (id);


--
-- Name: gsheet_cache gsheet_cache_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.gsheet_cache
    ADD CONSTRAINT gsheet_cache_pkey PRIMARY KEY (id);


--
-- Name: history_order_pipeline history_order_pipeline_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.history_order_pipeline
    ADD CONSTRAINT history_order_pipeline_pkey PRIMARY KEY (id);


--
-- Name: inm_data inm_data_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.inm_data
    ADD CONSTRAINT inm_data_pkey PRIMARY KEY (id);


--
-- Name: kiosk_contents kiosk_contents_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.kiosk_contents
    ADD CONSTRAINT kiosk_contents_pkey PRIMARY KEY (id);


--
-- Name: kiosk_fact kiosk_fact_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.kiosk_fact
    ADD CONSTRAINT kiosk_fact_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: merchandising_slot_sku_group merchandising_slot_sku_group_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.merchandising_slot_sku_group
    ADD CONSTRAINT merchandising_slot_sku_group_pkey PRIMARY KEY (sku_group_id);


--
-- Name: order_fact order_fact_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.order_fact
    ADD CONSTRAINT order_fact_pkey PRIMARY KEY (id);


--
-- Name: pick_preference_kiosk_sku pick_preference_kiosk_sku_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.pick_preference_kiosk_sku
    ADD CONSTRAINT pick_preference_kiosk_sku_pkey PRIMARY KEY (kiosk_id, sku_id);


--
-- Name: pick_priority_kiosk pick_priority_kiosk_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.pick_priority_kiosk
    ADD CONSTRAINT pick_priority_kiosk_pkey PRIMARY KEY (kiosk_id);


--
-- Name: product_fact product_fact_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.product_fact
    ADD CONSTRAINT product_fact_pkey PRIMARY KEY (id);


--
-- Name: request_log request_log_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.request_log
    ADD CONSTRAINT request_log_pkey PRIMARY KEY (request_uuid);


--
-- Name: route route_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_date_time, driver_name);


--
-- Name: route_stop route_stop_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.route_stop
    ADD CONSTRAINT route_stop_pkey PRIMARY KEY (route_date_time, driver_name, location_name, schedule_at);


--
-- Name: sku_group_def sku_group_def_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_group_def
    ADD CONSTRAINT sku_group_def_pkey PRIMARY KEY (id);


--
-- Name: sku_group_member sku_group_member_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_group_member
    ADD CONSTRAINT sku_group_member_pkey PRIMARY KEY (id);


--
-- Name: sku_group sku_group_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_group
    ADD CONSTRAINT sku_group_pkey PRIMARY KEY (id);


--
-- Name: sku_property_def sku_property_def_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_property_def
    ADD CONSTRAINT sku_property_def_pkey PRIMARY KEY (id);


--
-- Name: sku_property sku_property_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.sku_property
    ADD CONSTRAINT sku_property_pkey PRIMARY KEY (sku_id, property_id);


--
-- Name: tmp_discount_applied tmp_discount_applied_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.tmp_discount_applied
    ADD CONSTRAINT tmp_discount_applied_pkey PRIMARY KEY (id);


--
-- Name: tmp_kiosk_status tmp_kiosk_status_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.tmp_kiosk_status
    ADD CONSTRAINT tmp_kiosk_status_pkey PRIMARY KEY (id);


--
-- Name: tmp_transact tmp_transact_pkey; Type: CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.tmp_transact
    ADD CONSTRAINT tmp_transact_pkey PRIMARY KEY (order_id);


--
-- Name: accounting accounting_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.accounting
    ADD CONSTRAINT accounting_pkey PRIMARY KEY (id);


--
-- Name: bad_timestamp bad_timestamp_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.bad_timestamp
    ADD CONSTRAINT bad_timestamp_pkey PRIMARY KEY (id);


--
-- Name: campus_assets campus_assets_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.campus_assets
    ADD CONSTRAINT campus_assets_pkey PRIMARY KEY (campus_id);


--
-- Name: campus campus_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.campus
    ADD CONSTRAINT campus_pkey PRIMARY KEY (id);


--
-- Name: card card_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.card
    ADD CONSTRAINT card_pkey PRIMARY KEY (id);


--
-- Name: coupon coupon_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.coupon
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (id);


--
-- Name: discount_applied discount_applied_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.discount_applied
    ADD CONSTRAINT discount_applied_pkey PRIMARY KEY (id);


--
-- Name: discount_history discount_history_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.discount_history
    ADD CONSTRAINT discount_history_pkey PRIMARY KEY (id);


--
-- Name: discount discount_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (id);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: empty_transaction empty_transaction_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.empty_transaction
    ADD CONSTRAINT empty_transaction_pkey PRIMARY KEY (id);


--
-- Name: fee_rates fee_rates_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.fee_rates
    ADD CONSTRAINT fee_rates_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: group_campus group_campus_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.group_campus
    ADD CONSTRAINT group_campus_pkey PRIMARY KEY (group_id, campus_id);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: history_epc_order history_epc_order_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.history_epc_order
    ADD CONSTRAINT history_epc_order_pkey PRIMARY KEY (id);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);


--
-- Name: inventory_history inventory_history_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.inventory_history
    ADD CONSTRAINT inventory_history_pkey PRIMARY KEY (id);


--
-- Name: inventory_request inventory_request_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.inventory_request
    ADD CONSTRAINT inventory_request_pkey PRIMARY KEY (id);


--
-- Name: kiosk_audit_log kiosk_audit_log_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk_audit_log
    ADD CONSTRAINT kiosk_audit_log_pkey PRIMARY KEY (id);


--
-- Name: kiosk_catalog_downloads kiosk_catalog_downloads_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk_catalog_downloads
    ADD CONSTRAINT kiosk_catalog_downloads_pkey PRIMARY KEY (id);


--
-- Name: kiosk_components_history kiosk_components_history_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk_components_history
    ADD CONSTRAINT kiosk_components_history_pkey PRIMARY KEY (id);


--
-- Name: kiosk_par_level kiosk_par_level_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk_par_level
    ADD CONSTRAINT kiosk_par_level_pkey PRIMARY KEY (kiosk_id, product_id);


--
-- Name: kiosk kiosk_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk
    ADD CONSTRAINT kiosk_pkey PRIMARY KEY (id);


--
-- Name: kiosk_status kiosk_status_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosk_status
    ADD CONSTRAINT kiosk_status_pkey PRIMARY KEY (id);


--
-- Name: discount kiosk_type_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.discount
    ADD CONSTRAINT kiosk_type_pkey UNIQUE (kiosk_id, type);


--
-- Name: kiosks_date_non_new kiosks_date_non_new_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.kiosks_date_non_new
    ADD CONSTRAINT kiosks_date_non_new_pkey PRIMARY KEY (id);


--
-- Name: label_order label_order_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.label_order
    ADD CONSTRAINT label_order_pkey PRIMARY KEY (id);


--
-- Name: label label_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.label
    ADD CONSTRAINT label_pkey PRIMARY KEY (id);


--
-- Name: last_kiosk_status last_kiosk_status_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.last_kiosk_status
    ADD CONSTRAINT last_kiosk_status_pkey PRIMARY KEY (id);


--
-- Name: manual_adjustment manual_adjustment_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.manual_adjustment
    ADD CONSTRAINT manual_adjustment_pkey PRIMARY KEY (id);


--
-- Name: nutrition_filter nutrition_filter_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.nutrition_filter
    ADD CONSTRAINT nutrition_filter_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);


--
-- Name: payment_order payment_order_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.payment_order
    ADD CONSTRAINT payment_order_pkey PRIMARY KEY (id);


--
-- Name: pick_list_row pick_list_row_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.pick_list_row
    ADD CONSTRAINT pick_list_row_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: product_history product_history_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.product_history
    ADD CONSTRAINT product_history_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: recent_transactions recent_transactions_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.recent_transactions
    ADD CONSTRAINT recent_transactions_pkey PRIMARY KEY (kiosk_id);


--
-- Name: ro_order ro_order_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.ro_order
    ADD CONSTRAINT ro_order_pkey PRIMARY KEY (order_id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: temp_kiosk temp_kiosk_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.temp_kiosk
    ADD CONSTRAINT temp_kiosk_pkey PRIMARY KEY (id);


--
-- Name: temp_product temp_product_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.temp_product
    ADD CONSTRAINT temp_product_pkey PRIMARY KEY (id);


--
-- Name: temperature_tag_history temperature_tag_history_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry.temperature_tag_history
    ADD CONSTRAINT temperature_tag_history_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: pantry; Owner: erpuser
--

ALTER TABLE ONLY pantry."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: awsdms_ddl_audit awsdms_ddl_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: erpuser
--

ALTER TABLE ONLY public.awsdms_ddl_audit
    ADD CONSTRAINT awsdms_ddl_audit_pkey PRIMARY KEY (c_key);


--
-- Name: bytecodelog bytecodelog_pkey; Type: CONSTRAINT; Schema: public; Owner: erpuser
--

ALTER TABLE ONLY public.bytecodelog
    ADD CONSTRAINT bytecodelog_pkey PRIMARY KEY (email, bytecode);


--
-- Name: history_order_pipeline history_order_pipeline_pkey; Type: CONSTRAINT; Schema: public; Owner: erpuser
--

ALTER TABLE ONLY public.history_order_pipeline
    ADD CONSTRAINT history_order_pipeline_pkey PRIMARY KEY (id);


--
-- Name: product_fact product_fact_pkey; Type: CONSTRAINT; Schema: public; Owner: erpuser
--

ALTER TABLE ONLY public.product_fact
    ADD CONSTRAINT product_fact_pkey PRIMARY KEY (id);


--
-- Name: fact_daily_kiosk_sku_summary fact_daily_kiosk_sku_summary_pkey; Type: CONSTRAINT; Schema: test; Owner: erpuser
--

ALTER TABLE ONLY test.fact_daily_kiosk_sku_summary
    ADD CONSTRAINT fact_daily_kiosk_sku_summary_pkey PRIMARY KEY (campus_id, product_id, kiosk_id, date_id);


--
-- Name: fact_monthly_kiosk_summary fact_monthly_kiosk_summary_pkey; Type: CONSTRAINT; Schema: test; Owner: erpuser
--

ALTER TABLE ONLY test.fact_monthly_kiosk_summary
    ADD CONSTRAINT fact_monthly_kiosk_summary_pkey PRIMARY KEY (campus_id, kiosk_id, date_id);


--
-- Name: kiosk_log kiosk_log_pkey; Type: CONSTRAINT; Schema: test; Owner: erpuser
--

ALTER TABLE ONLY test.kiosk_log
    ADD CONSTRAINT kiosk_log_pkey PRIMARY KEY (id);


--
-- Name: remittance_history remittance_history_pkey; Type: CONSTRAINT; Schema: test; Owner: erpuser
--

ALTER TABLE ONLY test.remittance_history
    ADD CONSTRAINT remittance_history_pkey PRIMARY KEY (campus_id, period, version);


--
-- Name: deps_saved_ddl deps_saved_ddl_pkey; Type: CONSTRAINT; Schema: util; Owner: erpuser
--

ALTER TABLE ONLY util.deps_saved_ddl
    ADD CONSTRAINT deps_saved_ddl_pkey PRIMARY KEY (deps_id);


--
-- Name: dw_fact_daily_kiosk_sku_summary_date_id; Type: INDEX; Schema: dw; Owner: muriel
--

CREATE INDEX dw_fact_daily_kiosk_sku_summary_date_id ON dw.fact_daily_kiosk_sku_summary USING btree (date_id);


--
-- Name: dw_fact_daily_kiosk_sku_summary_product_id; Type: INDEX; Schema: dw; Owner: muriel
--

CREATE INDEX dw_fact_daily_kiosk_sku_summary_product_id ON dw.fact_daily_kiosk_sku_summary USING btree (product_id);


--
-- Name: client_contact_client_id_idx; Type: INDEX; Schema: erp; Owner: erpuser
--

CREATE INDEX client_contact_client_id_idx ON erp.client_contact USING btree (client_id);


--
-- Name: client_id_contact_type; Type: INDEX; Schema: erp; Owner: erpuser
--

CREATE UNIQUE INDEX client_id_contact_type ON erp.contact USING btree (client_id, contact_type);


--
-- Name: tag_type_type_key; Type: INDEX; Schema: erp; Owner: erpuser
--

CREATE UNIQUE INDEX tag_type_type_key ON erp.tag_type USING btree (type);


--
-- Name: client_id_contact_type; Type: INDEX; Schema: erp_test; Owner: erpuser
--

CREATE UNIQUE INDEX client_id_contact_type ON erp_test.contact USING btree (client_id, contact_type);


--
-- Name: byte_created_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_created_idx ON pantry."order" USING btree (created);


--
-- Name: byte_label_added_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_label_added_idx ON pantry.label USING btree (to_timestamp((time_added)::double precision), product_id);


--
-- Name: byte_label_epc_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_label_epc_idx ON pantry.label USING btree (epc);


--
-- Name: byte_label_kiosk_id_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_label_kiosk_id_idx ON pantry.label USING btree (kiosk_id);


--
-- Name: byte_label_order_id_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_label_order_id_idx ON pantry.label USING btree (order_id);


--
-- Name: byte_label_order_status_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_label_order_status_idx ON pantry.label USING btree (order_id, status);


--
-- Name: byte_label_ts_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_label_ts_idx ON pantry.label USING btree (to_timestamp((COALESCE(time_updated, time_created, time_added))::double precision));


--
-- Name: byte_raw_orders_ts_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_raw_orders_ts_idx ON pantry."order" USING btree (to_timestamp((created)::double precision)) WHERE (campus_id = 87);


--
-- Name: byte_tickets_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_tickets_idx ON pantry."order" USING btree (to_timestamp((created)::double precision)) WHERE ((campus_id = 87) AND ((state)::text = ANY (ARRAY[('Processed'::character varying)::text, ('Refunded'::character varying)::text])));


--
-- Name: byte_time_created_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX byte_time_created_idx ON pantry.label USING btree (time_created);


--
-- Name: history_epc; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX history_epc ON pantry.history USING btree (epc);


--
-- Name: history_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX history_idx ON pantry.history USING btree (to_timestamp(("time")::double precision));


--
-- Name: history_kiosk_id; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX history_kiosk_id ON pantry.history USING btree (kiosk_id);


--
-- Name: history_order_id; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX history_order_id ON pantry.history USING btree (order_id);


--
-- Name: history_time; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX history_time ON pantry.history USING btree ("time");


--
-- Name: idx_pantry_product_consumer_category; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX idx_pantry_product_consumer_category ON pantry.product USING btree (consumer_category);


--
-- Name: inventory_history_kiosk_id_time_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX inventory_history_kiosk_id_time_idx ON pantry.inventory_history USING btree (kiosk_id, "time");


--
-- Name: kiosk_status_kiosk_id_time_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX kiosk_status_kiosk_id_time_idx ON pantry.kiosk_status USING btree (kiosk_id, "time");


--
-- Name: pantry_coupon_code_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX pantry_coupon_code_idx ON pantry.coupon USING btree (code);


--
-- Name: pantry_order_coupon_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX pantry_order_coupon_idx ON pantry."order" USING btree (coupon);


--
-- Name: pantry_order_kiosk_id; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX pantry_order_kiosk_id ON pantry."order" USING btree (kiosk_id);


--
-- Name: pantry_order_kiosk_id_ts; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX pantry_order_kiosk_id_ts ON pantry."order" USING btree (kiosk_id, created) WHERE ((campus_id = 87) AND ((order_id)::text !~~ 'RE%'::text));


--
-- Name: ro_order_customer_full_name_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX ro_order_customer_full_name_idx ON pantry.ro_order USING btree (customer_full_name);


--
-- Name: ro_order_to_timestamp_campus_id_idx; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX ro_order_to_timestamp_campus_id_idx ON pantry.ro_order USING btree (to_timestamp((created)::double precision), campus_id);


--
-- Name: to_timestamp_created_state_status; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX to_timestamp_created_state_status ON pantry."order" USING btree (to_timestamp((created)::double precision), state, status);


--
-- Name: to_timestamp_time; Type: INDEX; Schema: pantry; Owner: erpuser
--

CREATE INDEX to_timestamp_time ON pantry.kiosk_status USING btree (to_timestamp(("time")::double precision));


--
-- Name: fact_daily_kiosk_sku_summary_date_id_idx; Type: INDEX; Schema: test; Owner: erpuser
--

CREATE INDEX fact_daily_kiosk_sku_summary_date_id_idx ON test.fact_daily_kiosk_sku_summary USING btree (date_id);


--
-- Name: fact_daily_kiosk_sku_summary_product_id_idx; Type: INDEX; Schema: test; Owner: erpuser
--

CREATE INDEX fact_daily_kiosk_sku_summary_product_id_idx ON test.fact_daily_kiosk_sku_summary USING btree (product_id);


--
-- Name: campus sync_campus; Type: TRIGGER; Schema: pantry; Owner: erpuser
--

CREATE TRIGGER sync_campus BEFORE INSERT OR DELETE OR UPDATE ON pantry.campus FOR EACH ROW EXECUTE PROCEDURE pantry.sync_campus();


--
-- Name: kiosk sync_kiosk; Type: TRIGGER; Schema: pantry; Owner: erpuser
--

CREATE TRIGGER sync_kiosk BEFORE INSERT OR DELETE OR UPDATE ON pantry.kiosk FOR EACH ROW EXECUTE PROCEDURE erp.sync_kiosk();


--
-- Name: label_order sync_label_order; Type: TRIGGER; Schema: pantry; Owner: erpuser
--

CREATE TRIGGER sync_label_order BEFORE INSERT OR DELETE OR UPDATE ON pantry.label_order FOR EACH ROW EXECUTE PROCEDURE pantry.sync_label_order();


--
-- Name: product sync_product; Type: TRIGGER; Schema: pantry; Owner: erpuser
--

CREATE TRIGGER sync_product BEFORE INSERT OR DELETE OR UPDATE ON pantry.product FOR EACH ROW EXECUTE PROCEDURE erp.sync_product();


--
-- Name: log log_order_id_fkey; Type: FK CONSTRAINT; Schema: mixalot; Owner: erpuser
--

ALTER TABLE ONLY mixalot.log
    ADD CONSTRAINT log_order_id_fkey FOREIGN KEY (order_id) REFERENCES mixalot.tmp_transact(order_id);


--
-- Name: SCHEMA campus_87; Type: ACL; Schema: -; Owner: erpuser
--

GRANT USAGE ON SCHEMA campus_87 TO rc87;


--
-- Name: SCHEMA dw; Type: ACL; Schema: -; Owner: muriel
--

GRANT ALL ON SCHEMA dw TO lambdazen;
GRANT ALL ON SCHEMA dw TO yann;
GRANT ALL ON SCHEMA dw TO readonly;
GRANT USAGE ON SCHEMA dw TO dbservice;
GRANT ALL ON SCHEMA dw TO bytedevs;
GRANT ALL ON SCHEMA dw TO tableauuser;


--
-- Name: SCHEMA erp; Type: ACL; Schema: -; Owner: erpuser
--

GRANT ALL ON SCHEMA erp TO muriel;
GRANT ALL ON SCHEMA erp TO lambdazen;
GRANT ALL ON SCHEMA erp TO yann;
GRANT USAGE ON SCHEMA erp TO report;
GRANT USAGE ON SCHEMA erp TO readonly;
GRANT USAGE ON SCHEMA erp TO dbservice;


--
-- Name: SCHEMA inm; Type: ACL; Schema: -; Owner: erpuser
--

GRANT ALL ON SCHEMA inm TO lambdazen;
GRANT ALL ON SCHEMA inm TO muriel;
GRANT ALL ON SCHEMA inm TO yann;
GRANT USAGE ON SCHEMA inm TO readonly;
GRANT USAGE ON SCHEMA inm TO dbservice;
GRANT ALL ON SCHEMA inm TO tableauuser;
GRANT ALL ON SCHEMA inm TO bartender;
GRANT ALL ON SCHEMA inm TO bytedevs;


--
-- Name: SCHEMA mixalot; Type: ACL; Schema: -; Owner: erpuser
--

GRANT USAGE ON SCHEMA mixalot TO yann;
GRANT USAGE ON SCHEMA mixalot TO readonly;
GRANT ALL ON SCHEMA mixalot TO muriel;
GRANT ALL ON SCHEMA mixalot TO lambdazen;
GRANT ALL ON SCHEMA mixalot TO tableauuser;
GRANT ALL ON SCHEMA mixalot TO bartender;
GRANT ALL ON SCHEMA mixalot TO bytedevs;


--
-- Name: SCHEMA pantry; Type: ACL; Schema: -; Owner: erpuser
--

GRANT ALL ON SCHEMA pantry TO muriel;
GRANT ALL ON SCHEMA pantry TO lambdazen;
GRANT ALL ON SCHEMA pantry TO yann;
GRANT USAGE ON SCHEMA pantry TO readonly;
GRANT USAGE ON SCHEMA pantry TO dbservice;
GRANT USAGE ON SCHEMA pantry TO jungvu;
GRANT ALL ON SCHEMA pantry TO tableauuser;
GRANT ALL ON SCHEMA pantry TO bartender;
GRANT ALL ON SCHEMA pantry TO bytedevs;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: erpuser
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO erpuser;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO yann;
GRANT ALL ON SCHEMA public TO tableauuser;
GRANT ALL ON SCHEMA public TO bartender;
GRANT ALL ON SCHEMA public TO bytedevs;


--
-- Name: SCHEMA test; Type: ACL; Schema: -; Owner: erpuser
--

GRANT ALL ON SCHEMA test TO lambdazen;
GRANT ALL ON SCHEMA test TO bartender;
GRANT ALL ON SCHEMA test TO bytedevs;


--
-- Name: SCHEMA type; Type: ACL; Schema: -; Owner: erpuser
--

GRANT ALL ON SCHEMA type TO muriel;
GRANT ALL ON SCHEMA type TO lambdazen;
GRANT ALL ON SCHEMA type TO yann;
GRANT USAGE ON SCHEMA type TO report;
GRANT ALL ON SCHEMA type TO bartender;
GRANT ALL ON SCHEMA type TO bytedevs;


--
-- Name: FUNCTION byte_losses(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.byte_losses(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.byte_losses(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.byte_losses(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.byte_losses(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION byte_restocks(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.byte_restocks(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.byte_restocks(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.byte_restocks(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.byte_restocks(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION byte_sales(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.byte_sales(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.byte_sales(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.byte_sales(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.byte_sales(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION byte_spoils(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.byte_spoils(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.byte_spoils(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.byte_spoils(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.byte_spoils(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION calculate_prorated_fee(fee numeric, month_date date, deployment_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) TO yann;
GRANT ALL ON FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.calculate_prorated_fee(fee numeric, month_date date, deployment_date date) TO tableauuser;


--
-- Name: FUNCTION clear_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.clear_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION clear_fact_monthly_kiosk_summary(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.clear_fact_monthly_kiosk_summary(month_date date) TO tableauuser;


--
-- Name: FUNCTION export_consolidated_remittance(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_consolidated_remittance(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_consolidated_remittance(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_consolidated_remittance(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_consolidated_remittance(month_date date) TO tableauuser;


--
-- Name: FUNCTION export_feedback(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_feedback(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_feedback(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_feedback(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_feedback(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION export_kiosk_performance(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_kiosk_performance(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION export_kiosk_status(kiosk_number bigint); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_kiosk_status(kiosk_number bigint) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_kiosk_status(kiosk_number bigint) TO yann;
GRANT ALL ON FUNCTION dw.export_kiosk_status(kiosk_number bigint) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_kiosk_status(kiosk_number bigint) TO tableauuser;


--
-- Name: FUNCTION export_licensee_fee(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_licensee_fee(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_licensee_fee(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_licensee_fee(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_licensee_fee(month_date date) TO tableauuser;


--
-- Name: FUNCTION export_losses(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_losses(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_losses(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_losses(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_losses(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION export_remittance(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_remittance(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_remittance(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_remittance(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_remittance(month_date date) TO tableauuser;


--
-- Name: FUNCTION export_spoilage(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_spoilage(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_spoilage(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_spoilage(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_spoilage(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) TO yann;
GRANT ALL ON FUNCTION dw.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) TO tableauuser;


--
-- Name: FUNCTION export_unconsolidated_remittance(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.export_unconsolidated_remittance(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.export_unconsolidated_remittance(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.export_unconsolidated_remittance(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.export_unconsolidated_remittance(month_date date) TO tableauuser;


--
-- Name: FUNCTION insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_hb_stat_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION insert_in_monthly_kiosk_summary(month_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.insert_in_monthly_kiosk_summary(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_in_monthly_kiosk_summary(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_in_monthly_kiosk_summary(month_date date) TO tableauuser;


--
-- Name: FUNCTION insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_inv_snapshot_in_daily_byte_foods_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_losses_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_sales_daily_byte_foods_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_sales_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION insert_sales_monthly_byte_foods_summary(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.insert_sales_monthly_byte_foods_summary(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.insert_sales_monthly_byte_foods_summary(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_sales_monthly_byte_foods_summary(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_sales_monthly_byte_foods_summary(month_date date) TO tableauuser;


--
-- Name: FUNCTION insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_spoils_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.insert_stock_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION losses(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.losses(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.losses(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.losses(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.losses(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION non_byte_losses(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.non_byte_losses(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION non_byte_restocks(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.non_byte_restocks(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.non_byte_restocks(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.non_byte_restocks(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.non_byte_restocks(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION non_byte_sales(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.non_byte_sales(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION non_byte_spoils(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.non_byte_spoils(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION refresh_daily_byte_foods_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.refresh_daily_byte_foods_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.refresh_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION refresh_dim_kiosk(); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.refresh_dim_kiosk() TO yann;
GRANT ALL ON FUNCTION dw.refresh_dim_kiosk() TO dbservice;
GRANT ALL ON FUNCTION dw.refresh_dim_kiosk() TO bytedevs;
GRANT ALL ON FUNCTION dw.refresh_dim_kiosk() TO tableauuser;


--
-- Name: FUNCTION refresh_dim_product(); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.refresh_dim_product() TO yann;
GRANT ALL ON FUNCTION dw.refresh_dim_product() TO dbservice;
GRANT ALL ON FUNCTION dw.refresh_dim_product() TO bytedevs;
GRANT ALL ON FUNCTION dw.refresh_dim_product() TO tableauuser;


--
-- Name: FUNCTION refresh_monthly_byte_foods_summary(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.refresh_monthly_byte_foods_summary(month_date date) TO tableauuser;


--
-- Name: FUNCTION refresh_monthly_kiosk_summary(month_date date); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) TO lambdazen;
GRANT ALL ON FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) TO yann;
GRANT ALL ON FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.refresh_monthly_kiosk_summary(month_date date) TO tableauuser;


--
-- Name: FUNCTION restocks(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.restocks(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.restocks(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.restocks(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.restocks(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION sales(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.sales(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.sales(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.sales(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.sales(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION spoils(beginning_date date, ending_date date); Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON FUNCTION dw.spoils(beginning_date date, ending_date date) TO yann;
GRANT ALL ON FUNCTION dw.spoils(beginning_date date, ending_date date) TO dbservice;
GRANT ALL ON FUNCTION dw.spoils(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION dw.spoils(beginning_date date, ending_date date) TO tableauuser;


--
-- Name: FUNCTION stockout(beginning_date date, ending_date date, kiosk_number bigint); Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) TO lambdazen;
GRANT ALL ON FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) TO yann;
GRANT ALL ON FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) TO bytedevs;
GRANT ALL ON FUNCTION dw.stockout(beginning_date date, ending_date date, kiosk_number bigint) TO tableauuser;


--
-- Name: FUNCTION parse_address(address_str text); Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON FUNCTION erp.parse_address(address_str text) TO muriel;
GRANT ALL ON FUNCTION erp.parse_address(address_str text) TO yann;
GRANT ALL ON FUNCTION erp.parse_address(address_str text) TO dbservice;


--
-- Name: FUNCTION parse_phone(text_to_parse text); Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON FUNCTION erp.parse_phone(text_to_parse text) TO muriel;
GRANT ALL ON FUNCTION erp.parse_phone(text_to_parse text) TO yann;
GRANT ALL ON FUNCTION erp.parse_phone(text_to_parse text) TO dbservice;


--
-- Name: FUNCTION reverse_sync_kiosk(); Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON FUNCTION erp.reverse_sync_kiosk() TO muriel;
GRANT ALL ON FUNCTION erp.reverse_sync_kiosk() TO yann;


--
-- Name: FUNCTION sync_kiosk(); Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON FUNCTION erp.sync_kiosk() TO muriel;
GRANT ALL ON FUNCTION erp.sync_kiosk() TO yann;


--
-- Name: FUNCTION sync_kiosk_reference(); Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON FUNCTION erp.sync_kiosk_reference() TO muriel;
GRANT ALL ON FUNCTION erp.sync_kiosk_reference() TO yann;


--
-- Name: FUNCTION sync_kiosk_tables(); Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON FUNCTION erp.sync_kiosk_tables() TO muriel;
GRANT ALL ON FUNCTION erp.sync_kiosk_tables() TO yann;
GRANT ALL ON FUNCTION erp.sync_kiosk_tables() TO dbservice;


--
-- Name: FUNCTION sync_product(); Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON FUNCTION erp.sync_product() TO muriel;
GRANT ALL ON FUNCTION erp.sync_product() TO yann;


--
-- Name: FUNCTION f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) TO lambdazen;
GRANT ALL ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.f_kiosk_sku_group_sku_pick_stats(pick_time timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.get_pull_date(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION get_spoilage_pull_list(); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.get_spoilage_pull_list() TO muriel;
GRANT ALL ON FUNCTION inm.get_spoilage_pull_list() TO yann;
GRANT ALL ON FUNCTION inm.get_spoilage_pull_list() TO dbservice;
GRANT ALL ON FUNCTION inm.get_spoilage_pull_list() TO tableauuser;
GRANT ALL ON FUNCTION inm.get_spoilage_pull_list() TO bartender;
GRANT ALL ON FUNCTION inm.get_spoilage_pull_list() TO bytedevs;


--
-- Name: FUNCTION pick_check_duplicate_stop(); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_check_duplicate_stop() TO lambdazen;
GRANT ALL ON FUNCTION inm.pick_check_duplicate_stop() TO muriel;
GRANT ALL ON FUNCTION inm.pick_check_duplicate_stop() TO yann;
GRANT ALL ON FUNCTION inm.pick_check_duplicate_stop() TO dbservice;
GRANT ALL ON FUNCTION inm.pick_check_duplicate_stop() TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_check_duplicate_stop() TO bartender;
GRANT ALL ON FUNCTION inm.pick_check_duplicate_stop() TO bytedevs;


--
-- Name: FUNCTION pick_check_restriction(_pick_date date); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_check_restriction(_pick_date date) TO muriel;
GRANT ALL ON FUNCTION inm.pick_check_restriction(_pick_date date) TO yann;
GRANT ALL ON FUNCTION inm.pick_check_restriction(_pick_date date) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_check_restriction(_pick_date date) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_check_restriction(_pick_date date) TO bartender;
GRANT ALL ON FUNCTION inm.pick_check_restriction(_pick_date date) TO bytedevs;


--
-- Name: FUNCTION pick_get_delivery_schedule(pick_date date); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_delivery_schedule(pick_date date) TO lambdazen;
GRANT ALL ON FUNCTION inm.pick_get_delivery_schedule(pick_date date) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_delivery_schedule(pick_date date) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_delivery_schedule(pick_date date) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_delivery_schedule(pick_date date) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_delivery_schedule(pick_date date) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_delivery_schedule(pick_date date) TO bytedevs;


--
-- Name: FUNCTION pick_get_demand_weekly_by_velocity(); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_by_velocity() TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_by_velocity() TO yann;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_by_velocity() TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_by_velocity() TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_by_velocity() TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_by_velocity() TO bytedevs;


--
-- Name: FUNCTION pick_get_demand_weekly_wo_min(); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_wo_min() TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_wo_min() TO yann;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_wo_min() TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_wo_min() TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_wo_min() TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_demand_weekly_wo_min() TO bytedevs;


--
-- Name: FUNCTION pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_order(start_ts timestamp with time zone, end_ts timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_order_with_velocity(start_ts timestamp with time zone, end_ts timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION pick_get_plan_kiosk(pick_date date); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(pick_date date) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(pick_date date) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(pick_date date) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(pick_date date) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(pick_date date) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(pick_date date) TO bytedevs;


--
-- Name: FUNCTION pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION pick_get_plan_kiosk_disabled_product(pick_date date); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) TO lambdazen;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_disabled_product(pick_date date) TO bytedevs;


--
-- Name: FUNCTION pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_optimo(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO lambdazen;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_plan_kiosk_projected_stock(plan_window_start timestamp with time zone, plan_window_stop timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) TO lambdazen;
GRANT ALL ON FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_sales_period_ratio(start_ts timestamp with time zone, end_ts timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION pick_get_summary(target_date date); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_summary(target_date date) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_summary(target_date date) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_summary(target_date date) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_summary(target_date date) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_summary(target_date date) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_summary(target_date date) TO bytedevs;


--
-- Name: FUNCTION pick_get_ticket(target_date date); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_get_ticket(target_date date) TO lambdazen;
GRANT ALL ON FUNCTION inm.pick_get_ticket(target_date date) TO muriel;
GRANT ALL ON FUNCTION inm.pick_get_ticket(target_date date) TO yann;
GRANT ALL ON FUNCTION inm.pick_get_ticket(target_date date) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_get_ticket(target_date date) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_get_ticket(target_date date) TO bartender;
GRANT ALL ON FUNCTION inm.pick_get_ticket(target_date date) TO bytedevs;


--
-- Name: FUNCTION pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text); Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON FUNCTION inm.pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text) TO muriel;
GRANT ALL ON FUNCTION inm.pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text) TO yann;
GRANT ALL ON FUNCTION inm.pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text) TO dbservice;
GRANT ALL ON FUNCTION inm.pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text) TO tableauuser;
GRANT ALL ON FUNCTION inm.pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text) TO bartender;
GRANT ALL ON FUNCTION inm.pick_submit(target_date date, overwrite integer, wait_time_seconds integer, OUT submit_status text) TO bytedevs;


--
-- Name: FUNCTION get_label_order_epc(); Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON FUNCTION pantry.get_label_order_epc() TO lambdazen;
GRANT ALL ON FUNCTION pantry.get_label_order_epc() TO muriel;
GRANT ALL ON FUNCTION pantry.get_label_order_epc() TO yann;
GRANT ALL ON FUNCTION pantry.get_label_order_epc() TO tableauuser;
GRANT ALL ON FUNCTION pantry.get_label_order_epc() TO bartender;
GRANT ALL ON FUNCTION pantry.get_label_order_epc() TO bytedevs;


--
-- Name: FUNCTION sync_campus(); Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON FUNCTION pantry.sync_campus() TO lambdazen;
GRANT ALL ON FUNCTION pantry.sync_campus() TO muriel;
GRANT ALL ON FUNCTION pantry.sync_campus() TO yann;
GRANT ALL ON FUNCTION pantry.sync_campus() TO tableauuser;
GRANT ALL ON FUNCTION pantry.sync_campus() TO bartender;
GRANT ALL ON FUNCTION pantry.sync_campus() TO bytedevs;


--
-- Name: FUNCTION sync_label_order(); Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON FUNCTION pantry.sync_label_order() TO muriel;
GRANT ALL ON FUNCTION pantry.sync_label_order() TO yann;
GRANT ALL ON FUNCTION pantry.sync_label_order() TO lambdazen;
GRANT ALL ON FUNCTION pantry.sync_label_order() TO tableauuser;
GRANT ALL ON FUNCTION pantry.sync_label_order() TO bartender;
GRANT ALL ON FUNCTION pantry.sync_label_order() TO bytedevs;


--
-- Name: FUNCTION awsdms_intercept_ddl(); Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON FUNCTION public.awsdms_intercept_ddl() TO tableauuser;
GRANT ALL ON FUNCTION public.awsdms_intercept_ddl() TO bartender;
GRANT ALL ON FUNCTION public.awsdms_intercept_ddl() TO bytedevs;


--
-- Name: FUNCTION dowhour(timestamp with time zone); Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON FUNCTION public.dowhour(timestamp with time zone) TO tableauuser;
GRANT ALL ON FUNCTION public.dowhour(timestamp with time zone) TO bartender;
GRANT ALL ON FUNCTION public.dowhour(timestamp with time zone) TO bytedevs;


--
-- Name: FUNCTION if(boolean, anyelement, anyelement); Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON FUNCTION public.if(boolean, anyelement, anyelement) TO tableauuser;
GRANT ALL ON FUNCTION public.if(boolean, anyelement, anyelement) TO bartender;
GRANT ALL ON FUNCTION public.if(boolean, anyelement, anyelement) TO bytedevs;


--
-- Name: FUNCTION make_odd_or_even_sequence(table_name text, sequence_field_name text, odd_or_even text); Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON FUNCTION public.make_odd_or_even_sequence(table_name text, sequence_field_name text, odd_or_even text) TO tableauuser;
GRANT ALL ON FUNCTION public.make_odd_or_even_sequence(table_name text, sequence_field_name text, odd_or_even text) TO bartender;
GRANT ALL ON FUNCTION public.make_odd_or_even_sequence(table_name text, sequence_field_name text, odd_or_even text) TO bytedevs;


--
-- Name: FUNCTION export_consolidated_remittance(month_date date); Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON FUNCTION test.export_consolidated_remittance(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION test.export_consolidated_remittance(month_date date) TO bartender;


--
-- Name: FUNCTION export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying); Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON FUNCTION test.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) TO bytedevs;
GRANT ALL ON FUNCTION test.export_transaction(beginning_date timestamp without time zone, ending_date timestamp without time zone, time_zone character varying) TO bartender;


--
-- Name: FUNCTION insert_in_monthly_kiosk_summary(month_date date); Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON FUNCTION test.insert_in_monthly_kiosk_summary(month_date date) TO bytedevs;
GRANT ALL ON FUNCTION test.insert_in_monthly_kiosk_summary(month_date date) TO bartender;


--
-- Name: FUNCTION insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date); Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON FUNCTION test.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION test.insert_sales_after_discount_in_daily_kiosk_sku_summary(beginning_date date, ending_date date) TO bartender;


--
-- Name: FUNCTION spoils(beginning_date date, ending_date date); Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON FUNCTION test.spoils(beginning_date date, ending_date date) TO bytedevs;
GRANT ALL ON FUNCTION test.spoils(beginning_date date, ending_date date) TO bartender;


--
-- Name: FUNCTION uptime_percentage(start_date date, end_date date); Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON FUNCTION test.uptime_percentage(start_date date, end_date date) TO bytedevs;
GRANT ALL ON FUNCTION test.uptime_percentage(start_date date, end_date date) TO bartender;


--
-- Name: FUNCTION uptime_ratio(start_date date, end_date date); Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON FUNCTION test.uptime_ratio(start_date date, end_date date) TO bytedevs;
GRANT ALL ON FUNCTION test.uptime_ratio(start_date date, end_date date) TO bartender;


--
-- Name: TABLE feedback; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.feedback TO muriel;
GRANT ALL ON TABLE pantry.feedback TO yann;
GRANT SELECT ON TABLE pantry.feedback TO readonly;
GRANT ALL ON TABLE pantry.feedback TO lambdazen;
GRANT ALL ON TABLE pantry.feedback TO dbservice;
GRANT ALL ON TABLE pantry.feedback TO jungvu;
GRANT ALL ON TABLE pantry.feedback TO tableauuser;
GRANT ALL ON TABLE pantry.feedback TO bartender;
GRANT ALL ON TABLE pantry.feedback TO bytedevs;


--
-- Name: TABLE kiosk; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.kiosk TO muriel;
GRANT ALL ON TABLE pantry.kiosk TO yann;
GRANT SELECT ON TABLE pantry.kiosk TO readonly;
GRANT ALL ON TABLE pantry.kiosk TO lambdazen;
GRANT ALL ON TABLE pantry.kiosk TO dbservice;
GRANT ALL ON TABLE pantry.kiosk TO jungvu;
GRANT ALL ON TABLE pantry.kiosk TO tableauuser;
GRANT ALL ON TABLE pantry.kiosk TO bartender;
GRANT ALL ON TABLE pantry.kiosk TO bytedevs;


--
-- Name: TABLE "order"; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry."order" TO muriel;
GRANT ALL ON TABLE pantry."order" TO yann;
GRANT SELECT ON TABLE pantry."order" TO readonly;
GRANT ALL ON TABLE pantry."order" TO lambdazen;
GRANT ALL ON TABLE pantry."order" TO dbservice;
GRANT ALL ON TABLE pantry."order" TO jungvu;
GRANT ALL ON TABLE pantry."order" TO tableauuser;
GRANT ALL ON TABLE pantry."order" TO bartender;
GRANT ALL ON TABLE pantry."order" TO bytedevs;


--
-- Name: TABLE all_raw_orders; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.all_raw_orders TO yann;
GRANT SELECT ON TABLE public.all_raw_orders TO readonly;
GRANT ALL ON TABLE public.all_raw_orders TO tableauuser;
GRANT ALL ON TABLE public.all_raw_orders TO bartender;
GRANT ALL ON TABLE public.all_raw_orders TO bytedevs;


--
-- Name: TABLE _all_orders; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public._all_orders TO yann;
GRANT SELECT ON TABLE public._all_orders TO readonly;
GRANT ALL ON TABLE public._all_orders TO tableauuser;
GRANT ALL ON TABLE public._all_orders TO bartender;
GRANT ALL ON TABLE public._all_orders TO bytedevs;


--
-- Name: TABLE all_orders; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.all_orders TO yann;
GRANT SELECT ON TABLE public.all_orders TO readonly;
GRANT ALL ON TABLE public.all_orders TO tableauuser;
GRANT ALL ON TABLE public.all_orders TO bartender;
GRANT ALL ON TABLE public.all_orders TO bytedevs;


--
-- Name: TABLE byte_orders; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_orders TO yann;
GRANT SELECT ON TABLE public.byte_orders TO readonly;
GRANT ALL ON TABLE public.byte_orders TO tableauuser;
GRANT ALL ON TABLE public.byte_orders TO bartender;
GRANT ALL ON TABLE public.byte_orders TO bytedevs;


--
-- Name: TABLE byte_tickets; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_tickets TO yann;
GRANT SELECT ON TABLE public.byte_tickets TO readonly;
GRANT ALL ON TABLE public.byte_tickets TO tableauuser;
GRANT ALL ON TABLE public.byte_tickets TO bartender;
GRANT ALL ON TABLE public.byte_tickets TO bytedevs;


--
-- Name: TABLE byte_feedback; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_feedback TO tableauuser;
GRANT ALL ON TABLE public.byte_feedback TO bartender;
GRANT ALL ON TABLE public.byte_feedback TO bytedevs;


--
-- Name: TABLE byte_feedback_monthly; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_feedback_monthly TO tableauuser;
GRANT ALL ON TABLE public.byte_feedback_monthly TO bartender;
GRANT ALL ON TABLE public.byte_feedback_monthly TO bytedevs;


--
-- Name: TABLE byte_feedback_monthly; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.byte_feedback_monthly TO rc87;


--
-- Name: TABLE campus; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.campus TO muriel;
GRANT ALL ON TABLE pantry.campus TO yann;
GRANT SELECT ON TABLE pantry.campus TO readonly;
GRANT ALL ON TABLE pantry.campus TO lambdazen;
GRANT ALL ON TABLE pantry.campus TO dbservice;
GRANT ALL ON TABLE pantry.campus TO jungvu;
GRANT ALL ON TABLE pantry.campus TO tableauuser;
GRANT ALL ON TABLE pantry.campus TO bartender;
GRANT ALL ON TABLE pantry.campus TO bytedevs;


--
-- Name: TABLE campus; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.campus TO rc87;


--
-- Name: TABLE dim_date; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.dim_date TO lambdazen;
GRANT ALL ON TABLE dw.dim_date TO yann;
GRANT SELECT ON TABLE dw.dim_date TO readonly;
GRANT ALL ON TABLE dw.dim_date TO dbservice;
GRANT ALL ON TABLE dw.dim_date TO bytedevs;
GRANT ALL ON TABLE dw.dim_date TO tableauuser;


--
-- Name: TABLE dim_date; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.dim_date TO rc87;


--
-- Name: TABLE fact_daily_kiosk_sku_summary; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.fact_daily_kiosk_sku_summary TO lambdazen;
GRANT ALL ON TABLE dw.fact_daily_kiosk_sku_summary TO yann;
GRANT SELECT ON TABLE dw.fact_daily_kiosk_sku_summary TO readonly;
GRANT ALL ON TABLE dw.fact_daily_kiosk_sku_summary TO dbservice;
GRANT ALL ON TABLE dw.fact_daily_kiosk_sku_summary TO bytedevs;
GRANT ALL ON TABLE dw.fact_daily_kiosk_sku_summary TO tableauuser;


--
-- Name: TABLE fact_daily_kiosk_sku_summary; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.fact_daily_kiosk_sku_summary TO rc87;


--
-- Name: TABLE kiosk; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.kiosk TO rc87;


--
-- Name: TABLE kiosk_control; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_control TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_control TO muriel;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE inm.kiosk_control TO yann;
GRANT SELECT ON TABLE inm.kiosk_control TO yann WITH GRANT OPTION;
SET SESSION AUTHORIZATION yann;
GRANT SELECT ON TABLE inm.kiosk_control TO readonly;
RESET SESSION AUTHORIZATION;
GRANT SELECT ON TABLE inm.kiosk_control TO readonly;
GRANT ALL ON TABLE inm.kiosk_control TO dbservice;
GRANT ALL ON TABLE inm.kiosk_control TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_control TO bartender;
GRANT ALL ON TABLE inm.kiosk_control TO bytedevs;


--
-- Name: TABLE kiosk_control; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.kiosk_control TO rc87;


--
-- Name: TABLE kiosk_restriction_by_product; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_restriction_by_product TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product TO muriel;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product TO yann;
GRANT SELECT ON TABLE inm.kiosk_restriction_by_product TO readonly;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product TO dbservice;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product TO bartender;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product TO bytedevs;


--
-- Name: TABLE kiosk_restriction_by_product; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.kiosk_restriction_by_product TO rc87;


--
-- Name: TABLE kiosk_restriction_by_product_ed; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_restriction_by_product_ed TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product_ed TO muriel;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product_ed TO yann;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product_ed TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product_ed TO bartender;
GRANT ALL ON TABLE inm.kiosk_restriction_by_product_ed TO bytedevs;


--
-- Name: TABLE kiosk_restriction_by_product_ed; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.kiosk_restriction_by_product_ed TO rc87;


--
-- Name: TABLE kiosk_restriction_by_property; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_restriction_by_property TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_restriction_by_property TO muriel;
GRANT ALL ON TABLE inm.kiosk_restriction_by_property TO yann;
GRANT SELECT ON TABLE inm.kiosk_restriction_by_property TO readonly;
GRANT ALL ON TABLE inm.kiosk_restriction_by_property TO dbservice;
GRANT ALL ON TABLE inm.kiosk_restriction_by_property TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_restriction_by_property TO bartender;
GRANT ALL ON TABLE inm.kiosk_restriction_by_property TO bytedevs;


--
-- Name: TABLE kiosk_restriction_by_property; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.kiosk_restriction_by_property TO rc87;


--
-- Name: TABLE kiosk_sku_group_manual_scale; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_sku_group_manual_scale TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_sku_group_manual_scale TO muriel;
GRANT ALL ON TABLE inm.kiosk_sku_group_manual_scale TO yann;
GRANT SELECT ON TABLE inm.kiosk_sku_group_manual_scale TO readonly;
GRANT ALL ON TABLE inm.kiosk_sku_group_manual_scale TO dbservice;
GRANT ALL ON TABLE inm.kiosk_sku_group_manual_scale TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_sku_group_manual_scale TO bartender;
GRANT ALL ON TABLE inm.kiosk_sku_group_manual_scale TO bytedevs;


--
-- Name: TABLE kiosk_sku_group_manual_scale; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.kiosk_sku_group_manual_scale TO rc87;


--
-- Name: TABLE label; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.label TO muriel;
GRANT ALL ON TABLE pantry.label TO yann;
GRANT SELECT ON TABLE pantry.label TO readonly;
GRANT ALL ON TABLE pantry.label TO lambdazen;
GRANT ALL ON TABLE pantry.label TO dbservice;
GRANT ALL ON TABLE pantry.label TO jungvu;
GRANT ALL ON TABLE pantry.label TO tableauuser;
GRANT ALL ON TABLE pantry.label TO bartender;
GRANT ALL ON TABLE pantry.label TO bytedevs;


--
-- Name: TABLE label; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.label TO rc87;


--
-- Name: TABLE "order"; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87."order" TO rc87;


--
-- Name: TABLE pick_allocation; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_allocation TO lambdazen;
GRANT ALL ON TABLE inm.pick_allocation TO muriel;
GRANT ALL ON TABLE inm.pick_allocation TO yann;
GRANT SELECT ON TABLE inm.pick_allocation TO readonly;
GRANT ALL ON TABLE inm.pick_allocation TO dbservice;
GRANT ALL ON TABLE inm.pick_allocation TO tableauuser;
GRANT ALL ON TABLE inm.pick_allocation TO bartender;
GRANT ALL ON TABLE inm.pick_allocation TO bytedevs;


--
-- Name: TABLE pick_allocation; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_allocation TO rc87;


--
-- Name: TABLE pick_demand; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_demand TO lambdazen;
GRANT ALL ON TABLE inm.pick_demand TO muriel;
GRANT ALL ON TABLE inm.pick_demand TO yann;
GRANT SELECT ON TABLE inm.pick_demand TO readonly;
GRANT ALL ON TABLE inm.pick_demand TO dbservice;
GRANT ALL ON TABLE inm.pick_demand TO tableauuser;
GRANT ALL ON TABLE inm.pick_demand TO bartender;
GRANT ALL ON TABLE inm.pick_demand TO bytedevs;


--
-- Name: TABLE pick_demand; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_demand TO rc87;


--
-- Name: TABLE pick_inventory; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_inventory TO lambdazen;
GRANT ALL ON TABLE inm.pick_inventory TO muriel;
GRANT ALL ON TABLE inm.pick_inventory TO yann;
GRANT SELECT ON TABLE inm.pick_inventory TO readonly;
GRANT ALL ON TABLE inm.pick_inventory TO dbservice;
GRANT ALL ON TABLE inm.pick_inventory TO tableauuser;
GRANT ALL ON TABLE inm.pick_inventory TO bartender;
GRANT ALL ON TABLE inm.pick_inventory TO bytedevs;


--
-- Name: TABLE pick_inventory; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_inventory TO rc87;


--
-- Name: TABLE pick_list; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_list TO lambdazen;
GRANT ALL ON TABLE inm.pick_list TO muriel;
GRANT ALL ON TABLE inm.pick_list TO yann;
GRANT SELECT ON TABLE inm.pick_list TO readonly;
GRANT ALL ON TABLE inm.pick_list TO dbservice;
GRANT ALL ON TABLE inm.pick_list TO tableauuser;
GRANT ALL ON TABLE inm.pick_list TO bartender;
GRANT ALL ON TABLE inm.pick_list TO bytedevs;


--
-- Name: TABLE pick_list; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_list TO rc87;


--
-- Name: TABLE pick_preference_kiosk_sku; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_preference_kiosk_sku TO lambdazen;
GRANT ALL ON TABLE inm.pick_preference_kiosk_sku TO muriel;
GRANT ALL ON TABLE inm.pick_preference_kiosk_sku TO yann;
GRANT SELECT ON TABLE inm.pick_preference_kiosk_sku TO readonly;
GRANT ALL ON TABLE inm.pick_preference_kiosk_sku TO dbservice;
GRANT ALL ON TABLE inm.pick_preference_kiosk_sku TO tableauuser;
GRANT ALL ON TABLE inm.pick_preference_kiosk_sku TO bartender;
GRANT ALL ON TABLE inm.pick_preference_kiosk_sku TO bytedevs;


--
-- Name: TABLE pick_preference_kiosk_sku; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_preference_kiosk_sku TO rc87;


--
-- Name: TABLE pick_priority_kiosk; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_priority_kiosk TO lambdazen;
GRANT ALL ON TABLE inm.pick_priority_kiosk TO muriel;
GRANT ALL ON TABLE inm.pick_priority_kiosk TO yann;
GRANT SELECT ON TABLE inm.pick_priority_kiosk TO readonly;
GRANT ALL ON TABLE inm.pick_priority_kiosk TO dbservice;
GRANT ALL ON TABLE inm.pick_priority_kiosk TO tableauuser;
GRANT ALL ON TABLE inm.pick_priority_kiosk TO bartender;
GRANT ALL ON TABLE inm.pick_priority_kiosk TO bytedevs;


--
-- Name: TABLE pick_priority_kiosk; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_priority_kiosk TO rc87;


--
-- Name: TABLE pick_priority_sku; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_priority_sku TO lambdazen;
GRANT ALL ON TABLE inm.pick_priority_sku TO muriel;
GRANT ALL ON TABLE inm.pick_priority_sku TO yann;
GRANT SELECT ON TABLE inm.pick_priority_sku TO readonly;
GRANT ALL ON TABLE inm.pick_priority_sku TO dbservice;
GRANT ALL ON TABLE inm.pick_priority_sku TO tableauuser;
GRANT ALL ON TABLE inm.pick_priority_sku TO bartender;
GRANT ALL ON TABLE inm.pick_priority_sku TO bytedevs;


--
-- Name: TABLE pick_priority_sku; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_priority_sku TO rc87;


--
-- Name: TABLE pick_rejection; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_rejection TO lambdazen;
GRANT ALL ON TABLE inm.pick_rejection TO muriel;
GRANT ALL ON TABLE inm.pick_rejection TO yann;
GRANT SELECT ON TABLE inm.pick_rejection TO readonly;
GRANT ALL ON TABLE inm.pick_rejection TO dbservice;
GRANT ALL ON TABLE inm.pick_rejection TO tableauuser;
GRANT ALL ON TABLE inm.pick_rejection TO bartender;
GRANT ALL ON TABLE inm.pick_rejection TO bytedevs;


--
-- Name: TABLE pick_rejection; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_rejection TO rc87;


--
-- Name: TABLE pick_route; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_route TO lambdazen;
GRANT ALL ON TABLE inm.pick_route TO muriel;
GRANT ALL ON TABLE inm.pick_route TO yann;
GRANT SELECT ON TABLE inm.pick_route TO readonly;
GRANT ALL ON TABLE inm.pick_route TO dbservice;
GRANT ALL ON TABLE inm.pick_route TO tableauuser;
GRANT ALL ON TABLE inm.pick_route TO bartender;
GRANT ALL ON TABLE inm.pick_route TO bytedevs;


--
-- Name: TABLE pick_route; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.pick_route TO rc87;


--
-- Name: TABLE product; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.product TO muriel;
GRANT ALL ON TABLE pantry.product TO yann;
GRANT SELECT ON TABLE pantry.product TO readonly;
GRANT ALL ON TABLE pantry.product TO lambdazen;
GRANT ALL ON TABLE pantry.product TO dbservice;
GRANT ALL ON TABLE pantry.product TO jungvu;
GRANT ALL ON TABLE pantry.product TO tableauuser;
GRANT ALL ON TABLE pantry.product TO bartender;
GRANT ALL ON TABLE pantry.product TO bytedevs;


--
-- Name: TABLE product; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.product TO rc87;


--
-- Name: TABLE product_property; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.product_property TO lambdazen;
GRANT ALL ON TABLE inm.product_property TO muriel;
GRANT ALL ON TABLE inm.product_property TO yann;
GRANT SELECT ON TABLE inm.product_property TO readonly;
GRANT ALL ON TABLE inm.product_property TO dbservice;
GRANT ALL ON TABLE inm.product_property TO tableauuser;
GRANT ALL ON TABLE inm.product_property TO bartender;
GRANT ALL ON TABLE inm.product_property TO bytedevs;


--
-- Name: TABLE product_property; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.product_property TO rc87;


--
-- Name: TABLE product_property_def; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.product_property_def TO lambdazen;
GRANT ALL ON TABLE inm.product_property_def TO muriel;
GRANT ALL ON TABLE inm.product_property_def TO yann;
GRANT SELECT ON TABLE inm.product_property_def TO readonly;
GRANT ALL ON TABLE inm.product_property_def TO dbservice;
GRANT ALL ON TABLE inm.product_property_def TO tableauuser;
GRANT ALL ON TABLE inm.product_property_def TO bartender;
GRANT ALL ON TABLE inm.product_property_def TO bytedevs;


--
-- Name: TABLE product_property_def; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.product_property_def TO rc87;


--
-- Name: TABLE route_stop; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.route_stop TO lambdazen;
GRANT ALL ON TABLE inm.route_stop TO muriel;
GRANT ALL ON TABLE inm.route_stop TO yann;
GRANT SELECT ON TABLE inm.route_stop TO readonly;
GRANT ALL ON TABLE inm.route_stop TO dbservice;
GRANT ALL ON TABLE inm.route_stop TO tableauuser;
GRANT ALL ON TABLE inm.route_stop TO bartender;
GRANT ALL ON TABLE inm.route_stop TO bytedevs;


--
-- Name: TABLE route_stop; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.route_stop TO rc87;


--
-- Name: TABLE sku_group_attribute; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.sku_group_attribute TO lambdazen;
GRANT ALL ON TABLE inm.sku_group_attribute TO muriel;
GRANT ALL ON TABLE inm.sku_group_attribute TO yann;
GRANT SELECT ON TABLE inm.sku_group_attribute TO readonly;
GRANT ALL ON TABLE inm.sku_group_attribute TO dbservice;
GRANT ALL ON TABLE inm.sku_group_attribute TO tableauuser;
GRANT ALL ON TABLE inm.sku_group_attribute TO bartender;
GRANT ALL ON TABLE inm.sku_group_attribute TO bytedevs;


--
-- Name: TABLE sku_group_attribute; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.sku_group_attribute TO rc87;


--
-- Name: TABLE sku_group_control; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.sku_group_control TO lambdazen;
GRANT ALL ON TABLE inm.sku_group_control TO muriel;
GRANT ALL ON TABLE inm.sku_group_control TO yann;
GRANT SELECT ON TABLE inm.sku_group_control TO readonly;
GRANT ALL ON TABLE inm.sku_group_control TO dbservice;
GRANT ALL ON TABLE inm.sku_group_control TO tableauuser;
GRANT ALL ON TABLE inm.sku_group_control TO bartender;
GRANT ALL ON TABLE inm.sku_group_control TO bytedevs;


--
-- Name: TABLE sku_group_control; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.sku_group_control TO rc87;


--
-- Name: TABLE warehouse_inventory; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.warehouse_inventory TO lambdazen;
GRANT ALL ON TABLE inm.warehouse_inventory TO muriel;
GRANT ALL ON TABLE inm.warehouse_inventory TO yann;
GRANT SELECT ON TABLE inm.warehouse_inventory TO readonly;
GRANT ALL ON TABLE inm.warehouse_inventory TO dbservice;
GRANT ALL ON TABLE inm.warehouse_inventory TO tableauuser;
GRANT ALL ON TABLE inm.warehouse_inventory TO bartender;
GRANT ALL ON TABLE inm.warehouse_inventory TO bytedevs;


--
-- Name: TABLE warehouse_inventory; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.warehouse_inventory TO rc87;


--
-- Name: TABLE warehouse_order_history; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.warehouse_order_history TO lambdazen;
GRANT ALL ON TABLE inm.warehouse_order_history TO muriel;
GRANT ALL ON TABLE inm.warehouse_order_history TO yann;
GRANT ALL ON TABLE inm.warehouse_order_history TO tableauuser;
GRANT ALL ON TABLE inm.warehouse_order_history TO bartender;
GRANT ALL ON TABLE inm.warehouse_order_history TO bytedevs;


--
-- Name: TABLE warehouse_order_history; Type: ACL; Schema: campus_87; Owner: erpuser
--

GRANT SELECT ON TABLE campus_87.warehouse_order_history TO rc87;


--
-- Name: TABLE current_inventory; Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON TABLE dw.current_inventory TO lambdazen;
GRANT ALL ON TABLE dw.current_inventory TO yann;
GRANT ALL ON TABLE dw.current_inventory TO bytedevs;
GRANT ALL ON TABLE dw.current_inventory TO tableauuser;


--
-- Name: TABLE byte_current_inventory; Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON TABLE dw.byte_current_inventory TO lambdazen;
GRANT ALL ON TABLE dw.byte_current_inventory TO yann;
GRANT ALL ON TABLE dw.byte_current_inventory TO bytedevs;
GRANT ALL ON TABLE dw.byte_current_inventory TO tableauuser;


--
-- Name: TABLE dim_campus; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.dim_campus TO lambdazen;
GRANT ALL ON TABLE dw.dim_campus TO yann;
GRANT SELECT ON TABLE dw.dim_campus TO readonly;
GRANT ALL ON TABLE dw.dim_campus TO dbservice;
GRANT ALL ON TABLE dw.dim_campus TO bytedevs;
GRANT ALL ON TABLE dw.dim_campus TO tableauuser;


--
-- Name: TABLE dim_kiosk; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.dim_kiosk TO lambdazen;
GRANT ALL ON TABLE dw.dim_kiosk TO yann;
GRANT SELECT ON TABLE dw.dim_kiosk TO readonly;
GRANT ALL ON TABLE dw.dim_kiosk TO dbservice;
GRANT ALL ON TABLE dw.dim_kiosk TO bytedevs;
GRANT ALL ON TABLE dw.dim_kiosk TO tableauuser;


--
-- Name: TABLE dim_product; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.dim_product TO lambdazen;
GRANT ALL ON TABLE dw.dim_product TO yann;
GRANT SELECT ON TABLE dw.dim_product TO readonly;
GRANT ALL ON TABLE dw.dim_product TO dbservice;
GRANT ALL ON TABLE dw.dim_product TO bytedevs;
GRANT ALL ON TABLE dw.dim_product TO tableauuser;


--
-- Name: TABLE tag; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.tag TO muriel;
GRANT ALL ON TABLE pantry.tag TO yann;
GRANT ALL ON TABLE pantry.tag TO lambdazen;
GRANT ALL ON TABLE pantry.tag TO jungvu;
GRANT ALL ON TABLE pantry.tag TO tableauuser;
GRANT ALL ON TABLE pantry.tag TO bartender;
GRANT ALL ON TABLE pantry.tag TO bytedevs;


--
-- Name: TABLE export_inventory_lots; Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON TABLE dw.export_inventory_lots TO lambdazen;
GRANT ALL ON TABLE dw.export_inventory_lots TO yann;
GRANT ALL ON TABLE dw.export_inventory_lots TO bytedevs;
GRANT ALL ON TABLE dw.export_inventory_lots TO tableauuser;


--
-- Name: TABLE fact_daily_byte_foods_summary; Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON TABLE dw.fact_daily_byte_foods_summary TO lambdazen;
GRANT ALL ON TABLE dw.fact_daily_byte_foods_summary TO yann;
GRANT ALL ON TABLE dw.fact_daily_byte_foods_summary TO bytedevs;
GRANT ALL ON TABLE dw.fact_daily_byte_foods_summary TO tableauuser;


--
-- Name: TABLE fact_monthly_byte_foods_summary; Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON TABLE dw.fact_monthly_byte_foods_summary TO lambdazen;
GRANT ALL ON TABLE dw.fact_monthly_byte_foods_summary TO yann;
GRANT ALL ON TABLE dw.fact_monthly_byte_foods_summary TO bytedevs;
GRANT ALL ON TABLE dw.fact_monthly_byte_foods_summary TO tableauuser;


--
-- Name: TABLE fact_monthly_kiosk_summary; Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON TABLE dw.fact_monthly_kiosk_summary TO lambdazen;
GRANT ALL ON TABLE dw.fact_monthly_kiosk_summary TO yann;
GRANT ALL ON TABLE dw.fact_monthly_kiosk_summary TO bytedevs;
GRANT ALL ON TABLE dw.fact_monthly_kiosk_summary TO tableauuser;


--
-- Name: TABLE last_15_months; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.last_15_months TO yann;
GRANT SELECT ON TABLE dw.last_15_months TO readonly;
GRANT ALL ON TABLE dw.last_15_months TO dbservice;
GRANT ALL ON TABLE dw.last_15_months TO bytedevs;
GRANT ALL ON TABLE dw.last_15_months TO tableauuser;


--
-- Name: TABLE last_15_weeks; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.last_15_weeks TO yann;
GRANT SELECT ON TABLE dw.last_15_weeks TO readonly;
GRANT ALL ON TABLE dw.last_15_weeks TO dbservice;
GRANT ALL ON TABLE dw.last_15_weeks TO bytedevs;
GRANT ALL ON TABLE dw.last_15_weeks TO tableauuser;


--
-- Name: TABLE last_30_days; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.last_30_days TO yann;
GRANT ALL ON TABLE dw.last_30_days TO dbservice;
GRANT ALL ON TABLE dw.last_30_days TO bytedevs;
GRANT ALL ON TABLE dw.last_30_days TO tableauuser;


--
-- Name: TABLE last_30_days_kpis; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.last_30_days_kpis TO yann;
GRANT ALL ON TABLE dw.last_30_days_kpis TO dbservice;
GRANT ALL ON TABLE dw.last_30_days_kpis TO bytedevs;
GRANT ALL ON TABLE dw.last_30_days_kpis TO tableauuser;


--
-- Name: TABLE monthly_kpis; Type: ACL; Schema: dw; Owner: muriel
--

GRANT ALL ON TABLE dw.monthly_kpis TO yann;
GRANT SELECT ON TABLE dw.monthly_kpis TO readonly;
GRANT ALL ON TABLE dw.monthly_kpis TO dbservice;
GRANT ALL ON TABLE dw.monthly_kpis TO bytedevs;
GRANT ALL ON TABLE dw.monthly_kpis TO tableauuser;


--
-- Name: TABLE non_byte_current_inventory; Type: ACL; Schema: dw; Owner: erpuser
--

GRANT ALL ON TABLE dw.non_byte_current_inventory TO lambdazen;
GRANT ALL ON TABLE dw.non_byte_current_inventory TO yann;
GRANT ALL ON TABLE dw.non_byte_current_inventory TO bytedevs;
GRANT ALL ON TABLE dw.non_byte_current_inventory TO tableauuser;


--
-- Name: TABLE address; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.address TO lambdazen;
GRANT ALL ON TABLE erp.address TO muriel;
GRANT SELECT ON TABLE erp.address TO readonly;
GRANT ALL ON TABLE erp.address TO dbservice;


--
-- Name: SEQUENCE address_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.address_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.address_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.address_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.address_id_seq TO dbservice;


--
-- Name: TABLE awsdms_apply_exceptions; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.awsdms_apply_exceptions TO muriel;
GRANT ALL ON TABLE erp.awsdms_apply_exceptions TO yann;


--
-- Name: TABLE classic_product_allergen_tag; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.classic_product_allergen_tag TO muriel;
GRANT ALL ON TABLE erp.classic_product_allergen_tag TO yann;


--
-- Name: TABLE classic_product_category_tag; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.classic_product_category_tag TO muriel;
GRANT ALL ON TABLE erp.classic_product_category_tag TO yann;


--
-- Name: TABLE client; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.client TO lambdazen;
GRANT ALL ON TABLE erp.client TO muriel;
GRANT SELECT ON TABLE erp.client TO readonly;
GRANT ALL ON TABLE erp.client TO dbservice;


--
-- Name: TABLE client_campus; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.client_campus TO lambdazen;
GRANT ALL ON TABLE erp.client_campus TO muriel;
GRANT SELECT ON TABLE erp.client_campus TO readonly;
GRANT ALL ON TABLE erp.client_campus TO dbservice;


--
-- Name: TABLE client_contact; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.client_contact TO lambdazen;
GRANT ALL ON TABLE erp.client_contact TO muriel;
GRANT SELECT ON TABLE erp.client_contact TO readonly;
GRANT ALL ON TABLE erp.client_contact TO dbservice;


--
-- Name: SEQUENCE client_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.client_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.client_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.client_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.client_id_seq TO dbservice;


--
-- Name: TABLE client_industry; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.client_industry TO lambdazen;
GRANT ALL ON TABLE erp.client_industry TO muriel;
GRANT SELECT ON TABLE erp.client_industry TO readonly;
GRANT ALL ON TABLE erp.client_industry TO dbservice;


--
-- Name: TABLE contact; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.contact TO lambdazen;
GRANT ALL ON TABLE erp.contact TO muriel;
GRANT SELECT ON TABLE erp.contact TO readonly;
GRANT ALL ON TABLE erp.contact TO dbservice;


--
-- Name: SEQUENCE contact_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.contact_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.contact_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.contact_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.contact_id_seq TO dbservice;


--
-- Name: TABLE fcm_repeater; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.fcm_repeater TO muriel;
GRANT ALL ON TABLE erp.fcm_repeater TO yann;


--
-- Name: TABLE global_attribute_def; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.global_attribute_def TO lambdazen;
GRANT ALL ON TABLE erp.global_attribute_def TO muriel;
GRANT SELECT ON TABLE erp.global_attribute_def TO readonly;
GRANT ALL ON TABLE erp.global_attribute_def TO dbservice;


--
-- Name: SEQUENCE global_attribute_def_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.global_attribute_def_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.global_attribute_def_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.global_attribute_def_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.global_attribute_def_id_seq TO dbservice;


--
-- Name: TABLE hardware_software; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.hardware_software TO lambdazen;
GRANT ALL ON TABLE erp.hardware_software TO muriel;
GRANT SELECT ON TABLE erp.hardware_software TO readonly;
GRANT ALL ON TABLE erp.hardware_software TO dbservice;


--
-- Name: TABLE kiosk; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk TO lambdazen;
GRANT ALL ON TABLE erp.kiosk TO muriel;
GRANT SELECT ON TABLE erp.kiosk TO readonly;
GRANT SELECT ON TABLE erp.kiosk TO yann;
GRANT ALL ON TABLE erp.kiosk TO dbservice;


--
-- Name: TABLE kiosk_access_card; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_access_card TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_access_card TO muriel;
GRANT SELECT ON TABLE erp.kiosk_access_card TO readonly;
GRANT ALL ON TABLE erp.kiosk_access_card TO dbservice;


--
-- Name: SEQUENCE kiosk_access_card_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.kiosk_access_card_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.kiosk_access_card_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.kiosk_access_card_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.kiosk_access_card_id_seq TO dbservice;


--
-- Name: TABLE kiosk_accounting; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_accounting TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_accounting TO muriel;
GRANT SELECT ON TABLE erp.kiosk_accounting TO readonly;
GRANT ALL ON TABLE erp.kiosk_accounting TO dbservice;


--
-- Name: TABLE kiosk_attribute; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_attribute TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_attribute TO muriel;
GRANT SELECT ON TABLE erp.kiosk_attribute TO readonly;
GRANT ALL ON TABLE erp.kiosk_attribute TO dbservice;


--
-- Name: TABLE kiosk_contact; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_contact TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_contact TO muriel;
GRANT SELECT ON TABLE erp.kiosk_contact TO readonly;
GRANT ALL ON TABLE erp.kiosk_contact TO dbservice;


--
-- Name: TABLE kiosk_delivery_window; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_delivery_window TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_delivery_window TO muriel;
GRANT SELECT ON TABLE erp.kiosk_delivery_window TO readonly;
GRANT ALL ON TABLE erp.kiosk_delivery_window TO dbservice;


--
-- Name: TABLE kiosk_note; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_note TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_note TO muriel;
GRANT SELECT ON TABLE erp.kiosk_note TO readonly;
GRANT ALL ON TABLE erp.kiosk_note TO dbservice;


--
-- Name: TABLE kiosk_status; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_status TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_status TO muriel;
GRANT SELECT ON TABLE erp.kiosk_status TO readonly;
GRANT ALL ON TABLE erp.kiosk_status TO dbservice;


--
-- Name: TABLE kiosk_classic_view; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_classic_view TO muriel;
GRANT ALL ON TABLE erp.kiosk_classic_view TO yann;
GRANT ALL ON TABLE erp.kiosk_classic_view TO lambdazen;


--
-- Name: SEQUENCE kiosk_note_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.kiosk_note_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.kiosk_note_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.kiosk_note_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.kiosk_note_id_seq TO dbservice;


--
-- Name: TABLE kiosk_restriction_by_product; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_restriction_by_product TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_restriction_by_product TO muriel;
GRANT SELECT ON TABLE erp.kiosk_restriction_by_product TO readonly;
GRANT ALL ON TABLE erp.kiosk_restriction_by_product TO dbservice;


--
-- Name: TABLE kiosk_restriction_by_property; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.kiosk_restriction_by_property TO lambdazen;
GRANT ALL ON TABLE erp.kiosk_restriction_by_property TO muriel;
GRANT SELECT ON TABLE erp.kiosk_restriction_by_property TO readonly;
GRANT ALL ON TABLE erp.kiosk_restriction_by_property TO dbservice;


--
-- Name: TABLE product; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product TO lambdazen;
GRANT ALL ON TABLE erp.product TO muriel;
GRANT SELECT ON TABLE erp.product TO readonly;
GRANT ALL ON TABLE erp.product TO dbservice;


--
-- Name: TABLE product_asset; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_asset TO lambdazen;
GRANT ALL ON TABLE erp.product_asset TO muriel;
GRANT SELECT ON TABLE erp.product_asset TO readonly;
GRANT ALL ON TABLE erp.product_asset TO dbservice;


--
-- Name: TABLE product_category; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_category TO lambdazen;
GRANT ALL ON TABLE erp.product_category TO muriel;
GRANT SELECT ON TABLE erp.product_category TO readonly;
GRANT ALL ON TABLE erp.product_category TO dbservice;


--
-- Name: TABLE product_category_def; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_category_def TO lambdazen;
GRANT ALL ON TABLE erp.product_category_def TO muriel;
GRANT SELECT ON TABLE erp.product_category_def TO readonly;
GRANT ALL ON TABLE erp.product_category_def TO dbservice;


--
-- Name: SEQUENCE product_category_def_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.product_category_def_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.product_category_def_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.product_category_def_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.product_category_def_id_seq TO dbservice;


--
-- Name: TABLE product_categories; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.product_categories TO muriel;
GRANT ALL ON TABLE pantry.product_categories TO yann;
GRANT SELECT ON TABLE pantry.product_categories TO readonly;
GRANT ALL ON TABLE pantry.product_categories TO lambdazen;
GRANT ALL ON TABLE pantry.product_categories TO dbservice;
GRANT ALL ON TABLE pantry.product_categories TO jungvu;
GRANT ALL ON TABLE pantry.product_categories TO tableauuser;
GRANT ALL ON TABLE pantry.product_categories TO bartender;
GRANT ALL ON TABLE pantry.product_categories TO bytedevs;


--
-- Name: TABLE product_category_tag; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_category_tag TO muriel;
GRANT ALL ON TABLE erp.product_category_tag TO yann;


--
-- Name: TABLE product_handling; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_handling TO lambdazen;
GRANT ALL ON TABLE erp.product_handling TO muriel;
GRANT SELECT ON TABLE erp.product_handling TO readonly;
GRANT ALL ON TABLE erp.product_handling TO dbservice;


--
-- Name: TABLE product_nutrition; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_nutrition TO lambdazen;
GRANT ALL ON TABLE erp.product_nutrition TO muriel;
GRANT SELECT ON TABLE erp.product_nutrition TO readonly;
GRANT ALL ON TABLE erp.product_nutrition TO dbservice;


--
-- Name: TABLE product_pricing; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_pricing TO lambdazen;
GRANT ALL ON TABLE erp.product_pricing TO muriel;
GRANT SELECT ON TABLE erp.product_pricing TO readonly;
GRANT ALL ON TABLE erp.product_pricing TO dbservice;


--
-- Name: TABLE product_property; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_property TO lambdazen;
GRANT ALL ON TABLE erp.product_property TO muriel;
GRANT SELECT ON TABLE erp.product_property TO readonly;
GRANT ALL ON TABLE erp.product_property TO dbservice;


--
-- Name: TABLE product_property_tag; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_property_tag TO muriel;
GRANT ALL ON TABLE erp.product_property_tag TO yann;
GRANT ALL ON TABLE erp.product_property_tag TO lambdazen;


--
-- Name: TABLE product_sourcing; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_sourcing TO lambdazen;
GRANT ALL ON TABLE erp.product_sourcing TO muriel;
GRANT SELECT ON TABLE erp.product_sourcing TO readonly;
GRANT ALL ON TABLE erp.product_sourcing TO dbservice;


--
-- Name: TABLE product_classic_view; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_classic_view TO muriel;
GRANT ALL ON TABLE erp.product_classic_view TO yann;
GRANT ALL ON TABLE erp.product_classic_view TO lambdazen;


--
-- Name: TABLE product_property_def; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.product_property_def TO lambdazen;
GRANT ALL ON TABLE erp.product_property_def TO muriel;
GRANT SELECT ON TABLE erp.product_property_def TO readonly;
GRANT ALL ON TABLE erp.product_property_def TO dbservice;


--
-- Name: SEQUENCE product_property_def_id_seq; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON SEQUENCE erp.product_property_def_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE erp.product_property_def_id_seq TO muriel;
GRANT ALL ON SEQUENCE erp.product_property_def_id_seq TO yann;
GRANT ALL ON SEQUENCE erp.product_property_def_id_seq TO dbservice;


--
-- Name: TABLE sku_group; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.sku_group TO lambdazen;
GRANT ALL ON TABLE erp.sku_group TO muriel;
GRANT SELECT ON TABLE erp.sku_group TO readonly;
GRANT ALL ON TABLE erp.sku_group TO dbservice;


--
-- Name: TABLE tag_order; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.tag_order TO muriel;
GRANT ALL ON TABLE erp.tag_order TO yann;


--
-- Name: TABLE tag_order_stats; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.tag_order_stats TO muriel;
GRANT ALL ON TABLE erp.tag_order_stats TO yann;


--
-- Name: TABLE tag_price; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.tag_price TO muriel;
GRANT ALL ON TABLE erp.tag_price TO yann;


--
-- Name: TABLE tag_type; Type: ACL; Schema: erp; Owner: erpuser
--

GRANT ALL ON TABLE erp.tag_type TO muriel;
GRANT ALL ON TABLE erp.tag_type TO yann;


--
-- Name: TABLE v_client; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_client TO erpuser;
GRANT SELECT ON TABLE erp.v_client TO yann;
GRANT SELECT ON TABLE erp.v_client TO readonly;
GRANT ALL ON TABLE erp.v_client TO dbservice;


--
-- Name: TABLE v_client_list; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_client_list TO erpuser;
GRANT SELECT ON TABLE erp.v_client_list TO yann;
GRANT SELECT ON TABLE erp.v_client_list TO readonly;
GRANT ALL ON TABLE erp.v_client_list TO dbservice;


--
-- Name: TABLE last_kiosk_status; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.last_kiosk_status TO muriel;
GRANT ALL ON TABLE pantry.last_kiosk_status TO lambdazen;
GRANT ALL ON TABLE pantry.last_kiosk_status TO yann;
GRANT SELECT ON TABLE pantry.last_kiosk_status TO readonly;
GRANT ALL ON TABLE pantry.last_kiosk_status TO dbservice;
GRANT ALL ON TABLE pantry.last_kiosk_status TO jungvu;
GRANT ALL ON TABLE pantry.last_kiosk_status TO tableauuser;
GRANT ALL ON TABLE pantry.last_kiosk_status TO bartender;
GRANT ALL ON TABLE pantry.last_kiosk_status TO bytedevs;


--
-- Name: TABLE v_kiosk; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_kiosk TO erpuser;
GRANT SELECT ON TABLE erp.v_kiosk TO yann;
GRANT SELECT ON TABLE erp.v_kiosk TO readonly;
GRANT ALL ON TABLE erp.v_kiosk TO dbservice;


--
-- Name: TABLE kiosk_status; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.kiosk_status TO muriel;
GRANT ALL ON TABLE pantry.kiosk_status TO yann;
GRANT ALL ON TABLE pantry.kiosk_status TO lambdazen;
GRANT ALL ON TABLE pantry.kiosk_status TO jungvu;
GRANT ALL ON TABLE pantry.kiosk_status TO tableauuser;
GRANT ALL ON TABLE pantry.kiosk_status TO bartender;
GRANT ALL ON TABLE pantry.kiosk_status TO bytedevs;


--
-- Name: TABLE v_kiosk_options; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_kiosk_options TO erpuser;
GRANT SELECT ON TABLE erp.v_kiosk_options TO yann;
GRANT SELECT ON TABLE erp.v_kiosk_options TO readonly;
GRANT ALL ON TABLE erp.v_kiosk_options TO dbservice;


--
-- Name: TABLE v_product; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_product TO erpuser;
GRANT SELECT ON TABLE erp.v_product TO yann;
GRANT SELECT ON TABLE erp.v_product TO readonly;
GRANT ALL ON TABLE erp.v_product TO dbservice;


--
-- Name: TABLE v_product_list; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_product_list TO erpuser;
GRANT SELECT ON TABLE erp.v_product_list TO yann;
GRANT SELECT ON TABLE erp.v_product_list TO readonly;
GRANT ALL ON TABLE erp.v_product_list TO dbservice;


--
-- Name: TABLE v_product_options; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_product_options TO erpuser;
GRANT SELECT ON TABLE erp.v_product_options TO yann;
GRANT SELECT ON TABLE erp.v_product_options TO readonly;
GRANT ALL ON TABLE erp.v_product_options TO dbservice;


--
-- Name: TABLE sku_group; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.sku_group TO lambdazen;
GRANT ALL ON TABLE inm.sku_group TO muriel;
GRANT ALL ON TABLE inm.sku_group TO yann;
GRANT SELECT ON TABLE inm.sku_group TO readonly;
GRANT ALL ON TABLE inm.sku_group TO dbservice;
GRANT ALL ON TABLE inm.sku_group TO tableauuser;
GRANT ALL ON TABLE inm.sku_group TO bartender;
GRANT ALL ON TABLE inm.sku_group TO bytedevs;


--
-- Name: TABLE v_sku_group_list; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_sku_group_list TO erpuser;
GRANT SELECT ON TABLE erp.v_sku_group_list TO yann;
GRANT SELECT ON TABLE erp.v_sku_group_list TO readonly;
GRANT ALL ON TABLE erp.v_sku_group_list TO dbservice;


--
-- Name: TABLE label_order; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.label_order TO muriel;
GRANT ALL ON TABLE pantry.label_order TO yann;
GRANT ALL ON TABLE pantry.label_order TO lambdazen;
GRANT ALL ON TABLE pantry.label_order TO jungvu;
GRANT ALL ON TABLE pantry.label_order TO tableauuser;
GRANT ALL ON TABLE pantry.label_order TO bartender;
GRANT ALL ON TABLE pantry.label_order TO bytedevs;


--
-- Name: TABLE coupon; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.coupon TO muriel;
GRANT ALL ON TABLE pantry.coupon TO yann;
GRANT SELECT ON TABLE pantry.coupon TO readonly;
GRANT ALL ON TABLE pantry.coupon TO lambdazen;
GRANT ALL ON TABLE pantry.coupon TO dbservice;
GRANT ALL ON TABLE pantry.coupon TO jungvu;
GRANT ALL ON TABLE pantry.coupon TO tableauuser;
GRANT ALL ON TABLE pantry.coupon TO bartender;
GRANT ALL ON TABLE pantry.coupon TO bytedevs;


--
-- Name: TABLE discount_applied; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.discount_applied TO muriel;
GRANT ALL ON TABLE pantry.discount_applied TO yann;
GRANT ALL ON TABLE pantry.discount_applied TO lambdazen;
GRANT ALL ON TABLE pantry.discount_applied TO jungvu;
GRANT ALL ON TABLE pantry.discount_applied TO tableauuser;
GRANT ALL ON TABLE pantry.discount_applied TO bartender;
GRANT ALL ON TABLE pantry.discount_applied TO bytedevs;


--
-- Name: TABLE v_transaction_detail; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT ALL ON TABLE erp.v_transaction_detail TO dbservice;


--
-- Name: TABLE v_transaction_list; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT ALL ON TABLE erp.v_transaction_list TO dbservice;


--
-- Name: TABLE v_warehouse_inventory; Type: ACL; Schema: erp; Owner: lambdazen
--

GRANT SELECT ON TABLE erp.v_warehouse_inventory TO erpuser;
GRANT SELECT ON TABLE erp.v_warehouse_inventory TO yann;
GRANT SELECT ON TABLE erp.v_warehouse_inventory TO readonly;
GRANT ALL ON TABLE erp.v_warehouse_inventory TO dbservice;


--
-- Name: TABLE kiosk_product_disabled; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_product_disabled TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_product_disabled TO muriel;
GRANT ALL ON TABLE inm.kiosk_product_disabled TO yann;
GRANT SELECT ON TABLE inm.kiosk_product_disabled TO readonly;
GRANT ALL ON TABLE inm.kiosk_product_disabled TO dbservice;
GRANT ALL ON TABLE inm.kiosk_product_disabled TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_product_disabled TO bartender;
GRANT ALL ON TABLE inm.kiosk_product_disabled TO bytedevs;


--
-- Name: TABLE byte_products_fast; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_products_fast TO yann;
GRANT SELECT ON TABLE public.byte_products_fast TO readonly;
GRANT ALL ON TABLE public.byte_products_fast TO tableauuser;
GRANT ALL ON TABLE public.byte_products_fast TO bartender;
GRANT ALL ON TABLE public.byte_products_fast TO bytedevs;


--
-- Name: TABLE byte_products; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_products TO yann;
GRANT SELECT ON TABLE public.byte_products TO readonly;
GRANT ALL ON TABLE public.byte_products TO tableauuser;
GRANT ALL ON TABLE public.byte_products TO bartender;
GRANT ALL ON TABLE public.byte_products TO bytedevs;


--
-- Name: TABLE byte_label_product; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_label_product TO yann;
GRANT SELECT ON TABLE public.byte_label_product TO readonly;
GRANT ALL ON TABLE public.byte_label_product TO tableauuser;
GRANT ALL ON TABLE public.byte_label_product TO bartender;
GRANT ALL ON TABLE public.byte_label_product TO bytedevs;


--
-- Name: TABLE byte_tickets_12weeks; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_tickets_12weeks TO yann;
GRANT SELECT ON TABLE public.byte_tickets_12weeks TO readonly;
GRANT ALL ON TABLE public.byte_tickets_12weeks TO tableauuser;
GRANT ALL ON TABLE public.byte_tickets_12weeks TO bartender;
GRANT ALL ON TABLE public.byte_tickets_12weeks TO bytedevs;


--
-- Name: TABLE byte_epcssold_12weeks; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_epcssold_12weeks TO yann;
GRANT SELECT ON TABLE public.byte_epcssold_12weeks TO readonly;
GRANT ALL ON TABLE public.byte_epcssold_12weeks TO tableauuser;
GRANT ALL ON TABLE public.byte_epcssold_12weeks TO bartender;
GRANT ALL ON TABLE public.byte_epcssold_12weeks TO bytedevs;


--
-- Name: TABLE v_kiosk_sale_hourly; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.v_kiosk_sale_hourly TO lambdazen;
GRANT ALL ON TABLE inm.v_kiosk_sale_hourly TO muriel;
GRANT ALL ON TABLE inm.v_kiosk_sale_hourly TO yann;
GRANT SELECT ON TABLE inm.v_kiosk_sale_hourly TO readonly;
GRANT ALL ON TABLE inm.v_kiosk_sale_hourly TO dbservice;
GRANT ALL ON TABLE inm.v_kiosk_sale_hourly TO tableauuser;
GRANT ALL ON TABLE inm.v_kiosk_sale_hourly TO bartender;
GRANT ALL ON TABLE inm.v_kiosk_sale_hourly TO bytedevs;


--
-- Name: TABLE route_stop; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.route_stop TO readonly;
GRANT SELECT ON TABLE mixalot.route_stop TO yann;
GRANT ALL ON TABLE mixalot.route_stop TO muriel;
GRANT ALL ON TABLE mixalot.route_stop TO lambdazen;
GRANT ALL ON TABLE mixalot.route_stop TO tableauuser;
GRANT ALL ON TABLE mixalot.route_stop TO bartender;
GRANT ALL ON TABLE mixalot.route_stop TO bytedevs;


--
-- Name: TABLE v_kiosk_demand_plan_ratio; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.v_kiosk_demand_plan_ratio TO lambdazen;
GRANT ALL ON TABLE inm.v_kiosk_demand_plan_ratio TO muriel;
GRANT ALL ON TABLE inm.v_kiosk_demand_plan_ratio TO yann;
GRANT SELECT ON TABLE inm.v_kiosk_demand_plan_ratio TO readonly;
GRANT ALL ON TABLE inm.v_kiosk_demand_plan_ratio TO dbservice;
GRANT ALL ON TABLE inm.v_kiosk_demand_plan_ratio TO tableauuser;
GRANT ALL ON TABLE inm.v_kiosk_demand_plan_ratio TO bartender;
GRANT ALL ON TABLE inm.v_kiosk_demand_plan_ratio TO bytedevs;


--
-- Name: TABLE v_kiosk_sku_enabled; Type: ACL; Schema: inm; Owner: dbservice
--

GRANT ALL ON TABLE inm.v_kiosk_sku_enabled TO lambdazen;
GRANT ALL ON TABLE inm.v_kiosk_sku_enabled TO muriel;
GRANT ALL ON TABLE inm.v_kiosk_sku_enabled TO yann;


--
-- Name: TABLE v_kiosk_sku_group_stock_sale_spoil_history; Type: ACL; Schema: inm; Owner: dbservice
--

GRANT ALL ON TABLE inm.v_kiosk_sku_group_stock_sale_spoil_history TO lambdazen;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_stock_sale_spoil_history TO muriel;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_stock_sale_spoil_history TO yann;


--
-- Name: TABLE byte_tickets_3months; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_tickets_3months TO yann;
GRANT SELECT ON TABLE public.byte_tickets_3months TO readonly;
GRANT ALL ON TABLE public.byte_tickets_3months TO tableauuser;
GRANT ALL ON TABLE public.byte_tickets_3months TO bartender;
GRANT ALL ON TABLE public.byte_tickets_3months TO bytedevs;


--
-- Name: TABLE byte_epcssold_3months; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.byte_epcssold_3months TO yann;
GRANT SELECT ON TABLE public.byte_epcssold_3months TO readonly;
GRANT ALL ON TABLE public.byte_epcssold_3months TO tableauuser;
GRANT ALL ON TABLE public.byte_epcssold_3months TO bartender;
GRANT ALL ON TABLE public.byte_epcssold_3months TO bytedevs;


--
-- Name: TABLE v_kiosk_sku_group_velocity_demand_week; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.v_kiosk_sku_group_velocity_demand_week TO lambdazen;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_velocity_demand_week TO muriel;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_velocity_demand_week TO yann;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_velocity_demand_week TO tableauuser;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_velocity_demand_week TO bartender;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_velocity_demand_week TO bytedevs;


--
-- Name: TABLE v_kiosk_sku_velocity; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.v_kiosk_sku_velocity TO lambdazen;
GRANT ALL ON TABLE inm.v_kiosk_sku_velocity TO muriel;
GRANT ALL ON TABLE inm.v_kiosk_sku_velocity TO yann;
GRANT SELECT ON TABLE inm.v_kiosk_sku_velocity TO readonly;
GRANT ALL ON TABLE inm.v_kiosk_sku_velocity TO dbservice;
GRANT ALL ON TABLE inm.v_kiosk_sku_velocity TO tableauuser;
GRANT ALL ON TABLE inm.v_kiosk_sku_velocity TO bartender;
GRANT ALL ON TABLE inm.v_kiosk_sku_velocity TO bytedevs;


--
-- Name: TABLE v_kiosk_sku_group_sku_stats; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.v_kiosk_sku_group_sku_stats TO lambdazen;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_sku_stats TO muriel;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_sku_stats TO yann;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_sku_stats TO tableauuser;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_sku_stats TO bartender;
GRANT ALL ON TABLE inm.v_kiosk_sku_group_sku_stats TO bytedevs;


--
-- Name: TABLE product_picking_order; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.product_picking_order TO lambdazen;
GRANT ALL ON TABLE inm.product_picking_order TO muriel;
GRANT ALL ON TABLE inm.product_picking_order TO yann;
GRANT ALL ON TABLE inm.product_picking_order TO tableauuser;
GRANT ALL ON TABLE inm.product_picking_order TO bartender;
GRANT ALL ON TABLE inm.product_picking_order TO bytedevs;


--
-- Name: TABLE allocable_inventory; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.allocable_inventory TO lambdazen;
GRANT ALL ON TABLE inm.allocable_inventory TO muriel;
GRANT ALL ON TABLE inm.allocable_inventory TO yann;
GRANT ALL ON TABLE inm.allocable_inventory TO tableauuser;
GRANT ALL ON TABLE inm.allocable_inventory TO bartender;
GRANT ALL ON TABLE inm.allocable_inventory TO bytedevs;


--
-- Name: TABLE configuration; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.configuration TO lambdazen;
GRANT ALL ON TABLE inm.configuration TO muriel;
GRANT ALL ON TABLE inm.configuration TO yann;
GRANT SELECT ON TABLE inm.configuration TO readonly;
GRANT ALL ON TABLE inm.configuration TO dbservice;
GRANT ALL ON TABLE inm.configuration TO tableauuser;
GRANT ALL ON TABLE inm.configuration TO bartender;
GRANT ALL ON TABLE inm.configuration TO bytedevs;


--
-- Name: TABLE kiosk_projected_stock; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_projected_stock TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_projected_stock TO muriel;
GRANT ALL ON TABLE inm.kiosk_projected_stock TO yann;
GRANT SELECT ON TABLE inm.kiosk_projected_stock TO readonly;
GRANT ALL ON TABLE inm.kiosk_projected_stock TO dbservice;
GRANT ALL ON TABLE inm.kiosk_projected_stock TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_projected_stock TO bartender;
GRANT ALL ON TABLE inm.kiosk_projected_stock TO bytedevs;


--
-- Name: TABLE kiosk_restriction_list; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.kiosk_restriction_list TO lambdazen;
GRANT ALL ON TABLE inm.kiosk_restriction_list TO muriel;
GRANT ALL ON TABLE inm.kiosk_restriction_list TO yann;
GRANT SELECT ON TABLE inm.kiosk_restriction_list TO readonly;
GRANT ALL ON TABLE inm.kiosk_restriction_list TO dbservice;
GRANT ALL ON TABLE inm.kiosk_restriction_list TO tableauuser;
GRANT ALL ON TABLE inm.kiosk_restriction_list TO bartender;
GRANT ALL ON TABLE inm.kiosk_restriction_list TO bytedevs;


--
-- Name: TABLE pick_substitution; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.pick_substitution TO lambdazen;
GRANT ALL ON TABLE inm.pick_substitution TO muriel;
GRANT ALL ON TABLE inm.pick_substitution TO yann;
GRANT SELECT ON TABLE inm.pick_substitution TO readonly;
GRANT ALL ON TABLE inm.pick_substitution TO dbservice;
GRANT ALL ON TABLE inm.pick_substitution TO tableauuser;
GRANT ALL ON TABLE inm.pick_substitution TO bartender;
GRANT ALL ON TABLE inm.pick_substitution TO bytedevs;


--
-- Name: TABLE product_pick_order; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.product_pick_order TO lambdazen;
GRANT ALL ON TABLE inm.product_pick_order TO muriel;
GRANT ALL ON TABLE inm.product_pick_order TO yann;
GRANT SELECT ON TABLE inm.product_pick_order TO readonly;
GRANT ALL ON TABLE inm.product_pick_order TO dbservice;
GRANT ALL ON TABLE inm.product_pick_order TO tableauuser;
GRANT ALL ON TABLE inm.product_pick_order TO bartender;
GRANT ALL ON TABLE inm.product_pick_order TO bytedevs;


--
-- Name: TABLE product_pick_order_temp; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.product_pick_order_temp TO lambdazen;
GRANT ALL ON TABLE inm.product_pick_order_temp TO muriel;
GRANT ALL ON TABLE inm.product_pick_order_temp TO yann;
GRANT SELECT ON TABLE inm.product_pick_order_temp TO readonly;
GRANT ALL ON TABLE inm.product_pick_order_temp TO dbservice;
GRANT ALL ON TABLE inm.product_pick_order_temp TO tableauuser;
GRANT ALL ON TABLE inm.product_pick_order_temp TO bartender;
GRANT ALL ON TABLE inm.product_pick_order_temp TO bytedevs;


--
-- Name: SEQUENCE product_property_def_id_seq; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON SEQUENCE inm.product_property_def_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE inm.product_property_def_id_seq TO muriel;
GRANT ALL ON SEQUENCE inm.product_property_def_id_seq TO yann;
GRANT ALL ON SEQUENCE inm.product_property_def_id_seq TO dbservice;
GRANT ALL ON SEQUENCE inm.product_property_def_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE inm.product_property_def_id_seq TO bartender;
GRANT ALL ON SEQUENCE inm.product_property_def_id_seq TO bytedevs;


--
-- Name: TABLE v_warehouse_order_delivered_totals; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.v_warehouse_order_delivered_totals TO lambdazen;
GRANT ALL ON TABLE inm.v_warehouse_order_delivered_totals TO muriel;
GRANT ALL ON TABLE inm.v_warehouse_order_delivered_totals TO yann;
GRANT ALL ON TABLE inm.v_warehouse_order_delivered_totals TO tableauuser;
GRANT ALL ON TABLE inm.v_warehouse_order_delivered_totals TO bartender;
GRANT ALL ON TABLE inm.v_warehouse_order_delivered_totals TO bytedevs;


--
-- Name: TABLE v_warehouse_ordering_rec; Type: ACL; Schema: inm; Owner: erpuser
--

GRANT ALL ON TABLE inm.v_warehouse_ordering_rec TO lambdazen;
GRANT ALL ON TABLE inm.v_warehouse_ordering_rec TO muriel;
GRANT ALL ON TABLE inm.v_warehouse_ordering_rec TO yann;
GRANT ALL ON TABLE inm.v_warehouse_ordering_rec TO tableauuser;
GRANT ALL ON TABLE inm.v_warehouse_ordering_rec TO bartender;
GRANT ALL ON TABLE inm.v_warehouse_ordering_rec TO bytedevs;


--
-- Name: TABLE card_product_fact; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.card_product_fact TO readonly;
GRANT SELECT ON TABLE mixalot.card_product_fact TO yann;
GRANT ALL ON TABLE mixalot.card_product_fact TO muriel;
GRANT ALL ON TABLE mixalot.card_product_fact TO lambdazen;
GRANT ALL ON TABLE mixalot.card_product_fact TO tableauuser;
GRANT ALL ON TABLE mixalot.card_product_fact TO bartender;
GRANT ALL ON TABLE mixalot.card_product_fact TO bytedevs;


--
-- Name: SEQUENCE card_product_fact_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.card_product_fact_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.card_product_fact_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.card_product_fact_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.card_product_fact_id_seq TO bytedevs;


--
-- Name: TABLE gsheet_cache; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.gsheet_cache TO readonly;
GRANT SELECT ON TABLE mixalot.gsheet_cache TO yann;
GRANT ALL ON TABLE mixalot.gsheet_cache TO muriel;
GRANT ALL ON TABLE mixalot.gsheet_cache TO lambdazen;
GRANT ALL ON TABLE mixalot.gsheet_cache TO tableauuser;
GRANT ALL ON TABLE mixalot.gsheet_cache TO bartender;
GRANT ALL ON TABLE mixalot.gsheet_cache TO bytedevs;


--
-- Name: TABLE history_order_pipeline; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.history_order_pipeline TO readonly;
GRANT SELECT ON TABLE mixalot.history_order_pipeline TO yann;
GRANT ALL ON TABLE mixalot.history_order_pipeline TO muriel;
GRANT ALL ON TABLE mixalot.history_order_pipeline TO lambdazen;
GRANT ALL ON TABLE mixalot.history_order_pipeline TO tableauuser;
GRANT ALL ON TABLE mixalot.history_order_pipeline TO bartender;
GRANT ALL ON TABLE mixalot.history_order_pipeline TO bytedevs;


--
-- Name: SEQUENCE history_order_pipeline_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.history_order_pipeline_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.history_order_pipeline_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.history_order_pipeline_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.history_order_pipeline_id_seq TO bytedevs;


--
-- Name: TABLE inm_data; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.inm_data TO readonly;
GRANT SELECT ON TABLE mixalot.inm_data TO yann;
GRANT ALL ON TABLE mixalot.inm_data TO muriel;
GRANT ALL ON TABLE mixalot.inm_data TO lambdazen;
GRANT ALL ON TABLE mixalot.inm_data TO tableauuser;
GRANT ALL ON TABLE mixalot.inm_data TO bartender;
GRANT ALL ON TABLE mixalot.inm_data TO bytedevs;


--
-- Name: SEQUENCE inm_data_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.inm_data_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.inm_data_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.inm_data_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.inm_data_id_seq TO bytedevs;


--
-- Name: TABLE inm_kiosk_projected_stock; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.inm_kiosk_projected_stock TO readonly;
GRANT SELECT ON TABLE mixalot.inm_kiosk_projected_stock TO yann;
GRANT ALL ON TABLE mixalot.inm_kiosk_projected_stock TO muriel;
GRANT ALL ON TABLE mixalot.inm_kiosk_projected_stock TO lambdazen;
GRANT ALL ON TABLE mixalot.inm_kiosk_projected_stock TO tableauuser;
GRANT ALL ON TABLE mixalot.inm_kiosk_projected_stock TO bartender;
GRANT ALL ON TABLE mixalot.inm_kiosk_projected_stock TO bytedevs;


--
-- Name: TABLE merchandising_slot_sku_group; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.merchandising_slot_sku_group TO readonly;
GRANT SELECT ON TABLE mixalot.merchandising_slot_sku_group TO yann;
GRANT ALL ON TABLE mixalot.merchandising_slot_sku_group TO muriel;
GRANT ALL ON TABLE mixalot.merchandising_slot_sku_group TO lambdazen;
GRANT ALL ON TABLE mixalot.merchandising_slot_sku_group TO tableauuser;
GRANT ALL ON TABLE mixalot.merchandising_slot_sku_group TO bartender;
GRANT ALL ON TABLE mixalot.merchandising_slot_sku_group TO bytedevs;


--
-- Name: TABLE sku_group_def; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.sku_group_def TO readonly;
GRANT SELECT ON TABLE mixalot.sku_group_def TO yann;
GRANT ALL ON TABLE mixalot.sku_group_def TO muriel;
GRANT ALL ON TABLE mixalot.sku_group_def TO lambdazen;
GRANT ALL ON TABLE mixalot.sku_group_def TO tableauuser;
GRANT ALL ON TABLE mixalot.sku_group_def TO bartender;
GRANT ALL ON TABLE mixalot.sku_group_def TO bytedevs;


--
-- Name: TABLE inm_sku_group_title_to_merchandising_slot; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.inm_sku_group_title_to_merchandising_slot TO readonly;
GRANT SELECT ON TABLE mixalot.inm_sku_group_title_to_merchandising_slot TO yann;
GRANT ALL ON TABLE mixalot.inm_sku_group_title_to_merchandising_slot TO muriel;
GRANT ALL ON TABLE mixalot.inm_sku_group_title_to_merchandising_slot TO lambdazen;
GRANT ALL ON TABLE mixalot.inm_sku_group_title_to_merchandising_slot TO tableauuser;
GRANT ALL ON TABLE mixalot.inm_sku_group_title_to_merchandising_slot TO bartender;
GRANT ALL ON TABLE mixalot.inm_sku_group_title_to_merchandising_slot TO bytedevs;


--
-- Name: TABLE inm_sku_velocity; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.inm_sku_velocity TO readonly;
GRANT SELECT ON TABLE mixalot.inm_sku_velocity TO yann;
GRANT ALL ON TABLE mixalot.inm_sku_velocity TO muriel;
GRANT ALL ON TABLE mixalot.inm_sku_velocity TO lambdazen;
GRANT ALL ON TABLE mixalot.inm_sku_velocity TO tableauuser;
GRANT ALL ON TABLE mixalot.inm_sku_velocity TO bartender;
GRANT ALL ON TABLE mixalot.inm_sku_velocity TO bytedevs;


--
-- Name: TABLE kiosk_contents; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.kiosk_contents TO readonly;
GRANT SELECT ON TABLE mixalot.kiosk_contents TO yann;
GRANT ALL ON TABLE mixalot.kiosk_contents TO muriel;
GRANT ALL ON TABLE mixalot.kiosk_contents TO lambdazen;
GRANT ALL ON TABLE mixalot.kiosk_contents TO tableauuser;
GRANT ALL ON TABLE mixalot.kiosk_contents TO bartender;
GRANT ALL ON TABLE mixalot.kiosk_contents TO bytedevs;


--
-- Name: SEQUENCE kiosk_contents_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.kiosk_contents_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.kiosk_contents_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.kiosk_contents_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.kiosk_contents_id_seq TO bytedevs;


--
-- Name: TABLE kiosk_fact; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.kiosk_fact TO readonly;
GRANT SELECT ON TABLE mixalot.kiosk_fact TO yann;
GRANT ALL ON TABLE mixalot.kiosk_fact TO muriel;
GRANT ALL ON TABLE mixalot.kiosk_fact TO lambdazen;
GRANT ALL ON TABLE mixalot.kiosk_fact TO tableauuser;
GRANT ALL ON TABLE mixalot.kiosk_fact TO bartender;
GRANT ALL ON TABLE mixalot.kiosk_fact TO bytedevs;


--
-- Name: SEQUENCE kiosk_fact_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.kiosk_fact_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.kiosk_fact_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.kiosk_fact_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.kiosk_fact_id_seq TO bytedevs;


--
-- Name: TABLE last_kiosk_status; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.last_kiosk_status TO readonly;
GRANT SELECT ON TABLE mixalot.last_kiosk_status TO yann;
GRANT ALL ON TABLE mixalot.last_kiosk_status TO muriel;
GRANT ALL ON TABLE mixalot.last_kiosk_status TO lambdazen;
GRANT ALL ON TABLE mixalot.last_kiosk_status TO tableauuser;
GRANT ALL ON TABLE mixalot.last_kiosk_status TO bartender;
GRANT ALL ON TABLE mixalot.last_kiosk_status TO bytedevs;


--
-- Name: TABLE log; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.log TO readonly;
GRANT SELECT ON TABLE mixalot.log TO yann;
GRANT ALL ON TABLE mixalot.log TO muriel;
GRANT ALL ON TABLE mixalot.log TO lambdazen;
GRANT ALL ON TABLE mixalot.log TO tableauuser;
GRANT ALL ON TABLE mixalot.log TO bartender;
GRANT ALL ON TABLE mixalot.log TO bytedevs;


--
-- Name: SEQUENCE log_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.log_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.log_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.log_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.log_id_seq TO bytedevs;


--
-- Name: TABLE order_fact; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.order_fact TO readonly;
GRANT SELECT ON TABLE mixalot.order_fact TO yann;
GRANT ALL ON TABLE mixalot.order_fact TO muriel;
GRANT ALL ON TABLE mixalot.order_fact TO lambdazen;
GRANT ALL ON TABLE mixalot.order_fact TO tableauuser;
GRANT ALL ON TABLE mixalot.order_fact TO bartender;
GRANT ALL ON TABLE mixalot.order_fact TO bytedevs;


--
-- Name: SEQUENCE order_fact_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.order_fact_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.order_fact_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.order_fact_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.order_fact_id_seq TO bytedevs;


--
-- Name: TABLE pgdu; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON TABLE mixalot.pgdu TO lambdazen;
GRANT ALL ON TABLE mixalot.pgdu TO bytedevs;
GRANT ALL ON TABLE mixalot.pgdu TO tableauuser;
GRANT ALL ON TABLE mixalot.pgdu TO bartender;


--
-- Name: TABLE pick_preference_kiosk_sku; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.pick_preference_kiosk_sku TO readonly;
GRANT SELECT ON TABLE mixalot.pick_preference_kiosk_sku TO yann;
GRANT ALL ON TABLE mixalot.pick_preference_kiosk_sku TO muriel;
GRANT ALL ON TABLE mixalot.pick_preference_kiosk_sku TO lambdazen;
GRANT ALL ON TABLE mixalot.pick_preference_kiosk_sku TO tableauuser;
GRANT ALL ON TABLE mixalot.pick_preference_kiosk_sku TO bartender;
GRANT ALL ON TABLE mixalot.pick_preference_kiosk_sku TO bytedevs;


--
-- Name: TABLE pick_priority_kiosk; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.pick_priority_kiosk TO readonly;
GRANT SELECT ON TABLE mixalot.pick_priority_kiosk TO yann;
GRANT ALL ON TABLE mixalot.pick_priority_kiosk TO muriel;
GRANT ALL ON TABLE mixalot.pick_priority_kiosk TO lambdazen;
GRANT ALL ON TABLE mixalot.pick_priority_kiosk TO tableauuser;
GRANT ALL ON TABLE mixalot.pick_priority_kiosk TO bartender;
GRANT ALL ON TABLE mixalot.pick_priority_kiosk TO bytedevs;


--
-- Name: TABLE product_fact; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.product_fact TO readonly;
GRANT SELECT ON TABLE mixalot.product_fact TO yann;
GRANT ALL ON TABLE mixalot.product_fact TO muriel;
GRANT ALL ON TABLE mixalot.product_fact TO lambdazen;
GRANT ALL ON TABLE mixalot.product_fact TO tableauuser;
GRANT ALL ON TABLE mixalot.product_fact TO bartender;
GRANT ALL ON TABLE mixalot.product_fact TO bytedevs;


--
-- Name: SEQUENCE product_fact_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.product_fact_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.product_fact_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.product_fact_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.product_fact_id_seq TO bytedevs;


--
-- Name: TABLE request_log; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.request_log TO readonly;
GRANT SELECT ON TABLE mixalot.request_log TO yann;
GRANT ALL ON TABLE mixalot.request_log TO muriel;
GRANT ALL ON TABLE mixalot.request_log TO lambdazen;
GRANT ALL ON TABLE mixalot.request_log TO tableauuser;
GRANT ALL ON TABLE mixalot.request_log TO bartender;
GRANT ALL ON TABLE mixalot.request_log TO bytedevs;


--
-- Name: TABLE route; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.route TO readonly;
GRANT SELECT ON TABLE mixalot.route TO yann;
GRANT ALL ON TABLE mixalot.route TO muriel;
GRANT ALL ON TABLE mixalot.route TO lambdazen;
GRANT ALL ON TABLE mixalot.route TO tableauuser;
GRANT ALL ON TABLE mixalot.route TO bartender;
GRANT ALL ON TABLE mixalot.route TO bytedevs;


--
-- Name: TABLE sku_group; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.sku_group TO readonly;
GRANT SELECT ON TABLE mixalot.sku_group TO yann;
GRANT ALL ON TABLE mixalot.sku_group TO muriel;
GRANT ALL ON TABLE mixalot.sku_group TO lambdazen;
GRANT ALL ON TABLE mixalot.sku_group TO tableauuser;
GRANT ALL ON TABLE mixalot.sku_group TO bartender;
GRANT ALL ON TABLE mixalot.sku_group TO bytedevs;


--
-- Name: SEQUENCE sku_group_def_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.sku_group_def_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.sku_group_def_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.sku_group_def_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.sku_group_def_id_seq TO bytedevs;


--
-- Name: SEQUENCE sku_group_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.sku_group_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.sku_group_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.sku_group_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.sku_group_id_seq TO bytedevs;


--
-- Name: TABLE sku_group_member; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.sku_group_member TO readonly;
GRANT SELECT ON TABLE mixalot.sku_group_member TO yann;
GRANT ALL ON TABLE mixalot.sku_group_member TO muriel;
GRANT ALL ON TABLE mixalot.sku_group_member TO lambdazen;
GRANT ALL ON TABLE mixalot.sku_group_member TO tableauuser;
GRANT ALL ON TABLE mixalot.sku_group_member TO bartender;
GRANT ALL ON TABLE mixalot.sku_group_member TO bytedevs;


--
-- Name: SEQUENCE sku_group_member_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.sku_group_member_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.sku_group_member_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.sku_group_member_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.sku_group_member_id_seq TO bytedevs;


--
-- Name: TABLE sku_property; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.sku_property TO readonly;
GRANT SELECT ON TABLE mixalot.sku_property TO yann;
GRANT ALL ON TABLE mixalot.sku_property TO muriel;
GRANT ALL ON TABLE mixalot.sku_property TO lambdazen;
GRANT ALL ON TABLE mixalot.sku_property TO tableauuser;
GRANT ALL ON TABLE mixalot.sku_property TO bartender;
GRANT ALL ON TABLE mixalot.sku_property TO bytedevs;


--
-- Name: TABLE sku_property_def; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.sku_property_def TO readonly;
GRANT SELECT ON TABLE mixalot.sku_property_def TO yann;
GRANT ALL ON TABLE mixalot.sku_property_def TO muriel;
GRANT ALL ON TABLE mixalot.sku_property_def TO lambdazen;
GRANT ALL ON TABLE mixalot.sku_property_def TO tableauuser;
GRANT ALL ON TABLE mixalot.sku_property_def TO bartender;
GRANT ALL ON TABLE mixalot.sku_property_def TO bytedevs;


--
-- Name: SEQUENCE sku_property_def_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.sku_property_def_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.sku_property_def_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.sku_property_def_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.sku_property_def_id_seq TO bytedevs;


--
-- Name: TABLE tmp_discount_applied; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.tmp_discount_applied TO readonly;
GRANT SELECT ON TABLE mixalot.tmp_discount_applied TO yann;
GRANT ALL ON TABLE mixalot.tmp_discount_applied TO muriel;
GRANT ALL ON TABLE mixalot.tmp_discount_applied TO lambdazen;
GRANT ALL ON TABLE mixalot.tmp_discount_applied TO tableauuser;
GRANT ALL ON TABLE mixalot.tmp_discount_applied TO bartender;
GRANT ALL ON TABLE mixalot.tmp_discount_applied TO bytedevs;


--
-- Name: SEQUENCE tmp_discount_applied_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.tmp_discount_applied_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.tmp_discount_applied_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.tmp_discount_applied_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.tmp_discount_applied_id_seq TO bytedevs;


--
-- Name: TABLE tmp_kiosk_status; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.tmp_kiosk_status TO readonly;
GRANT SELECT ON TABLE mixalot.tmp_kiosk_status TO yann;
GRANT ALL ON TABLE mixalot.tmp_kiosk_status TO muriel;
GRANT ALL ON TABLE mixalot.tmp_kiosk_status TO lambdazen;
GRANT ALL ON TABLE mixalot.tmp_kiosk_status TO tableauuser;
GRANT ALL ON TABLE mixalot.tmp_kiosk_status TO bartender;
GRANT ALL ON TABLE mixalot.tmp_kiosk_status TO bytedevs;


--
-- Name: SEQUENCE tmp_kiosk_status_id_seq; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT ALL ON SEQUENCE mixalot.tmp_kiosk_status_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE mixalot.tmp_kiosk_status_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE mixalot.tmp_kiosk_status_id_seq TO bartender;
GRANT ALL ON SEQUENCE mixalot.tmp_kiosk_status_id_seq TO bytedevs;


--
-- Name: TABLE tmp_transact; Type: ACL; Schema: mixalot; Owner: erpuser
--

GRANT SELECT ON TABLE mixalot.tmp_transact TO readonly;
GRANT SELECT ON TABLE mixalot.tmp_transact TO yann;
GRANT ALL ON TABLE mixalot.tmp_transact TO muriel;
GRANT ALL ON TABLE mixalot.tmp_transact TO lambdazen;
GRANT ALL ON TABLE mixalot.tmp_transact TO tableauuser;
GRANT ALL ON TABLE mixalot.tmp_transact TO bartender;
GRANT ALL ON TABLE mixalot.tmp_transact TO bytedevs;


--
-- Name: TABLE accounting; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.accounting TO muriel;
GRANT ALL ON TABLE pantry.accounting TO yann;
GRANT ALL ON TABLE pantry.accounting TO lambdazen;
GRANT ALL ON TABLE pantry.accounting TO jungvu;
GRANT ALL ON TABLE pantry.accounting TO tableauuser;
GRANT ALL ON TABLE pantry.accounting TO bartender;
GRANT ALL ON TABLE pantry.accounting TO bytedevs;


--
-- Name: TABLE awsdms_apply_exceptions; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.awsdms_apply_exceptions TO lambdazen;
GRANT ALL ON TABLE pantry.awsdms_apply_exceptions TO muriel;
GRANT ALL ON TABLE pantry.awsdms_apply_exceptions TO yann;
GRANT ALL ON TABLE pantry.awsdms_apply_exceptions TO bytedevs;
GRANT ALL ON TABLE pantry.awsdms_apply_exceptions TO tableauuser;
GRANT ALL ON TABLE pantry.awsdms_apply_exceptions TO bartender;


--
-- Name: TABLE bad_timestamp; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.bad_timestamp TO lambdazen;
GRANT ALL ON TABLE pantry.bad_timestamp TO muriel;
GRANT ALL ON TABLE pantry.bad_timestamp TO yann;
GRANT ALL ON TABLE pantry.bad_timestamp TO tableauuser;
GRANT ALL ON TABLE pantry.bad_timestamp TO bartender;
GRANT ALL ON TABLE pantry.bad_timestamp TO bytedevs;


--
-- Name: TABLE campus_assets; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.campus_assets TO lambdazen;
GRANT ALL ON TABLE pantry.campus_assets TO muriel;
GRANT ALL ON TABLE pantry.campus_assets TO yann;
GRANT ALL ON TABLE pantry.campus_assets TO tableauuser;
GRANT ALL ON TABLE pantry.campus_assets TO bartender;
GRANT ALL ON TABLE pantry.campus_assets TO bytedevs;


--
-- Name: TABLE card; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.card TO muriel;
GRANT ALL ON TABLE pantry.card TO yann;
GRANT ALL ON TABLE pantry.card TO lambdazen;
GRANT ALL ON TABLE pantry.card TO tableauuser;
GRANT ALL ON TABLE pantry.card TO bartender;
GRANT ALL ON TABLE pantry.card TO bytedevs;


--
-- Name: TABLE discount; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.discount TO muriel;
GRANT ALL ON TABLE pantry.discount TO yann;
GRANT ALL ON TABLE pantry.discount TO lambdazen;
GRANT ALL ON TABLE pantry.discount TO jungvu;
GRANT ALL ON TABLE pantry.discount TO tableauuser;
GRANT ALL ON TABLE pantry.discount TO bartender;
GRANT ALL ON TABLE pantry.discount TO bytedevs;


--
-- Name: TABLE discount_history; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.discount_history TO muriel;
GRANT ALL ON TABLE pantry.discount_history TO yann;
GRANT ALL ON TABLE pantry.discount_history TO lambdazen;
GRANT ALL ON TABLE pantry.discount_history TO jungvu;
GRANT ALL ON TABLE pantry.discount_history TO tableauuser;
GRANT ALL ON TABLE pantry.discount_history TO bartender;
GRANT ALL ON TABLE pantry.discount_history TO bytedevs;


--
-- Name: TABLE email; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.email TO lambdazen;
GRANT ALL ON TABLE pantry.email TO muriel;
GRANT ALL ON TABLE pantry.email TO yann;


--
-- Name: TABLE empty_transaction; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.empty_transaction TO lambdazen;
GRANT ALL ON TABLE pantry.empty_transaction TO muriel;
GRANT ALL ON TABLE pantry.empty_transaction TO yann;
GRANT ALL ON TABLE pantry.empty_transaction TO tableauuser;
GRANT ALL ON TABLE pantry.empty_transaction TO bartender;
GRANT ALL ON TABLE pantry.empty_transaction TO bytedevs;


--
-- Name: TABLE fee_rates; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.fee_rates TO muriel;
GRANT ALL ON TABLE pantry.fee_rates TO yann;
GRANT ALL ON TABLE pantry.fee_rates TO lambdazen;
GRANT ALL ON TABLE pantry.fee_rates TO jungvu;
GRANT ALL ON TABLE pantry.fee_rates TO tableauuser;
GRANT ALL ON TABLE pantry.fee_rates TO bartender;
GRANT ALL ON TABLE pantry.fee_rates TO bytedevs;


--
-- Name: TABLE "group"; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry."group" TO lambdazen;
GRANT ALL ON TABLE pantry."group" TO muriel;
GRANT ALL ON TABLE pantry."group" TO yann;
GRANT ALL ON TABLE pantry."group" TO tableauuser;
GRANT ALL ON TABLE pantry."group" TO bartender;
GRANT ALL ON TABLE pantry."group" TO bytedevs;


--
-- Name: TABLE group_campus; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.group_campus TO lambdazen;
GRANT ALL ON TABLE pantry.group_campus TO muriel;
GRANT ALL ON TABLE pantry.group_campus TO yann;
GRANT ALL ON TABLE pantry.group_campus TO tableauuser;
GRANT ALL ON TABLE pantry.group_campus TO bartender;
GRANT ALL ON TABLE pantry.group_campus TO bytedevs;


--
-- Name: TABLE history; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.history TO muriel;
GRANT ALL ON TABLE pantry.history TO yann;
GRANT SELECT ON TABLE pantry.history TO readonly;
GRANT ALL ON TABLE pantry.history TO lambdazen;
GRANT ALL ON TABLE pantry.history TO dbservice;
GRANT ALL ON TABLE pantry.history TO jungvu;
GRANT ALL ON TABLE pantry.history TO tableauuser;
GRANT ALL ON TABLE pantry.history TO bartender;
GRANT ALL ON TABLE pantry.history TO bytedevs;


--
-- Name: TABLE history_epc_order; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.history_epc_order TO lambdazen;
GRANT ALL ON TABLE pantry.history_epc_order TO muriel;
GRANT ALL ON TABLE pantry.history_epc_order TO yann;
GRANT ALL ON TABLE pantry.history_epc_order TO tableauuser;
GRANT ALL ON TABLE pantry.history_epc_order TO bartender;
GRANT ALL ON TABLE pantry.history_epc_order TO bytedevs;


--
-- Name: TABLE inventory_history; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.inventory_history TO muriel;
GRANT ALL ON TABLE pantry.inventory_history TO yann;
GRANT ALL ON TABLE pantry.inventory_history TO lambdazen;
GRANT ALL ON TABLE pantry.inventory_history TO jungvu;
GRANT ALL ON TABLE pantry.inventory_history TO tableauuser;
GRANT ALL ON TABLE pantry.inventory_history TO bartender;
GRANT ALL ON TABLE pantry.inventory_history TO bytedevs;


--
-- Name: TABLE inventory_request; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.inventory_request TO lambdazen;
GRANT ALL ON TABLE pantry.inventory_request TO muriel;
GRANT ALL ON TABLE pantry.inventory_request TO yann;
GRANT ALL ON TABLE pantry.inventory_request TO tableauuser;
GRANT ALL ON TABLE pantry.inventory_request TO bartender;
GRANT ALL ON TABLE pantry.inventory_request TO bytedevs;


--
-- Name: TABLE kiosk_audit_log; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.kiosk_audit_log TO lambdazen;
GRANT ALL ON TABLE pantry.kiosk_audit_log TO muriel;
GRANT ALL ON TABLE pantry.kiosk_audit_log TO yann;
GRANT ALL ON TABLE pantry.kiosk_audit_log TO tableauuser;
GRANT ALL ON TABLE pantry.kiosk_audit_log TO bartender;
GRANT ALL ON TABLE pantry.kiosk_audit_log TO bytedevs;


--
-- Name: TABLE kiosk_catalog_downloads; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.kiosk_catalog_downloads TO lambdazen;
GRANT ALL ON TABLE pantry.kiosk_catalog_downloads TO muriel;
GRANT ALL ON TABLE pantry.kiosk_catalog_downloads TO yann;
GRANT ALL ON TABLE pantry.kiosk_catalog_downloads TO tableauuser;
GRANT ALL ON TABLE pantry.kiosk_catalog_downloads TO bartender;
GRANT ALL ON TABLE pantry.kiosk_catalog_downloads TO bytedevs;


--
-- Name: TABLE kiosk_components_history; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.kiosk_components_history TO lambdazen;
GRANT ALL ON TABLE pantry.kiosk_components_history TO muriel;
GRANT ALL ON TABLE pantry.kiosk_components_history TO yann;
GRANT ALL ON TABLE pantry.kiosk_components_history TO tableauuser;
GRANT ALL ON TABLE pantry.kiosk_components_history TO bartender;
GRANT ALL ON TABLE pantry.kiosk_components_history TO bytedevs;


--
-- Name: TABLE kiosk_par_level; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.kiosk_par_level TO muriel;
GRANT ALL ON TABLE pantry.kiosk_par_level TO yann;
GRANT ALL ON TABLE pantry.kiosk_par_level TO lambdazen;
GRANT ALL ON TABLE pantry.kiosk_par_level TO jungvu;
GRANT ALL ON TABLE pantry.kiosk_par_level TO tableauuser;
GRANT ALL ON TABLE pantry.kiosk_par_level TO bartender;
GRANT ALL ON TABLE pantry.kiosk_par_level TO bytedevs;


--
-- Name: TABLE kiosks_date_non_new; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.kiosks_date_non_new TO muriel;
GRANT ALL ON TABLE pantry.kiosks_date_non_new TO yann;
GRANT ALL ON TABLE pantry.kiosks_date_non_new TO lambdazen;
GRANT ALL ON TABLE pantry.kiosks_date_non_new TO jungvu;
GRANT ALL ON TABLE pantry.kiosks_date_non_new TO tableauuser;
GRANT ALL ON TABLE pantry.kiosks_date_non_new TO bartender;
GRANT ALL ON TABLE pantry.kiosks_date_non_new TO bytedevs;


--
-- Name: SEQUENCE label_order_id_seq; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON SEQUENCE pantry.label_order_id_seq TO lambdazen;
GRANT ALL ON SEQUENCE pantry.label_order_id_seq TO muriel;


--
-- Name: TABLE label_stats; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.label_stats TO lambdazen;
GRANT ALL ON TABLE pantry.label_stats TO muriel;
GRANT ALL ON TABLE pantry.label_stats TO yann;
GRANT ALL ON TABLE pantry.label_stats TO bytedevs;
GRANT ALL ON TABLE pantry.label_stats TO tableauuser;
GRANT ALL ON TABLE pantry.label_stats TO bartender;


--
-- Name: TABLE manual_adjustment; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.manual_adjustment TO muriel;
GRANT ALL ON TABLE pantry.manual_adjustment TO yann;
GRANT ALL ON TABLE pantry.manual_adjustment TO lambdazen;
GRANT ALL ON TABLE pantry.manual_adjustment TO jungvu;
GRANT ALL ON TABLE pantry.manual_adjustment TO tableauuser;
GRANT ALL ON TABLE pantry.manual_adjustment TO bartender;
GRANT ALL ON TABLE pantry.manual_adjustment TO bytedevs;


--
-- Name: TABLE nutrition_filter; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.nutrition_filter TO muriel;
GRANT ALL ON TABLE pantry.nutrition_filter TO yann;
GRANT ALL ON TABLE pantry.nutrition_filter TO lambdazen;
GRANT ALL ON TABLE pantry.nutrition_filter TO jungvu;
GRANT ALL ON TABLE pantry.nutrition_filter TO tableauuser;
GRANT ALL ON TABLE pantry.nutrition_filter TO bartender;
GRANT ALL ON TABLE pantry.nutrition_filter TO bytedevs;


--
-- Name: TABLE payment_order; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.payment_order TO lambdazen;
GRANT ALL ON TABLE pantry.payment_order TO muriel;
GRANT ALL ON TABLE pantry.payment_order TO yann;
GRANT ALL ON TABLE pantry.payment_order TO tableauuser;
GRANT ALL ON TABLE pantry.payment_order TO bartender;
GRANT ALL ON TABLE pantry.payment_order TO bytedevs;


--
-- Name: TABLE payment_order_nursing; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.payment_order_nursing TO lambdazen;
GRANT ALL ON TABLE pantry.payment_order_nursing TO muriel;
GRANT ALL ON TABLE pantry.payment_order_nursing TO yann;
GRANT ALL ON TABLE pantry.payment_order_nursing TO tableauuser;
GRANT ALL ON TABLE pantry.payment_order_nursing TO bartender;
GRANT ALL ON TABLE pantry.payment_order_nursing TO bytedevs;


--
-- Name: TABLE pick_list_row; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.pick_list_row TO lambdazen;
GRANT ALL ON TABLE pantry.pick_list_row TO muriel;
GRANT ALL ON TABLE pantry.pick_list_row TO yann;
GRANT ALL ON TABLE pantry.pick_list_row TO tableauuser;
GRANT ALL ON TABLE pantry.pick_list_row TO bartender;
GRANT ALL ON TABLE pantry.pick_list_row TO bytedevs;


--
-- Name: TABLE product_history; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.product_history TO muriel;
GRANT ALL ON TABLE pantry.product_history TO yann;
GRANT ALL ON TABLE pantry.product_history TO lambdazen;
GRANT ALL ON TABLE pantry.product_history TO jungvu;
GRANT ALL ON TABLE pantry.product_history TO tableauuser;
GRANT ALL ON TABLE pantry.product_history TO bartender;
GRANT ALL ON TABLE pantry.product_history TO bytedevs;


--
-- Name: TABLE recent_transactions; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.recent_transactions TO lambdazen;
GRANT ALL ON TABLE pantry.recent_transactions TO muriel;
GRANT ALL ON TABLE pantry.recent_transactions TO yann;
GRANT ALL ON TABLE pantry.recent_transactions TO tableauuser;
GRANT ALL ON TABLE pantry.recent_transactions TO bartender;
GRANT ALL ON TABLE pantry.recent_transactions TO bytedevs;


--
-- Name: TABLE refunds; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.refunds TO muriel;
GRANT ALL ON TABLE pantry.refunds TO yann;
GRANT ALL ON TABLE pantry.refunds TO lambdazen;
GRANT ALL ON TABLE pantry.refunds TO jungvu;
GRANT ALL ON TABLE pantry.refunds TO tableauuser;
GRANT ALL ON TABLE pantry.refunds TO bartender;
GRANT ALL ON TABLE pantry.refunds TO bytedevs;


--
-- Name: TABLE ro_order; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.ro_order TO lambdazen;
GRANT ALL ON TABLE pantry.ro_order TO muriel;
GRANT ALL ON TABLE pantry.ro_order TO yann;
GRANT ALL ON TABLE pantry.ro_order TO tableauuser;
GRANT ALL ON TABLE pantry.ro_order TO bartender;
GRANT ALL ON TABLE pantry.ro_order TO bytedevs;


--
-- Name: TABLE role; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.role TO muriel;
GRANT ALL ON TABLE pantry.role TO lambdazen;
GRANT ALL ON TABLE pantry.role TO yann;
GRANT SELECT ON TABLE pantry.role TO readonly;
GRANT ALL ON TABLE pantry.role TO dbservice;
GRANT ALL ON TABLE pantry.role TO jungvu;
GRANT ALL ON TABLE pantry.role TO tableauuser;
GRANT ALL ON TABLE pantry.role TO bartender;
GRANT ALL ON TABLE pantry.role TO bytedevs;


--
-- Name: TABLE temp_kiosk; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.temp_kiosk TO muriel;
GRANT ALL ON TABLE pantry.temp_kiosk TO yann;
GRANT ALL ON TABLE pantry.temp_kiosk TO lambdazen;
GRANT ALL ON TABLE pantry.temp_kiosk TO jungvu;
GRANT ALL ON TABLE pantry.temp_kiosk TO tableauuser;
GRANT ALL ON TABLE pantry.temp_kiosk TO bartender;
GRANT ALL ON TABLE pantry.temp_kiosk TO bytedevs;


--
-- Name: TABLE temp_product; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.temp_product TO muriel;
GRANT ALL ON TABLE pantry.temp_product TO yann;
GRANT ALL ON TABLE pantry.temp_product TO lambdazen;
GRANT ALL ON TABLE pantry.temp_product TO jungvu;
GRANT ALL ON TABLE pantry.temp_product TO tableauuser;
GRANT ALL ON TABLE pantry.temp_product TO bartender;
GRANT ALL ON TABLE pantry.temp_product TO bytedevs;


--
-- Name: TABLE temperature_tag_history; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry.temperature_tag_history TO lambdazen;
GRANT ALL ON TABLE pantry.temperature_tag_history TO muriel;
GRANT ALL ON TABLE pantry.temperature_tag_history TO yann;


--
-- Name: TABLE "user"; Type: ACL; Schema: pantry; Owner: erpuser
--

GRANT ALL ON TABLE pantry."user" TO lambdazen;
GRANT ALL ON TABLE pantry."user" TO muriel;
GRANT ALL ON TABLE pantry."user" TO yann;
GRANT ALL ON TABLE pantry."user" TO tableauuser;
GRANT ALL ON TABLE pantry."user" TO bartender;
GRANT ALL ON TABLE pantry."user" TO bytedevs;


--
-- Name: TABLE awsdms_ddl_audit; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.awsdms_ddl_audit TO tableauuser;
GRANT ALL ON TABLE public.awsdms_ddl_audit TO bartender;
GRANT ALL ON TABLE public.awsdms_ddl_audit TO bytedevs;


--
-- Name: SEQUENCE awsdms_ddl_audit_c_key_seq; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON SEQUENCE public.awsdms_ddl_audit_c_key_seq TO tableauuser;
GRANT ALL ON SEQUENCE public.awsdms_ddl_audit_c_key_seq TO bartender;
GRANT ALL ON SEQUENCE public.awsdms_ddl_audit_c_key_seq TO bytedevs;


--
-- Name: TABLE bak_awsdms_apply_exceptions; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.bak_awsdms_apply_exceptions TO yann;
GRANT SELECT ON TABLE public.bak_awsdms_apply_exceptions TO readonly;
GRANT ALL ON TABLE public.bak_awsdms_apply_exceptions TO tableauuser;
GRANT ALL ON TABLE public.bak_awsdms_apply_exceptions TO bartender;
GRANT ALL ON TABLE public.bak_awsdms_apply_exceptions TO bytedevs;


--
-- Name: TABLE bak_awsdms_validation_failures_v1; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.bak_awsdms_validation_failures_v1 TO yann;
GRANT SELECT ON TABLE public.bak_awsdms_validation_failures_v1 TO readonly;
GRANT ALL ON TABLE public.bak_awsdms_validation_failures_v1 TO tableauuser;
GRANT ALL ON TABLE public.bak_awsdms_validation_failures_v1 TO bartender;
GRANT ALL ON TABLE public.bak_awsdms_validation_failures_v1 TO bytedevs;


--
-- Name: TABLE byte_epcssold; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_epcssold TO tableauuser;
GRANT ALL ON TABLE public.byte_epcssold TO bartender;
GRANT ALL ON TABLE public.byte_epcssold TO bytedevs;


--
-- Name: TABLE byte_feedback_weekly; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_feedback_weekly TO tableauuser;
GRANT ALL ON TABLE public.byte_feedback_weekly TO bartender;
GRANT ALL ON TABLE public.byte_feedback_weekly TO bytedevs;


--
-- Name: TABLE byte_kiosks; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_kiosks TO tableauuser;
GRANT ALL ON TABLE public.byte_kiosks TO bartender;
GRANT ALL ON TABLE public.byte_kiosks TO bytedevs;


--
-- Name: TABLE inventory_history; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.inventory_history TO tableauuser;
GRANT ALL ON TABLE public.inventory_history TO bartender;
GRANT ALL ON TABLE public.inventory_history TO bytedevs;


--
-- Name: TABLE byte_inventory_history; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_inventory_history TO tableauuser;
GRANT ALL ON TABLE public.byte_inventory_history TO bartender;
GRANT ALL ON TABLE public.byte_inventory_history TO bytedevs;


--
-- Name: TABLE byte_inventory_history_eod; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_inventory_history_eod TO tableauuser;
GRANT ALL ON TABLE public.byte_inventory_history_eod TO bartender;
GRANT ALL ON TABLE public.byte_inventory_history_eod TO bytedevs;


--
-- Name: TABLE byte_inventory_history_eod_2wks; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.byte_inventory_history_eod_2wks TO tableauuser;
GRANT ALL ON TABLE public.byte_inventory_history_eod_2wks TO bartender;
GRANT ALL ON TABLE public.byte_inventory_history_eod_2wks TO bytedevs;


--
-- Name: TABLE bytecodelog; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.bytecodelog TO yann;
GRANT SELECT ON TABLE public.bytecodelog TO readonly;
GRANT ALL ON TABLE public.bytecodelog TO tableauuser;
GRANT ALL ON TABLE public.bytecodelog TO bartender;
GRANT ALL ON TABLE public.bytecodelog TO bytedevs;


--
-- Name: TABLE history_order_pipeline; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.history_order_pipeline TO yann;
GRANT SELECT ON TABLE public.history_order_pipeline TO readonly;
GRANT ALL ON TABLE public.history_order_pipeline TO tableauuser;
GRANT ALL ON TABLE public.history_order_pipeline TO bartender;
GRANT ALL ON TABLE public.history_order_pipeline TO bytedevs;


--
-- Name: SEQUENCE history_order_pipeline_id_seq; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON SEQUENCE public.history_order_pipeline_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE public.history_order_pipeline_id_seq TO bartender;
GRANT ALL ON SEQUENCE public.history_order_pipeline_id_seq TO bytedevs;


--
-- Name: TABLE kiosk_status; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON TABLE public.kiosk_status TO tableauuser;
GRANT ALL ON TABLE public.kiosk_status TO bartender;
GRANT ALL ON TABLE public.kiosk_status TO bytedevs;


--
-- Name: TABLE product_fact; Type: ACL; Schema: public; Owner: erpuser
--

GRANT SELECT ON TABLE public.product_fact TO yann;
GRANT SELECT ON TABLE public.product_fact TO readonly;
GRANT ALL ON TABLE public.product_fact TO tableauuser;
GRANT ALL ON TABLE public.product_fact TO bartender;
GRANT ALL ON TABLE public.product_fact TO bytedevs;


--
-- Name: SEQUENCE product_fact_id_seq; Type: ACL; Schema: public; Owner: erpuser
--

GRANT ALL ON SEQUENCE public.product_fact_id_seq TO tableauuser;
GRANT ALL ON SEQUENCE public.product_fact_id_seq TO bartender;
GRANT ALL ON SEQUENCE public.product_fact_id_seq TO bytedevs;


--
-- Name: TABLE fact_daily_campus_87; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.fact_daily_campus_87 TO lambdazen;
GRANT ALL ON TABLE test.fact_daily_campus_87 TO bartender;
GRANT ALL ON TABLE test.fact_daily_campus_87 TO bytedevs;


--
-- Name: TABLE fact_daily_kiosk_sku_summary; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.fact_daily_kiosk_sku_summary TO lambdazen;
GRANT ALL ON TABLE test.fact_daily_kiosk_sku_summary TO bytedevs;
GRANT ALL ON TABLE test.fact_daily_kiosk_sku_summary TO bartender;


--
-- Name: TABLE fact_monthly_kiosk_summary; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.fact_monthly_kiosk_summary TO lambdazen;
GRANT ALL ON TABLE test.fact_monthly_kiosk_summary TO bytedevs;
GRANT ALL ON TABLE test.fact_monthly_kiosk_summary TO bartender;


--
-- Name: TABLE kiosk_20190528; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.kiosk_20190528 TO lambdazen;
GRANT ALL ON TABLE test.kiosk_20190528 TO bartender;
GRANT ALL ON TABLE test.kiosk_20190528 TO bytedevs;


--
-- Name: TABLE kiosk_log; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.kiosk_log TO lambdazen;
GRANT ALL ON TABLE test.kiosk_log TO bartender;
GRANT ALL ON TABLE test.kiosk_log TO bytedevs;


--
-- Name: TABLE pick_priority_kiosk; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.pick_priority_kiosk TO lambdazen;
GRANT ALL ON TABLE test.pick_priority_kiosk TO bartender;
GRANT ALL ON TABLE test.pick_priority_kiosk TO bytedevs;


--
-- Name: TABLE remittance_history; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.remittance_history TO lambdazen;
GRANT ALL ON TABLE test.remittance_history TO bytedevs;
GRANT ALL ON TABLE test.remittance_history TO bartender;


--
-- Name: TABLE sync_qa_kiosk_before_2way; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.sync_qa_kiosk_before_2way TO lambdazen;
GRANT ALL ON TABLE test.sync_qa_kiosk_before_2way TO bartender;
GRANT ALL ON TABLE test.sync_qa_kiosk_before_2way TO bytedevs;


--
-- Name: TABLE sync_qa_kiosk_erp; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.sync_qa_kiosk_erp TO lambdazen;
GRANT ALL ON TABLE test.sync_qa_kiosk_erp TO bartender;
GRANT ALL ON TABLE test.sync_qa_kiosk_erp TO bytedevs;


--
-- Name: TABLE sync_qa_kiosk_iotmaster; Type: ACL; Schema: test; Owner: erpuser
--

GRANT ALL ON TABLE test.sync_qa_kiosk_iotmaster TO lambdazen;
GRANT ALL ON TABLE test.sync_qa_kiosk_iotmaster TO bartender;
GRANT ALL ON TABLE test.sync_qa_kiosk_iotmaster TO bytedevs;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: campus_87; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA campus_87 REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA campus_87 GRANT SELECT ON TABLES  TO rc87;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: dw; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON FUNCTIONS  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON FUNCTIONS  TO yann;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON FUNCTIONS  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON FUNCTIONS  TO tableauuser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: dw; Owner: muriel
--

ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA dw REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA dw REVOKE ALL ON FUNCTIONS  FROM muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA dw GRANT ALL ON FUNCTIONS  TO yann;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: dw; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON TABLES  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON TABLES  TO yann;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON TABLES  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA dw GRANT ALL ON TABLES  TO tableauuser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: dw; Owner: muriel
--

ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA dw REVOKE ALL ON TABLES  FROM muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA dw GRANT ALL ON TABLES  TO yann;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: erp; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA erp REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA erp REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA erp GRANT ALL ON FUNCTIONS  TO muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA erp GRANT ALL ON FUNCTIONS  TO yann;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: erp; Owner: muriel
--

ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA erp REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA erp REVOKE ALL ON FUNCTIONS  FROM muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA erp GRANT ALL ON FUNCTIONS  TO yann;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: erp; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA erp REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA erp GRANT ALL ON TABLES  TO muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA erp GRANT ALL ON TABLES  TO yann;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: erp; Owner: muriel
--

ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA erp REVOKE ALL ON TABLES  FROM muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE muriel IN SCHEMA erp GRANT ALL ON TABLES  TO yann;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: inm; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON FUNCTIONS  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON FUNCTIONS  TO muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON FUNCTIONS  TO yann;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON FUNCTIONS  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON FUNCTIONS  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON FUNCTIONS  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: inm; Owner: lambdazen
--

ALTER DEFAULT PRIVILEGES FOR ROLE lambdazen IN SCHEMA inm REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE lambdazen IN SCHEMA inm REVOKE ALL ON FUNCTIONS  FROM lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE lambdazen IN SCHEMA inm GRANT ALL ON FUNCTIONS  TO muriel;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: inm; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON TABLES  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON TABLES  TO muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON TABLES  TO yann;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON TABLES  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON TABLES  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA inm GRANT ALL ON TABLES  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: inm; Owner: lambdazen
--

ALTER DEFAULT PRIVILEGES FOR ROLE lambdazen IN SCHEMA inm REVOKE ALL ON TABLES  FROM lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE lambdazen IN SCHEMA inm GRANT ALL ON TABLES  TO muriel;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: mixalot; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON FUNCTIONS  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON FUNCTIONS  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON FUNCTIONS  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON FUNCTIONS  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: mixalot; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON TABLES  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON TABLES  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON TABLES  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA mixalot GRANT ALL ON TABLES  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pantry; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON FUNCTIONS  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON FUNCTIONS  TO muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON FUNCTIONS  TO yann;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON FUNCTIONS  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON FUNCTIONS  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON FUNCTIONS  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pantry; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON TABLES  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON TABLES  TO muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON TABLES  TO yann;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON TABLES  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON TABLES  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA pantry GRANT ALL ON TABLES  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public GRANT ALL ON FUNCTIONS  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public GRANT ALL ON FUNCTIONS  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public GRANT ALL ON FUNCTIONS  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public GRANT ALL ON TABLES  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public GRANT ALL ON TABLES  TO tableauuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA public GRANT ALL ON TABLES  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: test; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test GRANT ALL ON FUNCTIONS  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test GRANT ALL ON FUNCTIONS  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: test; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test GRANT ALL ON TABLES  TO lambdazen;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test GRANT ALL ON TABLES  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA test GRANT ALL ON TABLES  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: type; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type REVOKE ALL ON FUNCTIONS  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type REVOKE ALL ON FUNCTIONS  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type GRANT ALL ON FUNCTIONS  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type GRANT ALL ON FUNCTIONS  TO bartender;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: type; Owner: erpuser
--

ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type REVOKE ALL ON TABLES  FROM erpuser;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type GRANT ALL ON TABLES  TO muriel;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type GRANT ALL ON TABLES  TO bytedevs;
ALTER DEFAULT PRIVILEGES FOR ROLE erpuser IN SCHEMA type GRANT ALL ON TABLES  TO bartender;


--
-- Name: awsdms_intercept_ddl; Type: EVENT TRIGGER; Schema: -; Owner: rdsadmin
--

CREATE EVENT TRIGGER awsdms_intercept_ddl ON ddl_command_end
   EXECUTE FUNCTION public.awsdms_intercept_ddl();


ALTER EVENT TRIGGER awsdms_intercept_ddl OWNER TO rdsadmin;

--
-- PostgreSQL database dump complete
--

