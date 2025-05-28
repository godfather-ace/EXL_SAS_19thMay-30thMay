/* Analysing the Horsepower of the vehicles w.r.t Type and Origin
with the help of a stacked/clustered bar graph. */

PROC SQL;
create table hp_summary as
select
Type,
Origin,
mean(Horsepower) as Avg_Horsepower
from sashelp.cars
group by Type,Origin;
quit;

proc sgplot data=hp_summary;
vbar Origin / response = Avg_horsepower group=Type groupdisplay=cluster; 

/* Plotting two bar graphs overlapping with each other. */

PROC SGPLOT data=sashelp.prdsale;
yaxis label = 'Sales';
vbar country / response = predict;
vbar country / response = actual barwidth = 0.8 transparency=0.6;

/* Using SGPANEL to get a collection of plots seggregated on the basis of a category */

Proc sgpanel data=sashelp.cars;
panelby Type / layout = panel;
scatter x= horsepower y= weight;

/* Using SGRENDER to plot from predefined templates */

PROC template;
define statgraph w_vs_h;
begingraph;
entrytitle "Scatter Plot: Weight vs Height";
layout overlay;
scatterplot x=height y=weight;
endlayout;
endgraph;
end;

proc sgrender data=sashelp.class template= w_vs_h;

/* PROC SGSCATTER PLOT */

PRoc sgscatter data=sashelp.cars;
plot (MSRP Horsepower) * (MPG_Highway Weight);

/* PROC SGSCATTER COMPARE */

proc sgscatter data=sashelp.cars;
compare x=(Horsepower Weight) y=(MPG_Highway MPG_City);

/* Correlation between two numerical fields */

proc corr data = sashelp.cars;
var horsepower weight mpg_city;

/* Frequency Procedure */

Proc freq data=sashelp.class;
tables sex;

/* getting chi-squared analysis from frequency distribution. */
proc freq data=sashelp.cars;
tables Type*Origin / chisq;

/* loading the loan_default dataset into sas */

FILENAME REFFILE '/home/u64223611/loan_default.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.loan_default;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.loan_default; RUN;

/* Question 1: Out of person_home_ownership and loan_intent which factor
is a more important determinant for cb_person_default_on_file? */

proc freq data=work.loan_default;
tables person_home_ownership*cb_person_default_on_file / chisq;

proc freq data=work.loan_default;
tables loan_intent*cb_person_default_on_file / chisq;

/* Question 2:Test if younger people are more defaulters or older. */

* First categorizing the records as per the age;
data loan_agegroup;
set work.loan_default;
length age_group $10;
if person_age<25 then age_group ="<25";
else if person_age<40 then age_group = "25-40";
else if person_age<60 then age_group ="40-60";
else if person_age>=60 then age_group = ">60";

* Generating a summary table with SQL;
proc sql;
create table default_ratio as
select 
age_group,
mean(cb_person_default_on_file) as default_ratio
from loan_agegroup
group by age_group;
quit;

* Plotting the summary table;
proc sgplot data=default_ratio;
vbar age_group/ response=default_ratio datalabel;
yaxis label="Default_Ratio";
xaxis label="Age group";
title "Default Ratio by Age Group";

/* Question 3: People whose percentage of income as loan/emi is high are richer */
proc sgscatter data=loan_default;
plot (loan_percent_income)*(person_income);










