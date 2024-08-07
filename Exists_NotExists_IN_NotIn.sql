/**CREATE DATABASE SALESDATADB

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SALESDATADB')
BEGIN
    CREATE DATABASE [DataBase]
    PRINT 'DATABASE CREATED'
END
GO
USE [SALESDATADB]
PRINT 'DATABASE ALREADY EXISTS'
GO

IF NOT EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'SALES'
          and xtype = 'U'
)
BEGIN
    CREATE TABLE SALES
    (
        SALEID INT PRIMARY KEY NOT NULL,
        PRODUCT_ID INT,
        CUSTOMER_ID INT,
        SALEDATE DATE,
        AMOUNT DECIMAL(20, 4),
        FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCTID),
        FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMERID)
    )
END
ELSE
BEGIN
    PRINT 'TABLE ALREADY EXISTS'
END

IF NOT EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'PRODUCT'
          and xtype = 'U'
)
BEGIN
    CREATE TABLE PRODUCT
    (
        PRODUCTID INT PRIMARY KEY NOT NULL,
        PRODUCTNAME VARCHAR(100),
        CATEGORY_ID INT,
        FOREIGN KEY (CATEGORY_ID) REFERENCES PRODUCTCATEGORY (CATEGORYID)
    )
END
ELSE
BEGIN
    PRINT 'TABLE ALREADY EXISTS'
END

IF NOT EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'PRODUCTCATEGORY'
          and xtype = 'U'
)
BEGIN
    CREATE TABLE PRODUCTCATEGORY
    (
        CATEGORYID INT PRIMARY KEY NOT NULL,
        CATEGORYNAME VARCHAR(100)
    )
END
ELSE
BEGIN
    PRINT 'TABLE ALREADY EXISTS'
END


IF NOT EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'CUSTOMER'
          and xtype = 'U'
)
BEGIN
    CREATE TABLE CUSTOMER
    (
        CUSTOMERID INT PRIMARY KEY NOT NULL,
        CUSTOMERNAME VARCHAR(100),
        COUNTRY_ID INT,
        FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRY (COUNTRYID)
    )
END
ELSE
BEGIN
    PRINT 'TABLE ALREADY EXISTS'
END

IF NOT EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'COUNTRY'
          and xtype = 'U'
)
BEGIN
    CREATE TABLE COUNTRY
    (
        COUNTRYID INT PRIMARY KEY NOT NULL,
        COUNTRYNAME VARCHAR(100),
        REGION_ID INT,
        FOREIGN KEY (REGION_ID) REFERENCES REGION (REGIONID)
    )
END
ELSE
BEGIN
    PRINT 'TABLE ALREADY EXISTS'
END

IF NOT EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'REGION'
          and xtype = 'U'
)
BEGIN
    CREATE TABLE REGION
    (
        REGIONID INT PRIMARY KEY NOT NULL,
        REGIONNAME VARCHAR(100)
    )
END
ELSE
BEGIN
    PRINT 'DATABASE ALREADY EXISTS'
END

INSERT INTO SALES(SALEID,PRODUCT_ID,	CUSTOMER_ID	,SALEDATE	,AMOUNT) VALUES
(1,1,1,'2023-01-01',100.00),
(2,2,2,'2023-01-02',200.00),
(3,1,3,'2023-01-03',150.00)

INSERT INTO PRODUCT (PRODUCTID,PRODUCTNAME,CATEGORY_ID) VALUES
(1,			'PRODUCT A', 1),
(2,			'PRODUCT B', 2),
(3,			'PRODUCT C', 1)

INSERT INTO PRODUCTCATEGORY (CATEGORYID,CATEGORYNAME) VALUES
(1, 'CATEGORY X'),
(2,	'CATEGORY Y')


INSERT INTO CUSTOMER (CUSTOMERID,CUSTOMERNAME,COUNTRY_ID) VALUES
(1,'CUSTOMER A',1),
(2,'CUSTOMER B',2),
(3,'CUSTOMER C',1),
(4,'CUSTOMER D',3)

INSERT INTO COUNTRY (COUNTRYID,COUNTRYNAME,REGION_ID) VALUES
(1,	'COUNTRY 1',1),
(2,	'COUNTRY 2',2),
(3,	'COUNTRY 3',1)

INSERT INTO REGION (REGIONID,REGIONNAME) VALUES
(1,	'NORTH AMERICA'),
(2,'EUROPE')

**/
-----------------------EXISTS & NOT EXISTS RELATED QUESTIONS-----------
--FIND ALL PRODUCTS THAT HAVE BEEN SOLD AT LEAST ONCE.
SELECT P.PRODUCTID, P.PRODUCTNAME
FROM PRODUCT P
WHERE EXISTS (
    SELECT 1
    FROM SALES S
    WHERE S.PRODUCT_ID = P.PRODUCTID
);

--FIND ALL PRODUCTS THAT HAVE NEVER BEEN SOLD.
SELECT P.PRODUCTID, P.PRODUCTNAME
FROM PRODUCT P
WHERE NOT EXISTS (
    SELECT 1
    FROM SALES S
    WHERE S.PRODUCT_ID = P.PRODUCTID
);

--FIND ALL CUSTOMERS IN 'NORTH AMERICA' WHO HAVE MADE AT LEAST ONE PURCHASE.
SELECT C.CUSTOMERID, C.CUSTOMERNAME
FROM CUSTOMER C
JOIN COUNTRY CO ON C.COUNTRY_ID = CO.COUNTRYID
JOIN REGION R ON CO.REGION_ID = R.REGIONID
WHERE R.REGIONNAME = 'NORTH AMERICA'
  AND EXISTS (
    SELECT 1
    FROM SALES S
    WHERE S.CUSTOMER_ID = C.CUSTOMERID
);

--FIND ALL CUSTOMERS IN 'NORTH AMERICA' WHO HAVE NEVER MADE A PURCHASE.
SELECT C.CUSTOMERID, C.CUSTOMERNAME
FROM CUSTOMER C
JOIN COUNTRY CO ON C.COUNTRY_ID = CO.COUNTRYID
JOIN REGION R ON CO.REGION_ID = R.REGIONID
WHERE R.REGIONNAME = 'NORTH AMERICA'
  AND NOT EXISTS (
    SELECT 1
    FROM SALES S
    WHERE S.CUSTOMER_ID = C.CUSTOMERID
);

--FIND CATEGORIES THAT HAVE AT LEAST ONE PRODUCT SOLD.
SELECT PC.CATEGORYID, PC.CATEGORYNAME
FROM PRODUCTCATEGORY PC
WHERE EXISTS (
    SELECT 1
    FROM PRODUCT P
    JOIN SALES S ON P.PRODUCTID = S.PRODUCT_ID
    WHERE P.CATEGORY_ID = PC.CATEGORYID
);

--FIND CUSTOMERS IN 'NORTH AMERICA' WHO HAVE NEVER MADE A PURCHASE.

SELECT C.CUSTOMERID, C.CUSTOMERNAME
FROM CUSTOMER C
JOIN COUNTRY CO ON C.COUNTRY_ID = CO.COUNTRYID
JOIN REGION R ON CO.REGION_ID = R.REGIONID
WHERE R.REGIONNAME = 'NORTH AMERICA'
  AND NOT EXISTS (
    SELECT 1
    FROM SALES S
    WHERE S.CUSTOMER_ID = C.CUSTOMERID
);

-- FIND CUSTOMERS WHO HAVE MADE AT LEAST ONE PURCHASE.
SELECT C.CUSTOMERID, C.CUSTOMERNAME
FROM CUSTOMER C
WHERE EXISTS (
    SELECT 1
    FROM SALES S
    WHERE S.CUSTOMER_ID = C.CUSTOMERID
);

--FIND PRODUCTS THAT HAVE NEVER BEEN SOLD.
SELECT P.PRODUCTID, P.PRODUCTNAME
FROM PRODUCT P
WHERE NOT EXISTS (
    SELECT 1
    FROM SALES S
    WHERE S.PRODUCT_ID = P.PRODUCTID
);

--------------------DATE TIME RELATED QUESTIONS --------------------------
-- LAST ONE HOUR SALES
--SCANARIO 1 -
SELECT SUM(AMOUNT) AS TOTALSALES
FROM SALES
WHERE SALEDATE >= DATEADD(HOUR, -1, GETDATE());

--SCANARIO 2 -
DECLARE @MAXDATE DATETIME;
SELECT  @MAXDATE = MAX(SALEDATE) FROM SALES;
SELECT SUM(AMOUNT) AS TOTALSALES FROM SALES WHERE SALEDATE >= DATEADD(HOUR, -1, @MAXDATE);

--LAST MONTH TOTAL SALES FROM TODAYS DATE
SELECT SUM(AMOUNT) AS TOTALSALES
FROM SALES
WHERE SALEDATE >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
  AND SALEDATE < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0);

--LAST MONTH TOTAL SALES FROM LAST SALES DATE
DECLARE @MAXDATE1 DATETIME;
SELECT  @MAXDATE1 = MAX(SALEDATE) FROM SALES;
SELECT SUM(AMOUNT) AS TOTALSALES
FROM SALES
WHERE SALEDATE >= DATEADD(MONTH, DATEDIFF(MONTH, 0, @MAXDATE1) - 1, 0)
  AND SALEDATE < DATEADD(MONTH, DATEDIFF(MONTH, 0, @MAXDATE1), 0);

--LAST YEAR TOTAL SALES FROM TODAYS DATE
SELECT SUM(AMOUNT) AS TOTALSALESLASTYEAR
FROM SALES
WHERE SALEDATE >= DATEADD(YEAR, -1, GETDATE()) AND SALEDATE < GETDATE();


---------------IN & NOT IN---------
 
--Example 1: Find sales for products in specific categories (using IN)

SELECT SaleID, Product_ID, Amount
FROM Sales
WHERE Product_ID IN (SELECT ProductID FROM Product WHERE Category_ID IN (1, 2));

--Example 2: Find sales for products not in specific categories (using NOT IN)

SELECT SaleID, Product_ID, Amount
FROM Sales
WHERE Product_ID NOT IN (SELECT ProductID FROM Product WHERE Category_ID IN (1, 2));

--Example 3: Find customers from specific countries (using IN)

SELECT CustomerID, CustomerName
FROM Customer
WHERE Country_ID IN (1, 2);

---Example 4: Find customers not from specific countries (using NOT IN)

SELECT CustomerID, CustomerName
FROM Customer
WHERE Country_ID NOT IN (1, 2);

--Example 5: Find customers in specific regions (using IN)

SELECT c.CustomerID, c.CustomerName
FROM Customer c
JOIN Country co ON c.Country_ID = co.CountryID
JOIN Region r ON co.Region_ID = r.RegionID
WHERE r.RegionName IN ('North America', 'South America');

--Example 6: Find customers not in specific regions (using NOT IN)

SELECT c.CustomerID, c.CustomerName
FROM Customer c
JOIN Country co ON c.Country_ID = co.CountryID
JOIN Region r ON co.Region_ID = r.RegionID
WHERE r.RegionName NOT IN ('North America', 'South America');
