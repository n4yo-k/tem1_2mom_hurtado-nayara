USE superstore;

-- 1) CSV -> staging
LOAD DATA LOCAL INPATH '/tmp/superstore.csv' OVERWRITE INTO TABLE stg_superstore;

-- 2) staging -> tabla analítica (casteo de tipos y fechas M/d/yyyy)
INSERT OVERWRITE TABLE superstore_sales
SELECT
  CAST(row_id AS INT),
  order_id,
  to_date(from_unixtime(unix_timestamp(order_date,'M/d/yyyy'))),
  to_date(from_unixtime(unix_timestamp(ship_date,'M/d/yyyy'))),
  ship_mode, customer_id, customer_name, segment, country, city, state,
  lpad(TRIM(postal_code),5,'0'),
  region, product_id, category, sub_category, product_name,
  CAST(sales AS DECIMAL(12,4)),
  CAST(quantity AS INT),
  CAST(discount AS DECIMAL(4,2)),
  CAST(profit AS DECIMAL(12,4))
FROM stg_superstore;
