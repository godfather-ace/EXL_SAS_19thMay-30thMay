# 1. Read Raw Data

## 1.1 Reading ASCII(Text) Data Set
```
DATA TEMP; 
   INFILE '/folders/myfolders/World Happiness/practice text dataset.txt' firstobs= 2; 
   INPUT @1 ID @5 Name $ 5-17 Location $;
RUN;
PROC PRINT DATA = TEMP;
RUN;
```

## 1.2 Reading Delimited Data
```
DATA TEMP; 
   INFILE '/folders/myfolders/World Happiness/2019.csv'  dlm="," firstobs=2; 
   INPUT Rank Region $ Score GDP_per_capita SS HL_Expectancy Freedom_To_Make_Life_Choices 
   		 Geneorisity Perception_Of_curroption;
RUN;
PROC PRINT DATA = TEMP;
RUN;
```
# 2. Write Data Set

## 2.1 PROC EXPORT
```
PROC EXPORT DATA = sashelp.cars OUTFILE = '/folders/myfolders/sasuser.v94/car_data.txt' DBMS = dlm;
   DELIMITER = ';';
RUN;
```
## 2.2 Writing a CSV file ;
PROC EXPORT DATA = sashelp.cars OUTFILE = '/folders/myfolders/sasuser.v94/car_data_csv.csv' DBMS = csv;
RUN;

## 2.3 Writing a tab delimited file ;
```
PROC EXPORT DATA = sashelp.cars OUTFILE = '/folders/myfolders/sasuser.v94/car_tab.txt' DBMS = tab;
RUN;
```

# 3. Concatenate Data Sets
```
DATA ITDEPT; 
	INPUT empid name $ salary; 
	DATALINES; 
	1 Rick 623.3 
	3 Mike 611.5 
	6 Tusar 578.6 
	; 
RUN; 
DATA NON_ITDEPT; 
	INPUT empid name $ salary; 
	DATALINES; 
	2 Dan 515.2 
	4 Ryan 729.1 
	5 Gary 843.25 
	7 Pranab 632.8 
	8 Rasmi 722.5 
	;
RUN; 
DATA All_Dept; 
   SET ITDEPT NON_ITDEPT; 
RUN; 
PROC PRINT DATA = ITDEPT;
RUN;  
PROC PRINT DATA = NON_ITDEPT; * Merged ITDEPT and NON_ITDEPT vertically ;
RUN; 
PROC PRINT DATA = All_Dept; * Print Vertically Merged ITDEPT and NON_ITDEPT ;
RUN;  
```
## 3.1 Scenarios

### 3.1.1 Different number of variables
```
DATA ITDEPT; 
	INPUT empid name $ salary DOJ date9.; 
	DATALINES; 
	1 Rick 623.3 02APR2001
	3 Mike 611.5 21OCT2000
	6 Tusar 578.6 01MAR2009  
	; 
RUN; 
DATA NON_ITDEPT; 
	INPUT empid name $ salary  ; 
	DATALINES; 
	2 Dan 515.2 
	4 Ryan 729.1 
	5 Gary 843.25 
	7 Pranab 632.8 
	8 Rasmi 722.5 
	;
RUN; 
DATA All_Dept; 
   SET ITDEPT NON_ITDEPT; 
RUN; 
PROC PRINT DATA = All_Dept; 
RUN;  
```

### 3.1.2 Different variable name
```
DATA ITDEPT; 
	INPUT empid ename $ salary; 
	DATALINES; 
	1 Rick 623.3 
	3 Mike 611.5 
	6 Tusar 578.6 
	; 
RUN; 
DATA NON_ITDEPT; 
	INPUT empid empname $ salary; 
	DATALINES; 2 Dan 515.2 
	4 Ryan 729.1 
	5 Gary 843.25 
	7 Pranab 632.8 
	8 Rasmi 722.5 
	;
RUN; 
DATA All_Dept; 
   SET ITDEPT(RENAME =(ename = empname)) NON_ITDEPT; * renaming ename to empname & then merging both datset ;
RUN; 
PROC PRINT DATA = All_Dept; 
RUN;
```

### 3.1.3 Different variable lengths
```
DATA SALARY; 
	INPUT empid name $ salary; 
	DATALINES; 
	1 Rick 623.3		 
	2 Dan 515.2 		
	3 Mike 611.5 
	;
RUN; 
DATA DEPT; 
	INPUT empid dEPT $; 
	DATALINES; 
	1 IT 
	2 OPS
	3 IT
	;
RUN; 
DATA All_details;
	MERGE SALARY DEPT;
	BY empid;
RUN;
PROC PRINT DATA = All_details; 
RUN; 
```

# 4. Merge Data Sets

## 4.1 Data Merging
```
DATA SALARY; 
	INPUT empid name $ salary; 
	DATALINES; 
	1 Rick 623.3		 
	2 Dan 515.2 		
	3 Jack 416.4
	;
RUN; 
DATA DEPT; 
	INPUT empid dEPT $ ; 
	DATALINES; 
	1 IT 
	2 OPS
	3 IT
	;
RUN; 
DATA All_details;
	MERGE SALARY DEPT;
	BY empid;
RUN;
PROC PRINT DATA = All_details; 
RUN;  		
```

### 4.1.1 Missing Values in the Matching Column ;
There may be cases when some values of the common variable will not match between the data sets. In such cases the data sets still get merged but give missing values in the result.

### 4.2.2 Merging only the Matches ;
To avoid the missing values in the result we can consider keeping only the observations with matched values 
for the common variable.

```
DATA SAL1; 
	INPUT empid name $ salary; 
	DATALINES; 
	1 Rick 623.3		 
	2 Dan 515.2 		
	4 Jack 416.4
	;
RUN; 
DATA DEPT1; 
	INPUT empid dEPT $ ; 
	DATALINES; 
	1 IT 
	2 OPS
	3 IT
	;
RUN;
DATA All_det;
	MERGE SAL1(IN = a) DEPT1(IN = b);
	BY empid;
	IF a = 1 and b = 1;
RUN;
PROC PRINT DATA = All_details; 
RUN; 
```

# 5. Subsetting Data Sets

## 5.1 Subsetting Variables

```
DATA Employee; 
	INPUT empid ename $ salary DEPT $ ; 
	DATALINES; 
	1 Rick 623.3 IT 		 
	2 Dan 515.2 OPS	
	3 Mike 611.5 IT
	;
RUN;
DATA OnlyDept;
	SET Employee;
	KEEP ename DEPT;
RUN;
PROC PRINT DATA = OnlyDept; 
RUN; 
```

The same result can be obtained by dropping the variables that are not required.

```
DATA OnlyDept2;
   SET Employee;
   DROP empid salary;
RUN;
PROC PRINT DATA = OnlyDept2; 
RUN;
```

## 5.2 Subsetting Observations: to extract only few observations from the entire data set. ;
```
DATA Employee; 
	INPUT empid name $ salary DEPT $ ; 
	DATALINES; 
	1 Rick 623.3 IT 		 
	2 Dan 515.2 OPS	
	3 Mike 611.5 IT 	
	4 Ryan 729.1 HR 
	5 Gary 843.25 FIN 
	;
RUN;
DATA OnlyDept;
	SET Employee;
	IF salary < 700 THEN DELETE;
RUN;
PROC PRINT DATA = OnlyDept; 
RUN; 
```

# 6. Sort Data Sets ;

**Syntax**
```
PROC SORT DATA = original dataset OUT = Sorted dataset;
	BY variable name; 
```

Variable name - column name on which the sorting happens.
Original dataset - the dataset name to be sorted.
Sorted dataset - the dataset name after it is sorted.

## 6.1 Ascending
```
DATA Employee; 
	INPUT empid name $ salary DEPT $; 
	DATALINES; 
	1 Rick 623.3 IT 		 
	2 Dan 515.2 OPS	
	3 Mike 611.5 IT
	;
RUN;
PROC SORT DATA = Employee OUT = Sorted_sal;
	BY salary;
RUN;
PROC PRINT DATA = Sorted_sal;
RUN;
```

## 6.2 Reverse Sorting
```
DATA Employee; 
	INPUT empid name $ salary DEPT $ ; 
	DATALINES; 
	1 Rick 623.3 IT 		 
	2 Dan 515.2 OPS	
	3 Mike 611.5 IT
	;
RUN;
PROC SORT DATA = Employee OUT = Sorted_sal_reverse ;
	BY DESCENDING salary;
RUN;
PROC PRINT DATA = Sorted_sal_reverse;
RUN; 
```

## 6.3 Sorting Multiple Variables
```
DATA Employee; 
	INPUT empid name $ salary DEPT $ ; 
	DATALINES;
	1 Rick 623.3 IT 		 
	2 Dan 515.2 OPS	
	3 Mike 611.5 IT 	
	4 Ryan 729.1 HR 
	5 Gary 515.2 FIN
	6 Rina 515.2 ABC
	;
RUN;
PROC SORT DATA = Employee OUT = Sorted_dept_sal ;
	BY salary DEPT;
RUN;
PROC PRINT DATA = Sorted_dept_sal;
RUN;
```

# 7. Format Data Sets
```
DATA Employee; 
	INPUT empid name $ salary DEPT $; 
	FORMAT name $upcase9.;
	DATALINES; 
	1 Rick 623.3 IT 		 
	2 Dan 515.2 OPS	
	3 Mike 611.5 IT
	;
RUN;
PROC PRINT DATA = Employee; 
RUN;
```

## 7.1 Using PROC FORMAT ;
```
DATA Employee; 
	INPUT empid name $ salary DEPT $ ; 
	DATALINES; 
	1 Rick 623.3 IT 		 
	2 Dan 515.2 OPS
	3 Mike 611.5 IT 	
	4 Ryan 729.1 HR 
	5 Gary 843.25 FIN 
	;
PROC FORMAT;
	VALUE $DEP 'IT' = 'Information Technology' 'OPS'= 'Operations' ;
RUN;
   PROC PRINT DATA = Employee; 
   FORMAT name $upcase9. DEPT $DEP.; 
RUN;
```

# 8. SQL

## 8.1 SQL Create Operation
```
DATA TEMP;
	INPUT ID $ NAME $ SALARY DEPARTMENT $ 10.;
	DATALINES;
	1 Rick 623.3 IT
	2 Dan 515.2 Operations
	3 Michelle 611 IT
	4 Ryan 729 HR
	5 Gary 843.25 Finance
	;
RUN;
PROC SQL;
	CREATE TABLE EMPLOYEES AS SELECT * FROM TEMP;
QUIT;
PROC PRINT data = EMPLOYEES;
RUN;
```
## 8.2 SQL Read Operation
```
PROC SQL;
	SELECT make,model,type FROM SASHELP.CARS WHERE Make = "Audi" and Type = 'Sports';
QUIT;
```

## 8.3 SQL UPDATE Operation
```
DATA TEMP;
	INPUT ID $ NAME $ SALARY DEPARTMENT $;
	DATALINES;
	1 Rick 623.3 IT
	2 Dan 515.2 Operations
	3 Michelle 611 IT
	4 Ryan 729 HR
	5 Gary 843.25 Finance
	;
RUN;
PROC SQL;
	CREATE TABLE EMPLOYEES2 AS
	SELECT ID as EMPID,
	Name as EMPNAME, SALARY as SALARY, DEPARTMENT as DEPT, SALARY*0.23 as COMMISION
	FROM TEMP;
QUIT;
PROC SQL;
	UPDATE EMPLOYEES2 SET SALARY = SALARY*1.25;
QUIT;
PROC PRINT DATA = EMPLOYEES2;
RUN;
```

## 8.3 SQL DELETE Operation
```
PROC SQL;
	DELETE FROM EMPLOYEES2 WHERE SALARY > 900;
QUIT;
PROC PRINT DATA = EMPLOYEES2;
RUN;
```
# 9. ODS (Output Delivery System): To convert a SAS program to more user friendly forms like html or PDF ;

**Syntax:**
```
ODS outputtype
PATH path name
FILE = Filename and Path
STYLE = StyleName
;
PROC some proc
;
ODS outputtype CLOSE;
```
- PATH: the statement used in case of HTML output, in other types of output we include the path in the filename.
- Style: one of the in-built styles available in the SAS environment.

# 9.1 Creating HTML Output
```
ODS HTML 
	PATH = '/folders/myfolders/sasuser.v94/'
	FILE = 'CARS2.html'
	STYLE = EGDefault;
PROC SQL;
	SELECT make, model, invoice 
	FROM sashelp.cars
	WHERE make in ('Audi','BMW')
	AND type = 'Sports'
	;
QUIT;
PROC SQL;
	SELECT make, mean(horsepower) AS meanhp
	FROM sashelp.cars
	WHERE make IN ('Audi','BMW')
	GROUP BY make;
QUIT;
ODS HTML CLOSE; 
```

## 9.2 Creating PDF Output
```
ODS PDF FILE = '/folders/myfolders/sasuser.v94/CARS2.pdf' STYLE = EGDefault;
PROC SQL;
	SELECT make, model, invoice 
	FROM sashelp.cars
	WHERE make IN ('Audi','BMW')
	AND type = 'Sports';
QUIT;
PROC SQL;
	SELECT make, mean(horsepower) AS meanhp
	FROM sashelp.cars
	WHERE make IN ('Audi','BMW')
	GROUP BY make;
QUIT;
ODS PDF CLOSE; 
```

## 9.3 Creating TRF(Word) Output
```
ODS RTF 
FILE = '/folders/myfolders/sasuser.v94/CARS.rtf'
STYLE = EGDefault;
PROC SQL;
	SELECT make, model, invoice 
	FROM sashelp.cars
	WHERE make IN ('Audi','BMW')
	AND type = 'Sports'
	;
QUIT;
PROC SQL;
	SELECT make, mean(horsepower) AS meanhp
	FROM sashelp.cars
	WHERE make IN ('Audi','BMW')
	GROUP BY make;
QUIT;
ODS RTF CLOSE;
```
