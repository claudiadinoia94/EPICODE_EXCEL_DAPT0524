/*W10D1 - Pratica */

/*Interrogare e filtrare le tabella */
SELECT *
FROM dimproduct;

_________________________________________________________ LEZIONE 
/*conta le righe*/

select count(*)
from dimproduct;
select count(*) cout (dimproduct)
from dimproduct;

/*Conta in maniera distinta le chiavi primarie */

select count(*) cout (distinct Productkey)
from dimproduct;
________________________________________________________ LEZIONE 

/*Connettiti al db aziendale o esegui il restore del db*/

select 
from

/*Esplora la tabelle dei prodotti (DimProduct)*/

Select 
from 

/*nella tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. 
Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.*/

SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag
from dimproduct;

/*Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.*/

SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag
from dimproduct;
where FinishedGoodsFlag = 1; 

/*Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK. 
Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).*/

SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, ListPrice
from dimproduct
where  ProductAlternateKey LIKE 'FR%'
OR ProductAlternateKey LIKE'BK%';

/*Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dall’azienda (ListPrice - StandardCost)*/

SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, ListPrice , ListPrice-StandardCost as markup 
from dimproduct
where  ProductAlternateKey LIKE 'FR%'
OR ProductAlternateKey LIKE'BK%';


/*scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.*/

SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, ListPrice , ListPrice-StandardCost as markup ,FinishedGoodsFlag 
FROM dimproduct
WHERE FinishedGoodsFlag =1 
AND ListPrice BETWEEN 1000 AND 2000
order by listprice -- asc/desc ;

/*Esplora la tabella degli impiegati aziendali (DimEmployee)*/

SELECT *
FROM dimemployee;

/*Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.*/

SELECT EmployeeKey,ParentEmployeeKey,title,FirstName,MiddleName,LastName,EmailAddress,SalesPersonFlag,Phone
FROM dimemployee
WHERE SalespersonFlag=1;


/*Interroga la tabella delle vendite (FactResellerSales). 
Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).*/

SELECT *
FROM factresellersales
WHERE 
ProductKey in ( 597,598,477,214) AND OrderDate > '2020-01-01'
order by OrderDate ;
