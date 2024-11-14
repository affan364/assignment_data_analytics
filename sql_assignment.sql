# SQL ASSIGNMENT

/* 1. Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).

Write the SQL query to create the above table with all constraints. 
*/
create database employee_data;
use employee_data;
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email varchar(255) UNIQUE,
    salary DECIMAL DEFAULT 30000
);

/* 
2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
examples of common types of constraints
solution- Constraints in a database are rules applied to table columns to ensure the accuracy, reliability, 
          and integrity of the data. They help prevent invalid data from being entered into the database and 
          maintain consistent relationships between tables. Here are some common types of constraints and their purposes:
          NOT NULL: Ensures that a column cannot have a NULL value. This is useful for columns where a value is always required, 
		  such as a primary key or a user’s name. Example: emp_name TEXT NOT NULL
          UNIQUE: Ensures that all values in a column are different. This is often used for columns that require unique entries, 
          such as email addresses. Example: email VARCHAR(255) UNIQUE
          PRIMARY KEY: A combination of NOT NULL and UNIQUE. It uniquely identifies each row in a table and 
		  ensures that no two rows have the same primary key value. Example: emp_id INT NOT NULL PRIMARY KEY
          FOREIGN KEY: Ensures referential integrity by linking a column in one table to a primary key in another table. 
		  This prevents actions that would destroy links between tables. 
          Example: FOREIGN KEY (department_id) REFERENCES departments(department_id)
          CHECK: Ensures that the values in a column satisfy a specific condition. 
          This is useful for enforcing business rules at the database level. Example: age INT CHECK (age >= 18)
		  DEFAULT: Sets a default value for a column if no value is specified. 
          This is useful for columns where a common default value is expected.Example: salary DECIMAL DEFAULT 30000 
*/

/*
3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer
solution-Applying the NOT NULL constraint to a column ensures that the column cannot have NULL values. 
	     This is important for maintaining data integrity and consistency. 
		 For example, if you have a column that stores email addresses, 
		 you would want to ensure that every row has a valid email address and not a NULL value.
         Regarding primary keys, they cannot contain NULL values. 
         A primary key is used to uniquely identify each row in a table, and NULL values would violate this uniqueness. 
         Since NULL represents the absence of a value, 
         having a NULL in a primary key would mean that the row cannot be uniquely identified, 
         which defeats the purpose of having a primary key. 
         Therefore, primary keys must always have non-NULL values to ensure the uniqueness and integrity of the data in the table.
*/

/*
4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
example for both adding and removing a constraint.
solution-
To add a constraint to an existing table, you can use the ALTER TABLE statement along with the ADD CONSTRAINT clause. 
Here's an example of adding a UNIQUE constraint to a column:
ALTER TABLE table_name
ADD CONSTRAINT constraint_name UNIQUE (column_name);
To remove a constraint from an existing table, you can use the ALTER TABLE statement along with the DROP CONSTRAINT clause. 
Here's an example of removing a UNIQUE constraint
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
*/

/*
5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
Provide an example of an error message that might occur when violating a constraint.
solution: 
Attempt to insert, update, or delete data in a way that violates constraints, 
the database management system (DBMS) will prevent the operation and return an error. 
This ensures data integrity and consistency. Here are some common consequences and examples of error messages:
Consequences of Violating Constraints
Insertion Violation: Trying to insert a row that violates a constraint.
Example: Inserting a duplicate value in a column with a UNIQUE constraint.
Error Message: ERROR: duplicate key value violates unique constraint "unique_constraint_name"
Update Violation: Trying to update a row in a way that violates a constraint.
Example: Updating a primary key column to a NULL value.
Error Message: ERROR: null value in column "primary_key_column" violates not-null constraint
Deletion Violation: Trying to delete a row that is referenced by a foreign key in another table.
Example: Deleting a row from a parent table that is referenced by a foreign key in a child table.
Error Message: ERROR: update or delete on table "parent_table" violates foreign key constraint "foreign_key_constraint_name" 
on table "child_table"
*/

/*
6.  You created a products table without constraints as follows:
CREATE TABLE products (
product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2));
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00
solution:
To modify the products table and add the constraints you mentioned, you can use the ALTER TABLE statement. 
Here are the steps and SQL commands to achieve this: 
Adding a Primary Key Constraint To make product_id a primary key, you can use the following command:
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);
Adding a Default Value Constraint To set the default value of price to 50.00, you can use the following command:
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;
*/

#SQL COMMANDS
/*1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences*/
SELECT 
    KCU.TABLE_NAME,
    KCU.COLUMN_NAME,
    TC.CONSTRAINT_TYPE,
    KCU.REFERENCED_TABLE_NAME,
    KCU.REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
JOIN 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU 
    ON TC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
    AND TC.TABLE_NAME = KCU.TABLE_NAME
WHERE 
    TC.CONSTRAINT_TYPE IN ('PRIMARY KEY', 'FOREIGN KEY')
    AND TC.TABLE_SCHEMA = 'maven_movies'  -- Replace with your actual schema name
ORDER BY 
    TC.TABLE_NAME, TC.CONSTRAINT_TYPE;

/*2- List all details of actors*/
SELECT * FROM actor;

/*3 -List all customer information from DB.*/
SELECT * FROM customer;

/*4 -List different countries.*/
SELECT DISTINCT country FROM country;

/*5 -Display all active customers.*/
SELECT * FROM customer WHERE active = 1;

/*6 -List of all rental IDs for customer with ID 1.*/
SELECT rental_id FROM rental WHERE customer_id = 1;

/*7 - Display all the films whose rental duration is greater than 5 .*/
SELECT * FROM film WHERE rental_duration > 5;

/*8 - List the total number of films whose replacement cost is greater than $15 and less than $20.*/
SELECT COUNT(*) AS total_films FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

/*9 - Display the count of unique first names of actors.*/
SELECT COUNT(DISTINCT first_name) AS unique_actor_first_names FROM actor;

/*10- Display the first 10 records from the customer table .*/
SELECT * FROM customer LIMIT 10;

-- 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM customer WHERE first_name LIKE 'B%' LIMIT 3;

-- 12 -Display the names of the first 5 movies which are rated as ‘G’.
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

-- 13-Find all customers whose first name starts with "a".
SELECT * FROM customer WHERE first_name LIKE 'A%';

-- 14- Find all customers whose first name ends with "a".
SELECT * FROM customer WHERE first_name LIKE '%A';

-- 15- Display the list of first 4 cities which start and end with ‘a’ .
SELECT * FROM customer WHERE first_name LIKE 'A%';

-- 16- Find all customers whose first name have "NI" in any position.
SELECT * FROM customer WHERE first_name LIKE '%NI%';

-- 17- Find all customers whose first name have "r" in the second position .
SELECT * FROM customer WHERE first_name LIKE '_R%';

-- 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

-- 19- Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer WHERE first_name LIKE 'A%O';

-- 20 - Get the films with pg and pg-13 rating using IN operator.
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

-- 21 - Get the films with length between 50 to 100 using between operator.
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

-- 22 - Get the top 50 actors using limit operator.
SELECT * FROM actor LIMIT 50;

-- 23 - Get the distinct film ids from inventory table.
SELECT DISTINCT film_id FROM inventory;

-- FUNCTION
-- Question 1: Retrieve the total number of rentals made in the Sakila database. Hint: Use the COUNT() function.
SELECT COUNT(*) AS total_rentals
FROM rental;

-- Question 2: Find the average rental duration (in days) of movies rented from the Sakila database. Hint: Utilize the AVG() function.
SELECT AVG(rental_duration) AS average_rental_duration FROM film;

-- Question 3: Display the first name and last name of customers in uppercase. Hint: Use the UPPER () function.
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper FROM customer;

-- Question 4: Extract the month from the rental date and display it alongside the rental ID. Hint: Employ the MONTH() function.
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

-- Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals). Hint: Use COUNT () in conjunction with GROUP BY.
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

-- Question 6: Find the total revenue generated by each store. Hint: Combine SUM() and GROUP BY.
SELECT 
    p.store_id, 
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY p.store_id;

-- Question 7: Determine the total number of rentals for each category of movies. Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
SELECT 
    c.name AS category_name, 
    COUNT(r.rental_id) AS total_rentals
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

-- Question 8: Find the average rental rate of movies in each language. Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT 
    l.name AS language, 
    AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

-- Questions 9 - Display the title of the movie, customer s first name, and last name who rented it. Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT 
    f.title, 
    c.first_name, 
    c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

-- Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind." Hint: Use JOIN between the film actor, film, and actor tables.
SELECT 
    a.first_name, 
    a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

-- Question 11: Retrieve the customer names along with the total amount they've spent on rentals. Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
SELECT 
    c.first_name, 
    c.last_name, 
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London'). Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.Advanced Joins and GROUP BY:
SELECT 
    c.first_name, 
    c.last_name, 
    f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.customer_id, f.title;

-- Question 13: Display the top 5 rented movies along with the number of times they've been rented. Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;

-- Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

-- WINDOW FUNCTION
-- 1. Rank the customers based on the total amount they've spent on rentals.
SELECT 
    customer_id, 
    first_name, 
    last_name, 
    SUM(amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS spending_rank
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer_id, first_name, last_name
ORDER BY total_spent DESC;

-- 2. Calculate the cumulative revenue generated by each film over time.
SELECT 
    f.film_id, 
    f.title, 
    p.payment_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date ROWS UNBOUNDED PRECEDING) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, p.payment_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT 
    f.title,
    f.length,
    AVG(f.rental_duration) AS average_duration
FROM film f
GROUP BY f.length, f.title
ORDER BY f.length, average_duration;

-- 4. Identify the top 3 films in each category based on their rental counts.
SELECT 
    c.name AS category_name,
    f.title,
    COUNT(r.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, f.film_id
HAVING rank_in_category <= 3
ORDER BY c.name, rental_count DESC;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
WITH CustomerRentals AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS total_rentals
    FROM 
        rental
    GROUP BY 
        customer_id
),
AverageRentals AS (
    SELECT 
        AVG(total_rentals) AS avg_rentals
    FROM 
        CustomerRentals
)
SELECT 
    cr.customer_id,
    cr.total_rentals,
    ar.avg_rentals,
    cr.total_rentals - ar.avg_rentals AS rental_difference
FROM 
    CustomerRentals cr
CROSS JOIN 
    AverageRentals ar;

-- 6. Find the monthly revenue trend for the entire rental store over time.
SELECT 
    YEAR(payment_date) AS year,
    MONTH(payment_date) AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH customer_spending AS (
    SELECT 
        customer_id, 
        SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
),
percentile_threshold AS (
    SELECT 
        PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY total_spent) AS spending_threshold
    FROM customer_spending
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    cs.total_spent
FROM customer c
JOIN customer_spending cs ON c.customer_id = cs.customer_id
JOIN percentile_threshold pt ON cs.total_spent >= pt.spending_threshold;

-- 8. Calculate the running total of rentals per category, ordered by rental count.
SELECT 
    c.name AS category_name,
    f.title,
    COUNT(r.rental_id) AS rental_count,
    SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS running_total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, f.film_id
ORDER BY c.category_id, rental_count DESC;

-- 9. Find the films that have been rented less than the average rental count for their respective categories.
WITH category_avg_rentals AS (
    SELECT 
        c.category_id, 
        c.name AS category_name, 
        AVG(rental_count) AS avg_rental_count
    FROM (
        SELECT 
            fc.category_id,
            f.film_id,
            COUNT(r.rental_id) AS rental_count
        FROM film_category fc
        JOIN film f ON fc.film_id = f.film_id
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        GROUP BY fc.category_id, f.film_id
    ) AS category_rentals
    JOIN category c ON category_rentals.category_id = c.category_id
    GROUP BY c.category_id
)
SELECT 
    f.title,
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY fc.category_id, f.film_id
HAVING COUNT(r.rental_id) < (SELECT avg_rental_count FROM category_avg_rentals WHERE category_avg_rentals.category_id = fc.category_id);

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT 
    YEAR(payment_date) AS year,
    MONTH(payment_date) AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY monthly_revenue DESC
LIMIT 5;

-- Normalisation & CTE
-- 1. First Normal Form (1NF): a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
#Let's assume we have a table customer_orders
CREATE TABLE customer_orders (
    customer_id INT,
    customer_name VARCHAR(50),
    orders VARCHAR(255) -- Comma-separated list of orders
);
#To normalize this table to 1NF
CREATE TABLE customer_orders_normalized (
    customer_id INT,
    customer_name VARCHAR(50),
    order_id INT
);


-- 2. Second Normal Form (2NF): a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
#Let's consider the film_actor table:
CREATE TABLE film_actor (
    actor_id INT,
    film_id INT,
    actor_name VARCHAR(50), -- Violates 2NF
    PRIMARY KEY (actor_id, film_id)
);
# normalize it to 2NF
CREATE TABLE actor (
    actor_id INT PRIMARY KEY,
    actor_name VARCHAR(50)
);

CREATE TABLE film_actor (
    actor_id INT,
    film_id INT,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- 3. Third Normal Form (3NF): a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
-- Let's consider the film table:
CREATE TABLE film (
    film_id INT PRIMARY KEY,
    title VARCHAR(100),
    director_name VARCHAR(50), -- Transitive dependency
    director_birthdate DATE -- Transitive dependency
);
# normalize it in 3NF
CREATE TABLE director (
    director_id INT PRIMARY KEY,
    director_name VARCHAR(50),
    director_birthdate DATE
);

ALTER TABLE film
ADD COLUMN director_id INT,
ADD FOREIGN KEY (director_id) REFERENCES director(director_id);



-- 4. Normalization Process: a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
CREATE TABLE rental (
    rental_id INT,
    customer_id INT,
    film_id INT,
    rental_date DATE
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE film (
    film_id INT PRIMARY KEY,
    film_title VARCHAR(100)
);



-- 5. CTE Basics: a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
WITH ActorFilmCount AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
)
SELECT first_name, last_name, film_count
FROM ActorFilmCount;


-- 6. CTE with Joins: a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.
WITH FilmLanguage AS (
    SELECT f.title AS film_title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT film_title, language_name, rental_rate
FROM FilmLanguage;

-- 7. CTE for Aggregation: a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables. 
WITH CustomerRevenue AS (
    SELECT p.customer_id, SUM(p.amount) AS total_revenue
    FROM payment p
    GROUP BY p.customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cr.total_revenue
FROM CustomerRevenue cr
JOIN customer c ON cr.customer_id = c.customer_id;


-- 8. CTE with Window Functions: a. Utilize a CTE with a window function to rank films based on their rental duration from the film table. 
WITH FilmRanking AS (
    SELECT title, rental_duration, RANK() OVER (ORDER BY rental_duration DESC) AS rank
    FROM film
)
SELECT title, rental_duration, rank
FROM FilmRanking;


-- 9.CTE and Filtering: a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
WITH FrequentRenters AS (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT c.customer_id, c.first_name, c.last_name
FROM FrequentRenters fr
JOIN customer c ON fr.customer_id = c.customer_id;
 
-- 10.CTE for Date Calculations: a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table. 
WITH MonthlyRentals AS (
    SELECT DATE_TRUNC('month', rental_date) AS month, COUNT(*) AS rental_count
    FROM rental
    GROUP BY month
)
SELECT month, rental_count
FROM MonthlyRentals;

-- 11. CTE and Self-Join: a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
WITH ActorPairs AS (
    SELECT fa1.actor_id AS actor1_id, fa2.actor_id AS actor2_id, fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id < fa2.actor_id
)
SELECT ap.actor1_id, ap.actor2_id, f.title
FROM ActorPairs ap
JOIN film f ON ap.film_id = f.film_id;

-- 12. CTE for Recursive Search: a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE reports_to = 1  -- Assuming 1 is the manager's staff_id
    UNION ALL
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT staff_id, first_name, last_name
FROM EmployeeHierarchy;
