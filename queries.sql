
-- 1.Get the names and the quantities in stock for each product.
SELECT productname, unitinstock, quantityperunit
FROM products
WHERE unitinstock <> 0;

-- 2.Get a list of current products (Product ID and name).
SELECT productid, productname
FROM products;

-- 3. Get a list of the most and least expensive products (name and unit price).
SELECT productname, unitprice
FROM products
WHERE unitprice = (SELECT MAX(unitprice) FROM products)
OR unitprice = (SELECT MIN(unitprice) FROM products);

-- 4.Get products that cost less than $20.
SELECT productname, unitprice
FROM products 
WHERE unitprice < 20;

-- 5. Get products that cost between $15 and $25.
SELECT productname, unitprice
FROM products 
WHERE unitprice BETWEEN 15 AND 25;

-- 6. Get products above average price.
SELECT productname, unitprice
FROM products 
WHERE unitprice > (SELECT AVG(unitprice) FROM products);

-- 7. Find the ten most expensive products.
SELECT productname, unitprice
FROM products 
ORDER BY unitprice 
DESC 
LIMIT 10;

-- 8. Get a list of discontinued products (Product ID and name).
SELECT productid, productname 
FROM products 
WHERE discontinued = 1;

-- 9. Count current and discontinued products.
SELECT discontinued, COUNT(discontinued) AS number_of_products 
FROM products 
GROUP BY discontinued;

-- 10. Find products with less units in stock than the quantity on order.
SELECT productname, unitinstock, unitsonorder
FROM products
WHERE unitinstock < unitsonorder

-- 11. Find the customer who had the highest order amount
SELECT customers.customerid, customers.companyname, customers.contactname, customers.contacttitle, COUNT(customers.customerid) AS orders
FROM customers, orders
WHERE orders.customerid = customers.customerid
GROUP BY customers.customerid
ORDER BY orders DESC
LIMIT 1;

-- 12. Get orders for a given employee and the according customer
SELECT employees.titleofcourtesy || '  ' || employees.firstname || '  ' || employees.lastname AS employees,
customers.companyname AS customers, products.productname, order_details.quantity AS order_quantity
FROM customers, employees, orders, order_details, products
WHERE orders.customerid = customers.customerid
AND orders.orderid = order_details.orderid
AND employees.employeeid = orders.employeeid
AND order_details.productid = products.productid;

-- 13. Find the hiring age of each employee
SELECT employeeid, lastname, firstname, DATE_PART('year', hiredate) - DATE_PART('year', birthdate) AS hiring_age
FROM employees

-- 15. Number of orders per month for specific product
SELECT products.productname, DATE_PART('month', orders.orderdate) AS orders_month, count(order_details.quantity) orders_per_month
FROM order_details, products, orders
WHERE order_details.productid = products.productid
AND order_details.orderid = orders.orderid
AND products.productid = 59
GROUP BY products.productname, orders_month
ORDER BY orders_month

-- 15. Create views and/or named queries for some of these queries
CREATE VIEW orders_employee_customer AS
SELECT employees.titleofcourtesy || '  ' || employees.firstname || '  ' || employees.lastname AS employees,
customers.companyname AS customers, products.productname, order_details.quantity AS order_quantity
FROM customers, employees, orders, order_details, products
WHERE orders.customerid = customers.customerid
AND orders.orderid = order_details.orderid
AND employees.employeeid = orders.employeeid
AND order_details.productid = products.productid;
--------------------------------