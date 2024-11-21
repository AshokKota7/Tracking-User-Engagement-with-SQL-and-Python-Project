select * from student_purchases;
select 
    purchase_id,
    student_id,
    plan_id,
    date_purchased as date_start,
    case
       when plan_id = 0 then DATE_ADD(date_purchased, INTERVAL 1 MONTH)
       when plan_id = 1 then DATE_ADD(date_purchased, INTERVAL 3 MONTH)
       when plan_id = 2 then DATE_ADD(date_purchased, INTERVAL 12 MONTH)
       WHEN plan_id = 3 THEN NULL
       else date_purchased
	end as date_end,
    date_refunded
from student_purchases;
       
SELECT 
    purchase_id,
    student_id,
    plan_id,
    date_purchased as date_start,
    -- Recalculate the date_end using IF statements
    IF(date_refunded IS NOT NULL, date_refunded, 
        CASE 
            WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- Monthly plan
            WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- Quarterly plan
            WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH) -- Annual plan
            WHEN plan_id = 3 THEN NULL  -- Lifetime plan (no end date)
            ELSE NULL  -- Default case for any other plan_id values
        END) AS date_end
FROM (
    -- Subquery to calculate date_end based on plan_id
    SELECT 
        purchase_id,
        student_id,
        plan_id,
        date_purchased,
        date_refunded
    FROM student_purchases
) a;


SELECT 
    purchase_id,
    student_id,
    plan_id,
    date_start,
    date_end,
    -- paid_q2_2021: Check if the subscription was active in Q2 2021
    CASE 
        WHEN date_end < '2021-04-01' OR date_start > '2021-06-30' THEN 0  -- No active subscription in Q2 2021
        ELSE 1  -- Active subscription in Q2 2021
    END AS paid_q2_2021,
    
    -- paid_q2_2022: Check if the subscription was active in Q2 2022
    CASE 
        WHEN date_end < '2022-04-01' OR date_start > '2022-06-30' THEN 0  -- No active subscription in Q2 2022
        ELSE 1  -- Active subscription in Q2 2022
    END AS paid_q2_2022
FROM (
    -- Sub-query created in the task "II. Re-Calculating a Subscription's End Date"
    SELECT 
        purchase_id,
        student_id,
        plan_id,
        date_purchased AS date_start,
        IF(date_refunded IS NOT NULL, date_refunded, 
            CASE 
                WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- Monthly plan
                WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- Quarterly plan
                WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH) -- Annual plan
                WHEN plan_id = 3 THEN NULL  -- Lifetime plan (no end date)
                ELSE NULL  -- Default case for any other plan_id values
            END) AS date_end
    FROM student_purchases
) AS b;

      


DROP VIEW IF EXISTS purchases_info;

CREATE VIEW purchases_info AS
SELECT 
    purchase_id,
    student_id,
    plan_id,
    date_purchased AS date_start,
    -- Recalculate the date_end directly in the SELECT statement
    IF(date_refunded IS NOT NULL, date_refunded, 
        CASE 
            WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- Monthly plan
            WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- Quarterly plan
            WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH) -- Annual plan
            WHEN plan_id = 3 THEN NULL  -- Lifetime plan (no end date)
            ELSE NULL  -- Default case for any other plan_id values
        END) AS date_end,
    
    -- Calculate paid_q2_2021 (active in Q2 2021) using the same logic for date_end
    CASE 
        WHEN IF(date_refunded IS NOT NULL, date_refunded, 
            CASE 
                WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- Monthly plan
                WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- Quarterly plan
                WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH) -- Annual plan
                WHEN plan_id = 3 THEN NULL  -- Lifetime plan (no end date)
                ELSE NULL  -- Default case for any other plan_id values
            END) < '2021-04-01' OR date_purchased > '2021-06-30' THEN 0  -- No active subscription in Q2 2021
        ELSE 1  -- Active subscription in Q2 2021
    END AS paid_q2_2021,

    -- Calculate paid_q2_2022 (active in Q2 2022) using the same logic for date_end
    CASE 
        WHEN IF(date_refunded IS NOT NULL, date_refunded, 
            CASE 
                WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- Monthly plan
                WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- Quarterly plan
                WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH) -- Annual plan
                WHEN plan_id = 3 THEN NULL  -- Lifetime plan (no end date)
                ELSE NULL  -- Default case for any other plan_id values
            END) < '2022-04-01' OR date_purchased > '2022-06-30' THEN 0  -- No active subscription in Q2 2022
        ELSE 1  -- Active subscription in Q2 2022
    END AS paid_q2_2022
FROM (
    SELECT 
        purchase_id,
        student_id,
        plan_id,
        date_purchased,
        date_refunded
    FROM student_purchases
) AS b;
SHOW FULL TABLES WHERE Table_type = 'VIEW';
