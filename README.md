# SQL-Exists-Not-Exists-IN-Not-In-DATE-TIME

SQL PRACTICE 

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

-----------------------------------------------------------------------------------------------------

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



**--------------EXISTS & NOT EXISTS-----------------------------------------**

FIND ALL PRODUCTS THAT HAVE BEEN SOLD AT LEAST ONCE.

FIND ALL PRODUCTS THAT HAVE NEVER BEEN SOLD.

FIND ALL CUSTOMERS IN 'NORTH AMERICA' WHO HAVE MADE AT LEAST ONE PURCHASE.

FIND ALL CUSTOMERS IN 'NORTH AMERICA' WHO HAVE NEVER MADE A PURCHASE.

FIND CATEGORIES THAT HAVE AT LEAST ONE PRODUCT SOLD.

FIND CUSTOMERS IN 'NORTH AMERICA' WHO HAVE NEVER MADE A PURCHASE.

FIND CUSTOMERS WHO HAVE MADE AT LEAST ONE PURCHASE.

FIND PRODUCTS THAT HAVE NEVER BEEN SOLD.

**--------------------DATE TIME RELATED QUESTIONS --------------------------**

LAST ONE HOUR SALES FROM TODAYS DATE

LAST ONE HOUR SALES FROM LAST SALES DATE

LAST MONTH TOTAL SALES FROM TODAYS DATE

LAST MONTH TOTAL SALES FROM LAST SALES DATE

LAST YEAR TOTAL SALES FROM TODAYS DATE

**---------------IN & NOT IN------------------------------------------------**
 
Find sales for products in specific categories (using IN)

Find sales for products not in specific categories (using NOT IN)

Find customers from specific countries (using IN)

Find customers not from specific countries (using NOT IN)

Find customers in specific regions (using IN)

Find customers not in specific regions (using NOT IN)
