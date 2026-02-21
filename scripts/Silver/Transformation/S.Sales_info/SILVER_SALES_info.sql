--Checking for the Invalid Date 

select NULLIF(sls_due_dt , 0 ) AS sls_due_dt
FROM
bronze.crm_sales_details
WHERE sls_due_dt <=0 OR LEN(sls_due_dt) ! = 8

-- Checking for Invalid Order Date Means OrderDate should be less than ship_date 
select * from bronze.crm_sales_details
WHERE sls_due_dt < sls_order_dt  OR sls_due_dt < sls_ship_dt

-- SALE = Qunatity * proce and it should not be NUll , negative , Zero

Select DISTINCT 
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
THEN sls_quantity * ABS(sls_price)
ELSE sls_sales
END AS sls_sales ,
sls_quantity , 
CASE WHEN sls_price <=0 OR sls_price IS NULL
THEN sls_sales / NULLIF(sls_quantity,0)
ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details
WHERE sls_Sales != sls_quantity * sls_price
OR sls_Sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_Sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0 
ORDER BY  sls_sales,sls_quantity ,sls_price


-- After this we need to identify the business logic for what needs to done for 
-- sales , quantity , price 

--If Sales is negative, zero, or null, derive it using Quantity and Price.
--If Price is zero or null, calculate it using Sales and Quantity.
--If Price is negative, convert it to a positive value.



INSERT INTO silver.crm_sales_details
(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)



Select
    sls_ord_num,  
    sls_prd_key , 
    sls_cust_id , 
    CASE
        WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
        ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
        END AS sls_order_dt,
   CAST( CAST(sls_ship_dt AS VARCHAR) AS DATE) AS sls_ship_dt, 
   CAST( CAST (sls_due_dt AS VARCHAR) AS DATE) AS sls_due_dt,
    CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
THEN sls_quantity * ABS(sls_price)
ELSE sls_sales
END AS sls_sales   ,  
    sls_quantity ,
    CASE WHEN sls_price <=0 OR sls_price IS NULL
THEN sls_sales / NULLIF(sls_quantity,0)
ELSE sls_price
END AS sls_price    
    FROM bronze.crm_sales_details


    select * from silver.crm_sales_details