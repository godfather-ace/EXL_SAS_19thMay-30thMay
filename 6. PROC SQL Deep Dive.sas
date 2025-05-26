/*==============================================================================*/
/*==============================================================================*/

/*
PROC SQL - It calls the SQL procedure and QUIT statement ends the procedure.
*/

/* The syntax of PROC SQL is as follows: */
/*
PROC SQL;
  SELECT column(s)
  FROM table(s) | view(s)
  WHERE expression
  GROUP BY column(s)
  HAVING expression
  ORDER BY column(s);
QUIT;
*/

/*
The SQL statements must be specified in the following order:
SELECT : Specify the columns (variables) to be selected.
FROM : Specify the table (dataset) to be queried.
WHERE : Filters the data based on a condition.
GROUP BY : Classifies data into groups based on the specified columns.
HAVING : Filters data with the GROUP BY clause.
ORDER BY : Sorts the rows (observations) by the specified columns.
*/

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - COMMAND BLUEPRINTS(FORMAT) */
/* 
CREATE - 
INSERT -
UPDATE -
ALTER -
DROP -
DELETE - 
SELECT -
SELECT with WHERE Clause - 
*/ 

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - CREATE */
PROC SQL;
	CREATE TABLE Emp
	(EmpID INT, EmpName CHAR(30), DeptID INT, DOB NUM FORMAT date9.);
	DESCRIBE TABLE Emp;
QUIT;

/*  Creating table using LIKE keyword from another table */
PROC SQL;
	CREATE TABLE EMP1 LIKE EMP;
QUIT;

/* PROC SQL - INSERT */
/* Giving column names is optional, unless blank (NULL) values are needed to be filled */ 
PROC SQL;
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (101, 'Alice Smith', 20, '01JAN1990'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (102, 'Bob Johnson', 10, '15MAR1985'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (103, 'Charlie Brown', 20, '22JUN1992'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (104, 'Diana Lee', 30, '10NOV1988'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (105, 'Ethan Davis', 10, '05MAY1995'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (106, 'Fiona Green', 20, '28SEP1987'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (107, 'George Harris', 30, '12FEB1991'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (108, 'Hannah Clark', 10, '03AUG1989'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (109, 'Ian White', 20, '18APR1993'd);
  	INSERT INTO Emp (EmpID, EmpName, DeptID, DOB)
  	VALUES (110, 'Julia Adams', 30, '25JUL1986'd);
QUIT;

/* Verifying the inserted records */
PROC PRINT 
	DATA=Emp;
RUN;

/* Creating table using AS keyword from another table */
PROC SQL;
	CREATE TABLE Emp1 AS
		SELECT * FROM Emp;
	DESCRIBE TABLE Emp1;
quit;

/* PROC SQL - CREATE & INSERT (Another Example) */ 
PROC SQL;
	CREATE TABLE FinancialTransactions 
	(	
		TransactionID INT,
	    TransactionDate DATE FORMAT date9.,
	    AccountID INT,
	    TransactionType CHAR(10) CHECK (TransactionType IN ('Debit', 'Credit')),
	    Amount NUM,
	    Currency CHAR(3),
	    Description CHAR(200),
	    Department CHAR(50),
	    CostCenter CHAR(10),
	    TransactionStatus CHAR(15) CHECK (TransactionStatus IN ('Pending', 'Approved', 'Rejected', 'Completed')),
	    ReportingPeriod CHAR(7)
	);
QUIT;

PROC SQL;
  	DESCRIBE TABLE FinancialTransactions;
QUIT;

PROC SQL;
  	INSERT INTO FinancialTransactions VALUES
  	(1, '15May2025'd, 1001, 'Debit', 50.00, 'USD', 'Office Supplies Purchase', 'Admin', 'CC001', 'Completed', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(2, '16May2025'd, 2005, 'Credit', 1200.00, 'USD', 'Sales Revenue - Product A', 'Sales', 'CC002', 'Completed', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(3, '17May2025'd, 3010, 'Debit', 75.50, 'EUR', 'Employee Travel Expense', 'Marketing', 'CC003', 'Approved', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(4, '18May2025'd, 1002, 'Debit', 250.00, 'USD', 'IT Software License Renewal', 'IT', 'CC004', 'Completed', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(5, '18May2025'd, 2008, 'Credit', 850.75, 'USD', 'Service Fee Income', 'Services', 'CC005', 'Completed', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(6, '18May2025'd, 4001, 'Debit', 1500.00, 'USD', 'Monthly Rent Payment', 'Admin', 'CC001', 'Completed', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(7, '19May2025'd, 2010, 'Credit', 300.00, 'GBP', 'Consulting Services Revenue', 'Consulting', 'CC006', 'Approved', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(8, '19May2025'd, 3005, 'Debit', 45.20, 'USD', 'Marketing Material Printing', 'Marketing', 'CC003', 'Pending', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(9, '19May2025'd, 1005, 'Debit', 99.99, 'USD', 'Employee Training Subscription', 'HR', 'CC007', 'Completed', '2025-Q2');
  	INSERT INTO FinancialTransactions VALUES
  	(10, '20May2025'd, 2012, 'Credit', 210.50, 'USD', 'Interest Income', 'Finance', 'CC008', 'Rejected', '2025-Q2');
QUIT;


PROC PRINT 
	DATA=FinancialTransactions;
RUN;

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - ALTER (ADD COLUMNS) */
PROC SQL;
	ALTER TABLE Emp ADD Deptname VARCHAR;
	ALTER TABLE Emp ADD Sal NUM;
quit;

/* PROC SQL - ALTER (DROP COLUMNS) */
PROC SQL;
	ALTER TABLE Emp DROP Deptname;
quit;

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - UPDATE */
PROC SQL;
	UPDATE Emp SET Sal = 3500 WHERE Sal eq .;
	SELECT * FROM Emp;
quit;

PROC SQL;
	UPDATE Emp SET Sal = 2500 WHERE DeptID eq 10;
	UPDATE Emp SET Sal = 3000 WHERE DeptID eq 20;
	SELECT * FROM Emp;
QUIT;

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - DELETE */ 
PROC SQL;
	DELETE * FROM Emp WHERE EmpID in(105,106);
	SELECT * from Emp;
QUIT;

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - DROP */
PROC SQL;
	CREATE TABLE Emp101 AS SELECT * FROM Emp;
	DROP TABLE Emp101;
QUIT;

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - SELECT with Inbuilt Datasets */
PROC SQL;
 	SELECT * FROM sashelp.class;
QUIT;

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - Creating Data from Existing Data */
PROC SQL;
 	CREATE TABLE Class_New AS
  	SELECT * FROM sashelp.class;
QUIT;

/*==============================================================================*/
/*==============================================================================*/

/* PROC SQL - WHERE Clause */
PROC SQL;
	SELECT TransactionType,
		Amount,
		Department, 
		TransactionStatus
	FROM FINANCIALTRANSACTIONS
	WHERE Department='Marketing';
QUIT;

/* WHERE Clause - Operator List */
/* 
1. = or EQ (equal to)
2. ^=, ~=, or NE (not equal to)
3. > or GT (greater than)
4. < or LT (less than)
5. >= or GE (greater than or equal to)
6. <= or LE (less than or equal to)
7. IN (equal to one of a list)
8. NOT IN (not equal to one of a list)
*/

/* PROC SQL - WHERE Clause with AND Operator */
PROC SQL;
	SELECT TransactionType,
		Amount,
		Department, 
		TransactionStatus
	FROM FINANCIALTRANSACTIONS
	WHERE Department='Marketing' AND TRANSACTIONSTATUS='Approved';
QUIT;

/* PROC SQL - WHERE Clause with OR Operator */
PROC SQL;
	SELECT TransactionType,
		Amount,
		Department, 
		TransactionStatus
	FROM FINANCIALTRANSACTIONS
	WHERE Department='Marketing' OR Department='Admin';
QUIT;

/* PROC SQL - WHERE Clause with IN Operator */
PROC SQL;
	SELECT TransactionType,
		Amount,
		Department, 
		TransactionStatus
	FROM FINANCIALTRANSACTIONS
	WHERE Department IN ('Marketing', 'Admin', 'HR');
QUIT;

/* PROC SQL - WHERE Clause with NOT IN Operator */
PROC SQL;
	SELECT TransactionType,
		Amount,
		Department, 
		TransactionStatus
	FROM FINANCIALTRANSACTIONS
	WHERE Department NOT IN ('Marketing', 'Admin', 'HR');
QUIT;

/* PROC SQL - WHERE Clause with NE (NOT EQ) */
PROC SQL;
	SELECT TransactionType,
		Amount,
		Department, 
		TransactionStatus
	FROM FINANCIALTRANSACTIONS
	WHERE Department NE 'Marketing';
QUIT;

/* PROC SQL - WHERE Clause with Relational Operators */
PROC SQL;
	SELECT TransactionType,
		Amount,
		Department, 
		TransactionStatus
	FROM FINANCIALTRANSACTIONS
	WHERE Amount > 200;
QUIT;

/*==============================================================================*/
/*==============================================================================*/
/* PROC SQL - ADDITIONAL SQL CLAUSES AND CONCEPTS */

/* Creating a Library named SQL and importing multiple datafiles */
libname sql '/home/tripathisachin130/Data/SampleDatFiles';

/* Description of datafiles */
/* 
The Countries table contains data that pertains to countries.
The WorldCityCoords table contains latitude and longitude data for world cities. 
The USCityCoords table contains the coordinates for cities in the United States. 
The United States table contains data that is associated with the states. 
The PostalCodes table contains postal code abbreviations.
The WorldTemps table contains average high and low temperatures from various international cities.
The OilProd table contains oil production statistics from oil-producing countries.
The OilRsrvs table lists approximate oil reserves of oil-producing countries.
The Continents table contains geographic data that relates to world continents.
The Features table contains statistics that describe various types of geographical features, such as oceans, lakes, and mountains.
*/

/* OUTOBS - Maximum Observations to be printed */
PROC SQL OUTOBS=12;
   TITLE 'U.S. Cities and Their States';
   SELECT City, State FROM sql.uscitycoords;
QUIT;

/* WHERE CLAUSE */
PROC SQL; 
	SELECT Name FROM sql.countries WHERE Population GT 5000000; 
QUIT; 

/* ORDER BY CLAUSE */
PROC SQL; 
	SELECT Name
		FROM sql.countries
	   	WHERE Population GT 5000000
	   	ORDER BY Population DESC;
QUIT; 	   	

/* GROUP BY CLAUSE */
PROC SQL;
	SELECT Continent, SUM(Population) 
   	FROM sql.countries
   	GROUP BY Continent
   	ORDER BY Continent;
QUIT;

/* HAVING CLAUSE */
PROC SQL; 
SELECT Continent, SUM(Population)
   	FROM sql.countries
   	GROUP BY Continent
   	HAVING Continent IN ('North America', 'South America')
   	ORDER BY Continent;
QUIT; 

/* Selecting specific columns */
PROC SQL OUTOBS=12;
   	TITLE 'U.S. States, their capitals, and area';
   	SELECT Name, Capital, Area
      FROM sql.unitedstates;
QUIT;

/* DISTINCT CLAUSE */ 
PROC SQL; 
   TITLE 'Continents of the United States';
   SELECT DISTINCT Continent 
      FROM sql.unitedstates;
QUIT;      
    
/* Adding text to output */
PROC SQL OUTOBS=20;
   	TITLE 'U.S. Postal Codes';
   	SELECT 'Postal code for', Name, 'is', Code
      	FROM sql.postalcodes;  
QUIT; 
      
/* Adding text and removing column names in output*/ 
PROC SQL OUTOBS=20;
   	TITLE 'U.S. Postal Codes';
  	SELECT 'Postal code for', Name label='#', 'is', Code label='#'
      	FROM sql.postalcodes;
QUIT; 

/* Value Calculation based on columns */
PROC SQL OUTOBS=20; 
   	TITLE 'Low Temperatures in Celsius';
   	SELECT City, (AvgLow - 32) * 5/9 AS LowTempCelsius format=4.1
      	FROM sql.worldtemps;
QUIT;
  
/* 
When you use a column alias to refer to a calculated value, 
you must use the CALCULATED keyword with the alias to inform PROC SQL 
that the value is calculated within the query. 
*/
PROC SQL OUTOBS=20; 
   	TITLE 'Range of High and Low Temperatures in Celsius';
    SELECT City, (AvgHigh - 32) * 5/9 as HighTemp format=5.1, 
    				(AvgLow - 32) * 5/9 as LowTemp format=5.1,
                 	(CALCULATED HighTemp - CALCULATED LowTemp)
                 	AS Range format=4.1
   	FROM sql.worldtemps;     
      
/* Assigning values based on conditions using CASE expression */  
PROC SQL OUTOBS=20;
   	TITLE 'Climate Zones of World Cities';
   	SELECT City, Country, Latitude,
    	CASE
        	WHEN Latitude GT 67 THEN 'North Frigid'
            WHEN 67 GE Latitude GE 23 THEN 'North Temperate'
            WHEN 23 GT Latitude GT -23 THEN 'Torrid'
            WHEN -23 GE Latitude GE -67 THEN 'South Temperate'
            ELSE 'South Frigid'
        END AS ClimateZone
  	FROM sql.worldcitycoords
   	ORDER BY City;
QUIT;

/*
The COALESCE function enables us to replace missing values in a column 
with a new value that you specify.
*/
PROC SQL;
   	TITLE 'Continental Low Points';
   	SELECT Name, COALESCE(LowPoint, 'Not Available') as LowPoint
      	FROM sql.continents; 
QUIT;

/* Sorting Data based on Column */
PROC SQL OUTOBS=20;
   	TITLE 'Country Populations';
   	SELECT Name, Population format=comma10.
      	FROM sql.countries
      	ORDER BY Population;
QUIT; 

/* Sorting based on multiple columns */
PROC SQL OUTOBS=20;
   	TITLE 'Countries, Sorted by Continent and Name';
   	SELECT Name, Continent
      	FROM sql.countries
      	ORDER BY Continent, Name;
QUIT; 

/* Sorting based on calculated column */
PROC SQL OUTOBS=20;
   	TITLE 'World Population Densities per Square Mile';
   	SELECT Name, Population format=comma12., Area format=comma8., 
    	Population/Area AS Density format=comma10. 
      	FROM sql.countries
      	ORDER BY Density DESC;
QUIT; 

/* Sorting based on column number (position) (Column index starts from 1) */
PROC SQL OUTOBS=20;
   	TITLE 'World Population Densities per Square Mile';
   	SELECT Name, Population format=comma12., Area format=comma8., 
    	Population/Area AS Density format=comma10. 
      	FROM sql.countries
      	ORDER BY 4 DESC;

/* Advanced WHERE Clause Conditional Operators */
/* 
ANY --- specifies that at least one of a set of values obtained from a subquery must satisfy a given condition
ALL --- specifies that all of the values obtained from a subquery must satisfy a given condition
BETWEEN-AND --- tests for values within an inclusive range
CONTAINS --- tests for values that contain a specified string
EXISTS --- tests for the existence of a set of values obtained from a subquery
IS NULL or IS MISSING --- tests for missing values
LIKE --- tests for values that match a specified pattern
=* --- tests for values that sound like a specified value
*/ 

PROC SQL; 
   	TITLE 'Countries with Missing Continents';
   	SELECT Name, Continent
      	FROM sql.countries
      	WHERE Continent IS missing;
QUIT; 

PROC SQL; 
   	TITLE 'Equatorial Cities of the World';
   	SELECT City, Country, Latitude
      	FROM sql.worldcitycoords
      	WHERE Latitude BETWEEN -5 AND 5;
QUIT;
      	
PROC SQL; 
   	TITLE1 'Country Names that Begin with the Letter "Z"';
   	TITLE2 'or Are 5 Characters Long and End with the Letter "a"';
   	SELECT Name
      	FROM sql.countries
      	WHERE Name LIKE 'Z%' OR Name LIKE '____a';
QUIT; 

/* Truncated String Comparison Operators */
/*
EQT --- equal to truncated strings
GTT --- greater than truncated strings
LTT --- less than truncated strings
GET --- greater than or equal to truncated strings
LET --- less than or equal to truncated strings
NET --- not equal to truncated strings
*/

PROC SQL; 
   	TITLE '"New" U.S. States';
   	SELECT Name
      	FROM sql.unitedstates
      	WHERE Name EQT 'New ';
QUIT; 

/* Data Summarisation using WHERE */
PROC SQL OUTOBS=20;
   	TITLE 'Mean Temperatures for World Cities';
   	SELECT City, Country, mean(AvgHigh, AvgLow) AS MeanTemp
      	FROM sql.worldtemps
      	WHERE calculated MeanTemp GT 75
      	ORDER BY MeanTemp DESC;

