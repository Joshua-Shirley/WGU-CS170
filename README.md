# WGU-CS170
# CS 170 Data Management - Applications
# Course Assignment

## A - Nora's Bagel 

## B - Jaunty Coffee Co

### 1. Table Schema
~~~~sql
USE JCoffeeCo; 

CREATE TABLE IF NOT EXISTS coffee_shop (
	shop_id INTEGER AUTO_INCREMENT,
	shop_name VARCHAR(50),
	city VARCHAR(50),
	state CHAR(2),
	CONSTRAINT pk_shop_id PRIMARY KEY (shop_id)
);
``

CREATE TABLE IF NOT EXISTS supplier (
	supplier_id INTEGER AUTO_INCREMENT,
	company_name VARCHAR(50),
	country VARCHAR(30),
	sales_contact_name VARCHAR(60),
	email VARCHAR(50) NOT NULL,
	CONSTRAINT pk_supplier_id PRIMARY KEY (supplier_id)
);

CREATE TABLE IF NOT EXISTS employee (
	employee_id INTEGER AUTO_INCREMENT,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	hire_date DATE,
	job_title VARCHAR(30),
	shop_id INTEGER,
	CONSTRAINT pk_employee_id PRIMARY KEY (employee_id),
	CONSTRAINT fk_employee_shop_id FOREIGN KEY (shop_id) REFERENCES coffee_shop(shop_id)
);

CREATE TABLE IF NOT EXISTS coffee (
	coffee_id INTEGER AUTO_INCREMENT,
	shop_id INTEGER,
	supplier_id INTEGER,
	coffee_name VARCHAR(30),
	price_per_pound NUMERIC(5,2),
	CONSTRAINT pk_coffee_id PRIMARY KEY (coffee_id),
	CONSTRAINT fk_coffee_shop_id FOREIGN KEY (shop_id) REFERENCES coffee_shop(shop_id),
	CONSTRAINT fk_coffee_supplier_id FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);
~~~~

### 2. Insert Data


### 3. Create a View


### 4. Create an Index



### 5. Select From Where



