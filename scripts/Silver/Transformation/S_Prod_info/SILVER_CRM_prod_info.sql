INSERT INTO Silver.crm_prd_info (
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)



SELECT 
      prd_id,
      REPLACE(SUBSTRING(prd_key,1,5), '-' , '_') AS cat_id ,
      SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
      prd_nm,
      ISNULL(prd_cost,0) AS prd_cost ,
      CASE UPPER(TRIM(prd_line))
          WHEN 'M' THEN 'Mountain'
          WHEN 'R' THEN 'Road'
          WHEN 'S' THEN 'Other Sales'
          WHEN 'T' THEN 'Touring'
          ELSE 'n/a'
      END AS prd_line,
      CAST(prd_start_dt AS DATE) AS prd_start_dt ,
      CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE ) AS prd_end_dt
  FROM bronze.crm_prd_info
  Order By prd_id



  


  --select * from bronze.erp_px_cat_g1v2

  --  select * from bronze.crm_sales_details
  select * from silver.crm_prd_info 

  select * from bronze.crm_prd_info 
