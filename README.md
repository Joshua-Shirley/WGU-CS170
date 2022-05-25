# CS 170 Data Management - Applications - Course Assignment

## A - Nora's Bagel 

### 1. Second Normal Form

#### A & B
**A1A**  
**A1B**
![Second Normal Form](/assets/images/second_normal_form_nora_bagel.png "Second Normal Form")

#### C - Explain the assignments
**A1C**
| Attribute         	| New Entity            	| Explaination                                	|
|-------------------	|-----------------------	|---------------------------------------------	|
| Bagel Order ID    	| Bagel Order           	| Primary Key                                 	|
| Order Date        	| Bagel Order           	| Functionally dependent on Bagel Order ID.   	|
| First Name        	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Last Name         	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Address 1         	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Address 2         	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| City              	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| State             	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Zip               	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Mobile Phone      	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Delivery Fee      	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Special Notes     	| Bagel Order           	| Functionally dependent on Bagel Order ID    	|
| Bagel Order ID    	| Bagel Order Line Item 	| Primary Key / Foreign Key                   	|
| Bagel ID          	| Bagel Order Line Item 	| Primary Key / Foreign Key                   	|
| Bagel Quantity    	| Bagel Order Line Item 	| Partial dependence on Order ID and Bagel ID 	|
| Bagel ID          	| Bagel                 	| Primary Key                                 	|
| Bagel Name        	| Bagel                 	| Functional dependence on bagel ID           	|
| Bagel Description 	| Bagel                 	| Functional dependence on bagel ID           	|
| Bagel Price       	| Bagel                 	| Functional dependence on bagel ID           	|

**Cardinality of Entity Relations**

Bagel Order -> has -> Bagels  
Bagels -> are part of -> a Bagel Order  
This describes a many to many relationship.  
Bagel order line item is an associative entity that ties orders and products together.  
One order includes one or more line items (One to Many).  
Many line items bagel ids point to one bagel instance (Many to One).  

### 2. Third Normal Form
**A2A**  
**A2B**  
**A2C**  
**A2D**  
![Third Normal Form](/assets/images/third_normal_form_nora_bagel.png "Third Normal Form")

**Relationships between the tables** 
**A2D**
The relationships between Order -> Line Items <- Bagels is the same as before.  

The new entity Customer has a Many to One relationship with Orders.  
Customer -> places -> Orders.  
Orders -> are placed by -> a Customer.  
One order is owned by a single customer.  The same customer can place many orders.  
Customer -> 1 : M -> Orders.  

**Attributes assigned**
**A2E**
Customer attributes were transitively dependent on the Order entity - they were moved to their own entity Customer.
Customer_ID was created to be the unique primary key for the Customer entity.  Attributes that have functional dependence on the Customer entity were moved to that entity.  
Customer_ID is used as a foreign key in the Order entity to establish a many to one relationship.

| Attribute         	| New Entity            	| Explaination                                	|
|-------------------	|-----------------------	|---------------------------------------------	|
| Bagel Order ID    	| Order                 	| Primary Key                                 	|
| Order Date        	| Order                 	| Functionally dependent on Order ID.         	|
| Delivery Fee      	| Order                 	| Functionally dependent on Order ID          	|
| Special Notes     	| Order                 	| Functionally dependent on Order ID          	|
| Customer ID       	| Order                 	| Foreign Key                                 	|
| Customer ID       	| Customer              	| Primary Key                                 	|
| First Name        	| Customer              	| Functionally dependent on Customer ID       	|
| Last Name         	| Customer              	| Functionally dependent on Customer ID       	|
| Address 1         	| Customer              	| Functionally dependent on Customer ID       	|
| Address 2         	| Customer              	| Functionally dependent on Customer ID       	|
| City              	| Customer              	| Functionally dependent on Customer ID       	|
| State             	| Customer              	| Functionally dependent on Customer ID       	|
| Zip               	| Customer              	| Functionally dependent on Customer ID       	|
| Mobile Phone      	| Customer              	| Functionally dependent on Customer ID       	|
| Bagel Order ID    	| Bagel Order Line Item 	| Primary Key / Foreign Key                   	|
| Bagel ID          	| Bagel Order Line Item 	| Primary Key / Foreign Key                   	|
| Bagel Quantity    	| Bagel Order Line Item 	| Partial dependence on Order ID and Bagel ID 	|
| Bagel ID          	| Bagel                 	| Primary Key                                 	|
| Bagel Name        	| Bagel                 	| Functional dependence on bagel ID           	|
| Bagel Description 	| Bagel                 	| Functional dependence on bagel ID           	|
| Bagel Price       	| Bagel                 	| Functional dependence on bagel ID           	|

### 3. Physical Design
**A3A**  
**A3B**
![Physical Design](/assets/images/physical_design_nora_bagel.png "Physical Design")

## B - Jaunty Coffee Co

### 1. Table Schema
**B1A**
#### SQL Code
~~~~sql
USE JCoffeeCo; 

CREATE TABLE IF NOT EXISTS coffee_shop (
	shop_id INTEGER AUTO_INCREMENT,
	shop_name VARCHAR(50),
	city VARCHAR(50),
	state CHAR(2),
	CONSTRAINT pk_shop_id PRIMARY KEY (shop_id)
);

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

#### SQL Result
**B1B**  
![Create Table Results](/assets/images/create_tables_results_v2.png "Create Table Results")


### 2. Insert Data
**B2A**  

#### SQL Code
~~~~SQL
-- -----------------------------------------------------
-- Insert data into the tables
-- -----------------------------------------------------

INSERT INTO coffee_shop
( shop_name, city, state )
VALUES
('Aroma Mocha','Fairview','NS'),
('Baristas','Yarrock','VC'),
('Beans \'n Cream Cafe','Derwent Bridge','TS'),
('Beany Business','Teviotville','QL'),
('Boston Barista','Kulwin','VC'),
('Club Coffee','Johanna','VC'),
('Coffee Express','Johanna','VC'),
('Coffee House','Derwent Bridge','TS'),
('Coffee Time','Yarrock','VC'),
('Cup o\' Joe','Kayuga','NS'),
('Dream Bean Coffee Shop','Yarrock','VC'),
('Espresso Cafe','Fairview','NS'),
('Espresso Express','Kayuga','NS'),
('Expresso','Hovea','WA'),
('Grind House','Kayuga','NS'),
('Grinders Cafe','Kulwin','VC'),
('Ground Up Cafe','Hovea','WA'),
('HuggaMug Cafe','Graman','NS'),
('Impresso Espresso','Hovea','WA'),
('Jacked Up Coffee','Kayuga','NS'),
('Jumpin\' Beans Cafe','Johanna','VC'),
('Jumpstart Coffee Shop','Teviotville','QL'),
('Lava Java','Hovea','WA'),
('Manhattan Mocha','Derwent Bridge','TS'),
('Mugs Coffee','Johanna','VC'),
('No Doze Cafe','Euroley','NS'),
('Screamin\' Beans','Kayuga','NS'),
('Spiced Chai Cafe','Hovea','WA'),
('Steam Beans Cafe','Teviotville','QL'),
('Steamin\' Mugs','Kulwin','VC'),
('Steamy Beans Coffee','Fairview','NS'),
('Tatiana\'s Cafe','Graman','NS'),
('The Busy Bean','Kulwin','VC'),
('The Coffee Club','Teviotville','QL'),
('The Family Bean','Fairview','NS'),
('The Friendly Bean','Derwent Bridge','TS'),
('The Grind','Fairview','NS'),
('The Hideout','Euroley','NS'),
('The Roasted Bean','Yarrock','VC'),
('The Split Bean','Kulwin','VC'),
('The Steam Room','Johanna','VC'),
('Topped Off','Teviotville','QL'),
('Wake Up Cafe','Euroley','NS'),
('Wide Awake Cafe','Graman','NS'),
('Yo Jo Coffee Shop','Euroley','NS');


INSERT INTO employee
( first_name , last_name, hire_date, job_title , shop_id)
VALUES
('Hannah', 'Adams', '2016-01-19', 'Store Manager', 6),
('Brooklynn', 'Adams', '2016-02-01', 'Store Manager', 1),
('Nicole', 'Adams', '2016-02-04', 'Store Manager', 45),
('Oakley', 'Adams', '2016-02-08', 'Store Manager', 11),
('Ophelia', 'Adams', '2016-02-22', 'Store Manager', 12),
('Kaisley', 'Adams', '2016-02-28', 'Store Manager', 26),
('John', 'Adams', '2016-03-04', 'Store Manager', 18),
('Lukas', 'Adams', '2016-03-05', 'Store Manager', 17),
('Aidan', 'Adams', '2016-03-09', 'Assistant Store Manager', 17),
('Edwin', 'Adams', '2016-03-17', 'Assistant Store Manager', 11),
('Edison', 'Adams', '2016-03-18', 'Store Manager', 27),
('Joey', 'Adams', '2016-03-23', 'Store Manager', 34),
('Khalid', 'Adams', '2016-03-24', 'Store Manager', 4),
('Maya', 'Allen', '2016-03-26', 'Store Manager', 36),
('Alaina', 'Allen', '2016-03-28', 'Store Manager', 28),
('Ian', 'Allen', '2016-04-03', 'Store Manager', 40),
('Rodney', 'Allen', '2016-04-08', 'Store Manager', 15),
('Adalyn', 'Anderson', '2016-04-12', 'Store Manager', 16),
('Amy', 'Anderson', '2016-04-15', 'Store Manager', 41),
('Rebecca', 'Anderson', '2016-04-27', 'Store Manager', 14),
('Avayah', 'Anderson', '2016-05-05', 'Store Manager', 42),
('Erik', 'Anderson', '2016-05-07', 'Store Manager', 23),
('Lucian', 'Anderson', '2016-05-20', 'Store Manager', 38),
('Legacy', 'Anderson', '2016-06-02', 'Store Manager', 32),
('Gianna', 'Baker', '2016-06-17', 'Assistant Store Manager', 28),
('Khloe', 'Baker', '2016-06-20', 'Assistant Store Manager', 14),
('Molly', 'Baker', '2016-06-24', 'Store Manager', 31),
('Estelle', 'Baker', '2016-07-05', 'Assistant Store Manager', 6),
('Arjun', 'Baker', '2016-07-11', 'Store Manager', 25),
('Zavier', 'Baker', '2016-07-26', 'Roaster Technician', 28),
('Alina', 'Brown', '2016-07-27', 'Store Manager', 7),
('Parker', 'Brown', '2016-07-31', 'Assistant Store Manager', 15),
('Beau', 'Brown', '2016-08-11', 'Assistant Store Manager', 4),
('Sylas', 'Brown', '2016-08-18', 'Roaster Technician', 4),
('Brayan', 'Brown', '2016-08-19', 'Store Manager', 22),
('Angelica', 'Campbell', '2016-09-01', 'Store Manager', 24),
('Maxine', 'Campbell', '2016-09-03', 'Store Manager', 20),
('Shay', 'Campbell', '2016-09-10', 'Store Manager', 3),
('Elias', 'Campbell', '2016-09-16', 'Assistant Store Manager', 45),
('Leonardo', 'Campbell', '2016-09-28', 'Assistant Store Manager', 1),
('Trevor', 'Campbell', '2016-10-26', 'Assistant Store Manager', 25),
('Ty', 'Campbell', '2016-11-03', 'Assistant Store Manager', 36),
('Douglas', 'Campbell', '2016-11-24', 'Roaster Technician', 45),
('Leroy', 'Campbell', '2016-11-27', 'Store Manager', 19),
('Justin', 'Carter', '2016-12-01', 'Store Manager', 8),
('Dakota', 'Carter', '2016-12-10', 'Roaster Technician', 6),
('Troy', 'Carter', '2016-12-16', 'Barista', 45),
('Athena', 'Clark', '2016-12-21', 'Store Manager', 13),
('Wren', 'Clark', '2016-12-22', 'Assistant Store Manager', 34),
('Veronica', 'Clark', '2016-12-28', 'Assistant Store Manager', 16),
('Mikayla', 'Clark', '2017-01-05', 'Store Manager', 21),
('Jazmin', 'Clark', '2017-01-14', 'Assistant Store Manager', 23),
('Vada', 'Clark', '2017-01-15', 'Assistant Store Manager', 8),
('Issac', 'Clark', '2017-01-20', 'Assistant Store Manager', 12),
('Jadiel', 'Clark', '2017-02-03', 'Store Manager', 33),
('Madisyn', 'Davis', '2017-02-05', 'Barista', 6),
('Yareli', 'Davis', '2017-02-10', 'Assistant Store Manager', 31),
('Nolan', 'Davis', '2017-02-22', 'Roaster Technician', 25),
('Wesley', 'Davis', '2017-02-26', 'Store Manager', 10),
('Adonis', 'Davis', '2017-03-01', 'Store Manager', 37),
('Dante', 'Davis', '2017-03-06', 'Assistant Store Manager', 21),
('Sage', 'Davis', '2017-03-07', 'Roaster Technician', 15),
('Keanu', 'Davis', '2017-03-08', 'Barista', 15),
('Arabella', 'Flores', '2017-03-09', 'Roaster Technician', 23),
('Liv', 'Flores', '2017-03-22', 'Roaster Technician', 21),
('Hadlee', 'Flores', '2017-03-25', 'Roaster Technician', 1),
('Mckinley', 'Garcia', '2017-03-28', 'Assistant Store Manager', 37),
('Davina', 'Garcia', '2017-04-08', 'Assistant Store Manager', 20),
('Jaelynn', 'Garcia', '2017-04-17', 'Assistant Store Manager', 38),
('Eli', 'Garcia', '2017-04-20', 'Barista', 25),
('Elliot', 'Garcia', '2017-04-22', 'Assistant Store Manager', 27),
('Aidan', 'Garcia', '2017-04-25', 'Roaster Technician', 27),
('Marshall', 'Garcia', '2017-05-15', 'Store Manager', 30),
('Gustavo', 'Garcia', '2017-05-22', 'Roaster Technician', 38),
('Joe', 'Garcia', '2017-05-24', 'Assistant Store Manager', 10),
('Grey', 'Garcia', '2017-05-25', 'Store Manager', 39),
('Felipe', 'Garcia', '2017-05-26', 'Roaster Technician', 8),
('Gerald', 'Garcia', '2017-06-01', 'Assistant Store Manager', 24),
('Brianna', 'Gonzalez', '2017-07-02', 'Barista', 25),
('Ezra', 'Gonzalez', '2017-07-05', 'Roaster Technician', 31),
('Jasper', 'Gonzalez', '2017-08-07', 'Assistant Store Manager', 39),
('Karter', 'Gonzalez', '2017-08-09', 'Barista', 1),
('Uriel', 'Gonzalez', '2017-08-31', 'Assistant Store Manager', 30),
('Zachariah', 'Gonzalez', '2017-09-29', 'Store Manager', 43),
('Azariah', 'Gonzalez', '2017-10-04', 'Assistant Store Manager', 32),
('Kellan', 'Gonzalez', '2017-10-11', 'Assistant Store Manager', 41),
('Lyric', 'Green', '2017-10-20', 'Barista', 38),
('Madisyn', 'Green', '2017-10-21', 'Assistant Store Manager', 19),
('Alexia', 'Green', '2017-10-29', 'Roaster Technician', 11),
('Kallie', 'Green', '2017-10-30', 'Roaster Technician', 32),
('Odin', 'Green', '2017-11-06', 'Barista', 11),
('Ameer', 'Green', '2017-11-11', 'Barista', 38),
('Raina', 'Hall', '2017-11-23', 'Roaster Technician', 41),
('Kamilah', 'Hall', '2017-11-28', 'Roaster Technician', 37),
('Knox', 'Hall', '2017-12-02', 'Store Manager', 29),
('Nico', 'Hall', '2017-12-20', 'Barista', 37),
('Tyson', 'Hall', '2017-12-27', 'Assistant Store Manager', 33),
('Kashton', 'Hall', '2017-12-29', 'Barista', 11),
('Dustin', 'Hall', '2018-01-04', 'Roaster Technician', 33),
('Amos', 'Hall', '2018-01-16', 'Roaster Technician', 14),
('Scarlet', 'Harris', '2018-01-22', 'Roaster Technician', 12),
('Fernanda', 'Harris', '2018-02-02', 'Assistant Store Manager', 13),
('Adele', 'Harris', '2018-02-19', 'Store Manager', 5),
('Paityn', 'Harris', '2018-02-21', 'Barista', 6),
('Christian', 'Harris', '2018-02-26', 'Store Manager', 2),
('Alden', 'Harris', '2018-03-09', 'Barista', 31),
('Jericho', 'Harris', '2018-03-18', 'Roaster Technician', 39),
('Alayna', 'Hernandez', '2018-03-23', 'Barista', 41),
('Haven', 'Hernandez', '2018-03-26', 'Barista', 25),
('Katie', 'Hernandez', '2018-04-03', 'Barista', 31),
('Karsyn', 'Hernandez', '2018-04-09', 'Roaster Technician', 10),
('Hayley', 'Hernandez', '2018-04-20', 'Barista', 12),
('Greyson', 'Hernandez', '2018-04-23', 'Barista', 27),
('Jesus', 'Hernandez', '2018-04-29', 'Roaster Technician', 30),
('Santino', 'Hernandez', '2018-05-10', 'Store Manager', 35),
('Peyton', 'Hill', '2018-05-11', 'Barista', 32),
('Jasmine', 'Hill', '2018-05-12', 'Assistant Store Manager', 42),
('Celeste', 'Hill', '2018-05-19', 'Assistant Store Manager', 7),
('Dior', 'Hill', '2018-05-28', 'Assistant Store Manager', 40),
('Liberty', 'Hill', '2018-06-05', 'Barista', 21),
('Maxwell', 'Hill', '2018-06-15', 'Roaster Technician', 13),
('Abdiel', 'Hill', '2018-06-17', 'Assistant Store Manager', 26),
('Davis', 'Hill', '2018-07-16', 'Roaster Technician', 42),
('Harlan', 'Hill', '2018-07-20', 'Roaster Technician', 26),
('Jacoby', 'Hill', '2018-07-22', 'Roaster Technician', 19),
('Legacy', 'Jackson', '2018-07-23', 'Barista', 27),
('Meredith', 'Jackson', '2018-07-26', 'Barista', 37),
('Rayna', 'Jackson', '2018-07-30', 'Roaster Technician', 36),
('Giovanna', 'Jackson', '2018-08-19', 'Barista', 1),
('Harrison', 'Jackson', '2018-08-22', 'Barista', 33),
('Elsie', 'Johnson', '2018-08-23', 'Barista', 1),
('Miley', 'Johnson', '2018-09-06', 'Barista', 19),
('Mateo', 'Johnson', '2018-09-08', 'Barista', 26),
('Kaysen', 'Johnson', '2018-09-09', 'Roaster Technician', 20),
('Shiloh', 'Johnson', '2018-09-14', 'Barista', 4),
('Reuben', 'Johnson', '2018-09-15', 'Roaster Technician', 24),
('Colin', 'Jones', '2018-09-23', 'Roaster Technician', 40),
('Skylar', 'King', '2018-10-25', 'Barista', 10),
('Ariana', 'King', '2018-10-28', 'Roaster Technician', 17),
('Alison', 'King', '2018-11-02', 'Roaster Technician', 34),
('Liv', 'King', '2018-11-12', 'Barista', 6),
('Zaniyah', 'King', '2018-12-01', 'Barista', 32),
('Trevor', 'King', '2018-12-06', 'Barista', 11),
('Graysen', 'King', '2018-12-16', 'Barista', 12),
('Franco', 'King', '2018-12-18', 'Barista', 6),
('Riggs', 'King', '2018-12-30', 'Barista', 24),
('River', 'Lee', '2019-01-04', 'Barista', 42),
('Andre', 'Lee', '2019-01-05', 'Assistant Store Manager', 35),
('Amina', 'Lewis', '2019-01-13', 'Barista', 11),
('Reign', 'Lewis', '2019-01-27', 'Barista', 45),
('Gustavo', 'Lewis', '2019-02-06', 'Barista', 15),
('Noelle', 'Lopez', '2019-02-18', 'Barista', 13),
('Siena', 'Lopez', '2019-03-10', 'Barista', 34),
('Greta', 'Lopez', '2019-03-18', 'Store Manager', 44),
('Paloma', 'Lopez', '2019-03-23', 'Barista', 36),
('Jerry', 'Lopez', '2019-03-24', 'Assistant Store Manager', 43),
('Sabrina', 'Martin', '2019-04-01', 'Barista', 37),
('Azariah', 'Martin', '2019-04-07', 'Assistant Store Manager', 3),
('Mila', 'Martinez', '2019-04-17', 'Barista', 34),
('Sophie', 'Martinez', '2019-04-19', 'Barista', 40),
('Ellis', 'Martinez', '2019-04-25', 'Barista', 39),
('Noah', 'Martinez', '2019-04-26', 'Roaster Technician', 7),
('Kaden', 'Martinez', '2019-05-03', 'Barista', 4),
('Aleena', 'Miller', '2019-05-07', 'Barista', 34),
('Haylee', 'Miller', '2019-05-17', 'Barista', 45),
('Esperanza', 'Miller', '2019-05-18', 'Barista', 2),
('Richard', 'Miller', '2019-05-19', 'Barista', 4),
('Kaiser', 'Miller', '2019-05-21', 'Barista', 30),
('Lucy', 'Mitchell', '2019-05-27', 'Barista', 42),
('Esmeralda', 'Mitchell', '2019-06-03', 'Roaster Technician', 3),
('Gwen', 'Mitchell', '2019-06-05', 'Maintenance', 6),
('Brady', 'Mitchell', '2019-06-06', 'Barista', 8),
('Edgar', 'Mitchell', '2019-06-07', 'Barista', 21),
('Tru', 'Mitchell', '2019-06-19', 'Barista', 36),
('Jada', 'Moore', '2019-06-27', 'Barista', 25),
('Aubriella', 'Moore', '2019-06-29', 'Assistant Store Manager', 18),
('Kevin', 'Moore', '2019-07-02', 'Barista', 39),
('Kameron', 'Moore', '2019-07-17', 'Barista', 6),
('Fernando', 'Moore', '2019-07-21', 'Barista', 34),
('Wallace', 'Moore', '2019-07-27', 'Barista', 15),
('Miriam', 'Nelson', '2019-08-07', 'Barista', 23),
('Destiny', 'Nelson', '2019-08-21', 'Barista', 33),
('Makenna', 'Nelson', '2019-08-22', 'Store Manager', 9),
('Kinley', 'Nelson', '2019-08-23', 'Barista', 1),
('Paul', 'Nelson', '2019-08-28', 'Barista', 26),
('Donald', 'Nelson', '2019-09-13', 'Assistant Store Manager', 9),
('Dominik', 'Nelson', '2019-09-21', 'Barista', 24),
('Leah', 'Nguyen', '2019-09-24', 'Assistant Store Manager', 5),
('Ariana', 'Nguyen', '2019-10-15', 'Roaster Technician', 16),
('Melody', 'Nguyen', '2019-10-19', 'Barista', 23),
('Aviana', 'Nguyen', '2019-10-21', 'Barista', 13),
('Ryker', 'Nguyen', '2019-11-01', 'Roaster Technician', 35),
('Legacy', 'Perez', '2019-11-13', 'Assistant Store Manager', 29),
('Meghan', 'Perez', '2019-11-19', 'Barista', 13),
('Yasmin', 'Perez', '2019-12-15', 'Roaster Technician', 18),
('Legend', 'Perez', '2019-12-18', 'Barista', 18),
('Emanuel', 'Perez', '2019-12-20', 'Barista', 13),
('Niklaus', 'Perez', '2019-12-21', 'Roaster Technician', 5),
('Alistair', 'Perez', '2019-12-29', 'Barista', 3),
('Zoey', 'Ramirez', '2020-01-04', 'Barista', 4),
('Isabel', 'Ramirez', '2020-01-27', 'Maintenance', 34),
('Rosalie', 'Ramirez', '2020-01-30', 'Assistant Store Manager', 22),
('Addyson', 'Ramirez', '2020-02-05', 'Barista', 18),
('Alan', 'Ramirez', '2020-02-17', 'Barista', 20),
('Zane', 'Ramirez', '2020-03-11', 'Barista', 24),
('Scarlett', 'Rivera', '2020-03-12', 'Barista', 42),
('Allison', 'Rivera', '2020-03-20', 'Barista', 7),
('Brielle', 'Rivera', '2020-03-21', 'Maintenance', 25),
('Melody', 'Rivera', '2020-03-22', 'Barista', 27),
('Lana', 'Rivera', '2020-03-23', 'Barista', 19),
('Vienna', 'Rivera', '2020-03-24', 'Assistant Store Manager', 44),
('Marisol', 'Rivera', '2020-03-29', 'Barista', 41),
('Lorenzo', 'Rivera', '2020-03-30', 'Roaster Technician', 43),
('Tony', 'Rivera', '2020-04-10', 'Barista', 35),
('Talia', 'Roberts', '2020-04-17', 'Barista', 12),
('Anaya', 'Roberts', '2020-04-21', 'Barista', 22),
('Archie', 'Roberts', '2020-04-22', 'Maintenance', 1),
('Ila', 'Robinson', '2020-04-26', 'Barista', 16),
('Cleo', 'Robinson', '2020-05-11', 'Barista', 27),
('Raya', 'Robinson', '2020-06-02', 'Barista', 21),
('Gunner', 'Robinson', '2020-06-03', 'Maintenance', 13),
('Sutton', 'Robinson', '2020-06-08', 'Barista', 8),
('Dangelo', 'Robinson', '2020-06-10', 'Barista', 28),
('Penelope', 'Rodriguez', '2020-06-15', 'Barista', 12),
('Leyla', 'Rodriguez', '2020-06-20', 'Roaster Technician', 44),
('Yareli', 'Rodriguez', '2020-06-26', 'Barista', 1),
('Jason', 'Rodriguez', '2020-06-28', 'Barista', 5),
('Conor', 'Rodriguez', '2020-07-19', 'Barista', 15),
('Landyn', 'Rodriguez', '2020-08-02', 'Roaster Technician', 29),
('Samir', 'Rodriguez', '2020-08-04', 'Barista', 1),
('Grey', 'Rodriguez', '2020-08-12', 'Barista', 14),
('Damari', 'Rodriguez', '2020-08-13', 'Barista', 13),
('Mccoy', 'Rodriguez', '2020-08-14', 'Barista', 17),
('Dani', 'Sanchez', '2020-08-17', 'Barista', 31),
('Valery', 'Sanchez', '2020-08-19', 'Maintenance', 4),
('Esperanza', 'Sanchez', '2020-08-23', 'Maintenance', 27),
('Artemis', 'Sanchez', '2020-08-28', 'Barista', 10),
('Bryson', 'Sanchez', '2020-08-29', 'Roaster Technician', 9),
('Cole', 'Sanchez', '2020-08-30', 'Barista', 21),
('Khalil', 'Sanchez', '2020-09-01', 'Barista', 14),
('Rory', 'Sanchez', '2020-09-23', 'Barista', 28),
('Onyx', 'Sanchez', '2020-09-28', 'Barista', 37),
('Quinton', 'Sanchez', '2020-10-05', 'Barista', 32),
('Karsyn', 'Sanchez', '2020-10-08', 'Barista', 32),
('Gabriella', 'Scott', '2020-10-14', 'Barista', 39),
('Hadley', 'Scott', '2020-10-19', 'Barista', 21),
('Madeleine', 'Scott', '2020-11-12', 'Maintenance', 15),
('Allie', 'Scott', '2020-12-02', 'Maintenance', 11),
('Meilani', 'Scott', '2020-12-05', 'Maintenance', 12),
('Dakota', 'Scott', '2020-12-07', 'Barista', 28),
('Lucca', 'Scott', '2020-12-19', 'Barista', 17),
('Wells', 'Scott', '2020-12-28', 'Barista', 28),
('Camilla', 'Smith', '2021-01-13', 'Barista', 19),
('Tiana', 'Smith', '2021-01-18', 'Barista', 12),
('Elodie', 'Smith', '2021-01-31', 'Barista', 1),
('Lyanna', 'Smith', '2021-02-10', 'Barista', 24),
('Griffin', 'Smith', '2021-02-21', 'Barista', 4),
('Maximiliano', 'Smith', '2021-02-25', 'Barista', 43),
('Raiden', 'Smith', '2021-03-12', 'Barista', 15),
('Titan', 'Smith', '2021-03-25', 'Barista', 24),
('Lorenzo', 'Taylor', '2021-04-09', 'Barista', 27),
('Ace', 'Taylor', '2021-04-19', 'Barista', 25),
('Nikolai', 'Taylor', '2021-04-23', 'Barista', 40),
('Leon', 'Thomas', '2021-05-06', 'Barista', 17),
('Griffin', 'Thomas', '2021-05-15', 'Barista', 13),
('Ronin', 'Thomas', '2021-05-19', 'Barista', 9),
('Frederick', 'Thomas', '2021-05-20', 'Barista', 8),
('Ephraim', 'Thomas', '2021-05-30', 'Barista', 27),
('Emory', 'Thompson', '2021-06-05', 'Barista', 1),
('Kamiyah', 'Thompson', '2021-06-14', 'Barista', 16),
('Samira', 'Thompson', '2021-06-21', 'Barista', 25),
('Carolyn', 'Thompson', '2021-06-24', 'Barista', 36),
('Dean', 'Thompson', '2021-06-25', 'Barista', 45),
('Ayaan', 'Thompson', '2021-06-26', 'Barista', 15),
('Jonas', 'Thompson', '2021-07-06', 'Barista', 12),
('Kaysen', 'Thompson', '2021-07-16', 'Maintenance', 37),
('Leandro', 'Thompson', '2021-07-27', 'Barista', 20),
('Wallace', 'Thompson', '2021-07-31', 'Barista', 23),
('Jordyn', 'Torres', '2021-08-22', 'Barista', 5),
('Jayda', 'Torres', '2021-08-28', 'Barista', 29),
('Messiah', 'Torres', '2021-08-30', 'Barista', 43),
('Malik', 'Torres', '2021-09-01', 'Barista', 27),
('Gary', 'Torres', '2021-09-12', 'Barista', 37),
('Valentina', 'Walker', '2021-09-22', 'Barista', 13),
('Hailey', 'Walker', '2021-09-24', 'Maintenance', 28),
('Adaline', 'Walker', '2021-09-26', 'Maintenance', 32),
('Skyler', 'Walker', '2021-10-05', 'Barista', 15),
('Skyla', 'Walker', '2021-10-19', 'Barista', 25),
('Jose', 'Walker', '2021-10-31', 'Barista', 36),
('Gustavo', 'Walker', '2021-11-01', 'Barista', 38),
('Magnus', 'Walker', '2021-11-02', 'Barista', 35),
('Aspen', 'White', '2021-11-07', 'Barista', 27),
('Margo', 'White', '2021-11-09', 'Barista', 37),
('Kailey', 'White', '2021-11-17', 'Barista', 29),
('Ayleen', 'White', '2021-11-29', 'Barista', 34),
('Asher', 'White', '2021-12-09', 'Barista', 43),
('Barrett', 'White', '2021-12-13', 'Barista', 12),
('Darwin', 'White', '2021-12-22', 'Barista', 13),
('Harris', 'White', '2022-01-02', 'Barista', 30),
('Morgan', 'Williams', '2022-01-07', 'Barista', 11),
('Annabelle', 'Williams', '2022-01-08', 'Barista', 35),
('Navy', 'Williams', '2022-01-10', 'Barista', 31),
('Elyse', 'Williams', '2022-01-14', 'Barista', 28),
('Greta', 'Williams', '2022-02-06', 'Barista', 45),
('Peyton', 'Williams', '2022-02-07', 'Barista', 16),
('Ishaan', 'Williams', '2022-02-08', 'Barista', 10),
('Demetrius', 'Williams', '2022-02-16', 'Barista', 11),
('Alfred', 'Williams', '2022-02-20', 'Barista', 14),
('Sylvia', 'Wilson', '2022-02-21', 'Barista', 41),
('Hanna', 'Wilson', '2022-02-22', 'Barista', 10),
('Cadence', 'Wilson', '2022-03-09', 'Barista', 27),
('Marleigh', 'Wilson', '2022-03-17', 'Barista', 17),
('Matteo', 'Wilson', '2022-03-24', 'Barista', 39),
('Donovan', 'Wilson', '2022-03-28', 'Barista', 16),
('Sullivan', 'Wilson', '2022-03-30', 'Barista', 40),
('Finnegan', 'Wilson', '2022-04-01', 'Barista', 16),
('Stetson', 'Wilson', '2022-04-06', 'Barista', 36),
('Cayson', 'Wilson', '2022-04-10', 'Barista', 23),
('Davion', 'Wilson', '2022-04-17', 'Barista', 31),
('Elliana', 'Wright', '2022-04-20', 'Barista', 25),
('Mira', 'Wright', '2022-04-28', 'Barista', 41),
('Philip', 'Wright', '2022-05-26', 'Barista', 32),
('Destiny', 'Yang', '2022-03-27', 'Barista', 11),
('Alexia', 'Young', '2022-02-28', 'Barista', 30),
('Ansley', 'Young', '2022-01-10', 'Barista', 34),
('Zaid', 'Young', '2021-07-02', 'Barista', 42),
('Jaxx', 'Young', '2022-02-12', 'Barista', 3),
('Adler', 'Young', '2022-03-24', 'Barista', 44),
('Hakeem', 'Young', '2022-04-27', 'Barista', 4);

INSERT INTO supplier
( company_name, country, sales_contact_name, email )
VALUES
('Lions Roast','Ethiopia','Anbassa','anbassa@lionsroast.com' ),
('Kenya Blend','Kenya','Makena','kenya@blend.com' ),
('Kion Coffee','Uganda','Dembe Okello','sales@kioncoffee.com' ),
('Necktie Coffee','Colombia','Jose Gracias','jose.gracias@columbianecktiecoffee.com' ),
('Torogoz Beans','El Salvador','Juanita Haddad','beans@torogoz.com' ),
('Tarrazu Coffee','Costa Rica','Isabella Rodiquez','coffee@tarrazu.com' ),
('Thai Beans','Thailand','Somsuk Thongsing','thongsing@thaibeans.th' );

INSERT INTO coffee
( shop_id , supplier_id, coffee_name, price_per_pound )
VALUES
(1, 6, 'Blonde', 8.27),
(1, 2, 'Dark', 15.06),
(1, 2, 'Medium / Dark', 13.86),
(1, 2, 'Light', 11.86),
(2, 5, 'Medium', 10.28),
(2, 5, 'Light', 9.30),
(2, 2, 'Medium', 13.11),
(3, 6, 'Dark', 11.09),
(3, 6, 'Medium / Dark', 10.20),
(3, 1, 'Light', 14.24),
(4, 5, 'Medium / Dark', 10.87),
(4, 5, 'Light', 9.30),
(4, 3, 'Dark', 12.65),
(5, 7, 'Blonde', 9.44),
(5, 6, 'Medium', 9.65),
(5, 6, 'Blonde', 8.27),
(5, 3, 'Dark', 12.65),
(5, 3, 'Medium / Dark', 11.64),
(5, 1, 'Medium', 15.74),
(6, 7, 'Blonde', 9.44),
(6, 2, 'Light', 11.86),
(6, 1, 'Medium', 15.74),
(6, 1, 'Light', 14.24),
(7, 6, 'Medium / Dark', 10.20),
(7, 5, 'Medium', 10.28),
(7, 4, 'Dark', 12.05),
(7, 4, 'Light', 9.49),
(7, 3, 'Light', 9.96),
(7, 3, 'Blonde', 9.44),
(7, 2, 'Dark', 15.06),
(8, 7, 'Dark', 12.65),
(8, 6, 'Medium / Dark', 10.20),
(8, 4, 'Medium / Dark', 11.09),
(8, 3, 'Dark', 12.65),
(8, 3, 'Light', 9.96),
(9, 7, 'Light', 9.96),
(9, 5, 'Blonde', 8.81),
(9, 2, 'Dark', 15.06),
(9, 2, 'Light', 11.86),
(10, 7, 'Medium / Dark', 11.64),
(10, 4, 'Dark', 12.05),
(10, 3, 'Blonde', 9.44),
(10, 2, 'Dark', 15.06),
(10, 2, 'Medium / Dark', 13.86),
(11, 7, 'Medium / Dark', 11.64),
(11, 4, 'Blonde', 8.99),
(11, 3, 'Dark', 12.65),
(12, 7, 'Dark', 12.65),
(12, 7, 'Medium / Dark', 11.64),
(12, 6, 'Dark', 11.09),
(12, 6, 'Medium', 9.65),
(12, 5, 'Medium / Dark', 10.87),
(12, 3, 'Medium', 11.01),
(12, 3, 'Light', 9.96),
(12, 2, 'Light', 11.86),
(12, 1, 'Dark', 18.08),
(13, 6, 'Medium / Dark', 10.20),
(13, 5, 'Dark', 11.81),
(13, 5, 'Medium / Dark', 10.87),
(13, 4, 'Medium / Dark', 11.09),
(13, 3, 'Medium / Dark', 11.64),
(13, 2, 'Blonde', 11.24),
(14, 7, 'Blonde', 9.44),
(14, 5, 'Dark', 11.81),
(14, 4, 'Light', 9.49),
(14, 3, 'Medium', 11.01),
(15, 7, 'Light', 9.96),
(15, 1, 'Medium / Dark', 16.64),
(16, 6, 'Medium', 9.65),
(16, 5, 'Dark', 11.81),
(16, 5, 'Medium', 10.28),
(16, 4, 'Blonde', 8.99),
(16, 2, 'Medium / Dark', 13.86),
(16, 2, 'Medium', 13.11),
(17, 5, 'Dark', 11.81),
(17, 4, 'Medium / Dark', 11.09),
(17, 2, 'Blonde', 11.24),
(18, 7, 'Medium', 11.01),
(18, 6, 'Medium', 9.65),
(18, 5, 'Dark', 11.81),
(18, 5, 'Medium / Dark', 10.87),
(18, 3, 'Light', 9.96),
(18, 2, 'Dark', 15.06),
(18, 1, 'Blonde', 13.49),
(19, 5, 'Blonde', 8.81),
(19, 2, 'Light', 11.86),
(20, 7, 'Dark', 12.65),
(20, 6, 'Light', 8.73),
(20, 5, 'Dark', 11.81),
(20, 2, 'Light', 11.86),
(21, 6, 'Blonde', 8.27),
(21, 4, 'Medium / Dark', 11.09),
(21, 2, 'Medium / Dark', 13.86),
(21, 2, 'Blonde', 11.24),
(22, 6, 'Medium / Dark', 10.20),
(22, 6, 'Medium', 9.65),
(22, 5, 'Medium', 10.28),
(22, 4, 'Light', 9.49),
(22, 3, 'Medium', 11.01),
(22, 1, 'Dark', 18.08),
(23, 6, 'Dark', 11.09),
(23, 6, 'Medium / Dark', 10.20),
(23, 6, 'Medium', 9.65),
(23, 4, 'Dark', 12.05),
(23, 4, 'Blonde', 8.99),
(23, 2, 'Dark', 15.06),
(24, 6, 'Dark', 11.09),
(24, 5, 'Blonde', 8.81),
(24, 4, 'Medium / Dark', 11.09),
(24, 3, 'Medium', 11.01),
(24, 2, 'Blonde', 11.24),
(25, 4, 'Medium / Dark', 11.09),
(25, 4, 'Blonde', 8.99),
(25, 2, 'Medium / Dark', 13.86),
(25, 1, 'Blonde', 13.49),
(26, 6, 'Blonde', 8.27),
(26, 2, 'Medium', 13.11),
(26, 1, 'Dark', 18.08),
(27, 6, 'Medium', 9.65),
(27, 5, 'Medium', 10.28),
(27, 3, 'Dark', 12.65),
(27, 2, 'Dark', 15.06),
(28, 5, 'Medium', 10.28),
(28, 1, 'Dark', 18.08),
(28, 1, 'Medium / Dark', 16.64),
(28, 1, 'Blonde', 13.49),
(29, 7, 'Blonde', 9.44),
(29, 1, 'Light', 14.24),
(30, 7, 'Dark', 12.65),
(30, 6, 'Dark', 11.09),
(30, 4, 'Medium', 10.49),
(30, 3, 'Dark', 12.65),
(30, 3, 'Light', 9.96),
(30, 2, 'Medium', 13.11),
(30, 1, 'Dark', 18.08),
(31, 6, 'Dark', 11.09),
(31, 6, 'Blonde', 8.27),
(31, 4, 'Dark', 12.05),
(31, 4, 'Medium', 10.49),
(31, 2, 'Medium / Dark', 13.86),
(31, 1, 'Light', 14.24),
(32, 7, 'Dark', 12.65),
(32, 5, 'Medium / Dark', 10.87),
(32, 5, 'Blonde', 8.81),
(32, 3, 'Medium / Dark', 11.64),
(32, 3, 'Medium', 11.01),
(32, 2, 'Medium / Dark', 13.86),
(32, 2, 'Blonde', 11.24),
(32, 1, 'Medium', 15.74),
(33, 6, 'Medium / Dark', 10.20),
(33, 6, 'Blonde', 8.27),
(33, 5, 'Dark', 11.81),
(33, 2, 'Medium / Dark', 13.86),
(33, 2, 'Blonde', 11.24),
(34, 7, 'Medium / Dark', 11.64),
(34, 6, 'Medium', 9.65),
(34, 4, 'Light', 9.49),
(34, 2, 'Dark', 15.06),
(35, 5, 'Blonde', 8.81),
(35, 3, 'Dark', 12.65),
(35, 2, 'Medium', 13.11),
(35, 1, 'Blonde', 13.49),
(36, 6, 'Light', 8.73),
(36, 2, 'Medium', 13.11),
(36, 1, 'Blonde', 13.49),
(37, 7, 'Medium / Dark', 11.64),
(37, 5, 'Light', 9.30),
(37, 4, 'Dark', 12.05),
(37, 4, 'Medium', 10.49),
(37, 4, 'Blonde', 8.99),
(37, 2, 'Dark', 15.06),
(37, 2, 'Medium', 13.11),
(37, 1, 'Dark', 18.08),
(38, 6, 'Medium / Dark', 10.20),
(38, 5, 'Light', 9.30),
(38, 5, 'Blonde', 8.81),
(38, 4, 'Blonde', 8.99),
(38, 3, 'Medium / Dark', 11.64),
(38, 3, 'Medium', 11.01),
(38, 2, 'Blonde', 11.24),
(38, 1, 'Medium / Dark', 16.64),
(39, 6, 'Medium / Dark', 10.20),
(39, 5, 'Medium', 10.28),
(39, 5, 'Blonde', 8.81),
(39, 4, 'Medium', 10.49),
(39, 3, 'Dark', 12.65),
(39, 2, 'Medium', 13.11),
(39, 2, 'Blonde', 11.24),
(39, 1, 'Medium', 15.74),
(40, 6, 'Medium', 9.65),
(40, 2, 'Blonde', 11.24),
(41, 6, 'Medium', 9.65),
(41, 5, 'Medium / Dark', 10.87),
(41, 5, 'Medium', 10.28),
(41, 5, 'Light', 9.30),
(41, 4, 'Light', 9.49),
(41, 3, 'Blonde', 9.44),
(42, 4, 'Medium', 10.49),
(42, 3, 'Dark', 12.65),
(42, 2, 'Blonde', 11.24),
(42, 1, 'Dark', 18.08),
(43, 6, 'Light', 8.73),
(43, 5, 'Medium / Dark', 10.87),
(43, 3, 'Dark', 12.65),
(43, 2, 'Dark', 15.06),
(44, 6, 'Medium / Dark', 10.20),
(44, 6, 'Light', 8.73),
(44, 5, 'Light', 9.30),
(44, 2, 'Blonde', 11.24),
(45, 6, 'Medium', 9.65),
(45, 5, 'Medium', 10.28),
(45, 3, 'Dark', 12.65),
(45, 2, 'Blonde', 11.24);
~~~~~

#### SQL Result
**B2B**  
![Populate Tables with Data](/assets/images/populate_tables_output.png "Populate Tables Results")

### 3. Create a View
**B3A**  
#### SQL Code
~~~~SQL
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
~~~~

#### SQL Result
**B3B**  
![Create View Results](/assets/images/create_view_output.png "Create View Results")

### 4. Create an Index
**B4A**  
#### SQL Code
~~~~SQL
-- ------------------------------------------------------
-- INDEXES
-- ------------------------------------------------------

CREATE INDEX idx_coffee_name
ON coffee(coffee_name);

-- SHOW INDEX FROM coffee;
~~~~
#### SQL Result
**B4B**  
![Create Index Results](/assets/images/create_index_output.png "Create Index Results")


### 5. Select From Where
**B5A**  
#### SQL Code
~~~~SQL
-- -------------------------------------------
-- SFW SELECT FROM WHERE example
-- -------------------------------------------

SELECT shop_id,
	shop_name,
    city,
    state
FROM coffee_shop
WHERE state in ('NS', 'VC' );
~~~~
#### SQL Result
**B5B**  
![SELECT FROM WHERE Results](/assets/images/SFW_results.png "Select From Where Query Results")

### 5. Three Table Join SELECT Query
**B6A**  
#### SQL Code
~~~~SQL
-- -------------------------------------------
-- SFW with 3 joined tables
-- SHOP MENUS
-- ------------------------------------------- 

SELECT 	
    coffee_shop.shop_name AS Shop,    
    supplier.company_name AS Beans,
    coffee_name AS Roast,
    price_per_pound AS Price
FROM coffee
LEFT JOIN supplier
ON coffee.supplier_id = supplier.supplier_id
LEFT JOIN coffee_shop
ON coffee.shop_id = coffee_shop.shop_id
ORDER BY shop_name ASC, Beans ASC, Roast ASC;
~~~~
#### SQL Result
**B6B**  
![JOIN Query](/assets/images/three_table_join_query.png "Three Table Join Query")
