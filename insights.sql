-- Viewing complete records from each table to understand available data
SELECT * FROM category;
SELECT * FROM products;
SELECT * FROM sales;
SELECT * FROM stores;
SELECT * FROM warranty;

-- Indexing key columns in the sales table to enhance query performance,
-- particularly for frequent filters and joins
CREATE INDEX sales_product_id ON sales(product_id);
CREATE INDEX sales_store_id ON sales(store_id);
CREATE INDEX sales_sale_date ON sales(sale_date);

-- Identifying geographic distribution of Apple Stores.
-- Helps Apple analyze regional presence and saturation, supporting market expansion or consolidation decisions.
SELECT 
    country, 
    COUNT(store_id) AS num_stores
FROM 
    stores
GROUP BY 
    country
ORDER BY 
    num_stores DESC;

-- Assessing the volume of products sold per store.
-- Useful for ranking store performance, identifying high-performing locations, and reallocating inventory or resources.
SELECT 
    st.store_name, 
    SUM(s.quantity) AS total_units_sold
FROM 
    sales s
JOIN 
    stores st USING(store_id)
GROUP BY 
    st.store_name
ORDER BY 
    total_units_sold DESC;

-- Measuring seasonal demand by evaluating sales in December 2023.
-- Informs staffing, marketing, and inventory planning for peak holiday seasons.
SELECT 
    SUM(quantity) AS december_2023_units_sold
FROM 
    sales
WHERE 
    sale_date BETWEEN '2023-12-01' AND '2023-12-31';

-- Determining how many stores have no warranty claims associated with their sales.
-- Helps flag consistently high-performing stores or possible data integrity issues, guiding customer service improvements.
SELECT 
    COUNT(*) AS stores_without_warranty_claims
FROM 
    stores
WHERE 
    store_id NOT IN (
        SELECT DISTINCT s.store_id
        FROM sales s
        JOIN warranty w USING(sale_id)
    );

-- Calculating the share of warranty claims deemed invalid.
-- Indicates product misuse rates, potential customer dissatisfaction, or the need for clearer warranty policy communication.
SELECT 
    ROUND(
        (SELECT COUNT(*) FROM warranty WHERE repair_status ILIKE 'Warranty Void')::NUMERIC 
        / 
        (SELECT COUNT(*) FROM warranty)::NUMERIC * 100, 
        2
    ) AS warranty_void_percentage;


-- 6. Which store had the highest total units sold in 2024?

SELECT 
    st.store_name, 
    SUM(s.quantity) AS total_units_sold
FROM 
    sales s
JOIN 
    stores st USING(store_id)
WHERE
	extract (year from s.sale_date)=2024
GROUP BY 
    st.store_name
ORDER BY 
    total_units_sold DESC
	limit 1 ;

-- 7. Count the number of unique products sold in the last year.
-- 8. What is the average price of products in each category?
-- 9. How many warranty claims were filed in 2020?
-- 10. Identify each store and best selling day based on highest qty sold
