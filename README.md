# SQL Project Using AdventureWorks Database

## Introduction

Welcome to my SQL project, where I dive deep into SQL querying using the renowned AdventureWorks database. This project is inspired by the SQL exercises available on [w3resource](https://www.w3resource.com/), and I will be addressing 200 diverse SQL queries based on their prompts. The goal is to showcase proficiency in SQL by solving real-world scenarios, which can be beneficial for both learning and demonstrating SQL skills.

## AdventureWorks Database

The AdventureWorks database is a sample database provided by Microsoft that is widely used for learning and testing SQL Server queries. It contains a variety of tables and data related to a fictitious company called Adventure Works Cycles, which manufactures and sells bicycles and related products.

### Database Schema

The database includes several schemas such as:

- **Person**: Information about individuals.
- **Production**: Details about products and manufacturing.
- **Sales**: Sales transactions and order information.
- **Purchasing**: Supplier and purchase order details.
- **HumanResources**: Employee data and related HR information.

## Setting Up the Project

To set up the project locally, follow the steps below:

### Prerequisites

- SQL Server Management Studio (SSMS)
- SQL Server instance (local or remote)
- AdventureWorks database backup file

### Steps

1. **Restore the AdventureWorks Database**:
    - Download the `AdventureWorks.bak` file from the `Data` directory.
    - Open SQL Server Management Studio (SSMS).
    - Connect to your SQL Server instance.
    - Right-click on the `Databases` node and select `Restore Database`.
    - Choose the `Device` option and browse to select the `AdventureWorks.bak` file.
    - Follow the prompts to restore the database.

2. **Clone the Repository**:

    ```bash
    git clone https://github.com/YourUsername/AdventureWorks_SQL_Project.git
    cd SQL_Project
    ```

3. **Run the SQL Queries**:
    - Open SSMS and connect to your SQL Server instance.
    - Open each `.sql` file from the `SQL` directory and execute the queries against the AdventureWorks database.

## Queries

Each SQL file in the `SQL` directory addresses a specific prompt from [w3resource SQL exercises](https://www.w3resource.com/sql-exercises/). The queries range from basic SELECT statements to more complex operations involving joins, subqueries, and stored procedures.

### Example Queries

####  Write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.

```sql
SELECT
    ROW_NUMBER() OVER (PARTITION BY postalcode ORDER BY salesytd DESC) AS 'rownumber',
    lastname, salesytd,
    postalcode FROM sales.SalesPerson AS SP
INNER JOIN person.Person AS P
    ON SP.businessentityid = P.businessentityid
INNER JOIN person.Adress AS A
    ON SP.businessentityid = A.addressid
WHERE SP.salesytd IS NOT NULL
    AND territoryid IS NOT NULL
ORDER BY postalcode;
```

## Additional Resources

- [Microsoft AdventureWorks Sample Databases]([https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)): This page provides information on how to download and set up the AdventureWorks sample databases. It also includes links to related resources and documentation.
- [w3resource SQL Exercises](https://www.w3resource.com/sql-exercises/adventureworks/adventureworks-exercises.php): A comprehensive collection of SQL exercises ranging from basic to advanced levels. This site offers practical problems and solutions to help improve your SQL skills.
- [SQL Server Management Studio (SSMS)](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15): The official download page for SQL Server Management Studio (SSMS). SSMS is an integrated environment for managing any SQL infrastructure, from SQL Server to Azure SQL Database.
