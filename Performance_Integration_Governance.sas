/* Making dataset in work library from the uploaded csv file. */

FILENAME REFFILE '/home/u64223611/Insurance.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.Insurance;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.Insurance; RUN;

/* Assume that you are director of NTCP and you are only concerned
with age, sex and smoker column for your analysis. */ 

* using keep;
data ntcp;
set insurance(keep=age sex smoker);
run;

* using drop;
data ntcp;
set insurance(drop=bmi children charges);
run;

/* Getting a summary table to analyze the % of smokers among Males and Females. */
proc sql;
create table smoker_ratio as
select sex,
sum(case when smoker='yes' then 1 else 0 end) as smokers,
count(*) as total,
calculated smokers/calculated total as smoker_ratio
from ntcp
group by sex;
quit;

* Plotting a bar graph based on the previous derived table;
proc sgplot data=smoker_ratio;
vbar sex/ response=smoker_ratio datalabel;

/* Working of OBS */

data sample_insurace;
set insurance(obs=10);

data sample_insurance2;
set insurance(firstobs=11 obs=20);

/* Using indexing to optimize the performance */

proc datasets library=work;
modify insurance;
index create sex_smoker = (sex smoker);
quit;

data smokers;
set insurance;
where smoker='yes' and sex='female';

/* Partitioning the dataset */

data southwest northwest;
set insurance;
if region='southwest' the output southwest;
else if region = 'norhtwest' then output northwest;

proc sort data=insurance out=insurance_sorted;
by region;

proc means data=insurance_sorted;
by region;

/* Stored procedures */

%macro region_report(region=);
ods pdf file= "/home/u64223611/region_report.pdf";

title "Report for Region: &region";
proc print data=insurance;
where region="&region";
run;
ods pdf close;
%mend;

%region_report(region=southwest);

/* Split the dataset based on age. */
%macro age_filter;

%do i=1 %to 3;

%let age_limit = %eval(20 + (&i *10));

data age_group_&age_limit;
set insurance;
if age>= &age_limit;
run;

%end;
%mend;

%age_filter





