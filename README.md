# Globant
# Challenge #1

# Move historic data from files in CSV format to the new database.

# 2. Create a Rest API service to receive new data. This service must have:

# 2.1. Each new transaction must fit the data dictionary rules.
  ```TSQL       
           USE challengers1
            select * from departments
            select * from hired_employees
            select * from jobs
            exec sp_columns departments
            exec sp_columns hired_employees
            exec sp_columns jobs
```
# 2.2. Be able to insert batch transactions (1 up to 1000 rows) with one request.

![image](https://user-images.githubusercontent.com/60296248/217196041-33f3cb22-6b00-452f-bc34-40aa75558a05.png)

# 2.3. Receive the data for each table in the same service.

![image](https://user-images.githubusercontent.com/60296248/217201213-5697c211-3b39-4573-9ba2-dc66aa7579c6.png)


# 2.4. Keep in mind the data rules for each table.
```TSQL 
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
```

#  3. Create a feature to backup for each table and 

```TSQL  
        BACKUP DATABASE your_database TO DISK = 'full.bak' 
```



![image](https://user-images.githubusercontent.com/60296248/217197313-27b835ca-2233-434f-9f99-f251ae1a8972.png)
      
      
      
![image](https://user-images.githubusercontent.com/60296248/217197466-c8ce7bcd-47c9-492a-96ad-c8f0c489677e.png)

# save it in the file system in AVRO format.

```TSQL  

        SELECT id, name AS "hired_employees.name", datetime AS date
        FROM hired_employees
        FOR JSON PATH;
        
        SELECT * FROM hired_employeed FOR JSON AUTO;
        
        [{"id":1,"name":"Harold Vogt","datetime":"2021-11-07T02:48:42Z","department_id":2,"job_id":96},{"id":2,"name":"Ty Hofer","datetime":"2021-05-                 
        30T05:43:46Z","department_id":8},{"id":3,"name":"Lyman Hadye","datetime":"2021-09-01T23:27:38Z","department_id":5,"job_id":52},{"id":4,"name":"Lotti 
        Crowthe","datetime":"2021-10-01T13:04:21Z","department_id":12,"job_id":71},{"id":5,"name":"Gretna Lording","datetime":"2021-10-1
        0T22:22:17Z","department_id":6,"job_id":80},{"id":6,"name":"Marlow Antecki","datetime":"2021-04-23T23:45:42Z","department_id":6,"job_id":95},
        {"id":7,"name":"Joan Rillett","datetime":"2021-10-10T01:33:31Z","department_id":9,"job_id":78},{"id":8,"name":"Ulrick Nucciotti","datetime":"2021-07-
        24T01:28:40Z","department_id":8,"job_id":169}, ........ ]
        
        
        SELECT id, department AS "departments.department"
        FROM departments
        FOR JSON PATH;
        
        SELECT * FROM departments FOR JSON AUTO;
        Output:
        [{"id":1,"department":"Product Management"},{"id":2,"department":"Sales"},{"id":3,"department":"Research and Development"},{"id":4,"department":"Business               Development"},{"id":5,"department":"Engineering"},{"id":6,"department":"Human Resources"},{"id":7,"department":"Services"},{"id":8,"department":"Support"},             {"id":9,"department":"Marketing"},{"id":10,"department":"Training"},{"id":11,"department":"Legal"},{"id":12,"department":"Accounting"}]

        SELECT id, job AS "job.job"
        FROM jobs
        FOR JSON PATH;
        
        SELECT * FROM jobs FOR JSON AUTO;
        
        [{"id":1,"job":"Marketing Assistant"},{"id":2,"job":"VP Sales"},{"id":3,"job":"Biostatistician IV"},{"id":4,"job":"Account Representative II"},
        {"id":5,"job":"VP Marketing"},{"id":6,"job":"Environmental Specialist"},{"id":7,"job":"Software Consultant"},{"id":8,"job":"Office Assistant III"},
        {"id":9,"job":"Information Systems Manager"},{"id":10,"job":"Desktop Support Technician"},{"id":11,"job":"Financial Advisor"},.........]
```
      

      
# 5. Create a feature to restore a certain table with its backup.


![image](https://user-images.githubusercontent.com/60296248/217202013-3b3ebaef-16a0-43d3-a743-a5c4fa53f538.png)

![image](https://user-images.githubusercontent.com/60296248/217202953-61270c4c-83fe-47d2-b1fb-13078c25601a.png)

![image](https://user-images.githubusercontent.com/60296248/217203503-8575cbd2-9123-48fd-837a-f55ac8965f71.png)





# Challenge #2
You need to explore the data that was inserted in the first challenge. The stakeholders ask for
some specific metrics they need. You should create an end-point for each requirement.

Requirements

● Number of employees hired for each job and department in 2021 divided by quarter. The
table must be ordered alphabetically by department and job.

```TSQL  
        SELECT d.department, j.job, e.department_id as 'Q1', COUNT(*) as 'Q2',e.job_id as 'Q3', DATEPART(quarter,e.datetime) AS 'Q4'
        FROM hired_employees e,
             departments d,
           jobs j
        WHERE e.id = d.id and e.id = j.id and datetime > '2021'
        GROUP BY d.department, j.job, e.department_id, e.job_id, DATEPART(quarter,e.datetime)
        HAVING COUNT(*) > 1/3
        ORDER BY d.department, j.job, e.department_id, e.job_id, DATEPART(quarter,e.datetime), COUNT(*) ASC
``` 

output: 

![image](https://user-images.githubusercontent.com/60296248/217205752-65b2fa38-0ddc-4cd0-8309-69b741d97d05.png)


● List of ids, name and number of employees hired of each department that hired more
employees than the mean of employees hired in 2021 for all the departments, ordered
by the number of employees hired (descending).

```TSQL
        SELECT d.department, COUNT(e.id) as 'hired'
        FROM departments d
        JOIN hired_employees e
        ON e.department_id=d.id
        WHERE  datetime > '2021'
        GROUP BY d.department
        ORDER BY d.department DESC
```
output:

![image](https://user-images.githubusercontent.com/60296248/217205831-34d388d7-a366-44ce-98ae-f665881a453e.png)



Not mandatory, but taken into account:

● Create a visual report for each requirement using your favorite tool


![image](https://user-images.githubusercontent.com/60296248/217193669-0c4ddb35-bbc9-4695-b629-c19c0c67f2cf.png)


Visual report Power Bi -> [View Report](https://app.powerbi.com/groups/me/reports/474d7f35-6166-4b82-9485-ccb6b90950b7/ReportSection)



