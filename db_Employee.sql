CREATE DATABASE db_Employee;

USE db_Employee;



CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );


CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );

CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );

CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    );

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'John Smith',
        '123 Main St',
        'New York'
    );

INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );

    INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'John Smith',
        'First Bank  Corporation',
        500000
    );

INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );

INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );

INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    ('John Smith', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe');

SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Company;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;

-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
AND company_name = 'First Bank Corporation';

UPDATE tbl_Works
SET company_name='First Bank Corporation'
WHERE employee_name='John Smith';


ALTER TABLE tbl_Works
ADD FOREIGN KEY (company_name)
 REFERENCES tbl_Company(company_name);

 






--question no. 2
--(a)  Find  the  names  of  all  employees
--     who  work  for  First  Bank  Corporation.

SELECT employee_name 
FROM tbl_Works
WHERE company_name = 'First Bank Corporation' ;


--(b)Find  the  names  and  cities  of  residence of  all
--  employees  who  work  for  First  Bank  Corporation.

SELECT employee_name, city
FROM tbl_Employee
WHERE employee_name IN (
    SELECT employee_name
    FROM tbl_Works
    WHERE company_name='First Bank Corporation'
);

--(c)    Find  the  names,  street  addresses,  and  cities
--       of  residence  of  all  employees  who  work  for 
--       First  Bank  Corporation  and  earn  more  than  $10,000.

SELECT employee_name, street, city
FROM tbl_Employee
WHERE employee_name IN (
    SELECT employee_name
    FROM tbl_Works
    WHERE company_name ='First Bank Corporation' AND salary>='10000'
);

--(d)    Find   all   employees   in   the   database 
--       who   live   in   the   same   cities   as  
--       the   companies   for which  they  work.
--select employees where employee city= company city

SELECT *
FROM tbl_Employee e
JOIN tbl_Company c
ON e.city= c.city;

SELECT employee_name, company_name
FROM tbl_Works;


--(f )    Find  all  employees  in  the  database  who  
--        do  not  work  for  First  Bank  Corporation.

SELECT employee_name
FROM tbl_Works
WHERE company_name !='First Bank Corporation';


--(g)   Find  all  employees  in  the  database  who 
--      earn  more  than  each  employee  of  Small  Bank Corporation.

SELECT employee_name
FROM tbl_Works
WHERE salary>(
    SELECT MAX(salary)
FROM tbl_Works
WHERE company_name='Small Bank Corporation'
);

--(h)    Assume  that  the  companies  may  be  located  in  several  cities. 
 --      Find  all  companies  located in  every  city  in  which  Small  Bank  Corporation  is  located.

SELECT company_name
from tbl_Company
WHERE city IN (
     SELECT city 
    FROM tbl_Company
    WHERE company_name='Small Bank Corporation'
);


--(i)    Find   all   employees   who   earn   more   than 
--       the   average   salary   of   all   employees   of   their company.

SELECT employee_name
FROM tbl_Works
WHERE salary>(
    SELECT AVG(salary) 
    FROM tbl_Works
    GROUP BY company_name
);


--(j)    Find  the  company  that  has  the  most  employees.




SELECT company_name, COUNT(employee_name) AS noOfEmployees
FROM tbl_Works
GROUP BY company_name
ORDER BY COUNT(employee_name) DESC


/*select company_name
from tbl_Works
where (
    
    SELECT COUNT(employee_name) AS noOfEmployees
FROM tbl_Works
GROUP BY company_name
) =*/


--(k)    Find  the  company  that  has  the  smallest  payroll.

SELECT company_name
FROM tbl_Works
GROUP BY company_name
HAVING (select sum(salary)
    from tbl_Works
    group by company_name) = MIN(salary) 




--(l)    Find    those   companies   whose   employees   earn   a   higher   salary,
-- on   average,    than    the average  salary  at  First  Bank  Corporation.

SELECT company_name
from tbl_Works
GROUP BY company_name
HAVING AVG(salary)>(
    SELECT AVG(salary) AS avg_salary
FROM tbl_Works
WHERE company_name='First Bank Corporation'
);


--Question no. 3

SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Company;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;


--(a)   Modify  the  database  so  that  Jones  now  lives  in  Newtown.
UPDATE tbl_Employee
SET city = 'Newtown'
WHERE employee_name='John Smith';

SELECT * FROM tbl_Employee;


--(b)  Give  all  employees  of  First  Bank  Corporation  a  10  percent  raise.
UPDATE tbl_Works 
SET salary=salary*1.1
WHERE company_name='First Bank Corporation';

--(c)  Give  all  managers  of  First  Bank  Corporation  a  10  percent  raise.

UPDATE tbl_Works
SET salary=salary*1.1
where employee_name IN(
    SELECT manager_name
    FROM tbl_Manages
    WHERE manager_name IN (
        SELECT employee_name
        FROM tbl_Works
        WHERE company_name='First Bank Corporation')
)


--(d)    Give   all  managers  of   First  Bank  Corporation  a  10  percent   raise
--      unless   the   salary  becomes  greater  than  $100,000; 
--      in  such  cases,  give  only  a  3  percent  raise.


--e.    Delete  all  tuples  in  the  works   relation
--      for  employees  of  Small  Bank  Corporation.





