create database challenger
use challenger

CREATE TABLE hired_employees(
id_employee INT PRIMARY KEY NOT NULL IDENTITY(1,1),
name NVARCHAR(30),
datetime NVARCHAR(30),
department_id INT,
job_ind INT,
);

CREATE TABLE departments(
Id_department INT PRIMARY KEY NOT NULL IDENTITY(1,1),
department NVARCHAR(30),
id_employee INT CONSTRAINT FK_idemployee FOREIGN KEY (id_employee)REFERENCES hired_employees(id_employee),
);

CREATE TABLE job(
id_job INT PRIMARY KEY NOT NULL IDENTITY(1,1),
job NVARCHAR(30),
id_department INT CONSTRAINT FK_iddepartment FOREIGN KEY(id_department)REFERENCES departments(id_department)

);

