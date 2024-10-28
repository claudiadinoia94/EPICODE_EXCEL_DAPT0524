-- Task 4: Dopo aver popolate le tabelle, scrivi delle query utili a:  

-- 1)

SELECT 
	SalesOrderNumber
    , SalesOrderLineNumber -- la tabella Sales ha una chiave composita
    , COUNT(*)
FROM Sales
GROUP BY 
	SalesOrderNumber
    , SalesOrderLineNumber
HAVING COUNT(*) > 1
	;

SELECT 
	ProductID
    , COUNT(*)
FROM Product
GROUP BY 
	ProductID
HAVING COUNT(*) > 1
	;

SELECT
	CategoryID
    , COUNT(*)
FROM Category
GROUP BY 
	CategoryID
HAVING COUNT(*) > 1
	;

SELECT
	RegionID
    , COUNT(*)
FROM Region
GROUP BY 
	RegionID
HAVING COUNT(*) > 1
	;

SELECT
	CountryID
    , COUNT(*)
FROM Country
GROUP BY 
	CountryID
HAVING COUNT(*) > 1
	;


-- 2) 

SELECT 
	S.SalesOrderNumber				AS DocumentCode
	, S.OrderDate					AS 'Date'
    , P.ProductName					AS Product
    , Ca.CategoryName				AS Category
    , R.RegionName					AS Region
    , Co.CountryName				AS Country
    , (DATEDIFF(CURRENT_DATE, s.Orderdate) > 180) AS '+180days'
FROM 
	Sales AS S
INNER JOIN 
	Product AS P
ON S.ProductID = P.ProductID
INNER JOIN 
	Category AS Ca
ON P.CategoryID = Ca.CategoryID
INNER JOIN 
	Country AS Co
ON S.RegionID = Co.RegionID
INNER JOIN 
	Region AS R
ON Co.RegionID = r.RegionID
ORDER BY S.OrderDate ASC;


-- 3) 
SELECT 
	s.ProductID
    , SUM(s.OrderQuantity) 		AS TotalQuantity
FROM 
	Sales  						AS S
WHERE YEAR(s.OrderDate) = (SELECT 
								MAX(YEAR(OrderDate)) 
                                FROM Sales)
GROUP BY s.ProductID
HAVING SUM(s.OrderQuantity) > (SELECT 
								 AVG(OrderQuantity)
								 FROM Sales
WHERE YEAR(OrderDate) = (SELECT 
								MAX(YEAR(OrderDate)) 
                                FROM Sales)
);

-- 4)  
SELECT 
    S.ProductID					AS PrKey
    , P.ProductName					AS Product
	, YEAR(S.OrderDate)				AS Anno
    , SUM(S.SalesAmount)			AS TotalSalesperY
FROM 
	Sales							AS  S
INNER JOIN
	Product							AS P
ON S.ProductID = P.ProductID
WHERE s.OrderQuantity > 0  
GROUP BY S.ProductID, YEAR(S.OrderDate)
ORDER BY Anno, S.ProductID
;

-- 5) 
    
SELECT YEAR(s.OrderDate) AS DataVendita,
       co.CountryName AS Stato,
       SUM(s.salesamount) AS Totalefatturato
FROM Sales s
JOIN Country co ON s.RegionID = co.RegionID
GROUP BY YEAR(s.OrderDate), co.CountryName
ORDER BY YEAR(s.OrderDate) ASC, Totalefatturato DESC;


-- 6) 

SELECT 
	Ca.CategoryName			AS Categoria
    , SUM(S.SalesAmount)	AS TotalSales
FROM 
	Product					AS P
INNER JOIN Sales			AS S
ON P.ProductID = S.ProductID
INNER JOIN 
	Category				AS Ca
ON P.CategoryID = Ca.CategoryID
GROUP BY Categoria
ORDER BY TotalSales DESC
LIMIT 1;

-- 7) 
-- 1° CASO
SELECT 
    p.ProductID  			AS 'ProductCode'
    , p.ProductName 		AS 'productname'
FROM 
    Product 				AS p
WHERE 
    p.ProductID NOT IN (SELECT 
							s.ProductID
							FROM Sales AS S);
                            
-- 2° CASO
SELECT 
	s.ProductID  		AS 'ProductCode'
    , p.ProductName 	AS 'productname'
FROM 
	Sales AS s 
LEFT JOIN Product p 
ON s.ProductID = p.ProductID
WHERE s.ProductID IS NULL;


-- 8) 

CREATE VIEW VW_ClaDiNoia_Prodotti AS 
SELECT
	p.ProductID			AS 'Code'
    , p.ProductName			AS 'Name'
    , ca.CategoryName			AS Category
FROM 
	product					AS p
LEFT OUTER JOIN 
	Category				AS ca
ON p.categoryID = ca.categoryID;	

-- 9)  

CREATE VIEW VW_ClaDiNoia_Geografia AS 
SELECT
	CountryID				AS GeoID
    , CountryName			AS State
    , RegionName			AS Area
FROM 
	Country 				AS co
LEFT OUTER JOIN 
	Region					AS r
ON r.regionID = co.regionID;	


