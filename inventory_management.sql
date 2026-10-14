-- NOTE: This is a reset-and-seed script for a DEMO database.

CREATE DATABASE IF NOT EXISTS InventoryDB;
USE InventoryDB;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Schema and data-integrity constraints
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(55) NOT NULL,
    CategoryID INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    UnitsInStock INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_products_category
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_product_price CHECK (UnitPrice > 0),
    CONSTRAINT chk_product_stock CHECK (UnitsInStock >= 0),
    INDEX idx_products_category (CategoryID),
    INDEX idx_products_name (ProductName)
) ENGINE=InnoDB;

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    SaleDate DATE NOT NULL,
    QuantitySold INT NOT NULL,
    CONSTRAINT fk_sales_product
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_sales_quantity CHECK (QuantitySold > 0),
    INDEX idx_sales_product (ProductID),
    INDEX idx_sales_date (SaleDate)
) ENGINE=InnoDB;

-- 2. Sample categories
INSERT INTO Categories (CategoryID, CategoryName) VALUES
    (101, 'Electronics'),
    (102, 'Mobile Devices'),
    (103, 'Audio Accessories'),
    (104, 'Televisions'),
    (105, 'Cameras'),
    (106, 'Appliances'),
    (107, 'Home Cleaning'),
    (108, 'Kitchen Appliances'),
    (109, 'Personal Care'),
    (110, 'Laundry Appliances'),
    (111, 'Furniture'),
    (112, 'Office Furniture'),
    (113, 'Home Decor'),
    (114, 'Wall Art'),
    (115, 'Outdoor Living'),
    (116, 'Sports Equipment'),
    (117, 'Sporting Goods'),
    (118, 'Accessories'),
    (119, 'Stationery'),
    (120, 'Computer Accessories'),
    (121, 'Storage Devices'),
    (122, 'Mobile Accessories'),
    (123, 'Kitchenware'),
    (124, 'Dining & Serving'),
    (125, 'Bathroom Accessories'),
    (126, 'Cleaning Supplies'),
    (127, 'Pet Supplies'),
    (128, 'Gaming'),
    (129, 'Health & Fitness'),
    (130, 'First Aid & Medical'),
    (131, 'Personal Care & Beauty'),
    (132, 'Weather Gear'),
    (133, 'Travel Accessories');

-- 3. Sample products
-- Category corrections: Iron -> Laundry Appliances; Keyboard and Mouse -> Computer Accessories.
INSERT INTO Products (ProductID, ProductName, CategoryID, UnitPrice, UnitsInStock) VALUES
    (1, 'Laptop', 101, 1200.00, 50),
    (2, 'Smartphone', 102, 800.00, 100),
    (3, 'Tablet', 102, 500.00, 75),
    (4, 'Desktop Computer', 101, 1500.00, 30),
    (5, 'Headphones', 103, 100.00, 200),
    (6, 'Portable Speaker', 103, 150.00, 150),
    (7, 'Television', 104, 2000.00, 40),
    (8, 'Digital Camera', 105, 600.00, 80),
    (9, 'Microwave Oven', 106, 300.00, 120),
    (10, 'Refrigerator', 106, 1200.00, 60),
    (11, 'Vacuum Cleaner', 107, 250.00, 100),
    (12, 'Toaster', 108, 50.00, 150),
    (13, 'Coffee Maker', 108, 100.00, 100),
    (14, 'Blender', 108, 80.00, 120),
    (15, 'Electric Kettle', 108, 40.00, 200),
    (16, 'Iron', 110, 30.00, 180),
    (17, 'Hair Dryer', 109, 25.00, 250),
    (18, 'Washing Machine', 110, 800.00, 70),
    (19, 'Dishwasher', 110, 700.00, 60),
    (20, 'Sofa', 111, 600.00, 25),
    (21, 'Bed', 111, 800.00, 20),
    (22, 'Dining Table', 111, 400.00, 40),
    (23, 'Office Chair', 112, 150.00, 80),
    (24, 'Bookshelf', 112, 200.00, 60),
    (25, 'Curtains', 113, 50.00, 300),
    (26, 'Carpet', 113, 80.00, 150),
    (27, 'Wall Clock', 114, 20.00, 500),
    (28, 'Painting', 114, 300.00, 30),
    (29, 'Outdoor Grill', 115, 150.00, 70),
    (30, 'Garden Hose', 115, 30.00, 200),
    (31, 'Patio Furniture Set', 115, 800.00, 15),
    (32, 'Bicycle', 116, 400.00, 50),
    (33, 'Treadmill', 116, 1000.00, 20),
    (34, 'Dumbbell Set', 116, 150.00, 100),
    (35, 'Yoga Mat', 116, 20.00, 150),
    (36, 'Basketball', 117, 30.00, 80),
    (37, 'Football', 117, 25.00, 100),
    (38, 'Golf Clubs', 117, 200.00, 40),
    (39, 'Tennis Racket', 117, 80.00, 60),
    (40, 'Running Shoes', 118, 100.00, 150),
    (41, 'Backpack', 118, 50.00, 200),
    (42, 'Sunglasses', 118, 30.00, 250),
    (43, 'Watch', 118, 150.00, 100),
    (44, 'Fountain Pen', 119, 20.00, 300),
    (45, 'Notebook', 119, 5.00, 500),
    (46, 'Desk Lamp', 119, 40.00, 150),
    (47, 'Calculator', 119, 15.00, 200),
    (48, 'Printer', 120, 200.00, 50),
    (49, 'Scanner', 120, 150.00, 80),
    (50, 'Projector', 120, 500.00, 25),
    (51, 'External Hard Drive', 121, 100.00, 100),
    (52, 'USB Flash Drive', 121, 20.00, 300),
    (53, 'Keyboard', 120, 50.00, 150),
    (54, 'Mouse', 120, 30.00, 200),
    (55, 'Power Bank', 122, 40.00, 200),
    (56, 'Charger Cable', 122, 10.00, 300),
    (57, 'Wireless Earbuds', 122, 80.00, 150),
    (58, 'Phone Case', 122, 15.00, 250),
    (59, 'Kitchen Knife Set', 123, 50.00, 100),
    (60, 'Cutting Board', 123, 20.00, 150),
    (61, 'Cookware Set', 123, 100.00, 80),
    (62, 'Blender', 123, 80.00, 120),
    (63, 'Tea Set', 124, 30.00, 200),
    (64, 'Coffee Mug', 124, 10.00, 300),
    (65, 'Water Pitcher', 124, 20.00, 250),
    (66, 'Dinnerware Set', 124, 150.00, 100),
    (67, 'Bathroom Towel Set', 125, 40.00, 150),
    (68, 'Shower Curtain', 125, 15.00, 250),
    (69, 'Toothbrush Holder', 125, 10.00, 300),
    (70, 'Soap Dispenser', 125, 12.00, 200),
    (71, 'Laundry Detergent', 126, 20.00, 250),
    (72, 'Fabric Softener', 126, 15.00, 200),
    (73, 'Bleach', 126, 10.00, 300),
    (74, 'Cleaning Wipes', 126, 8.00, 400),
    (75, 'Dog Food', 127, 30.00, 150),
    (76, 'Cat Litter', 127, 25.00, 200),
    (77, 'Pet Bed', 127, 50.00, 100),
    (78, 'Fish Tank', 127, 80.00, 75),
    (79, 'Gaming Console', 128, 400.00, 50),
    (80, 'Video Games', 128, 60.00, 200),
    (81, 'Gaming Headset', 128, 80.00, 150),
    (82, 'Gaming Chair', 128, 200.00, 80),
    (83, 'Digital Watch', 129, 150.00, 100),
    (84, 'Fitness Tracker', 129, 100.00, 120),
    (85, 'Smart Scale', 129, 50.00, 150),
    (86, 'Bluetooth Earphones', 129, 70.00, 180),
    (87, 'First Aid Kit', 130, 30.00, 200),
    (88, 'Thermometer', 130, 10.00, 300),
    (89, 'Pain Reliever', 130, 15.00, 250),
    (90, 'Bandages', 130, 8.00, 400),
    (91, 'Sunscreen', 131, 12.00, 200),
    (92, 'Moisturizer', 131, 15.00, 250),
    (93, 'Facial Cleanser', 131, 10.00, 300),
    (94, 'Shampoo', 131, 8.00, 400),
    (95, 'Umbrella', 132, 20.00, 300),
    (96, 'Raincoat', 132, 40.00, 150),
    (97, 'Winter Jacket', 132, 80.00, 100),
    (98, 'Gloves', 132, 10.00, 500),
    (99, 'Backpack', 133, 50.00, 200),
    (100, 'Travel Pillow', 133, 15.00, 300);

-- 4. Sample sales 
-- These are historical sample transactions dated January-February 2024.
INSERT INTO Sales (SaleID, ProductID, SaleDate, QuantitySold) VALUES
    (1, 1, '2024-01-01', 3),
    (2, 5, '2024-01-02', 2),
    (3, 10, '2024-01-03', 1),
    (4, 17, '2024-01-04', 4),
    (5, 22, '2024-01-05', 2),
    (6, 31, '2024-01-06', 1),
    (7, 40, '2024-01-07', 3),
    (8, 48, '2024-01-08', 2),
    (9, 55, '2024-01-09', 5),
    (10, 63, '2024-01-10', 1),
    (11, 71, '2024-01-11', 4),
    (12, 79, '2024-01-12', 2),
    (13, 86, '2024-01-13', 3),
    (14, 94, '2024-01-14', 1),
    (15, 100, '2024-01-15', 2),
    (16, 5, '2024-01-16', 3),
    (17, 17, '2024-01-17', 2),
    (18, 22, '2024-01-18', 1),
    (19, 31, '2024-01-19', 4),
    (20, 40, '2024-01-20', 2),
    (21, 48, '2024-01-21', 1),
    (22, 55, '2024-01-22', 3),
    (23, 63, '2024-01-23', 2),
    (24, 71, '2024-01-24', 1),
    (25, 79, '2024-01-25', 5),
    (26, 86, '2024-01-26', 2),
    (27, 94, '2024-01-27', 3),
    (28, 100, '2024-01-28', 1),
    (29, 5, '2024-01-29', 2),
    (30, 17, '2024-01-30', 3),
    (31, 22, '2024-01-31', 1),
    (32, 31, '2024-02-01', 4),
    (33, 40, '2024-02-02', 2),
    (34, 48, '2024-02-03', 1),
    (35, 55, '2024-02-04', 5),
    (36, 63, '2024-02-05', 2),
    (37, 71, '2024-02-06', 3),
    (38, 79, '2024-02-07', 1),
    (39, 86, '2024-02-08', 4),
    (40, 94, '2024-02-09', 2),
    (41, 100, '2024-02-10', 1),
    (42, 5, '2024-02-11', 3),
    (43, 17, '2024-02-12', 2),
    (44, 22, '2024-02-13', 1),
    (45, 31, '2024-02-14', 4),
    (46, 40, '2024-02-15', 2),
    (47, 48, '2024-02-16', 1),
    (48, 55, '2024-02-17', 3),
    (49, 63, '2024-02-18', 2),
    (50, 71, '2024-02-19', 1);

-- 5. Synchronize inventory with the seeded sales ONCE as part of this reset script.
-- Aggregation is essential because a product may appear in multiple sales rows.
START TRANSACTION;
UPDATE Products AS p
JOIN (
    SELECT ProductID, SUM(QuantitySold) AS TotalSold
    FROM Sales
    GROUP BY ProductID
) AS s ON s.ProductID = p.ProductID
SET p.UnitsInStock = p.UnitsInStock - s.TotalSold
WHERE p.UnitsInStock >= s.TotalSold;
COMMIT;

-- 6. CRUD examples.
-- CREATE: add a product using an existing CategoryID.
-- INSERT INTO Products (ProductID, ProductName, CategoryID, UnitPrice, UnitsInStock)
-- VALUES (101, 'USB-C Hub', 120, 35.00, 25);

-- READ: view all products with their category names.
-- SELECT p.ProductID, p.ProductName, c.CategoryName, p.UnitPrice, p.UnitsInStock
-- FROM Products AS p JOIN Categories AS c ON c.CategoryID = p.CategoryID;

-- UPDATE: change a product price.
-- UPDATE Products SET UnitPrice = 125.00 WHERE ProductID = 5;

-- DELETE: only succeeds if no Sales row references the product.
-- DELETE FROM Products WHERE ProductID = 101;

-- 7. Reports
-- A. Total units sold and estimated sales value by product.
-- Estimated value uses current UnitPrice because historical sale price is not stored.
SELECT p.ProductID, p.ProductName,
       COALESCE(SUM(s.QuantitySold), 0) AS TotalUnitsSold,
       COALESCE(SUM(s.QuantitySold * p.UnitPrice), 0.00) AS EstimatedSalesValue
FROM Products AS p
LEFT JOIN Sales AS s ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY EstimatedSalesValue DESC, p.ProductName;

-- B. Total units sold and estimated sales value by category.
SELECT c.CategoryID, c.CategoryName,
       COALESCE(SUM(s.QuantitySold), 0) AS TotalUnitsSold,
       COALESCE(SUM(s.QuantitySold * p.UnitPrice), 0.00) AS EstimatedSalesValue
FROM Categories AS c
LEFT JOIN Products AS p ON p.CategoryID = c.CategoryID
LEFT JOIN Sales AS s ON s.ProductID = p.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY EstimatedSalesValue DESC, c.CategoryName;

-- C. Current inventory status and inventory value.
SELECT ProductID, ProductName, UnitsInStock, UnitPrice,
       UnitsInStock * UnitPrice AS InventoryValue
FROM Products
ORDER BY UnitsInStock ASC, ProductName;

-- D. Low-stock products (threshold: 10 units or fewer).
SELECT ProductID, ProductName, UnitsInStock
FROM Products
WHERE UnitsInStock <= 10
ORDER BY UnitsInStock ASC, ProductName;

-- E. Sales by date.
SELECT SaleDate, SUM(QuantitySold) AS TotalUnitsSold
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;

-- 8. Validation / sanity checks. Each query should return 0 rows.
SELECT * FROM Products WHERE UnitPrice <= 0 OR UnitsInStock < 0;
SELECT * FROM Sales WHERE QuantitySold <= 0;
SELECT p.ProductID, p.ProductName
FROM Products AS p
LEFT JOIN Categories AS c ON c.CategoryID = p.CategoryID
WHERE c.CategoryID IS NULL;
SELECT s.SaleID
FROM Sales AS s
LEFT JOIN Products AS p ON p.ProductID = s.ProductID
WHERE p.ProductID IS NULL;

-- Quick counts: expected 33 categories, 100 products, 50 sales rows.
SELECT 'Categories' AS TableName, COUNT(*) AS RowCount FROM Categories
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Sales', COUNT(*) FROM Sales;
