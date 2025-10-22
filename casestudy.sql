
CREATE OR REPLACE DATABASE sales_case_db;
USE DATABASE sales_case_db;


CREATE OR REPLACE SCHEMA sales_case_schema1;
USE SCHEMA sales_case_schema1;

CREATE OR REPLACE TABLE sales_case_table (
    ORDER_ID STRING,
    ORDER_DATE DATE,
    MONTH_OF_SALE STRING,
    CUSTOMER_ID STRING,
    CUSTOMER_NAME STRING,
    COUNTRY STRING,
    REGION STRING,
    CITY STRING,
    CATEGORY STRING,
    SUBCATEGORY STRING,
    QUANTITY NUMBER,
    DISCOUNT FLOAT,
    SALES FLOAT,
    PROFIT FLOAT
);

CREATE OR REPLACE FILE FORMAT ff_sales_csv
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL');

CREATE OR REPLACE STAGE sales_case_stage
  URL = 'azure://casestudystorage123.blob.core.windows.net/salescsvfiles'
  CREDENTIALS = (AZURE_SAS_TOKEN = '?sp=rl&st=2025-10-22T09:33:35Z&se=2025-10-22T17:48:35Z&spr=https&sv=2024-11-04&sr=c&sig=8Mglg%2BLBX2HZ9N0cMHn%2BN%2Fgol2O4mgLRYf%2FOlUGGJHg%3D')
  FILE_FORMAT = (FORMAT_NAME = ff_sales_csv);


LIST @sales_case_stage;

COPY INTO sales_case_table
FROM @sales_case_stage
FILE_FORMAT = (FORMAT_NAME = ff_sales_csv)
ON_ERROR = 'CONTINUE';


SELECT * FROM sales_case_table
LIMIT 10;

SELECT * FROM sales_case_table;





