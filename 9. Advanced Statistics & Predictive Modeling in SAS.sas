/*=========================================================================================*/
/* Data Import */ 
PROC IMPORT OUT = bank_churners
	DATAFILE = "/home/tripathisachin130/Data/IndustryRelevantDatasets/bank_churners.csv"
	DBMS = CSV
	REPLACE; 
	GETNAMES = YES; 
RUN;

/* Simple Linear Regression */ 
PROC REG DATA = WORK.bank_churners; 
	MODEL total_trans_ct = total_trans_amt; 
RUN; 

/* Multiple Linear Regression */ 
PROC REG DATA = WORK.bank_churners; 
	MODEL total_trans_ct = total_trans_amt credit_limit ; 
RUN; 

/*=========================================================================================*/
/* Logistic Regression */ 
DATA retail_data;
    INPUT CustomerID Age Income Visits Gender $ Location $ MadePurchase;
    DATALINES;
1 25 3000 5 M Urban 0
2 32 4500 8 F Suburban 1
3 40 6000 2 M Urban 1
4 22 2500 3 F Rural 0
5 35 4800 9 F Suburban 1
6 28 3100 4 M Rural 0
7 45 7000 1 M Urban 1
8 30 4000 7 F Suburban 1
9 26 2800 6 F Rural 0
10 38 5200 10 M Suburban 1
;
RUN;

PROC LOGISTIC DATA=retail_data;
    CLASS Gender Location / PARAM=ref REF=first;
    MODEL MadePurchase(EVENT='1')=Age Income Visits Gender Location;
RUN;

PROC LOGISTIC DATA=retail_data;
    CLASS Gender Location / PARAM=ref REF=first;
    MODEL MadePurchase(EVENT='1')=Location;
RUN;

PROC LOGISTIC DATA = bank_churners;
	MODEL attrition_flag = credit_limit; 
RUN; 

/*=========================================================================================*/
/* ANOVA */
DATA insurance_data;
    INPUT CustomerID PlanType $ ClaimAmount;
    DATALINES;
1 Basic 300
2 Basic 350
3 Basic 400
4 Standard 450
5 Standard 480
6 Standard 500
7 Premium 700
8 Premium 750
9 Premium 770
;
RUN;

PROC ANOVA DATA = insurance_data; 
	CLASS PlanType; 
	MODEL ClaimAmount = PlanType;
RUN; 

/* Post-Hoc Comparison in ANOVA (TUKEY Test) */ 
PROC ANOVA DATA = insurance_data; 
	CLASS PlanType; 
	MODEL ClaimAmount = PlanType;
	MEANS PlanType / TUKEY; 
RUN; 

PROC ANOVA DATA = bank_churners;
	CLASS Attrition_Flag; 
	MODEL Customer_Age = Attrition_Flag; 
	MEANS Attrition_Flag / TUKEY; 
RUN; 

/*=========================================================================================*/
/* GLM */
DATA salary_data;
    INPUT ID Education $ Experience Salary;
    DATALINES;
1 Bachelors 2 50000
2 Masters 4 65000
3 PhD 6 80000
4 Bachelors 5 60000
5 Masters 7 75000
6 PhD 10 95000
;
RUN;

PROC GLM data = salary_data; 
	CLASS Education; 
	MODEL Salary = Education Experience; 
	MEANS Education / TUKEY; 
RUN; 

/* 1-way ANOVA using GLM */
DATA RETAIL_SALES; 
	INPUT STORETYPE $ SALES; 
	DATALINES;
Online 250 
Online 260
Outlet 265
Outlet 212
Online 182
Online 111
Malls 400
Malls 541
Malls 531
;
RUN; 

PROC GLM DATA = RETAIL_SALES;
	CLASS STORETYPE; 
	MODEL SALES = STORETYPE; 
	MEANS STORETYPE / TUKEY; 
RUN;

/* Multiple Linear Regression - GLM */ 
PROC IMPORT OUT = health_insurance
	DATAFILE = "/home/tripathisachin130/Data/IndustryRelevantDatasets/health_insurance_dataset.csv"
	DBMS = CSV
	REPLACE; 
	GETNAMES = YES; 
RUN;

PROC GLM DATA = health_insurance;;
	TITLE "Understanding PREMIUM_AMOUNT based on ANNUAL_INCOME & Age"; 
	MODEL PREMIUM_AMOUNT = ANNUAL_INCOME Age;  
RUN;
	
/* 2-Way ANOVA - GLM */
PROC GLM DATA = health_insurance;
	CLASS GENDER SMOKING_STATUS; 
	TITLE "Comparing means based on 2 groups GENDER and SMOKING_STATUS for BMI"; 
	MODEL BMI = GENDER SMOKING_STATUS;  
	MEANS GENDER SMOKING_STATUS / TUKEY; 
RUN;

/*=========================================================================================*/
/* PCA */
DATA CONSUMER_DATA;
    INPUT CUSTOMERID $ AGE GENDER $ INCOME PURCHASEAMOUNT FREQUENCY $ @@;
    DATALINES;
CUST001 35 Male 55000 120 Monthly
CUST002 28 Female 48000 250 Weekly
CUST003 42 Female 62000 80 Quarterly
CUST004 50 Male 70000 150 Monthly
CUST005 22 Female 30000 300 Weekly
CUST006 60 Male 80000 50 Annually
CUST007 31 Female 58000 180 Monthly
CUST008 45 Male 65000 100 Quarterly
CUST009 25 Male 35000 280 Weekly
CUST010 55 Female 75000 70 Annually
;
RUN;

PROC PRINT DATA=CONSUMER_DATA;
    TITLE 'SAMPLE CONSUMER DATASET';
RUN;

PROC PRINCOMP DATA=CONSUMER_DATA OUT=PCA_RESULTS PREFIX=PC;
    VAR AGE INCOME PURCHASEAMOUNT;
    TITLE 'PRINCIPAL COMPONENT ANALYSIS (CONSUMER DATA)';
RUN;

PROC PRINT DATA=PCA_RESULTS;
    TITLE 'PCA RESULTS (CONSUMER DATA)';
RUN;

/* ANOTHER EXAMPLE */ 
DATA CUSTOMER_BEHAVIOR;
    INPUT CUSTOMERID $ AGE INCOME PURCHASE FREQUENCY;
    DATALINES;
C001 25 45000 300 5
C002 30 52000 250 6
C003 45 80000 500 3
C004 35 60000 350 4
C005 50 90000 400 2
C006 40 75000 450 3
C007 28 49000 320 5
C008 55 95000 600 2
C009 33 57000 330 4
C010 48 85000 470 2
;
RUN;

PROC PRINCOMP DATA=CUSTOMER_BEHAVIOR OUT=PCA_RESULTS PREFIX=PC;
    VAR AGE INCOME PURCHASE FREQUENCY;
    TITLE 'PCA ON CUSTOMER BEHAVIOR DATA';
RUN;

/* Visualizing First Two Principal Components */
PROC SGPLOT DATA=PCA_RESULTS;
    SCATTER X=PC1 Y=PC2 / DATALABEL=CUSTOMERID;
    TITLE 'PLOT OF PC1 VS PC2';
RUN;

/* Example - When not to use PCA */
PROC PRINCOMP DATA=Health_insurance OUT=PCA_RESULTS PREFIX=PC;
    VAR Age	Annual_Income BMI Claim_History Policy_Term_Years Premium_Amount;
    TITLE 'PCA ON Health Insurance Data';
RUN; 

/*=========================================================================================*/
/* Clustering */
DATA CONSUMER_DATA;
    INPUT CUSTOMERID $ AGE GENDER $ INCOME PURCHASEAMOUNT FREQUENCY $ @@;
    DATALINES;
CUST001 35 Male 55000 120 Monthly
CUST002 28 Female 48000 250 Weekly
CUST003 42 Female 62000 80 Quarterly
CUST004 50 Male 70000 150 Monthly
CUST005 22 Female 30000 300 Weekly
CUST006 60 Male 80000 50 Annually
CUST007 31 Female 58000 180 Monthly
CUST008 45 Male 65000 100 Quarterly
CUST009 25 Male 35000 280 Weekly
CUST010 55 Female 75000 70 Annually
;
RUN;

/* Applying Normalization (Mean is 0 and STD is 1) ==> STANDARDIZATION
We are bringing the variables in one common scale */
PROC STANDARD DATA = CONSUMER_DATA MEAN = 0 STD = 1 OUT = STD_DATA; 
	VAR AGE INCOME PURCHASEAMOUNT; 
RUN; 

/* Clustering and Creating Dendrogram */
PROC CLUSTER DATA = STD_DATA METHOD = AVERAGE OUTTREE = CLUSTREE; 
	VAR AGE INCOME PURCHASEAMOUNT; 
	ID CUSTOMERID; 
RUN; 

/* Cluster Profiling */
PROC TREE DATA = CLUSTREE OUT = CLUSTER_RESULTS NCLUSTERS = 2; 
	COPY AGE INCOME PURCHASEAMOUNT; 
RUN; 

/*=========================================================================================*/























	