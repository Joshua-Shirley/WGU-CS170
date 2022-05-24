-- ------------------------------------------------------
-- INDEXES
-- ------------------------------------------------------

CREATE INDEX idx_coffee_name
ON coffee(coffee_name);

SHOW INDEX FROM coffee;

CREATE INDEX idx_employee_first_name
ON employee(first_name);

CREATE INDEX idx_employee_last_name
ON employee(last_name);

CREATE INDEX idx_hire_date 
ON employee(hire_date);

SHOW INDEX FROM employee;
