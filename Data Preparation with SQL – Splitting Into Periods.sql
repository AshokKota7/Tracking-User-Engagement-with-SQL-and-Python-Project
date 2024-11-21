select * from student_video_watched;
-- For Q2 2021
SELECT 
    student_id,
    ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
FROM 
    student_video_watched
WHERE 
    date_watched BETWEEN '2021-04-01' AND '2021-06-30'  -- Filter for Q2 2021
GROUP BY 
    student_id;

-- Check the row count for Q2 2021
SELECT COUNT(DISTINCT student_id) AS total_students_q2_2021
FROM 
    student_video_watched
WHERE 
    date_watched BETWEEN '2021-04-01' AND '2021-06-30';

-- For Q2 2022
SELECT 
    student_id,
    ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
FROM 
    student_video_watched
WHERE 
    date_watched BETWEEN '2022-04-01' AND '2022-06-30'  -- Filter for Q2 2022
GROUP BY 
    student_id;

-- Check the row count for Q2 2022
SELECT COUNT(DISTINCT student_id) AS total_students_q2_2022
FROM 
    student_video_watched
WHERE 
    date_watched BETWEEN '2022-04-01' AND '2022-06-30';

SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(i.paid_q2_2021 = 1 OR i.paid_q2_2022 = 1, 1, 0) AS paid_in_q2
FROM 
    (
        -- Sub-query from the previous task to calculate total minutes watched
        SELECT 
            student_id,
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
        FROM 
            student_video_watched
        WHERE 
            (date_watched BETWEEN '2021-04-01' AND '2021-06-30' OR 
             date_watched BETWEEN '2022-04-01' AND '2022-06-30')
        GROUP BY student_id
    ) a
LEFT JOIN purchases_info i ON a.student_id = i.student_id;


SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(i.paid_q2_2021 = 1, 1, 0) AS paid_in_q2
FROM 
    (
        -- Sub-query for Q2 2021
        SELECT 
            student_id,
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
        FROM 
            student_video_watched
        WHERE 
            date_watched BETWEEN '2021-04-01' AND '2021-06-30'
        GROUP BY student_id
    ) a
LEFT JOIN purchases_info i ON a.student_id = i.student_id
HAVING paid_in_q2 = 0;


SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(i.paid_q2_2022 = 1, 1, 0) AS paid_in_q2
FROM 
    (
        -- Sub-query for Q2 2022
        SELECT 
            student_id,
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
        FROM 
            student_video_watched
        WHERE 
            date_watched BETWEEN '2022-04-01' AND '2022-06-30'
        GROUP BY student_id
    ) a
LEFT JOIN purchases_info i ON a.student_id = i.student_id
HAVING paid_in_q2 = 0;

SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(i.paid_q2_2021 = 1, 1, 0) AS paid_in_q2
FROM 
    (
        -- Sub-query for Q2 2021
        SELECT 
            student_id,
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
        FROM 
            student_video_watched
        WHERE 
            date_watched BETWEEN '2021-04-01' AND '2021-06-30'
        GROUP BY student_id
    ) a
LEFT JOIN purchases_info i ON a.student_id = i.student_id
HAVING paid_in_q2 = 1;


SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(i.paid_q2_2022 = 1, 1, 0) AS paid_in_q2
FROM 
    (
        -- Sub-query for Q2 2022
        SELECT 
            student_id,
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
        FROM 
            student_video_watched
        WHERE 
            date_watched BETWEEN '2022-04-01' AND '2022-06-30'
        GROUP BY student_id
    ) a
LEFT JOIN purchases_info i ON a.student_id = i.student_id
HAVING paid_in_q2 = 1;


