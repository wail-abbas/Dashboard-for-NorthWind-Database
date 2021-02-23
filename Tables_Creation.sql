DROP TABLE IF EXISTS employee_territories;
DROP TABLE IF EXISTS territories;
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS shippers;
DROP TABLE IF EXISTS categories;




CREATE TABLE categories (
    categoryID SERIAL PRIMARY KEY,
    categoryName VARCHAR(50) NOT NULL,
    description VARCHAR(150),
    picture BYTEA
);


CREATE TABLE shippers (
    shipperID SERIAL PRIMARY KEY,
    companyName VARCHAR(100),    
    phone VARCHAR(50)
);


CREATE TABLE customers (
    customerID VARCHAR(5) PRIMARY KEY,
    companyName VARCHAR(50) NOT NULL,    
    contactName VARCHAR(50),    
    contactTitle VARCHAR(30),
    address VARCHAR(100),
    city VARCHAR(20),
    region VARCHAR(30),
    postalCode VARCHAR(10),
    country VARCHAR(30),
    phone VARCHAR(50),
    fax VARCHAR(50)
);


CREATE TABLE suppliers (
    supplierID SERIAL PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL,    
    contactName VARCHAR(50),
    contactTitle VARCHAR(30),
    address VARCHAR(100),
    city VARCHAR(20),
    region VARCHAR(30),
    postalCode VARCHAR(10),
    country VARCHAR(30),
    phone VARCHAR(50),
    fax VARCHAR(50),
    homePage VARCHAR
);


CREATE TABLE employees (
    employeeID SERIAL PRIMARY KEY,
    lastName VARCHAR(30) NOT NULL,    
    firstName VARCHAR(30),    
    title VARCHAR(30),
    titleOfCourtesy VARCHAR(10),
    birthDate TIMESTAMP,
    hireDate TIMESTAMP,
    address VARCHAR(100),
    city VARCHAR(20),
    region VARCHAR(30),
    postalCode VARCHAR(10),
    country VARCHAR(30),
    homePhone VARCHAR(50),
    extension INTEGER,
    photo BYTEA,
    notes VARCHAR,
    reportsTo INTEGER,
    photoPath VARCHAR
);


CREATE TABLE orders (
    orderID SERIAL PRIMARY KEY,
    customerID VARCHAR(5) NOT NULL,    
    employeeID SMALLINT NOT NULL,    
    orderDate TIMESTAMP,
    requiredDate TIMESTAMP,
    shippedDate TIMESTAMP,
    shipVia SMALLINT,
    freight REAL,
    shipName VARCHAR(100),
    shipAddress VARCHAR(100),
    shipCity VARCHAR(20),
    shipRegion VARCHAR(30),
    shipPostalCode VARCHAR(10),
    shipCountry VARCHAR(30),
FOREIGN KEY(customerID) REFERENCES customers(customerID),
FOREIGN KEY (employeeID) REFERENCES employees(employeeID)
FOREIGN KEY (shipVia) REFERENCES shippers(shipperID)
);

CREATE TABLE products (
    productID SERIAL PRIMARY KEY NOT NULL,
    productName VARCHAR(50) NOT NULL,    
    supplierID INTEGER NOT NULL,    
    categoryID INTEGER NOT NULL,
    quantityPerUnit VARCHAR(50),
    unitPrice REAL,
    unitInStock INTEGER,
    unitsOnOrder INTEGER,
    reorderLevel INTEGER,
    discontinued INTEGER,
FOREIGN KEY(supplierID) REFERENCES suppliers(supplierID),
FOREIGN KEY(categoryID) REFERENCES categories(categoryID)
);

CREATE TABLE order_details (
    orderID SERIAL NOT NULL,
    productID INTEGER NOT NULL,    
    unitPrice REAL,    
    quantity INTEGER,
    discount REAL,
FOREIGN KEY(orderID) REFERENCES orders(orderID),
FOREIGN KEY(productID) REFERENCES products(productID)
);

CREATE TABLE regions (
    regionID SERIAL PRIMARY KEY,
    regionDescription VARCHAR(50)  
);


CREATE TABLE territories (
    territoryID INTEGER PRIMARY KEY,
    territoryDescription VARCHAR(50),
    regionID INTEGER,
FOREIGN KEY(regionID)
REFERENCES regions(regionID)
);

CREATE TABLE employee_territories (
    employeeID SERIAL NOT NULL,
    territoryID INTEGER NOT NULL,
FOREIGN KEY(employeeID) REFERENCES employees(employeeID), 
FOREIGN KEY(territoryID) REFERENCES territories(territoryID)
);

COPY categories (
    categoryID,
    categoryName,
    description,
    picture
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/categories.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY shippers (
    shipperID,
    companyName,
    phone
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/shippers.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;



COPY customers (
    customerID,
    companyName,
    contactName,
    contactTitle,
    address,
    city,
    region,
    postalCode,
    country,
    phone,
    fax
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/customers.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY suppliers (
    supplierID,
    companyName,
    contactName,
    contactTitle,
    address,
    city,
    region,
    postalCode,
    country,
    phone,
    fax,
    homePage
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/suppliers.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY employees (
    employeeID,
    lastName,
    firstName,
    title,
    titleOfCourtesy,
    birthDate,
    hireDate,
    address,
    city,
    region,
    postalCode,
    country,
    homePhone,
    extension,
    photo,
    notes,
    reportsTo,
    photoPath
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/employees.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY orders (
    orderID,
    customerID,
    employeeID,
    orderDate,
    requiredDate,
    shippedDate,
    shipVia,
    freight,
    shipName,
    shipAddress,
    shipCity,
    shipRegion,
    shipPostalCode,
    shipCountry
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/orders.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY products (
    productID,
    productName,    
    supplierID,    
    categoryID,
    quantityPerUnit,
    unitPrice,
    unitInStock,
    unitsOnOrder,
    reorderLevel,
    discontinued
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/products.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY order_details (
    orderID,
    productID,
    unitPrice,
    quantity,
    discount
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/order_details.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY regions (
    regionID,
    regionDescription
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/regions.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY territories (
    territoryID,
    territoryDescription,
    regionID 
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/territories.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;


COPY employee_territories (
    employeeID,
    territoryID
)
FROM '/home/wail/spiced_projects/wail/week_06/project06/data/employee_territories.csv'
DELIMITER ','
NULL AS 'NULL'
CSV HEADER;
