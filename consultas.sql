USE challengers1
select * from departments
select * from hired_employees
select * from jobs

exec sp_columns departments
exec sp_columns hired_employees
exec sp_columns jobs


SELECT * FROM hired_employees FOR JSON AUTO;

SELECT id, name AS "hired_employees.name", datetime AS date
FROM hired_employees
FOR JSON PATH;

SELECT * FROM departments FOR JSON AUTO;

SELECT id, department AS "departments.department"
FROM departments
FOR JSON PATH;

SELECT * FROM jobs FOR JSON AUTO;

SELECT id, job AS "job.job"
FROM jobs
FOR JSON PATH;

BACKUP DATABASE challengers1
TO DISK = 'E:\sql\globant_old\challengers1.bak';

--Cambio de ruta C: a local E:
ALTER DATABASE challengers1
	MODIFY FILE (NAME = challengers1,
				 FILENAME = 'E:\sql\globant\challengers1.mdf');

GO

ALTER DATABASE challengers1
	MODIFY FILE(NAME = challengers1_log,
				FILENAME = 'E:\sql\globant\challengers1_log.ldf');

GO


ALTER DATABASE challengers1 SET OFFLINE;  
GO

ALTER DATABASE challengers1 SET ONLINE;

GO