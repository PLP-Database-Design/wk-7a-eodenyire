-- Question 1 Achieving 1NF (First Normal Form)
-- Original table:
-- OrderID   CustomerName   Products
-- 101       John Doe       Laptop, Mouse
-- 102       Jane Smith     Tablet, Keyboard, Mouse
-- 103       Emily Clark    Phone

-- SQL to transform the ProductDetail table to 1NF:
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data into ProductDetail ensuring each row has a single product:
INSERT INTO ProductDetail (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Question 2 Achieving 2NF (Second Normal Form) 
-- Original table:
-- OrderID   CustomerName   Product   Quantity
-- 101       John Doe       Laptop   2
-- 101       John Doe       Mouse    1
-- 102       Jane Smith     Tablet   3
-- 102       Jane Smith     Keyboard 1
-- 102       Jane Smith     Mouse    2
-- 103       Emily Clark    Phone    1

-- Step 1: Create Orders table to remove partial dependency (CustomerName depends on OrderID)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 3: Create Product table to store Product and Quantity separately
CREATE TABLE Product (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 4: Insert data into Product table
INSERT INTO Product (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
