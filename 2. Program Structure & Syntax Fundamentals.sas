/* Adding a column BMI based on existing height and weight.
Taking dataset from sashelp library and putting it in work.class */

DATA work.class;
SET sashelp.class;
BMI = (weight/(height**2))*703;
RUN;

/* Getting statistical summary of the dataset work.class*/
PROC MEANS DATA=work.class;

/*Getting the summary only for desired features*/
PROC MEANS DATA=work.class;
VAR height weight;

/*Getting the summary for each category('sex')*/
PROC MEANS DATA=work.class;
CLASS sex;
VAR height weight;

/* Dummy code to understand compilation and execution*/
DATA example;
INPUT Name $ Height Weight;
BMI = (weight/(height**2))*703;
DATALINES;
Abhi 70 180
Ram 65 150
;
RUN;

/* An example of explicit output*/

DATA adults minors;
INPUT Name $ Age;
IF Age>=18 THEN OUTPUT adults;
ELSE OUTPUT minors;
DATALINES;
Abhi 30
Tim 15
;
RUN;

/* What if we don't use output stetement*/

DATA adults minors;
INPUT Name $ Age;
DATALINES;
Abhi 30
Tim 15
;
RUN;

/* If we use output two times then each record will be updated in the dataset twice */

data adults;
INPUT Name $ Age;
OUtput; Output;
DATALINES;
Abhi 30
Tim 15
;
RUN;

/* Define a simple macro variable and call it */

%LET demo_name = Jane;
PROC PRINT DATA = SASHELP.CLASS;
WHERE NAME = "&demo_name";
RUN;

/* Defining a simple macro function */
%MACRO greet_user;
%LET greeting = Welcome;
%PUT NOTE: &greeting, Abhishek!;
%MEND;

/* Calling the predefined macro*/
%greet_user

/* Global vs Local Macro Variable */

%Global Namaskar;
%let Namaskar = Hello (Global outside);

%macro greet;
%global Namaste;
%let Namaste = hello(Global inside);

%local greeting;
%let greeting = Hello(Local);

%put &greeting;
%put &namaste;

%mend;

%greet;
%put &namaskar;
%put &namaste;

/* The following line would yield warning because local variable 
cannot be called outside the macro function */

%put &greeting;

/* The following macro variable has been defined in another script and has
been saved as autoexec.sas file to be fetched in this script to demonstrate 
auto execution. */

%PUT NOTE: Autoexex is running;
%LET userid = Abhishek;

/* Calling the autoexec.sas */
%INCLUDE "/home/u64223611/autoexec.sas";
%PUT &userid;








