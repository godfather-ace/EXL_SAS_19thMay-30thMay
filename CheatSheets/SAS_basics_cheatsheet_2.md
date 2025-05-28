# 1. Variables
```
DATA TEMP;
	INPUT ID NAME $ SALARY DEPT $ DOJ DATE9. ;
	FORMAT DOJ DATE9. ;
	DATALINES;
	1 Rick 623.3 IT 02APR2001
	2 Dan 515.2 OPS 11JUL2012
	3 Michelle 611 IT 21OCT2000
	;
RUN;
PROC PRINT DATA = TEMP;
RUN;
```
# 2. Strings

## 2.1 Declaring String Variables ; 
```
data string_examples;
   /*String variables of length 6 and 5 */
   String1 = 'Hello 7';
   String2 = 'World';
   Joined_strings =  String1 ||String2 ;
run;
proc print data = string_examples noobs;
run;
```
## 2.2 String Functions

### 2.2.1 SUBSTRN: extracts a substring using the start and end positions.
```
data string_examples;
   String1 = 'Hello';
   sub_string1 = substrn(String1,2,4) ; * Extract from position 2 to 4 ;
   sub_string2 = substrn(String1,3) ; * Extract from position 3 onwards ;
run;
proc print data = string_examples noobs;
run;
```

### 2.2.2 TRIMN: removes the trailing space form a string.
```
data string_examples;
   LENGTH string1 $ 7  ;
   String1='Hello  ';
   length_string1 = lengthc(String1); * Length of String1 (7) ;
   length_trimmed_string = lengthc(TRIMN(String1));  * Length of String1 (5 after removing spaces with TRIMN);
run;
proc print data = string_examples noobs;
run;
```

# 3. Arrays: used to store and retrieve a series of values using an index value.

**Syntax**
```
ARRAY ARRAY-NAME(SUBSCRIPT) ($) VARIABLE-LIST ARRAY-VALUES
```
- ARRAY : SAS keyword to declare an array.
- ARRAY-NAME : name of the array which follows the same rule as variable names.
- SUBSCRIPT : number of values the array is going to store.
- ($) : optional parameter to be used only if the array is going to store character values.
- VARIABLE-LIST : optional list of variables which are the place holders for array values.
- ARRAY-VALUES : actual values that are stored in the array, can be declared here or can be read from a file 
                 or dataline.

## 3.1 Various Ways of Array Declaration ;
- ARRAY AGE[5] (12 18 5 62 44); * Declare an array of length 5 named AGE with values. ;
- ARRAY COUNTRIES(0:8) A B C D E F G H I; * An array of length 5 named COUNTRIES, values starting at index 0. ;
- ARRAY QUESTS(1:5) $ Q1-Q5; * Declare an array of length 5 named QUESTS which contain character values. ;
- ARRAY ANSWER(*) A1-A100; * Declare an array of required length as per the number of values supplied. ;

### 3.1.1 Accessing Array Values 
```
DATA array_example;
	INPUT a1 $ a2 $ a3 $ a4 $ a5 $;
	ARRAY colours(5) $ a1-a5;
	mix = a1||'+'||a2;
	DATALINES;
	yellow pink orange green blue
	;
RUN;
PROC PRINT DATA = array_example;
RUN;
```

### 3.1.2 Using the OF operator ;
```
DATA array_example_OF;
	INPUT A1 A2 A3 A4;
	ARRAY A(4) A1-A4;
	A_SUM = SUM(OF A(*));
	A_MEAN = MEAN(OF A(*));
	A_MIN = MIN(OF A(*));
	DATALINES;
	21 4 52 11
	96 25 42 6
	;
RUN;
PROC PRINT DATA = array_example_OF;
RUN;
```

### 3.1.3 Using the IN operator
```
DATA array_in_example;
	INPUT A1 $ A2 $ A3 $ A4 $;
	ARRAY COLOURS(4) A1-A4;
	IF 'yellow' IN COLOURS THEN available = 'Yes';ELSE available = 'No';
	DATALINES;
	Orange pink violet yellow
	;
RUN;
PROC PRINT DATA = array_in_example;
RUN;
```
# 4. Numeric Formats

**Syntax**
```
Varname Formatnamew.d
```
- **Varname**: is the name of the variable.
- **Formatname**: name of the numeric format applied to the variable.
- **w**: the maximum number of data columns (including digits after . & the . itself) allowed to be stored for the variable.
- **d**: is the number of digits to the right of the decimal.

## 4.1 Reading Numeric formats

**Format - Use**
- **n.** : Maximum "n" number of columns with no decimal point.
- **n.p** : Maximum "n" number of columns with "p" decimal points.
- **COMMAn.p** : Maximum "n" number of columns with "p" decimal places which removes any comma or dollar signs.
- **COMMAn.p** : Maximum "n" number of columns with "p" decimal places which removes any comma or dollar signs.

## 4.2 Displaying Numeric formats ;

**Format - Use**
**n.** : Write maximum "n" number of digits with no decimal point.
**n.p** : Write maximum "n.p" number of columns with "p" decimal points.
**DOLLARn.p** : Write maximum "n" number of columns with p decimal places, leading dollar sign and a comma at the thousandth place.

**Note:**
- If the number of digits after the decimal point is less than the format specifier then 'zeros will be appended' at the end.
- If the number of digits after the decimal point is greater than the format specifier then the last digit will be 'rounded off'.

```
DATA MYDATA1;
	input x 6.; /*maxiiuum width of the data*/
	format x 6.3;
	datalines;
	8722
	93.2
	.1122
	15.116
	;
PROC PRINT DATA = MYDATA1;
RUN;

DATA MYDATA2;
	input y 6.; /*maximum width of the data*/
	format y 5.2;
	datalines;
	8722
	93.2
	.1122
	15.116
	;
PROC PRINT DATA = MYDATA2;
RUN;

DATA MYDATA3;
	input z 6.; /*maximum width of the data*/
	format z DOLLAR10.2;
	datalines;
	8722
	93.2
	.1122
	15.116
	;
PROC PRINT DATA = MYDATA3;
RUN;
```
**Output:**

**MYDATA1**
**Obs**	**x**
1 	8722.0 # Display 6 columns with zero appended after decimal.
2 	93.200 # Display 6 columns with zero appended after decimal.
3 	0.112  # No integers before decimal, so display 3 available digits after decimal.
4 	15.116 # Display 6 columns with 3 available digits after decimal.

**MYDATA2**
**Obs**	**x**
1 	8722  # Display 5 columns. Only 4 are available.
2 	93.20 # Display 5 columns with zero appended after decimal.
3 	0.11  # Display 5 columns with 2 places after decimal.
4 	15.12 # Display 5 columns with 2 places after decimal.

**MYDATA3**
**Obs**	**x**
1 	$8,722.00 # Display 10 columns with leading $ sign, comma at thousandth place and zeros appended after decimal.
2 	$93.20    # Only 2 integers available before decimal and one available after the decimal.
3 	$0.11	  # No integers available before decimal and two available after the decimal.
4 	$15.12    # Only 2 integers available before decimal and two available after the decimal.

# 5. Operators

## 5.1 Arithmetic Operators: Addition (+), Subtraction (-), Multiplication (*), Division (/), Exponentiation (**)
```
DATA MYDATA1;
	input @1 COL1 4.2 @7 COL2 3.1; 
	Add_result = COL1+COL2;
	Sub_result = COL1-COL2;
	Mult_result = COL1*COL2;
	Div_result = COL1/COL2;
	Expo_result = COL1**COL2;
	datalines;
	11.21 5.3
	3.11  11
	;
PROC PRINT DATA = MYDATA1;
RUN;
```

## 5.2 Logical Operators: ( AND (&), OR (|), NOT (~) )
```
DATA MYDATA1;
	input @1 COL1 5.2 @7 COL2 4.1; 
	and_=(COL1 > 10 & COL2 > 5 );
	or_ = (COL1 > 12 | COL2 > 15 );
	not_ = ~( COL2 > 7 );
	datalines;
	11.21 5.3
	3.11  11.4
	;
PROC PRINT DATA = MYDATA1;
RUN;
```

## 5.3 Comparison Operators: ( EQUAL (=), NOT EQUAL (^=), LESS THAN (<), LESS THAN or EQUAL TO (<=), GREATER THAN (>), GREATER THAN or EQUAL TO (>=), IN ) ;
```
DATA MYDATA1;
	input @1 COL1 5.2 @7 COL2 4.1; 
	EQ_ = (COL1 = 11.21);
	NEQ_= (COL1 ^= 11.21);
	GT_ = (COL2 => 8);
	LT_ = (COL2 <= 12);
	IN_ = COL2 in( 6.2,5.3,12 );
	datalines;
	11.21 5.3
	3.11  11.4
	;
PROC PRINT DATA = MYDATA1;
RUN;
```

## 5.4 Minimum/Maximum Operators: ( AND (&), OR (|), NOT (~) ) ;
```
DATA MYDATA1;
	input @1 COL1 5.2 @7 COL2 4.1 @12 COL3 6.3; 
	min_ = MIN(COL1 , COL2 , COL3);
	max_ = MAX( COL1, COl2 , COL3);
	datalines;
	11.21 5.3 29.012
	3.11  11.4 18.512
	;
PROC PRINT DATA = MYDATA1;
RUN;
```

## 5.5 Concatenation Operator: ( AND (&), OR (|), NOT (~) ) ;
```
DATA MYDATA1;
	input COL1 $ COL2 $ COL3 $; 
	concat_ = (COL1 || COL2 || COL3);
	datalines;
	Tutorial s point
	simple easy learning
	;
PROC PRINT DATA = MYDATA1;
RUN;
```

# 6. Loops
---------------------------------------------------------------------------------------------- 

## 6.1 DO Index - loop continues from the start value till the stop value of the index variable.
```
DATA MYDATA1;
	SUM = 0;
	DO VAR = 1 to 5;
	   SUM = SUM+VAR;
	END;
RUN;
PROC PRINT DATA = MYDATA1;
RUN;
```
## 6.2 DO WHILE - loop continues till the while condition becomes false.
```
DATA MYDATA;
	SUM = 0;
	VAR = 1;
	DO WHILE(VAR<6) ;
	   SUM = SUM+VAR;
	   VAR+1;
	END;
RUN;
PROC PRINT;
RUN;
```

## 6.2 DO UNTIL - loop continues till the UNTIL condition becomes True.
```
DATA MYDATA;
	SUM = 0;
	VAR = 1;
	DO UNTIL(VAR>5);
	   SUM = SUM+VAR;
	   VAR+1;
	END;
PROC PRINT;
RUN;
```

# 7. Decision Making

## 7.1 IF
**Syntax:**	
```IF (condition );```

## 7.2 IF THEN ELSE 
**Syntax:**
```
IF (condition ) THEN result1;
ELSE result2; 
```

## 7.3 IF THEN ELSE IF
**Syntax:**
```
IF (condition1) THEN result1;
ELSE IF (condition2) THEN result2;
ELSE IF (condition3) THEN result3;
```

## 7.4 IF THEN DELETE
**Syntax:**
```IF (condition) THEN DELETE;```

# 8. Functions
**Syntax**
```FUNCTIONNAME(argument1, argument2...argumentn)```

## 8.1 Mathematical Functions: used to apply some mathematical calculations on the variable values.
```
DATA Math_functions;
	v1=21; v2=42; v3=13; v4=10; v5=29;
	max_val = MAX(v1,v2,v3,v4,v5); /* Get Maximum value */
	min_val = MIN (v1,v2,v3,v4,v5); /* Get Minimum value */
	med_val = MEDIAN (v1,v2,v3,v4,v5); /* Get Median value */
	rand_val = RANUNI(0); /* Get a random number */
	SR_val= SQRT(sum(v1,v2,v3,v4,v5)); /* Get Square root of sum of the values */
PROC PRINT DATA = Math_functions NOOBS;
run;
```

## 8.2 Date and Time Functions: used to process date and time values.
```
data date_functions;
	INPUT @2 date1 DDMMYY10. @13 date2 DDMMYY10.;
	Years_ = INTCK('YEAR', date1, date2); /* Get the interval between the dates in years */
	months_ = INTCK('MONTH', date1, date2); /* Get the interval between the dates in months */
	weekday_ =  WEEKDAY(date1); /* Get the week day from the date */
	today_ = TODAY(); /* Get Today's date in SAS date format */
	time_ = TIME(); /* Get current time in SAS time format */
	format date1 DATE9. date2 DATE9.;
	DATALINES;
	21/10/2000 16/08/1998
	01/03/2009 11/07/2012
	;
	RUN;
PROC PRINT DATA = date_functions NOOBS;
RUN;
```

## 8.3 Character Functions: used to process character or text values.
```
DATA character_functions;
	lowcse_ = LOWCASE('HELLO'); /* Convert the string into lower case */
	upcase_ = UPCASE('hello'); /* Convert the string into upper case */
	reverse_ = REVERSE('Hello'); /* Reverse the string */
	nth_letter_ = SCAN('Learn SAS Now', 2); /* Return the nth word */
RUN;
PROC PRINT DATA = character_functions NOOBS;
RUN;
```

## 8.4 Truncation Functions: used to truncate numeric values.
```
DATA trunc_functions;
	ceil_ = CEIL(11.85); /* Nearest greatest integer */
	floor_ = FLOOR(11.85); /* Nearest greatest integer */
	int_ = INT(32.41); /* Integer portion of a number */
	round_ = ROUND(5621.78); /* Round off to nearest value */
RUN;
PROC PRINT DATA = trunc_functions NOOBS;
RUN;
```

## 8.5 Miscellaneous Functions ;
```
DATA misc_functions;
	state2=zipstate('01040'); /* Nearest greatest integer */ 
	payment = mort(50000, . , .10/12,30*12); /* Amortization calculation */
RUN;
PROC PRINT DATA = misc_functions NOOBS;
RUN;
```

# 9. Input Methods

## 9.1 List Input Method
```
DATA TEMP;
	INPUT EMPID ENAME $ DEPT $ ;
	DATALINES;
	1 Rick IT
	2 Dan OPS
	3 Tusar IT
	4 Pranab OPS
	5 Rasmi FIN
	;
PROC PRINT DATA = TEMP;
RUN;
```

## 9.2 Named Input Method
```
DATA TEMP;
	INPUT EMPID = ENAME = $ DEPT = $ ;
	DATALINES;
EMPID=101 ENAME=Rick DEPT=IT
EMPID=102 ENAME=Dan DEPT=OPS
EMPID=103 ENAME=Tusar DEPT=IT
EMPID=104 ENAME=Pranab DEPT=OPS
EMPID=105 ENAME=Rasmi DEPT=FIN
;
PROC PRINT DATA = TEMP;
RUN;
```

## 9.3 Column Input Method
```
DATA TEMP;
	INPUT EMPID 1-3 ENAME $ 4-12 DEPT $ 13-16;
	DATALINES;
14 Rick     IT 
241Dan      OPS 
30 Sanvi    IT 
410Chanchal OPS 
52 Piyu     FIN 
;
PROC PRINT DATA = TEMP;
RUN;
```

## 9.4 Formatted Input Method 
```
DATA TEMP;
	INPUT @2 EMPID $ @5 ENAME $ @14 DEPT $ ;
	DATALINES;
	14 Rick     IT 
	241 Dan      OPS 
	30 Sanvi    IT 
	410 Chanchal OPS 
	52 Piyu     FIN 
	;
PROC PRINT DATA = TEMP;
RUN;
```

# 10. Macros: hold a value to be used again & again by a SAS program

## 10.1 Global Macro variable
```
PROC PRINT DATA = sashelp.cars;
	where make = 'Audi' and type = 'Sports' ;
	TITLE "Sales as of &SYSDAY &SYSDATE";
RUN;
```

## 10.2 Local Macro variable: used to supply different varaibels to the same SAS statements so that they can process different observations of a data set
```
%LET make_name = 'Audi';
%LET type_name = 'Sports';
proc print data = sashelp.cars;
	where make = &make_name and type = &type_name ;
	TITLE "Sales as of &SYSDAY &SYSDATE";
RUN;
```

## 10.3 Macro Programs: group of SAS statements that is referred by a name and to use it in program anywhere, using that name. It starts with a %MACRO statement and ends with %MEND statement.
```
%MACRO show_result(make_ , type_);
PROC PRINT DATA = sashelp.cars;
	where make = "&make_" and type = "&type_" ;
	TITLE "Sales as of &SYSDAY &SYSDATE";
RUN;
%MEND;

%show_result(BMW,SUV);
```

## 10.4 Commonly Used Macros

### 10.4.1 %PUT
```
DATA _null_;
	CALL SYMPUT ('today', TRIM(PUT("&sysdate"d,worddate22.)));
RUN;
%PUT &today;
```
### 10.4.2 %RETURN
```
%MACRO check_condition(val);
   %IF &val = 10 %THEN %RETURN;
   DATA p;
      x = 34.2;
   RUN;  
%MEND check_condition;  
%check_condition(11);
```

### 10.4.3 %END
```
%MACRO test(finish);
   %LET i = 1;
   %DO %WHILE (&i <&finish);
      %PUT the value of i is &i;
      %LET i=%EVAL(&i+1);
   %END;
%MEND test;
%test(5)
```

# 11. Date & Time
```
Input Date        | Date width | Informat
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
03/11/2014        | 10	       | mmddyy10.
03/11/14          | 8	       | mmddyy8.
December 11, 2012 | 20	       | worddate20.
14mar2011         | 9	       | date9.
14-mar-2011       | 11	       | date11.
14-mar-2011       | 15	       | anydtdte15.
```

## 11.1 Date Informat & Output Format
```
DATA TEMP;
	INPUT @2 Date1 date11. @13 Date2 anydtdte15. @24 Date3 mmddyy10. ;
	FORMAT Date1 DATE9. Date2 date11. Date3 DATE9..;
	DATALINES;
	02-mar-2012 3/02/2012 3/02/2012
	;
PROC PRINT DATA = TEMP;
RUN;
```
