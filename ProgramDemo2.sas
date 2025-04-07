/* STEP 1: EXTRACT & DATA IMPORTATION */

/* Import the CSV file */
proc import datafile="/home/u64163028/Demo2/train.csv"
    out=sales2
    dbms=csv
    replace;
    getnames=yes;
run;

/* Check the actual column names */
proc contents data=sales2; 
run;

/* Rename columns for consistency (spaces/special chars removed) */
data sales2_clean;
    set sales2(rename=(
        'Order ID'n = Order_ID
        'Customer ID'n = Customer_ID
        'Product ID'n = Product_ID
        'Order Date'n = Order_Date
        'Sales'n = Sales
        'Customer Name'n = Customer_Name
        'Postal Code'n = Postal_Code
        'Product Name'n = Product_Name
        'Sub-Category'n = Sub_Category
    ));
run;

/* STEP 2: TRANSFORMATION */

/* Create Fact Table */
proc sql;
    create table fact as
    select 
        Order_ID, 
        Customer_ID, 
        Product_ID, 
        Order_Date, 
        Sales
    from sales2_clean;
quit;

/* Create Product Dimension Table */
proc sql;
    create table dim_product as
    select distinct 
        Product_ID, 
        Product_Name, 
        Category, 
        Sub_Category
    from sales2_clean;
quit;

/* Create Customer Dimension Table */
proc sql;
    create table dim_customer as
    select distinct 
        Customer_ID, 
        Customer_Name, 
        Country, 
        City, 
        State, 
        Postal_Code
    from sales2_clean;
quit;

/* STEP 3: VERIFY THE TABLES */

/* Print the top 5 rows of the Fact Table */
proc print data=fact(obs=5); 
run;

/* Print the top 5 rows of the Product Dimension Table */
proc print data=dim_product(obs=5); 
run;

/* Print the top 5 rows of the Customer Dimension Table */
proc print data=dim_customer(obs=5); 
run;


/* ______________ */

/* Export Fact Table */
proc export data=fact
    outfile="/home/u64163028/Demo2/fact.csv"
    dbms=csv
    replace;
run;

/* Export Product Dimension Table */
proc export data=dim_product
    outfile="/home/u64163028/Demo2/dim_product.csv"
    dbms=csv
    replace;
run;

/* Export Customer Dimension Table */
proc export data=dim_customer
    outfile="/home/u64163028/Demo2/dim_customer.csv"
    dbms=csv
    replace;
run;


