

Create View gold.fact_sales AS

SELECT 
       sd.sls_ord_num AS order_number,
       pr.product_number,
       cu.customer_id,
       sd.sls_order_dt AS Order_date,
       sd.sls_ship_dt AS shipping_date ,
       sd.sls_due_dt AS Due_date,
       sd.sls_sales AS sales,
       sd.sls_quantity AS quantity,
       sd.sls_price AS price
  FROM silver.crm_sales_details sd
  LEFT JOIN gold.dim_products pr
  ON sd.sls_prd_key = pr.product_number
  LEFT JOIN gold.dim_customers cu
  ON sls_cust_id = cu.customer_id

