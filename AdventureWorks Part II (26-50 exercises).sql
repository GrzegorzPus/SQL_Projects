USE AdventureWorks
GO

/* 26.Write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. 
Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity */

SELECT salesorderid, productid, orderqty,
SUM(orderqty) OVER (ORDER BY salesorderid, productid) AS 'sum',
AVG(orderqty) OVER (PARTITION BY salesorderid ORDER BY salesorderid, productid) AS 'average',
COUNT(orderqty) OVER (ORDER BY SalesOrderID, ProductID ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS 'numberoforder'
FROM sales.SalesOrderDetail
WHERE salesorderdetailid IN (43659, 43664)
AND CAST(productid AS VARCHAR) LIKE '71%';

/* 27. Write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. 
Return SalesOrderID, total cost */

SELECT salesorderid, SUM(unitprice * orderqty) AS 'totalcost'  FROM sales.SalesOrderDetail
GROUP BY salesorderid
HAVING SUM(unitprice * orderqty) > 100000;

/* 28. Write a query in SQL to retrieve products whose names start with 'Lock Washer'. 
Return product ID, and name and order the result set in ascending order on product ID column */

SELECT productid, [name] FROM production.Product
WHERE [name] LIKE 'Lock Washer%'
ORDER BY productid;

/* 29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. 
Return product ID, name, and color of the product */

SELECT productid, [name], color FROM production.Product
ORDER BY listprice;

/* 30. Write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate.
Return BusinessEntityID, JobTitle, and HireDate */

SELECT businessentityid, jobtitle, hiredate FROM humanresources.Employee
ORDER BY YEAR(hiredate);

/* 31. Write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns */

SELECT lastname, firstname FROM person.Person
WHERE lastname LIKE 'R%'
ORDER BY firstname, lastname DESC;

/* 32. Write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'.
Return BusinessEntityID, SalariedFlag columns */

SELECT businessentityid, salariedflag FROM humanresources.Employee
ORDER BY
	CASE salariedflag WHEN '1' THEN businessentityid END DESC,
	CASE salariedflag WHEN '0' THEN businessentityid END;

/* 33. Write a query in SQL to set the result in order by the column TerritoryName
when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows */

SELECT businessentityid, lastname, territoryname, countryregionname FROM sales.SalesPerson
WHERE territoryname IS NOT NULL 
ORDER BY CASE countryregionname WHEN 'United States' THEN territoryname  
         ELSE countryregionname END;

/* 34. Write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. 
Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. 
Order the output on postalcode column */

SELECT firstname, lastname, 
ROW_NUMBER() OVER (ORDER BY A.postalcode) AS 'rownumber',
RANK() OVER (ORDER BY A.postalcode) AS 'rank',
DENSE_RANK() OVER (ORDER BY A.postalcode) AS 'denserank',
NTILE(4) OVER (ORDER BY A.postalcode) AS 'quartile',
salesytd, postalcode
FROM sales.SalesPerson AS SP
INNER JOIN person.Person AS P
ON SP.businessentityid = P.businessentityid
INNER JOIN person.Adress AS A
ON SP.businessentityid = A.addressid
WHERE territoryid IS NOT NULL
AND salesytd <> 0;

/* 35. Write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows */

SELECT DepartmentID, [Name], GroupName FROM humanresources.Department
ORDER BY DepartmentID
OFFSET 10 ROWS;

/* 36. Write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set */

SELECT DepartmentID, [Name], GroupName FROM humanresources.Department
ORDER BY DepartmentID
	OFFSET 5 ROWS
	FETCH NEXT 5 ROWS ONLY;

/* 37. Write a query in SQL to list all the products that are Red or Blue in color. 
Return name, color and listprice.Sorts this result by the column listprice */

SELECT [name], color, listprice FROM production.Product
WHERE color IN ('Red', 'Blue')
ORDER BY listprice;

/* 38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. 
Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. 
Return product name, salesorderid. Sort the result set on product name column */

SELECT P.name, SOD.salesorderid FROM production.Product AS P
FULL OUTER JOIN sales.SalesOrderDetail AS SOD
ON P.productid = SOD.productid
ORDER BY P.name;

/* 39. Write a SQL query to retrieve the product name and salesorderid. 
Both ordered and unordered products are included in the result set */

SELECT P.name, SOD.salesorderid FROM production.Product AS P
LEFT JOIN sales.SalesOrderDetail AS SOD
ON P.productid = SOD.productid
ORDER BY P.name;

/* 40. Write a SQL query to get all product names and sales order IDs. 
Order the result set on product name column */

SELECT P.name, SOD.salesorderid FROM production.Product AS P
INNER JOIN sales.SalesOrderDetail AS SOD
ON P.productid = SOD.productid
ORDER BY P.name;

/* 41. Write a SQL query to retrieve the territory name and BusinessEntityID. 
The result set includes all salespeople, regardless of whether or not they are assigned a territory */

SELECT ST.territoryid, SP.businessentityid FROM sales.SalesTerritory AS ST
RIGHT JOIN sales.SalesPerson AS SP
ON ST.businessentityid = SP.businessentityid;

/* 42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. 
Order the result set on lastname then by firstname */

SELECT 
CONCAT(P.firstname, ' ', P.lastname) AS 'fullname',
A.city
FROM person.Person AS P
INNER JOIN person.BusinessEntityAddress AS BEA
	ON P.businessentityid = BEA.businessentityid
INNER JOIN person.Adress AS A
	ON BEA.addressid = A.addressid
ORDER BY P.lastname, P.firstname;

/* 43. Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'.
Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table */

SELECT businessentityid, firstname,lastname FROM 
	(SELECT * FROM person.Person
	WHERE persontype = 'IN') AS DerivedTable
WHERE lastname = 'Adams'
ORDER BY firstname;

/* 44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500,
a lastname starting with 'Al', and a firstname starting with 'M' */

SELECT businessentityid, firstname, lastname FROM person.Person
WHERE businessentityid <= 1500
AND lastname LIKE 'Al%'
AND firstname LIKE 'M%';

/* 45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values */

SELECT productid, P.[name], color FROM production.Product AS P
INNER JOIN (VALUES ('Blade'), ('Crown Race'), ('AWC Logo Cap')) AS DerivedTable([name])
ON P.[name] = DerivedTable.[name];

/* 46. Create a SQL query to display the total number of sales orders each sales representative receives annually.
Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order.
Return the year component of the OrderDate, SalesPersonID, and SalesOrderID */

WITH SalesCTE(salespersonid, salesorderid, salesyear) AS(
	SELECT salespersonid, salesorderid, YEAR(orderdate) AS 'salesyear' FROM sales.SalesOrderHeader
	WHERE salespersonid IS NOT NULL)
SELECT salespersonid, COUNT(salesorderid) AS 'totalsales', salesyear FROM SalesCTE
GROUP BY salesyear, salespersonid
ORDER BY salespersonid, salesyear;

/* 47. Write a query in SQL to find the average number of sales orders for all the years of the sales representatives */

WITH SalesCTE(salespersonid, numberoforders) AS(
	SELECT salespersonid, COUNT(*) AS 'numberoforders' FROM sales.SalesOrderHeader
	WHERE salespersonid IS NOT NULL
	GROUP BY salespersonid)
SELECT AVG(numberoforders) AS 'avgnumberoforders' FROM SalesCTE;

/* 48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field.
The following table's columns must all be returned */

SELECT * FROM production.roductPhoto  
WHERE largephotofilename LIKE '%greena_%' ESCAPE 'a';

/* 49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa.
Return Addressline1, Addressline2, city, postalcode, countryregioncode columns */

SELECT A.addressline1, A.addressline2, A.city, A.postalcode, SP.countryregioncode FROM person.Adress AS A
INNER JOIN person.StateProvince AS SP
ON A.stateprovinceid = SP.stateprovinceid
WHERE SP.countryregioncode NOT IN ('US')
AND city LIKE 'Pa%';

/* 50. Write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. 
Order the result set on hiredate column in descending order */

SELECT TOP 20 
jobtitle, hiredate FROM humanresources.Employee
ORDER BY hiredate DESC;