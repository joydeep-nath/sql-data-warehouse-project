
CREATE VIEW gold.dim_products AS 
SELECT 
	ROW_NUMBER() over (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
	pn.cat_id AS category_id, 
	er.cat AS categary,
	er.subcat As subcategory,
	er.maintenance ,
	pn.prd_cost AS product_cost,
	pn.prd_line AS product_line,
	pn.prd_start_dt AS start_date
FROM Silver.crm_prd_info pn
	JOIN Silver.erp_px_cat_g1v2 er
	ON pn.cat_id = er.id
WHERE prd_end_dt IS NULL -- Filter out all historical data
