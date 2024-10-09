CREATE TABLE sales(
					id int PRIMARY KEY,
					order_date date,
					customer_name VARCHAR(25),
					state VARCHAR(25),
					category VARCHAR(25),
					sub_category VARCHAR(25),
					product_name VARCHAR(255),
					sales FLOAT,
					quantity INT,
					profit FLOAT
					);
