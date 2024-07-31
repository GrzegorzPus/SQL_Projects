USE AdventureWorks
GO

/* 1. From the HumanResources.Employee table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. 
Sort the result set in ascending order on jobtitle */

SELECT * FROM humanresources.Employee
ORDER BY jobtitle;

/* 2. From the Person.Person table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database.
 Sort the output in ascending order on lastname */

 SELECT * FROM person.Person AS a
 ORDER BY lastname;

 /* 3. From the Person.Person table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. 
 The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname */

 SELECT firstname, lastname, businessentityid as employee_id FROM person.Person
 ORDER BY lastname;

 /* 4. From the production.Product table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'.
 Return productid, productnumber, and name. Arranged the output in ascending order on name */

 SELECT productid, productnumber, name FROM production.Product
 WHERE sellstartdate IS NOT NULL
 AND productline = 'T'
 ORDER BY name;

 /* 5. Write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided.
 Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in descending order on subtotal */

 SELECT salesorderid, customerid, orderdate, subtotal, taxamt/subtotal as 'PercentageOfTax' FROM sales.salesorderheader
 ORDER BY subtotal DESC;

 /* 6. Write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. 
 Return jobtitle column and arranged the resultset in ascending order */

 SELECT DISTINCT jobtitle FROM humanresources.Employee
 ORDER BY jobtitle;

 /* 7. Write a query in SQL to calculate the total freight paid by each customer. 
 Return customerid and total freight. Sort the output in ascending order on customerid */

 SELECT customerid, SUM(freight) AS 'TotalFreight' FROM sales.salesorderheader
 GROUP BY customerid
 ORDER BY customerid;

 /* 8. Write a query in SQL to find the average and the sum of the subtotal for every customer. 
 Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. 
 Sort the result on customerid column in descending order */

 SELECT customerid, salespersonid, AVG(subtotal) AS 'AvgSubtotal', SUM(subtotal) AS 'SumSubtotal' FROM sales.salesorderheader
 GROUP BY customerid, salespersonid
 ORDER BY customerid DESC;

 /* 9. Write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. 
 Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
 Sort the results according to the productid in ascending order */

 SELECT productid, SUM(quantity) AS 'TotalQuanity' FROM production.ProductInventory
 WHERE shelf IN ('A','C','H')
 GROUP BY productid
 HAVING SUM(quantity) > 500
 ORDER BY productid;

 /* 10. Write a query in SQL to find the total quantity for a group of locationid multiplied by 10 */

 SELECT SUM(quantity) AS 'TotalQuantity' FROM production.ProductInventory
 GROUP BY (locationid * 10);

 /* 11. Write a query in SQL to find the persons whose last name starts with letter 'L'. 
 Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname */

SELECT p.businessentityid, firstname, lastname, phonenumber FROM person.PersonPhone AS pp
JOIN person.Person AS p
ON pp.businessentityid =  p.businessentityid
WHERE lastname LIKE 'L%'
ORDER BY lastname, firstname;

/* 12. Write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid.
Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal */

SELECT salespersonid, customerid, SUM(subtotal) AS 'SumSubtotal' FROM sales.SalesOrderHeader
GROUP BY ROLLUP(salespersonid, customerid);

/* 13. Write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column.
Return locationid, shelf and sum of quantity as TotalQuantity */

SELECT locationid, shelf, SUM(quantity) AS 'TotalQuantity' FROM production.ProductInventory
GROUP BY CUBE(locationid, shelf);

/* 14. Write a query in SQL to find the sum of the quantity with subtotal for each locationid.
Group the results for all combination of distinct locationid and shelf column.  Rolls up the results into subtotal and running total. 
Return locationid, shelf and sum of quantity as TotalQuantity */

SELECT locationid, shelf, SUM(quantity) AS 'TotalQuantity' FROM production.ProductInventory
GROUP BY GROUPING SETS (ROLLUP(locationid, shelf), CUBE(locationid, shelf));

/* 15. Write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
Return locationid and total quantity. Group the results on locationid */

SELECT locationid, SUM(quantity) AS 'TotalQuantity' FROM production.ProductInventory
GROUP BY ROLLUP(locationid);

/* 16. Write a query in SQL to retrieve the number of employees for each City. 
Return city and number of employees. Sort the result in ascending order on city */

SELECT A.city, COUNT(BEA.businessentityid) AS 'NumberOfEmployees' FROM person.BusinessEntityAddress AS BEA
JOIN person.Adress AS A
ON BEA.addressid = A.addressid
GROUP BY A.city
ORDER BY A.city;

/* 17. Write a query in SQL to retrieve the total sales for each year.
Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date */

SELECT YEAR(orderdate) AS 'Year', SUM(totaldue) AS 'TotalDueAmount' FROM sales.SalesOrderHeader
GROUP BY YEAR(orderdate)
ORDER BY YEAR(orderdate);

/* 18. Write a query in SQL to retrieve the total sales for each year. 
Filter the result set for those orders where order year is on or before 2016. 
Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date */

SELECT YEAR(orderdate) AS 'Year', SUM(totaldue) AS 'TotalDueAmount' FROM sales.SalesOrderHeader
GROUP BY YEAR(orderdate)
HAVING YEAR(orderdate) <= 2016
ORDER BY YEAR(orderdate);

/* 19. Write a query in SQL to find the contacts who are designated as a manager in various departments.
Returns ContactTypeID, name. Sort the result set in descending order */

SELECT contacttypeid, [name] FROM person.ContactType
WHERE [name] LIKE '%Manager%'
ORDER BY contacttypeid DESC;

/* 20. Write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName and FirstName */

SELECT P.BusinessEntityID, LastName, FirstName FROM person.BusinessEntityContact AS BEC
INNER JOIN person.ContactType AS CT
ON BEC.contacttypeid = CT.contacttypeid
INNER JOIN person.Person AS P
ON BEC.businessentityid = P.businessentityid
WHERE CT.name = 'Purchasing Manager'
ORDER BY LastName, FirstName;

/* 21. Write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. 
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order */

SELECT ROW_NUMBER() OVER (PARTITION BY postalcode ORDER BY salesytd DESC) AS 'rownumber' ,lastname, salesytd, postalcode FROM sales.SalesPerson AS SP
INNER JOIN person.Person AS P
ON SP.businessentityid = P.businessentityid
INNER JOIN person.Adress AS A
ON SP.businessentityid = A.addressid
WHERE SP.salesytd IS NOT NULL
AND territoryid IS NOT NULL
ORDER BY postalcode;

/* 22. Write a query in SQL to count the number of contacts for combination of each type and name. 
Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
Sort the result set in descending order on number of contacts */

SELECT BEC.contacttypeid, [name], COUNT(BEC.businessentityid) AS 'numberofcontacts' FROM person.BusinessEntityContact AS BEC
INNER JOIN person.ContactType AS CT
ON BEC.contacttypeid = CT.contacttypeid
GROUP BY BEC.contacttypeid, [name]
HAVING COUNT(BEC.businessentityid) >= 100
ORDER BY COUNT(BEC.businessentityid) DESC;

/* 23. Write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees.
In the output the RateChangeDate should appears in date format. 
Sort the output in ascending order on NameInFull */

SELECT CAST(EPH.ratechangedate AS DATE) AS ratechangedate,
CONCAT( P.lastname, ' ', p.middlename, ' ',P.firstname) AS 'fullname',
(EPH.rate * 40) AS 'salaryinaweek'
FROM humanresources.EmployeePayHistory AS EPH
INNER JOIN person.Person AS P
ON EPH.businessentityid = P.businessentityid
ORDER BY fullname;

/* 25. Write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity */

SELECT salesorderid, productid, orderqty,
SUM(orderqty) OVER(PARTITION BY salesorderid) AS 'TotalQuantity', 
AVG(orderqty) OVER(PARTITION BY salesorderid) AS 'AvgQuantity', 
COUNT(orderqty) OVER(PARTITION BY salesorderid) AS 'NumbersOfOrders', 
MIN(orderqty) OVER(PARTITION BY salesorderid) AS 'MinQuantity', 
MAX(orderqty) OVER(PARTITION BY salesorderid) AS 'MaxQuantity'
FROM sales.SalesOrderDetail
WHERE salesorderid IN (43659, 43664);