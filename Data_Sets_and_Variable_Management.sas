/* For missing numerical values we can use dot(.)
And for missing character values we can use empty quotes ("") */

DATA sample_dataset;
INPUT Name $ Gender $ Age;
DATALINES;
Abhi M 30
Mani M .
Tim F 15
Jay M 20
;

/* Creating Data with PROC step */

PROC MEANS DATA = SASHELP.CARS;
CLASS Origin;
RUN;

/*Deletion of Datasets */

PROC DATASETS lib=WORK;
DELETE sample_dataset;
run;
quit;

/* Deleting dataset with DATA step. */
DATA WORK.sample_dataset;
SET _null_;

/* Creating a new library */
LIBNAME Project1 '/home/u64223611';
RUN;

/* Structural Attrubute LENGTH */

/* In this example name column is set to have 8 characters as we define
name as Abhishek. */

DATA example1;
name = 'Abhishek';
name = 'Manichandu';
RUN;

/* This will truncate all the entries to 6 characters*/
DATA example2;
LENGTH name $6;
name = 'Abhishek';
RUN;

/* Structural attribute TYPE. */
/* If not sure about the data type, prefer character over numerical. */

DATA sample;
INPUT name $ gender $;
datalines;
Abhi 1
Tim 1
Jiya F
;

/*Structural Attrubute: INFORMAT */

/* INFILE let the data step read from the datalines wherever it is defined.
INFORMAT decides how the data is interpreted from the raw file or user-input.
FORMAT decides how the data is displayed.
INFORMAT should be used with caution, keeping in mind the scope of our dataset */

DATA date_example;
INFILE datalines;
INFORMAT name $5. salary 2.1 dob date9.;
input name $ salary dob;
FORMAT dob date9.;
datalines;
Abhishek 30000 01JAN2025
Jiya 6200000 15FEB2024
;
RUN

/* Display attribute LABEL */

DATA student;
INPUT id, name $;
datalines;
1 Abhi
2 Jiya
;








