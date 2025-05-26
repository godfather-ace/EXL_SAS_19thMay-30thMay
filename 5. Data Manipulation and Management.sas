/*==============================================================================*/
/*==============================================================================*/

/*
Reading In-stream Data
*/
DATA temp1;
	input subj 1-4 gender 6 height 8-9 weight 11-13;
  	DATALINES;
1024 1 65 125
1167 1 68 140
1168 2 68 190
1201 2 72 190
1302 1 63 115
  	;
RUN;
PROC PRINT data=temp1;
	title 'Output dataset: TEMP1';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading Data into a Permanent SAS Data Set and Printing it
*/
LIBNAME mydata '/home/tripathisachin130';  
DATA mydata.temp1;
	input subj 1-4 gender 6 height 8-9 weight 11-13;
	DATALINES;
1024 1 65 125
1167 1 68 140
1168 2 68 190
1201 2 72 190
1302 1 63 115
  	;
RUN;
    
PROC PRINT data=mydata/temp1;
	title 'Output dataset: mydata.TEMP1';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading Data from a Raw File
*/
DATA temp;
	infile '/home/tripathisachin130/Data/temp.dat';
  	input subj 1-4 gender 6 height 8-9 weight 11-13;
RUN;

PROC PRINT data=temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading Data from a Raw File - 
use of a fileref in the INFILE statement, in conjunction with a FILENAME statement
*/
FILENAME patients '/home/tripathisachin130/Data/temp.dat';
DATA temp;
  	infile patients;
  	input subj 1-4 gender 6 height 8-9 weight 11-13;
RUN;
PROC PRINT data = temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading Column Input - I
*/
DATA temp;
  	input subj 1-4 name $ 6-23 gender 25 height 27-28 weight 30-32;
  	CARDS;
1024 Alice Smith        1 65 125
1167 Maryann White      1 68 140
1168 Thomas Jones       2 68 190
1201 Benedictine Arnold 2 68 190
1302 Felicia Ho         1 63 115
  	;
RUN;
PROC PRINT data=temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading Column Input - II
*/
DATA temp;
  	input init $ 6 f_name $ 6-16 l_name $ 18-23
    	weight 30-32 height 27-28;
  	CARDS;
1024 Alice       Smith  1 65 125
1167 Maryann     White  1 68 140
1168 Thomas      Jones  2    190
1201 Benedictine Arnold 2 68 190
1302 Felicia     Ho     1 63 115
	;
RUN;
PROC PRINT data=temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Creating a Temporary Data based on SAS Dataset
*/
DATA temp;
	set sashelp.cars;
RUN;

PROC PRINT data=temp;
	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading List Input
*/
DATA temp;
  	input subj name $ gender height weight;
  * The $ that follows name tells SAS that it is
    	a character variable;
  * By default, name only allows up to 8 characters
    	to be read in;
  	CARDS;
  1024 Alice 1 65 125
  1167 Maryann 1 68 140
  1168 Thomas 2 68 190
  1201 Benny 2 72 190
  1302 Felicia 1 63 115
  	;
RUN;
PROC PRINT data=temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading List Input - Missing value (.)
*/
DATA temp;
  	input subj name $ gender height weight;
  	CARDS;
  1024 Alice 1 65 125
  1167 Maryann 1 68 140
  1168 Thomas 2 68 190
  1201 Benny 2 . 190
  1302 Felicia 1 63 115
  	;
RUN;
PROC PRINT data=temp;
 	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
Reading List Input - Missing value (.)
*/
DATA temp;
	infile cards delimiter=',';
  	input subj name $ gender height weight;
  	CARDS;
  1024,Alice,1,65,125
  1167,Maryann,1,68,140
  1168,Thomas,2,68,190
  1201,Benny,2,.,190
  1302,Felicia,1,63,115
  	;
RUN;
PROC PRINT data=temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
@n column pointer control - I
*/
DATA temp;
  	input @1  subj 4. 
        @27 height 2. 
        @30 weight 3.;
  	DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  	;
RUN;
PROC PRINT data = temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
@n column pointer control - II
*/
DATA temp;
  	input @18 l_name $6.
        @6  f_name $11.
		@30 weight 3.
		@27 height 2.;
  	DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  	;
RUN;
PROC PRINT data = temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
@n & +n column pointer control
*/
DATA temp;
  	input @1  subj 4.
        @6  f_name $11.
		@18 l_name $6.
		+3 height 2.
        +5 wt_date mmddyy8.
        +1 calorie comma5.;
 	DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  	;
RUN;
PROC PRINT data = temp;
  	title 'Output dataset: TEMP';
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
INFILE Options - LINE
*/
/* Step 1: Write sample lines to a raw data file */
FILENAME myfile '/home/tripathisachin130/Data/line_demo.txt';
DATA _NULL_;
  	FILE myfile;
  	PUT 'John,25,Engineer';
  	PUT 'Sara,30,Analyst';
  	PUT 'Mike,28,Manager';
RUN;
/* Step 2: Read with LINE= to see line numbers being read */
DATA example_line;
  	INFILE myfile LINE=lineptr DELIMITER=','; 
  	INPUT name :$10. age :3. role :$10.;
  	PUT "Reading line " lineptr ": " name age role;
RUN;

/*==============================================================================*/
/*==============================================================================*/

/*
INFILE Options - LINE (Checking the usage of lineptr - Printing odd rows)
*/
filename myfile temp; /* Using a temporary file for demonstration */
data _null_;
  	file myfile;
  	put 'John,25,Engineer';
  	put 'Sara,30,Analyst';
  	put 'Mike,28,Manager';
  	put 'Nina,32,Consultant';
  	put 'Gary,29,Director';
run;

/* Step 2: Read the file and keep only odd-numbered lines */
data odd_lines_only;
  	infile myfile delimiter=',' ;
  	input name :$10. age :3. role :$15.;
  	lineptr + 1; /* Increment lineptr for each record read */
  	if mod(lineptr, 2) = 1;
  	put "Keeping line " lineptr ": " name age role;
run;

/*==============================================================================*/
/*==============================================================================*/

/* 
INFILE Options - MISSOVER 
*/
filename mydata temp;
data _null_;
  	file mydata;
  	put 'John,25,Engineer';
  	put 'Sara,30';
  	put 'Mike,,Manager,Project Lead';
  	put 'Nina,Consultant';
run;

/* Using MISSOVER */
/* -------------------- MISSOVER Option -------------------- */
/* Prevents SAS from going to the next input line if it doesn't */
/* find all the expected values in the current line. Missing */
/* values are assigned as missing. */
data missover_example;
  	infile mydata dsd dlm=',' missover;
  	input name $ age role $ title $;
  	put "Name: " name " Age: " age " Role: " role " Title: " title;
run;

/*==============================================================================*/
/*==============================================================================*/

/* 
INFILE Options - TURNCOVER 
*/ 
/* Sample data file for demonstration */
filename mydata temp;
data _null_;
  file mydata;
  put 'John,25,Engineer';
  put 'Sara,30';
  put 'Mike,,Manager,Project Lead';
  put 'Nina,Consultant';
run;

/* Using TRUNCOVER */
/* -------------------- TRUNCOVER Option -------------------- */
/* Allows SAS to read a shorter-than-expected input line without */
/* issuing an error. It pads the remaining variables with missing */
/* values. Similar to MISSOVER but doesn't prevent reading the next line. */
data truncover_example;
  infile mydata dsd dlm=',' truncover;
  input name $ age role $ title $;
  put "Name: " name " Age: " age " Role: " role " Title: " title;
run;

/*==============================================================================*/
/*==============================================================================*/

/* INFILE Options - DSD
/* Sample data file for demonstration */
filename mydata temp;
data _null_;
  file mydata;
  put 'John,25,"Engineer, Software"';
  put 'Sara,30,Analyst';
  put 'Mike,,Manager';
  put ',32,Consultant';
  put 'Gary,"29, Director",Executive';
run;

/* Using DSD option */
/* -------------------- DSD Option (Delimiter-Sensitive Data) -------------------- */
/* Handles consecutive delimiters as missing values and removes quoting */
/* characters around values. It's often used with DLM=. */
data dsd_example;
  infile mydata dsd dlm=',';
  input name $ age role $;
  put "Name: " name " Age: " age " Role: " role;
run;

/*==============================================================================*/
/*==============================================================================*/

/* INFILE Options - PAD */
filename myfile temp lrecl=30;
data _null_;
  file myfile;
  put 'John    25Engineer       ';
  put 'Sara    30Analyst        ';
  put 'Mike    28Manager        ';
  put 'Nina    32Consultant     ';
run;

/* Using PAD option */
data pad_example;
  infile myfile pad lrecl=30; /* LRECL should match the file's structure */
  input name $8. age 3. role $15.;
  put "Name: '" name "'" " Age: " age " Role: '" role "'";
run;
/* The PAD option in the INFILE statement is used when reading fixed-width data */
/* files where each record is expected to have a specific length */
/* (defined by the LRECL= option). If a line in the input file is shorter than the LRECL=, */
/* the PAD option tells SAS to pad the line with trailing blanks up to the specified */
/* LRECL before the INPUT statement attempts to read from it. */

/*==============================================================================*/
/*==============================================================================*/

/* Pointer Controls - Column Pointer (@) */
filename mydata temp;
data _null_;
  file mydata;
  put '1-John---25---Engineer';
  put '2-Sara---30---Analyst ';
run;

data read_columns;
  infile mydata;
  input @3 name $4. @10 age 2.;
  put "Name: " name " Age: " age;
run;

/* Pointer Controls - Line Pointer (@@) */
filename multiple temp;
data _null_;
  file multiple;
  put 'John 25 Sara 30 Mike 28';
run;

data multiple_read;
  infile multiple;
  input name1 $ age1 @@;
  input name2 $ age2 @@;
  input name3 $ age3;
  put "Name1: " name1 " Age1: " age1;
  put "Name2: " name2 " Age2: " age2;
  put "Name3: " name3 " Age3: " age3;
run;

/*==============================================================================*/
/*==============================================================================*/

/* SAS MERGE */ 

DATA one;
 	INPUT id v1 v2;
 	DATALINES;
 	1 10 100
 	2 15 150
 	3 20 200
 ;
PROC SORT Data=one;
 BY id;
RUN;

DATA two;
 	INPUT id v3 v4;
 	DATALINES;
 	1 1000 10000
 	2 1500 15000
 	3 2000 20000
 	4  800 30000
 ;
PROC SORT Data=two;
 BY id;
RUN;

DATA three;
 	MERGE one two;
 	BY id;
PROC PRINT DATA=three; 
RUN;

/* SAS MERGE - Another Example */
DATA Employee_Info;
    INPUT ID NAME $ SALARY;
    DATALINES;
	1 Alice 700.0
	2 Bob 645.5
	6 Fiona 600.3
	3 CEharlie 820.2
	8 Hannah 734.1
	4 Diana 910.6
	7 George 689.9
	5 Ethan 775.4
	;
RUN;
PROC SORT data = Employee_Info;
	By ID; 
RUN; 

data Emp_Department;
    INPUT ID DEPT $;
    DATALINES;
	1 HR
	7 HR
	2 IT
	8 MARKETING
	3 SALES
	6 IT
	4 FIN
	5 OPS
	;
run;
PROC SORT data = Emp_Department;
	By ID; 
RUN;


DATA Employee_Data;
    MERGE Employee_Info Emp_Department;
    BY ID;
RUN;

/* SAS MERGE - Merging only matching observations*/ 
DATA Employee_Info;
    INPUT ID NAME $ SALARY;
    DATALINES;
	1 Alice 700.0
	2 . 645.5
	3 Charlie .
	5 Ethan 775.4
	6 Fiona .
	7 George 689.9
	8 Hannah 734.1
	;
RUN;
PROC SORT DATA = Employee_Info;
	BY ID; 
RUN; 

DATA Emp_Department;
    INPUT ID DEPT $;
    DATALINES;
1 HR
2 IT
3 .
4 FIN
6 IT
7 HR
8 .
;
RUN;
PROC SORT DATA = Emp_Department;
	BY ID; 
RUN;

DATA All_details;
MERGE Employee_Info(IN = a) Emp_Department(IN = b);
BY ID;
IF a = 1 and b = 1;
RUN;
PROC PRINT DATA = All_details; 
RUN;  

/*==============================================================================*/
/*==============================================================================*/

/* SAS Dataset Concatenation */
DATA EmpInfo1;
    INPUT ID NAME $ SALARY;
    DATALINES;
	1 Alice 700.0
	2 Bob 645.5
	3 CEharlie 820.2
	7 George 689.9
	;

DATA EmpInfo2;
    INPUT ID NAME $ SALARY;
    DATALINES;
	6 Fiona 600.3
	8 Hannah 734.1
	4 Diana 910.6
	5 Ethan 775.4
	;

DATA AllEmps; 
   SET EmpInfo1 EmpInfo2; 

PROC SORT DATA = AllEmps;
	By ID; 

PROC PRINT DATA = AllEmps; 
RUN;  

/*==============================================================================*/
/*==============================================================================*/
