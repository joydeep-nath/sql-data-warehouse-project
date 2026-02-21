INSERT INTO silver.erp_cust_az12 (
cid,
bdate,
gen
)


SELECT 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) 
ELSE cid
END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
ELSE bdate
END AS bddate,
CASE WHEN gen = 'M' THEN 'Male'
     WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
     WHEN gen IS NULL  OR TRIM(gen) = '' Then 'n/a'
     else gen
     END As gen
FROM bronze.erp_cust_az12

