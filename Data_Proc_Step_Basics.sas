/* SAS DATA STEP */
/* Creating a data Syntax */
/*
DATA data_set_name;		#Name of the data set.
INPUT var1,var2,var3; 		#Define the variables in the data set.
NEW_VAR;			#Create new variables.
LABEL;			      	#Assign labels to variables.
DATALINES;		      	#Enter the data.
RUN;
*/ 

/* Example code */ 
DATA TEMP;
INPUT ID $ NAME $ SALARY DEPARTMENT $;
COMMISSION = SALARY*0.25;
LABEL ID = 'Employee ID' comm = 'COMMISSION';
DATALINES;
1 Arjun 700 Marketing
2 Sneha 600 Sales
3 Neeraj 500 Finance
4 Tanvi 800 HR
5 Kunal 200 IT
6 Priya 150 Marketing
7 Rahul 800 Sales
8 Isha 700 Finance
9 Rohit 500 Sales
10 Mehul 800 Finance
11 Akansha 700 IT
;
RUN;

/* SAS PROC STEP */
/* Using PROC */
/*
PROC procedure_name options; #Name of procedure.
RUN;
*/

/* Example code */
PROC PRINT DATA = TEMP;
WHERE SALARY > 600;
RUN;

PROC MEANS; 
RUN; 

/* BAR CHART */
PROC SGPLOT DATA = TEMP;
VBAR SALARY;
RUN;

/* STACKED BAR CHART */
PROC SGPLOT DATA = TEMP;
VBAR SALARY /group = COMMISSION;
RUN;
