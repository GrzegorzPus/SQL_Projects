USE AdventureWorks
GO

/* 51. Write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100. 
Return all the columns from the tables */

SELECT * FROM sales.SalesOrderHeader AS SOH
JOIN sales.SalesOrderDetail AS SOD
ON SOH.salesorderid = SOD.salesorderid
WHERE (orderqty > 5 OR unitpricediscount < 100)
AND totaldue > 100;

/* 52. Write a query in SQL that searches for the word 'red' in the name column. Return name, and color columns from the table */

SELECT [name], color FROM production.Product
WHERE [name] LIKE '%red%';

/* 53. Write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain.
Return name, and listprice columns from the table */

SELECT [name], listprice FROM production.Product
WHERE listprice = 80.99
AND [name] LIKE '%Mountain%';

/* 54. Write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road.
Return name, and color columns */

SELECT [name], color FROM production.Product
WHERE [name] LIKE '%Mountain%'
OR [name] LIKE '%Road%';

/* 55. Write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'.
Return Name and color */

SELECT [name], color FROM production.Product
WHERE [name] LIKE '%Mountain%'
  AND [name] LIKE '%Black%';

/* 56. Write a query in SQL to return all the product names with at least one word starting with the prefix chain in the Name column */

SELECT [name], color FROM production.Product
WHERE [name] LIKE '%chain %'
	OR [name] LIKE '%chain';

/* 57. Write a query in SQL to return all category descriptions containing strings with prefixes of either chain or full */

SELECT [name], color FROM production.Product
WHERE [name] LIKE '%chain %'
	OR [name] LIKE '%chain'
	OR [name] LIKE '%full%';

/* 58. Write a SQL query to output an employee's name and email address, separated by a new line character */

SELECT 
CONCAT(firstname, ' ', lastname,  CHAR(13) + CHAR(10), emailaddress)
FROM person.Person AS P
JOIN person.EmailAddress AS EA
ON P.businessentityid = EA.businessentityid;

/* 59. Write a SQL query to locate the position of the string "yellow" where it appears in the product name */

SELECT [name], CHARINDEX('yellow', [name]) AS positionofyellow
FROM production.product
WHERE [name] LIKE '%yellow%';

/* 60 Write a query in SQL to concatenate the name, color, and productnumber columns */

SELECT
CONCAT([name], ',', color, ' ,',productnumber) AS result
FROM production.Product;

/* 61 Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character from the following table, each separated by a specified character */

SELECT 
CONCAT_WS( ',', [name], productnumber, color,CHAR(10)) AS databaseinfo
FROM production.Product;

/* 62 Write a query in SQL to return the five leftmost characters of each product name */

SELECT LEFT([name],5) AS leftmostfivechars FROM production.Product;

/* 63 Write a query in SQL to select the number of characters and the data in FirstName for people located in Australia */

SELECT LENGTH(firstname) AS 'Length', firstname, lastname
FROM sales.IndividualCustomer
WHERE countryregionname = 'Australia';

/* 64 Write a query in SQL to return the number of characters in the column FirstName and the first and last name of contacts located in Australia */

SELECT LENGTH(firstname) AS 'Length', firstname, lastname
FROM sales.StoreWithContacts AS e SWC
INNER JOIN sales.StoreWithAddresses AS SWA
ON SWC.businessentityid = SWA.businessentityid   
WHERE CountryRegionName = 'Australia';

/* 65 Write a query in SQL to select product names that have prices between $1000.00 and $1220.00. 
Return product name as Lower, Upper, and also LowerUpper */

SELECT
LOWER([name]) AS 'lower',
UPPER([name]) AS 'upper',
LOWER(UPPER(SUBSTRING([name], 1, 25))) As 'lowerupper'
FROM production.Product
WHERE standardcost BETWEEN 1000 AND 1220;

/* 66 Write a query in SQL to remove the spaces from the beginning of a string */

SELECT  '     five space then the text' AS 'originaltext',
LTRIM('     five space then the text') AS 'rimmedtext';

/* 67 Write a query in SQL to remove the substring 'HN' from the start of the column productnumber.
Filter the results to only show those productnumbers that start with "HN".
Return original productnumber column and 'TrimmedProductnumber' */

SELECT productnumber,SUBSTRING(productnumber, 4, LEN(productnumber) - 2)  as 'trimmedproductnumber'FROM production.Product
WHERE productnumber  LIKE 'HN%';

/* 68 Write a query in SQL to repeat a 0 character four times in front of a production line for production line 'T */

SELECT [name], CONCAT(REPLICATE('0',4), productline) AS 'linecode' FROM production.Product
WHERE productline = 'T';

/* 69 Write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6 */

SELECT firstname, REVERSE(firstname) AS 'reverse ' FROM person.Person
WHERE businessentityid < 6
ORDER BY firstname;

/* 70 Write a query in SQL to return the eight rightmost characters of each name of the product.
Also return name, productnumber column. Sort the result set in ascending order on productnumber */

SELECT [name], productnumber,RIGHT([name],8) AS 'productname' FROM production.Product
ORDER BY productnumber;

/* 71 Write a query in SQL to remove the spaces at the end of a string */

SELECT CONCAT('text then five spaces     ','after space') as 'originaltext',
CONCAT(RTRIM('text then five spaces     '),'after space') as 'trimmedtext';

/* 72 Write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. Return productnumber and name */

SELECT productnumber, [name] FROM production.Product
WHERE[name] LIKE '%[SML]';

/* 73 Write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row */

SELECT STRING_AGG(COALESCE(firstname, 'N/A'), ', ') AS 'test'
FROM person.Person;

/*74 Write a query in SQL to return the names and modified date separated by commas in a single row */

SELECT STRING_AGG(CONCAT(firstname, ' ', lastname, ' ', '(', modifieddate, ')'), ', ') AS 'test'
FROM person.Person;

/* 75 Write a query in SQL to find the email addresses of employees and groups them by city. Return top ten rows */

SELECT TOP 10 city, STRING_AGG(CAST(emailaddress AS VARCHAR(100)), ';') AS 'emails'
FROM person.BusinessEntityAddress AS BEA
JOIN person.Adress AS A
ON BEA.addressid = A.addressid
JOIN person.EmailAddress AS EA
ON EA.businessentityid = BEA.businessentityid
GROUP BY city;