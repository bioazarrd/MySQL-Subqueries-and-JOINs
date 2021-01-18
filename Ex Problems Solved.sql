use `soft_uni`;
/*Problem 1*
01.	Employee Address
Write a query that selects:
employee_id
job_title
address_id
address_text
Return the first 5 rows sorted by address_id in ascending order*/
select
	e.`employee_id`,
	e.`job_title`,
	a.`address_id`,
	a.`address_text`
from 
	`employees` as e
join `addresses` as a on (e.`address_id` = a.`address_id`)
order by `address_id`
limit 5;



/*Problem 2*
02.	Addresses with Towns
Write a query that selects:
first_name
last_name
town
address_text
Sorted by first_name in ascending order then by last_name. 
Select first 5 employees.*/
select
	e.`first_name`,
	e.`last_name`,
	t.`name` as 'town',
	a.`address_text`
from `employees` as e
join `addresses` as a on (a.`address_id` = e.`address_id`)
join `towns` as t on (t.`town_id` = a.`town_id`)
order by e.`first_name`, e.`last_name`
limit 5;



/*Problem 3*
03.	Sales Employee
Write a query that selects:
employee_id
first_name
last_name
department_name
Sorted by employee_id in descending order. 
Select only employees from “Sales” department.*/
select
	e.`employee_id`,
    e.`first_name`,
    e.`last_name`,
    d.`name`
from 
	`employees` as e
join `departments` as d on (d.`department_id` = e.`department_id`)
where d.`name` like 'Sales'
order by e.`employee_id` desc;




/*Problem 4*
04.	Employee Departments
Write a query that selects:
employee_id
first_name
salary
department_name
Filter only employees with salary higher than 15000. 
Return the first 5 rows sorted by department_id in descending order.*/
select
	e.`employee_id`,
	e.`first_name`,
	e.`salary`,
	d.`name`
from `employees` as e 
join `departments` as d on (d.`department_id` = e.`department_id`) 
where e.`salary` > 15000
order by d.`department_id` desc
limit 5;


/*Problem 5*
Employees Without Project
-- Write a query that selects:
-- * employee_id
-- * first_name
-- Filter only employees without a project. 
-- Return the first 3 rows sorted by employee_id in descending order.*/
select
	e.`employee_id`,
    e.`first_name`
from
	`employees` as e
left join `employees_projects` as p on (e.`employee_id` = p.`employee_id`)
where p.`project_id` is null
order by e.`employee_id` desc
limit 3;


/*Problem 6
Employees Hired After
-- Write a query that selects:
-- * first_name
-- * last_name
-- * hire_date
-- * dept_name
-- Filter only employees with hired after 1/1/1999 and
-- are from either "Sales" or "Finance" departments. 
-- Sorted by hire_date (ascending).*/
select
	e.`first_name`,
    e.`last_name`,
    e.`hire_date`,
    d.`name` as 'dept_name'
from `employees` as e 
join `departments` as d on (d.`department_id` = e.`department_id`)
where DATE(e.`hire_date`) > '1999/1/1'
and
d.`name` in ('Sales','Finance')
order by e.`hire_date`;



/*Problem 7
Employees with Project
-- Write a query that selects:
-- * employee_id
-- * first_name
-- * project_name
-- Filter only employees with a project which has started
-- after 13.08.2002 and it is still ongoing (no end date). 
-- Return the first 5 rows sorted by first_name then by 
-- project_name both in ascending order.*/
select
	e.`employee_id`,
	e.`first_name`,
    p.`name` as 'project_name'
from `employees` as e
join `employees_projects` as ep on (ep.`employee_id` = e.`employee_id`)
join `projects` as p on (p.`project_id` = ep.`project_id`)
where date(p.`start_date`) > '2002/1/1' and p.`end_date` is null
order by e.`first_name`, p.`name`
limit 5;


/*Problem 8
Employee 24
-- Write a query that selects:
-- * employee_id
-- * first_name
-- * project_name
-- Filter all the projects of employees with id 24. 
-- If the project has started after 2005 inclusively the return value should be NULL. 
-- Sort result by project_name alphabetically.*/
SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) >= 2005,
        NULL,
        p.name) AS 'project_name'
FROM
    `employees` AS e
        JOIN
    `employees_projects` AS ep ON ep.employee_id = e.employee_id
        JOIN
    `projects` AS p ON ep.project_id = p.project_id
WHERE
    e.employee_id = 24
ORDER BY p.name;



/*Problem 9
Employee Manager
-- Write a query that selects:
-- * employee_id
-- * first_name
-- * manager_id
-- * manager_name
-- Filter all employees with a manager who has id equals to 3 or 7. 
-- Return the all rows sorted by employee first_name in ascending order.*/
SELECT 
    e.employee_id, e.first_name, e.manager_id, m.first_name
FROM
    `employees` AS e
        JOIN
    `employees` AS m ON e.manager_id = m.employee_id
WHERE
    e.manager_id IN (3 , 7)
ORDER BY e.first_name;



/*Problem 10
Employee Summary
-- Write a query that selects:
-- * employee_id
-- * employee_name
-- * manager_name
-- * department_name
-- Show first 5 employees (only for employees who has a manager) with their managers 
-- and the departments which they are in (show the departments of the employees). 
-- Order by employee_id.*/
SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name) AS 'employee_name',
    CONCAT_WS(' ', m.first_name, m.last_name) AS 'manager_name',
    d.name AS 'department_name'
FROM
    `employees` AS e
        JOIN
    `employees` AS m ON e.manager_id = m.employee_id
        JOIN
    `departments` AS d ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;



/*Problem 11
Min Average Salary
-- Write a query that return the value of the lowest average salary of all departments.
-- * min_average_salary*/
SELECT 
    AVG(e.salary) AS 'min_average_salary'
FROM
    `employees` AS e
GROUP BY e.department_id
ORDER BY `min_average_salary`
LIMIT 1;



use `geography`;
/*Problem 12
Highest Peaks in Bulgaria
-- Write a query that selects:
-- * country_code	
-- * mountain_range
-- * peak_name
-- * elevation
-- Filter all peaks in Bulgaria with elevation over 2835. 
-- Return the all rows sorted by elevation in descending order.*/
SELECT 
    c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    `countries` AS c
        JOIN
    `mountains_countries` AS mc ON c.country_code = mc.country_code
        JOIN
    `mountains` AS m ON m.id = mc.mountain_id
        JOIN
    `peaks` AS p ON p.mountain_id = mc.mountain_id
WHERE
    c.country_name = 'Bulgaria'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;



/*Problem 13
Count Mountain Ranges
-- Write a query that selects:
-- * country_code
-- * mountain_range
-- Filter the count of the mountain ranges in the United States, Russia and Bulgaria. 
-- Sort result by mountain_range count  in decreasing order.*/
SELECT 
    c.country_code, COUNT(mc.mountain_id) AS 'mountain_range'
FROM
    `countries` AS c
        JOIN
    `mountains_countries` AS mc ON c.country_code = mc.country_code
WHERE
    c.country_name IN ('United States' , 'Russia', 'Bulgaria')
GROUP BY c.country_code
ORDER BY `mountain_range` DESC;




/*Problem 14
Countries with Rivers
-- Write a query that selects:
-- * country_name
-- * river_name
-- Find the first 5 countries with or without rivers in Africa. 
-- Sort them by country_name in ascending order.*/
SELECT 
    c.country_name, r.river_name
FROM
    `countries` AS c
        LEFT JOIN
    `countries_rivers` AS cr ON c.country_code = cr.country_code
        LEFT JOIN
    `rivers` AS r ON r.id = cr.river_id
        JOIN
    `continents` AS cn ON cn.continent_code = c.continent_code
WHERE
    cn.continent_name = 'Africa'
ORDER BY c.country_name
LIMIT 5;



/*Problem 15
Continents and Currencies
-- Write a query that selects:
-- * continent_code
-- * currency_code
-- * currency_usage
-- Find all continents and their most used currency. 
-- Filter any currency that is used in only one country. 
-- Sort your results by continent_code and currency_code.*/
SELECT 
    c.continent_code,
    c.currency_code,
    COUNT(*) AS 'currency_usage'
FROM
    `countries` AS c
GROUP BY c.continent_code , c.currency_code
HAVING `currency_usage` > 1
    AND `currency_usage` = (SELECT 
        COUNT(*) AS cn
    FROM
        `countries` AS c2
    WHERE
        c2.continent_code = c.continent_code
    GROUP BY c2.currency_code
    ORDER BY cn DESC
    LIMIT 1)
ORDER BY c.continent_code , c.continent_code;


/*Problem 16
Countries without any Mountains
-- Find all the count of all countries which don’t have a mountain.*/
select
	count(*) as 'country_count'
from 
	`countries` as c
left join `mountains_countries` as mc on (mc.`country_code` = c.`country_code`)
where mc.`country_code` is null;


/*Problem 17
Highest Peak and Longest River by Country
-- For each country, find the elevation of the highest peak and the length 
-- of the longest river, sorted by the highest peak_elevation (from highest 
-- to lowest), then by the longest river_length (from longest to smallest), 
-- then by country_name (alphabetically). Display NULL when no data is 
-- available in some of the columns. Limit only the first 5 rows.
-- country_name, highest_peak_elevation, longest_river_length*/
select
	c.`country_name`,
    max(p.`elevation`) as 'highest_peak_elevation',
    max(r.`length`) as 'longest_river_length'
from 
	`countries` as c
join `countries_rivers` as cr on (cr.`country_code` = c.`country_code`)
join `rivers` as r on (cr.`river_id` = r.`id`)
join `mountains_countries` as mc on (mc.`country_code` = c.`country_code`)
join `peaks` as p on (p.`mountain_id` = mc.`mountain_id`)
group by c.`country_name`
order by p.`elevation` desc, r.`length` desc, c.`country_name`
limit 5;

































