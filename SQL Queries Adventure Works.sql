use advworks;

select * from dimcustomer;
select * from dimdate;
select * from dimproductfinal;
select * from dimsalesterritory;
select * from factsales;

-- 1.The Productname from the Productfinal
SELECT s.OrderDateKey, p.EnglishProductName, s.SalesAmount
FROM FactSales s
JOIN DimProductFinal p ON s.ProductKey = p.ProductKey;

-- 2.Unit Price
SELECT p.EnglishProductName, s.UnitPrice
FROM FactSales s
JOIN DimProductFinal p ON s.ProductKey = p.ProductKey;

-- 3 Year wise Sales
SELECT d.Year, SUM(s.SalesAmount) AS TotalSales
FROM FactSales s
JOIN DimDate d ON s.OrderDateKey = d.DateKey
GROUP BY d.Year;

-- 4 Month wise Sales
SELECT d.MonthFullName, SUM(s.SalesAmount) AS Sales
FROM FactSales s
JOIN DimDate d ON s.OrderDateKey = d.DateKey
GROUP BY d.MonthFullName;

-- 5 Quarter wise Sales
SELECT d.Quarter, SUM(s.SalesAmount) AS Sales
FROM FactSales s
JOIN DimDate d ON s.OrderDateKey = d.DateKey
GROUP BY d.Quarter;

-- 6 Weekday performance
SELECT DAYNAME(d.FullDateAlternateKey) AS Weekday, SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN DimDate d ON s.OrderDateKey = d.DateKey
GROUP BY Weekday;

-- 7 Total sales amount
SELECT SUM(SalesAmount) AS TotalSales FROM FactSales;

-- 8 Total production cost
SELECT SUM(UnitPrice * OrderQuantity) AS ProductionCost
FROM FactSales;

-- 9 Top 10 products by sales 
SELECT p.EnglishProductName, SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN DimProductFinal p ON s.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY Sales DESC
LIMIT 10;

-- 10 Category-wise sales
SELECT EnglishProductCategoryName, SUM(SalesAmount) Sales
FROM FactSales s
JOIN DimProductFinal p ON s.ProductKey = p.ProductKey
GROUP BY EnglishProductCategoryName;

-- 11 Top customers by sales
SELECT c.CustomerFullName Customer,
SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN DimCustomer c ON s.CustomerKey = c.CustomerKey
GROUP BY Customer
ORDER BY Sales DESC;

-- 12 Gender-wise sales
SELECT c.Gender, SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN DimCustomer c ON s.CustomerKey = c.CustomerKey
GROUP BY c.Gender;

-- 13 Region-wise sales
SELECT c.SalesTerritoryRegion, SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN dimsalesterritory c ON s.SalesTerritoryKey = c.SalesTerritoryKey
GROUP BY c.SalesTerritoryRegion;

-- 14 Year over year growth
SELECT d.Year, SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN DimDate d ON s.OrderDateKey = d.DateKey
GROUP BY d.Year;

-- 15 Best sales month
SELECT d.MonthFullName, SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN DimDate d ON s.OrderDateKey = d.DateKey
GROUP BY d.MonthFullName
ORDER BY Sales DESC
LIMIT 1;

-- 16 Total Orders
SELECT COUNT(*) TotalOrders FROM FactSales;

-- 17 Average order value
SELECT AVG(SalesAmount) AvgOrderValue FROM FactSales;

-- 18 Sales per customer
SELECT CustomerKey, SUM(SalesAmount) Sales
FROM FactSales
GROUP BY CustomerKey;

-- 19 Repeat customer
SELECT CustomerKey, COUNT(*) Orders
FROM FactSales
GROUP BY CustomerKey
HAVING Orders > 1;

-- 20 Highest selling category per year
SELECT d.Year, p.EnglishProductCategoryName, SUM(s.SalesAmount) Sales
FROM FactSales s
JOIN DimProductFinal p ON s.ProductKey = p.ProductKey
JOIN DimDate d ON s.OrderDateKey = d.DateKey
GROUP BY d.Year, p.EnglishProductCategoryName;

