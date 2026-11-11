USE superstore;
SELECT 'stg_superstore' AS tabla, COUNT(*) AS registros FROM stg_superstore
UNION ALL
SELECT 'superstore_sales', COUNT(*) FROM superstore_sales;

DESCRIBE superstore_sales;

SELECT row_id, order_id, order_date, ship_date, region, category, sales, quantity, discount, profit
FROM superstore_sales LIMIT 5;
