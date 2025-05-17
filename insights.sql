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

-- Identifying the top-performing Apple Store in terms of units sold during 2024.
-- This helps in recognizing the most commercially successful location, which can guide future investments, promotions, or layout replication.
SELECT 
    st.store_name, 
    SUM(s.quantity) AS total_units_sold
FROM 
    sales s
JOIN 
    stores st USING(store_id)
WHERE
    EXTRACT(YEAR FROM s.sale_date) = 2024
GROUP BY 
    st.store_name
ORDER BY 
    total_units_sold DESC
LIMIT 1;

-- Measuring product diversity by counting the number of unique items sold in 2023.
-- Useful for understanding catalog effectiveness and inventory variety from a historical perspective.
SELECT 
    COUNT(DISTINCT product_id) AS unique_products_sold_2023
FROM 
    sales
WHERE 
    EXTRACT(YEAR FROM sale_date) = 2023;

-- Calculating average product price per category.
-- Helps in pricing strategy and understanding the relative value offered within each product segment (e.g., accessories vs. devices).
SELECT 
    c.category_name,
    ROUND(AVG(p.price)::NUMERIC, 2) AS average_price
FROM 
    products p
JOIN 
    category c USING(category_id)
GROUP BY 
    c.category_name
ORDER BY 
    average_price DESC;

-- Quantifying total warranty claims filed in 2020.
-- Indicates post-sale service load and potential quality issues during that period, helping support planning and product evaluation.
SELECT 
    COUNT(*) AS no_of_warranty_claims_2020
FROM 
    sales
JOIN 
    warranty w USING(sale_id)
WHERE 
    EXTRACT(YEAR FROM sale_date) = 2020;

-- Identifying the best-selling day of the week for each Apple Store based on total quantity sold.
-- Enables optimization of staffing, promotional efforts, and stock allocation for peak days at individual store levels.
SELECT *
FROM (
    SELECT 
        st.store_name,
        TRIM(TO_CHAR(s.sale_date, 'Day')) AS day,
        SUM(s.quantity) AS total_units_sold,
        RANK() OVER (PARTITION BY st.store_name ORDER BY SUM(s.quantity) DESC) AS rnk
    FROM 
        sales s
    JOIN 
        stores st USING(store_id)
    GROUP BY 
        st.store_name, day
) t
WHERE rnk = 1;
