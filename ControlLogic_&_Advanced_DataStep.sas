/* Interpreting datalines with custom delimiter */

DATA name_split;
input name $20. gender $6.;
first_name = SCAN(name,1,' ');
last_name = SCAN(name,2,' ');
Datalines;
Abhishek Mishra     Male
Jaya Gupta          Female
;

/* Using dsd- delimiter sensitive data */

DATA name_split;
INFILE datalines dsd;
Length name $30 gender $6;
input name $ gender $;
first_name = SCAN(name,1,' ');
last_name = SCAN(name,2,' ');
Datalines;
"Abhishek Mishra",Male
"Jaya Gupta", Female
;

/* Using Array and Do */

DATA example_array;
INPUT num1 num2 num3;
ARRAY nums[3] num1 num2 num3;
DO i=1 to 3;
nums[i] = nums[i] * 2;
END;
DATALINES;
10 20 30
12 14 35
;

/*Checking conditionals and handling missing values in the logic. */

DATA demo_conditional;
INPUT name $ salary;

IF missing(salary) then status = 'Cannot be determined';
ELSE IF salary>=250 then status = 'Rich';
ELSE IF salary>150 then status = 'Middle-Class';
ELSE IF salary<=150 then status = 'Poor';

DATALINES;
Kim .
Abhi 100
Ram 200
Shyam 500
;

/* Differentiating between WHERE and IF */

/* It filters observations as they are being read from the dataset,
even before entering the DATA step. */
DATA where_demo;
SET sashelp.class;
WHERE sex='M';
RUN;

/*Filters observations after they are read into the PDV(Program Data Vector)*/
DATA if_demo;
SET sashelp.class;
IF sex='M';
RUN;

/* Using WHERE in PROC step. */
PROC print data=sashelp.class;
where sex='M';

/* Indexed DO loop */

data multiplication_table;
DO i=1 to 10;
Product = 17*i;
output;
end;

/* Calculating compound interest at the end of each year */

DATA compound;
DO i=1 to 10;
Amount = 10000 * 1.08**i;
output;
end;

/* Do while loop
A person is investing 2000 every year and he is getting 10 percent interest
In how many years he will cross 50000 as amount. Print the complete table */

DATA example_while;
capital=0;
year=0;
DO WHILE (capital>0);
capital + 2000;
capital + capital*0.1;
year+1;
output;
end;

/* Achieving the same objective with DO UNTIL */

DATA example_while;
capital=0;
year=0;
DO UNTIL (capital>0);
capital + 2000;
capital + capital*0.1;
year+1;
output;
end;

/* Nested DO Loop */

Data multi_table;
do i=2 to 20;
	do j=1 to 10;
		product = i*j;
		output;
end;
end;

/* The utility of RETAIN statement*/

DATA aggregate;
INPUT month revenue;
RETAIN total 0;
total=total+revenue;
DATALINES;
1 100
2 120
3 90
4 110
5 150
;

/* Using BY Grouping get total weight of Females in sashelp.class dataset. */

PROC sort data=sashelp.class out=sorted_class;
by sex;

data female_total;
set work.sorted_class;
by sex;

RETAIN total_weight;
if first.sex and sex='F' then total_weight = 0;
if sex='F' then total_weight + weight;
if last.sex and sex='F' then output;
keep sex total_weight;

/* Solving the same problem with traditional approach.
This approach is favourable if the dataset is not already sorted. */

Data total_female;
set sashelp.class end=last;
RETAIN total_weight 0;
IF sex='F' then total_weight+weight;
if last;
keep total_weight;

/* Creating date variables. */

data example_dates;
start = '01JAN2024'd;
end_ = '01JAN2025'd;
format start end_ date9.;
diff_days = end_ - start;

/* Creating time variables. */
data example_time;
start = '11:00:00't;
lunch = '13:00:00't;
format start lunch timeampm.;
duration = lunch - start;

/* Extracting features from a date. */
data extract_info;
mydate = '22MAY2025'd;
year = year(mydate);
month = month(mydate);
day = day(mydate);
weekday = weekday(mydate);
weekname = PUT(mydate,downame.);

/* Interval function INTCK- Interval check */

DATA example_intck;
start = '01JAN2024'd;
end_ = '01JAN2025'd;
quarter_between = intck('month3',start,end_);

/* Interval function INTNX - Interval Next */
DATA example_intnx;
start_date = '22MAY2025'd;
new_date = intnx('MONTH',start_date,-2,
 'SAMEDAY');
format start_date new_date date9.;

/* Implement hash to add codes for 'Make' in sashelp.cars */
DATA cars_with_code;

if _n_=1 then do;
declare hash h();
h.definekey('Make');
h.definedata('Company_code');
h.definedone();

h.add(key: 'Acura', data:1);
h.add(key: 'Audi', data:2);
h.add(key: 'BMW', data:3);
h.add(key: 'Buick', data:4);
h.add(key: 'Cadillac', data:5);
h.add(key: 'Chevrolet', data:6);
h.add(key: 'Chrysler', data:7);
end;

set sashelp.cars;
company_code=.;
if h.find() ne 0 then compnay_code = .;


/*PROC FCMP: Function compiler*/

PROC fcmp outlib=work.funcs.utils;
function adjust_num(n);
if mod(n,2)=0 then
return (n);
else
return (n+1);
endsub;

options cmplib = work.funcs;
data class_adjusted;
set sashelp.class;
adjusted_num=adjust_num(age);









;