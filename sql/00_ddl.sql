CREATE DATABASE IF NOT EXISTS superstore;
USE superstore;

-- Staging: copia fiel del CSV (todo STRING) para poder auditar antes de convertir tipos
DROP TABLE IF EXISTS stg_superstore;
CREATE TABLE stg_superstore (
  row_id STRING, order_id STRING, order_date STRING, ship_date STRING, ship_mode STRING,
  customer_id STRING, customer_name STRING, segment STRING, country STRING, city STRING,
  state STRING, postal_code STRING, region STRING, product_id STRING, category STRING,
  sub_category STRING, product_name STRING, sales STRING, quantity STRING,
  discount STRING, profit STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar"=",", "quoteChar"="\"", "escapeChar"="\\")
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

-- Tabla analítica con tipos apropiados
DROP TABLE IF EXISTS superstore_sales;
CREATE TABLE superstore_sales (
  row_id        INT,
  order_id      STRING,
  order_date    DATE,
  ship_date     DATE,
  ship_mode     STRING,
  customer_id   STRING,
  customer_name STRING,
  segment       STRING,
  country       STRING,
  city          STRING,
  state         STRING,
  postal_code   STRING,
  region        STRING,
  product_id    STRING,
  category      STRING,
  sub_category  STRING,
  product_name  STRING,
  sales         DECIMAL(12,4),
  quantity      INT,
  discount      DECIMAL(4,2),
  profit        DECIMAL(12,4)
)
STORED AS ORC
TBLPROPERTIES ('transactional'='false');
