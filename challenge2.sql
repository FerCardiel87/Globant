use challengers1


SELECT d.department, j.job, e.department_id as 'Q1', COUNT(*) as 'Q2',e.job_id as 'Q3', DATEPART(quarter,e.datetime) AS 'Q4'
FROM hired_employees e,
     departments d,
	 jobs j
WHERE e.id = d.id and e.id = j.id and datetime > '2021'
GROUP BY d.department, j.job, e.department_id, e.job_id, DATEPART(quarter,e.datetime)
HAVING COUNT(*) > 1/3
ORDER BY d.department, j.job, e.department_id, e.job_id, DATEPART(quarter,e.datetime), COUNT(*) ASC




SELECT d.department, COUNT(e.id) as 'hired'
FROM departments d
JOIN hired_employees e
ON e.department_id=d.id
WHERE  datetime > '2021'
GROUP BY d.department
ORDER BY d.department DESC



