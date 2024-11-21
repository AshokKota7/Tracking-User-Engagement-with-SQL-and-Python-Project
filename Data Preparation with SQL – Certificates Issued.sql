Count the Number of Certificates Issued by Each Student--

select student_id, count(*) as certificates_issued from student_certificates
group by student_id;

Calculate Minutes Watched and Certificates Issued for Students (Left Join)--

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
