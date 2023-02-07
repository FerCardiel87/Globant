# Globant
Challenge #1

Move historic data from files in CSV format to the new database.
2. Create a Rest API service to receive new data. This service must have:
2.1. Each new transaction must fit the data dictionary rules.
2.2. Be able to insert batch transactions (1 up to 1000 rows) with one request.
2.3. Receive the data for each table in the same service.
2.4. Keep in mind the data rules for each table.
3. Create a feature to backup for each table and save it in the file system in AVRO format.
4. Create a feature to restore a certain table with its backup.

Challenge #2
You need to explore the data that was inserted in the first challenge. The stakeholders ask for
some specific metrics they need. You should create an end-point for each requirement.

Requirements
● Number of employees hired for each job and department in 2021 divided by quarter. The
table must be ordered alphabetically by department and job.

● List of ids, name and number of employees hired of each department that hired more
employees than the mean of employees hired in 2021 for all the departments, ordered
by the number of employees hired (descending).

Not mandatory, but taken into account:
● Create a visual report for each requirement using your favorite tool


[View Report](https://app.powerbi.com/groups/me/reports/474d7f35-6166-4b82-9485-ccb6b90950b7/ReportSection)



