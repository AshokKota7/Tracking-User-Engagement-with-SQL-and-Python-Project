select * from student_certificates;
select student_id, count(*) as certificates_issued from student_certificates
group by student_id;

select 
    a.student_id,
    round(sum(seconds_watched)/60,2) as minutes_watched,
    a.certificates_issued
from (
       select 
		   student_id, 
           count(*) as certificates_issued 
	   from student_certificates
       group by student_id
	   ) a
join student_video_watched w on w.student_id = a.student_id
group by a.student_id;


SELECT 
    a.student_id,
    a.certificates_issued,
    ROUND(IFNULL(SUM(w.seconds_watched) / 60, 0), 2) AS minutes_watched
FROM 
    (
        SELECT 
            student_id, 
            COUNT(*) AS certificates_issued 
        FROM 
            student_certificates
        GROUP BY 
            student_id
    ) a
LEFT JOIN 
    student_video_watched w 
ON 
    a.student_id = w.student_id
GROUP BY 
    a.student_id, 
    a.certificates_issued;
