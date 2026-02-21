Select * from silver.erp_loc_a101
select * from silver.crm_cust_info

INSERT INTO Silver.erp_loc_a101 (
cid , cntry)
Select 
REPLACE(cid , '-' , '') AS cid,
CASE WHEN UPPER(TRIM(cntry)) IN ('DE') THEN 'Germany'
     WHEN  TRIM(cntry) IN ('USA' , 'US') THEN 'United States'
     WHEN cntry IS NULL OR TRIM(cntry) = '' THEN 'n/a'
     ELSE TRIM(cntry)
END cntry
FROM bronze.erp_loc_a101;






