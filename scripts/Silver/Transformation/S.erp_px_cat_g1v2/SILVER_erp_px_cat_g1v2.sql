Select * FROM bronze.erp_px_cat_g1v2
Select * from Silver.crm_prd_info



INSERT INTO silver.erp_px_cat_g1v2(
id,cat,subcat,maintenance)
SELECT * from bronze.erp_px_cat_g1v2

select * from silver.erp_px_cat_g1v2