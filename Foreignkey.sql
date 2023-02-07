select * from hired_employees

select * from departments

select * from jobs

exec sp_columns hired_employees

exec sp_columns departments

exec sp_columns jobs

alter table hired_employees
add primary key(id);

alter table hired_employees
ADD FOREIGN KEY (department_id) REFERENCES departments(id)

alter table hired_employees
ADD FOREIGN KEY (job_id) REFERENCES jobs(id)