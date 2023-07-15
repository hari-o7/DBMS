CREATE DATABASE db_practice

USE db_practice;

CREATE TABLE tbl_employee(
    employeeId INT,
    name VARCHAR(40),
    dept VARCHAR(40),
    salary INT
);

INSERT INTO tbl_employee(employeeId, name, dept, salary)
VALUES 
(1,'Ram','HR',10000),
(2,'Amrit','MRKT',20000),
(3,'Ravi','HR',30000),
(4,'Nitin','MRKT',40000),
(5,'Varun','IT',50000);

SELECT *
FROM tbl_employee;

--a. find max salary from employee table
SELECT MAX(salary) AS max_salary
FROM tbl_employee;

--b. select name of employee with max salary
SELECT name
FROM tbl_employee
WHERE salary=(
    SELECT MAX(salary)
    FROM tbl_employee
);

--c. select second highest salary

SELECT MAX(salary) AS second_max_salary
FROM tbl_employee
WHERE salary!=(             --this subquery gives 50000
    SELECT MAX(salary)
FROM tbl_employee);

--d. name of employee with second max salary
SELECT name
FROM tbl_employee
WHERE salary IN( --this sub query gives 40k
SELECT MAX(salary) AS second_max_salary
FROM tbl_employee
WHERE salary!=(             --this subquery gives 50000
    SELECT MAX(salary)
FROM tbl_employee));


--e. display dept name and no of employess working in those deprt

SELECT dept, COUNT(*) AS noOfEmployees
FROM tbl_employee
GROUP BY dept
ORDER BY noOfEmployees DESC;

SELECT dept
FROM tbl_employee
GROUP BY dept;

SELECT *
FROM tbl_employee

--f. display all dept names who have less than 2 employees

SELECT dept
FROM tbl_employee
GROUP BY dept
HAVING COUNT(dept)<2


--g. display name of employee who works in a dept having employees<2

SELECT name
FROM tbl_employee
WHERE dept IN (
    SELECT dept
FROM tbl_employee
GROUP BY dept
HAVING COUNT(dept)<2
)

--h. highest salary dept wise and name of employee having highest salary



SELECT name,dept, salary AS max_salary
--SELECT *
FROM tbl_employee
WHERE salary IN (
    SELECT  MAX(salary) AS max_salary
    FROM tbl_employee
    GROUP BY dept
    )