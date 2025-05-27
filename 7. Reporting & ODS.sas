/* Getting an html output */
ods html5 file='html_example.html' path="/home/u64223611/Unit7_output";
proc print data=sashelp.class;
run;
ods html5 close;

/*Getting a pdf output */
ods pdf file="/home/u64223611/Unit7_output/pdf_example.pdf";
proc print data=sashelp.class;
run;
ods pdf close;

/* Compiling data from multiple sources into one document
startpage = no would ensure that there is no page-change */

ods pdf file="/home/u64223611/Unit7_output/report1.pdf";

title "Summary of Class";
proc means data=sashelp.class;
run;

ods pdf startpage=no;

title "Summary of Cars";
proc means data=sashelp.cars;
run;

ods pdf close;

/* Styles and templates */
ods pdf file="/home/u64223611/Unit7_output/report2.pdf" style = Pearl;
PROC means data=sashelp.class;
run;
ods pdf close;

/* Listing all the available templates. */
PROC template;
list styles;
run;

/* Creating our custom style with ODS */

proc template;
define style styles.custom;
parent=styles.sapphire;

style Table from Output/
backgroundcolor= red
bordercolor=black
bordertopwidth=2;

style Header from Header/
backgroundcolor=blue
font_weight=bold;

end;
run;

/* Getting the pdf with custom style. */
ods pdf file="/home/u64223611/Unit7_output/report2.pdf" style = styles.custom;
PROC means data=sashelp.class;
run;
ods pdf close;

/* Saving and retrieving custom styles. */

ods path (prepend) sasuser.templat(update);

proc template;
define style styles.Mystyle;
parent=styles.sapphire;
style Table from output/
backgroundcolor=pink;
end;
run;

ods path (prepend) sasuser.templat(read);

ods pdf file="/home/u64223611/Unit7_output/report2.pdf" style = styles.Mystyle;
PROC means data=sashelp.class;
run;
ods pdf close;

/* PROC Report for summarization. */

proc report data=sashelp.class;
column sex age height weight;
define sex / group;
define age / analysis mean;
define height / analysis mean;
define weight / analysis mean;
run;

/* Computing a new feature */

Proc report data=sashelp.class;
column name height weight bmi;
define name /display;
define height/ display;
define weight/ display;
define bmi / computed;

compute bmi;
bmi=(weight/(height**2))*703;
endcomp;

run;

/* Layout - Absolute. */

ods pdf file = "/home/u64223611/Unit7_output/report3.pdf";

ods layout absolute x=1in y=1in width=4in height=2in;
ods region;
title 'Top Box';
proc print data=sashelp.class(obs=5);
run;
ods layout end;

ods layout absolute x=1in y=4in width=6in heigth=2in;
ods region;
title "Bottom Box";
Proc print data=sashelp.air(obs=5);
run;
ods layout end;

ods pdf close;

/* ODS Layout Gridded */

ods pdf file = "/home/u64223611/Unit7_output/report4.pdf";

ods layout gridded columns=2 advance=proc;
ods region;
title "Class Data";
proc print data=sashelp.class(obs=5);
run;

ods region;
title "Air Data";
Proc print data=sashelp.air(obs=5);
run;

ods region;
title "Car Data";
Proc print data=sashelp.cars(obs=5);
run;

ods layout end;
ods pdf close;

/* ODS Graphics */

ODS graphics on;

proc univariate data=sashelp.class;
var height weight;
histogram / normal;
run;

ods graphics off

/* Parameter driven report with Macro Variables */

%let target_gender = M;

proc print data=sashelp.class;
where sex="&target_gender";
run;

%let min_height=60;

proc report data=sashelp.class;
where height >= &min_height;
column name age height;
run;


/* parameter driven report with Macro programs */

%macro region_report(make);
proc print data = sashelp.cars;
where make = "&make";
run;
%mend;

%region_report(BMW);
%region_report(Acura);

















