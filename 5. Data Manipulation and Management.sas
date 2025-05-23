/* ===================================== Reading Data in SAS ===================================== */

/* =============================================================================================== */
/* =============================================================================================== */

/* Reading In-Stream Data */
DATA temp1; 
	INPUT RolNum 1-4 Gender 6 Height 8-9 Weight 11-13; 
	DATALINES;
1030 1 20 167
1031 2 54 178
1034 1 36 168
1029 1 56 168
1033 2 62 186
;

PROC PRINT DATA = temp1; 
	TITLE 'OUTPUT DATA: TEMP1';
RUN; 

/* Reading Data into a Permanent SAS Dataset */
LIBNAME mydata '/home/tripathisachin130'; 
DATA mydata.temp1; 
	INPUT RolNum 1-4 Gender 6 Height 8-9 Weight 11-13; 
	DATALINES;
1030 1 20 167
1031 2 54 178
1034 1 36 168
1029 1 56 168
1033 2 62 186
;

PROC PRINT DATA = mydata/temp1; 
	TITLE 'OUTPUT DATASET - MyData.TEMP1';
RUN; 

/* Reading Data from a Raw File */
DATA temp; 
 	INFILE '/home/tripathisachin130/Data/temp.dat';
 	INPUT RolNum 1-4 Gender 6 Height 8-9 Weight 11-13;  

PROC PRINT DATA = TEMP; 
	TITLE 'OUTPUT DATASET - TEMP'; 
RUN; 

/* Using FILEREF in the INFILE statement, in conjunction with a FILENAME statement */
FILENAME patients '/home/tripathisachin130/Data/temp.dat'; 
DATA temp; 
 	INFILE patients;
 	INPUT RolNum 1-4 Gender 6 Height 8-9 Weight 11-13;  

PROC PRINT DATA = TEMP; 
	TITLE 'OUTPUT DATASET - TEMP'; 
RUN; 

/* Reading Column Input - I */ 
DATA temp; 
 	INPUT Subj 1-4 Name $ 6-23 Gender 25 Height 27-28 Weight 30-32; 
 	CARDS; 
1024 Alice Smith        1 65 125
1167 Maryann White      1 68 140
1168 Raavan Jones       2 68 190
1201 Benedictine Arnold 2 68 190
1302 Felicia Ho         1 63 115
;
PROC PRINT DATA = TEMP; 
	TITLE 'OUTPUT DATA - TEMP'; 
RUN; 

/* Reading Column Input - II */
/* We can randomise the column names & widths in INPUT, 
but in the data entry section, the column data must be 
entered in actual sequence based on the width */
DATA temp; 
	INPUT init $ 6 f_name $ 6-16 l_name $ 18-23 
		weight 30-32 height 27-28; 
	CARDS; 
1024 Alice       Smith  1 65 125
1167 Maryann     White  1 68 140
1168 Raavan      Jones  2 68 190
1201 Benedictine Arnold 2 68 190
1302 Felicia     Ho     1 63 115
;
PROC PRINT DATA = TEMP; 
	TITLE 'OUTPUT DATA - TEMP'; 
RUN; 

/* Creating a Temporary Data based on SAS Dataset */ 
DATA temp; 
	SET SASHELP.CARS; 

PROC PRINT DATA = temp; 
	TITLE 'OUTPUT DATA - TEMP (SASHELP CARS)';
RUN;

/* Reading List Input */
/* $ allows character variable in the data
by default, the character variable only allows upto 8 characters
but number variable don't have that limitation */
DATA temp; 
	INPUT subj name $ gender height weight;
	CARDS; 
1024 Alice 1 65 125
1167 Maryann 1 68 140
1168 Raavan 2 68 190
1201 Benedictine 2 68 190
1302 Felicia 1 63 115
;
PROC PRINT DATA = temp;
	TITLE 'OUTPUT DATA - TEMP';
RUN;

/* Reading List Input - with Missing Value, represented by placeholder(.) */ 
DATA temp; 
	INPUT subj name $ gender height weight;
	CARDS; 
1024 Alice 1 65 125
1167 Maryann 1 68 .
1168 Raavan 2 68 190
1201 Benedictine 2 . 190
1302 Felicia . 63 115
;
PROC PRINT DATA = temp;
	TITLE 'OUTPUT DATA - TEMP';
RUN;

/* Reading List Input - using DELIMITER */
DATA temp; 
	INFILE CARDS DELIMITER = ',';
	INPUT subj name $ gender height weight;
	CARDS; 
1024,Alice,1,65,125
1167,Maryann,1,68,.
1168,Raavan,2,68,190
1201,Benedictine,2,.,190
1302,Felicia,.,63,115
;
PROC PRINT DATA = temp;
	TITLE 'OUTPUT DATA - TEMP';
RUN;

/* =====================================  Input Formatting  ===================================== */

/* ============================================================================================== */
/* ============================================================================================== */

/* @n Column Pointer Control - I */ 
DATA temp;
	INPUT @1 subj 4. 
		@27 height 2.
		@39 weight 3.; 
	DATALINES; 
1024 Alice       Smith  1 65 12/01/90 125
1167 Maryann     White  1 68 13/12/86 140
1168 Raavan      Jones  2 68 17/05/89 190
1201 Benedictine Arnold 2 68 13/12/86 190
1302 Felicia     Ho     1 63 13/12/86 115
;

PROC PRINT DATA = temp; 
RUN;

/* @n Column Pointer Control - II */
DATA temp;
	INPUT @6 f_name $5. 
		@18 l_name $6.
		@39 weight 3.
		@27 height 2.;
	DATALINES; 
1024 Alice       Smith  1 65 12/01/90 125
1167 Maryann     White  1 68 13/12/86 140
1168 Raavan      Jones  2 68 17/05/89 190
1201 Benedictine Arnold 2 68 13/12/86 190
1302 Felicia     Ho     1 63 13/12/86 115
;

PROC PRINT DATA = temp; 
RUN;

/* @n and +n  Column Pointer Control */ 
DATA temp;
	INPUT @1 subj 4.  
		@6 f_name $5. 
		@18 l_name $6.
		+3 height 2. 
		; 
	DATALINES; 
1024 Alice       Smith  1 65 16MAR2007
1167 Maryann     White  1 68 18FEB1995
1168 Raavan      Jones  2 68 19NOV1990
1201 Benedictine Arnold 2 68 19OCT1985
1302 Felicia     Ho     1 63 18SEP2001
;

PROC PRINT DATA = temp; 
RUN;


/* =====================================  INFILE OPTIONS ============================================= */

/* =================================================================================================== */
/* =================================================================================================== */

/* INFILE - LINE */
/* STEP 1 - Writing sample lines to a raw data file */ 
FILENAME myfile '/home/tripathisachin130/Data/line_demo.txt';
DATA _NULL_; 
	FILE myfile; 
	PUT 'John,25,Engineer';
	PUT 'Sarah,29,Analyst';
	PUT 'Michael,30,Manager';
RUN;

/* STEP 2 - Reading with LINE to see the line number which are being read */
DATA example_line;
	INFILE myfile LINE=lineptr DELIMITER=',';
	INPUT name :$10. age :3. role :$10.; 
  	PUT "Reading line " lineptr ": " name age role;
RUN;

/* INFILE OPTIONS - LINE (Checking the usage of lineptr - Print odd rows) */
FILENAME myfile temp; 
DATA _NULL_;
	FILE myfile; 
	PUT 'John,25,Engineer';
	PUT 'Sarah,29,Analyst';
	PUT 'Michael,30,Manager';
	PUT 'Ravi,30,HR';
	PUT 'Jagriti,28,Consultant';
	PUT 'Yashaswini,31,Director';

DATA odd_lines_only; 
	INFILE myfile DELIMITER=',';
	INPUT name :$10. age :3. role :$10.; 
	lineptr + 1; 
	IF mod(lineptr, 2) = 1; /* Any conditional/logical operation can be used */ 
		PUT "Keeping line" lineptr ":" name age role;
RUN; 
	
/* INFILE - MISSOVER */
FILENAME myfile temp; 
DATA _NULL_;
	FILE myfile; 
	PUT 'John,25,Engineer';
	PUT 'Sarah,29';
	PUT 'Michael,30,Manager';
	PUT 'Ravi,HR';
	PUT 'Nina,Consultant';
	PUT ',31,Director';

/* MISSOVER OPTION */
/* It prevents SAS from going to the next line if it doesnt
finds all the expected values in the current line. 
Missing values are assigned as missing (.) */
DATA missover_example; 
	INFILE myfile dsd dlm = "," MISSOVER; 
	INPUT name :$10. age :3. role :$10.; 
	PUT "Name: " name "Age: " age "Role: " role; 
RUN; 

/* INFILE - TRUNCOVER */
FILENAME myfile temp; 
DATA _NULL_;
	FILE myfile; 
	PUT 'John,25,Engineer';
	PUT 'Sarah,29';
	PUT 'Michael,30,Manager';
	PUT 'Ravi,HR';
	PUT 'Nina,Consultant';

/* TRUNCOVER OPTION */
/* It allows SAS to read a shorter-than-expected input line
without issuing an error. It pads the remaining variables with 
missing values. It is similar to MISSOVER but doesnt prevents reading
the next line*/
DATA turncover_example; 
	INFILE myfile dsd dlm = "," TRUNCOVER; 
	INPUT name $ age role $; 
	PUT "Name: " name "Age: " age "Role: " role; 
RUN; 

/* INFILE - DSD */
/* It is able to handle consecutive delimiters as missing values are removes 
quoting */
FILENAME myfile temp; 
DATA _NULL_;
  	file myfile;
 	put 'John,25,"Engineer, Software"';
  	put 'Sara,30,Analyst';
  	put 'Mike,,Manager';
  	put ',32,Consultant';
  	put 'Gary,"29,Director",Executive';
RUN; 

DATA dsd_example; 
	INFILE myfile dsd dlm = ","; 
	INPUT name $ age role $; 
	PUT "Name: " name "Age: " age "Role: " role;  
RUN; 






























