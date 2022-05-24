-- -----------------------------------------------------
-- VIEWS
-- -----------------------------------------------------
CREATE VIEW employee_view AS
SELECT employee_id,
	first_name,
    last_name,
    CONCAT( first_name, ' ', last_name ) AS employee_full_name,
    hire_date,
    job_title,
    shop_id
FROM employee;

CREATE VIEW employee_experience AS
SELECT shop_id, 
	count(*) as employees,
    max( datediff(now() , hire_date) ) as longest_employee,
    min( datediff(now() , hire_date) ) as newest_employee,
    avg( datediff(now() , hire_date) ) AS average_experience
FROM employee
GROUP BY shop_id;

CREATE VIEW employee_titles AS
SELECT job_title AS Titles,
	count(*) as Employees,
    CONVERT( min( datediff( now() , hire_date )) , DECIMAL(5,0) ) as Minimum_Exp,
    CONVERT( avg( datediff( now() , hire_date )) , DECIMAL(5,0) ) as Average_Exp,
    CONVERT( max( datediff( now() , hire_date )) , DECIMAL(5,0) ) as Maximum_Exp
FROM employee
GROUP BY job_title;
