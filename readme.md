# Inventory Management System

## Project Overview

A beginner-friendly relational database project built with MySQL. It manages product and category information, records sample sales, updates inventory based on those sales, and produces basic inventory and sales reports.

## Tech Stack
- MySQL 8.0.16 or newer (for enforced `CHECK` constraints)
- SQL: DDL, DML, joins, aggregation, constraints, and reporting queries

## Database Schema

### `Categories`
| Column | Description |
|---|---|
| `CategoryID` | Primary key |
| `CategoryName` | Required, unique category name |

### `Products`
| Column | Description |
|---|---|
| `ProductID` | Primary key |
| `ProductName` | Required product name |
| `CategoryID` | Foreign key to `Categories.CategoryID` |
| `UnitPrice` | Required price; must be greater than zero |
| `UnitsInStock` | Required stock count; must be zero or greater |

### `Sales`
| Column | Description |
|---|---|
| `SaleID` | Primary key |
| `ProductID` | Foreign key to `Products.ProductID` |
| `SaleDate` | Required date of sale |
| `QuantitySold` | Required positive quantity |

The foreign keys use `ON DELETE RESTRICT` to protect categories and products referenced by other records. Indexes are added to commonly joined/searched columns.

## Included Features

- Sample data: 33 categories, 100 products, and 50 sales records.
- Basic create, read, update, and delete examples (commented out so they do not modify the sample data automatically).
- Foreign-key relationships and `CHECK` constraints for price, stock, and sale quantity.
- Inventory adjustment based on the **sum** of all seeded sales for each product.
- Reports for units sold and estimated sales value by product and category, current inventory value, low-stock products, and sales by date.
- Sanity-check queries for invalid values and broken references.

## How to Run

1. Use MySQL 8.0.16+ in MySQL Workbench or the MySQL command line.
2. Open `inventory_management.sql`.
3. Read the warning at the top: the script drops and recreates the project's three tables. Back up any data you need before running it.
4. Execute the whole script in order.
5. Review the report outputs and sanity checks. The four validation queries should return zero rows. The final count query should show 33 categories, 100 products, and 50 sales records.

The script is designed as a reproducible demo reset. Because it resets the tables, rerunning it recreates the original sample data and applies the seeded sales deduction once to that fresh data.

## Important Design Notes

- The sample sales are dated January-February 2024 and are for demonstration only.
- `Sales` does not store the price at the time of sale. Therefore, `EstimatedSalesValue` uses the product's **current** price and is not a guaranteed historical revenue figure. A future version should store `UnitPriceAtSale` in each sales record.
- The script adjusts stock after inserting the sample sales by aggregating each product's total sold quantity. For a live application, sale recording and stock deduction should happen together in a transaction that locks/checks the product stock, so stock cannot become negative and the same sale cannot be deducted twice.
- The `CHECK` constraints require MySQL 8.0.16 or newer to be enforced.
- Category assignments were corrected for Iron (Laundry Appliances), Keyboard, and Mouse (Computer Accessories).

## Testing Checklist

The SQL file includes sanity-check queries. Before describing the project as fully tested, also manually verify:

- Duplicate primary keys are rejected.
- A product with a nonexistent category is rejected.
- A sale with a nonexistent product is rejected.
- Zero/negative prices, negative stock, and zero/negative sold quantities are rejected.
- Deleting a category/product that is referenced by another row is rejected.
- Re-running the reset script restores the seed data rather than applying stock deductions twice.
- Products with no sales still appear in reports because the reports use `LEFT JOIN`.

## Limitations / Future Improvements

- Add `UnitPriceAtSale` to preserve historical sale values.
- Add a stored procedure or application transaction for safe sale entry and stock deduction.
- Add supplier, purchase-order, and stock-movement tables if the system is expanded.
- Add automated test scripts and screenshots of successful query outputs.

## Conclusion

This project demonstrates relational schema design, foreign keys, validation constraints, CRUD examples, joins, aggregate functions, inventory updates, and SQL reporting. It is a portfolio-level SQL project; its current sample data and reports are educational rather than a complete production inventory solution.
