USE superstore;

-- Resumen de calidad (una fila por control). Se audita sobre staging (valores crudos)
WITH b AS (
  SELECT row_id, order_id, customer_id,
    to_date(from_unixtime(unix_timestamp(order_date,'M/d/yyyy'))) AS od,
    to_date(from_unixtime(unix_timestamp(ship_date,'M/d/yyyy')))  AS sd,
    CAST(sales AS DOUBLE)    AS s,
    CAST(discount AS DOUBLE) AS d,
    CAST(profit AS DOUBLE)   AS p
  FROM stg_superstore
)
SELECT * FROM (
  SELECT '01_total_registros' AS control, COUNT(*) AS cantidad FROM b
  UNION ALL SELECT '02_row_id_duplicados', COUNT(*) - COUNT(DISTINCT row_id) FROM b
  UNION ALL SELECT '03_ordenes_unicas', COUNT(DISTINCT order_id) FROM b
  UNION ALL SELECT '04_clientes_unicos', COUNT(DISTINCT customer_id) FROM b
  UNION ALL SELECT '05_fechas_invalidas', COUNT(*) FROM b WHERE od IS NULL OR sd IS NULL
  UNION ALL SELECT '06_ventas_menor_igual_cero', COUNT(*) FROM b WHERE s <= 0 OR s IS NULL
  UNION ALL SELECT '07_descuento_fuera_0_1', COUNT(*) FROM b WHERE d < 0 OR d > 1 OR d IS NULL
  UNION ALL SELECT '08_envio_antes_de_pedido', COUNT(*) FROM b WHERE sd < od
  UNION ALL SELECT '09_ganancia_negativa_info', COUNT(*) FROM b WHERE p < 0
) t ORDER BY control;

-- Campos con NULL (sobre la tabla tipada: un NULL aquí también incluye fallos de conversión)
SELECT
  COUNT(*) - COUNT(row_id) AS row_id, COUNT(*) - COUNT(order_id) AS order_id,
  COUNT(*) - COUNT(order_date) AS order_date, COUNT(*) - COUNT(ship_date) AS ship_date,
  COUNT(*) - COUNT(ship_mode) AS ship_mode, COUNT(*) - COUNT(customer_id) AS customer_id,
  COUNT(*) - COUNT(customer_name) AS customer_name, COUNT(*) - COUNT(segment) AS segment,
  COUNT(*) - COUNT(country) AS country, COUNT(*) - COUNT(city) AS city,
  COUNT(*) - COUNT(state) AS state, COUNT(*) - COUNT(postal_code) AS postal_code,
  COUNT(*) - COUNT(region) AS region, COUNT(*) - COUNT(product_id) AS product_id,
  COUNT(*) - COUNT(category) AS category, COUNT(*) - COUNT(sub_category) AS sub_category,
  COUNT(*) - COUNT(product_name) AS product_name, COUNT(*) - COUNT(sales) AS sales,
  COUNT(*) - COUNT(quantity) AS quantity, COUNT(*) - COUNT(discount) AS discount,
  COUNT(*) - COUNT(profit) AS profit
FROM superstore_sales;
