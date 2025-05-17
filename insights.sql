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

-- Finding the least-selling product in each country for each year.
-- Helps identify underperforming items by region and time, enabling more targeted product phase-outs or regional promotions.
WITH cte AS (
    SELECT 
        st.country,
        EXTRACT(YEAR FROM s.sale_date) AS year,
        p.product_name,
        SUM(s.quantity) AS total_units_sold,
        DENSE_RANK() OVER (
            PARTITION BY st.country, EXTRACT(YEAR FROM s.sale_date) 
            ORDER BY SUM(s.quantity)
        ) AS rnk
    FROM 
        products p
    JOIN 
        sales s USING(product_id)
    JOIN 
        stores st USING(store_id)
    GROUP BY 
        st.country, year, p.product_name
)
SELECT 
    country,
    year,
    product_name,
    total_units_sold
FROM 
    cte
WHERE 
    rnk = 1
ORDER BY 
    country, year, product_name DESC;

-- Calculating how many warranty claims were made within 180 days of purchase.
-- Useful for measuring short-term reliability of products and possible manufacturing defects.
SELECT 
    *, 
    (w.claim_date - s.sale_date) AS num_days
FROM 
    sales s
JOIN 
    warranty w USING(sale_id)
WHERE 
    (w.claim_date - s.sale_date) < 180;

-- Counting warranty claims for products launched in the last 3 years.
-- Assesses the durability and performance of newer products post-launch, useful for product quality assurance.
SELECT 
    p.product_name,
    COUNT(p.product_name) AS num_claims
FROM 
    products p
JOIN 
    sales s USING(product_id)
RIGHT JOIN 
    warranty w USING(sale_id)
WHERE 
    p.launch_date >= CURRENT_DATE - INTERVAL '3 year'
GROUP BY 
    p.product_name
ORDER BY 
    num_claims DESC;

-- Identifying months in the last 4 years when sales from USA stores exceeded 5000 units.
-- Supports seasonal trend analysis and planning for marketing or inventory based on high-demand periods.
SELECT 
    TO_CHAR(s.sale_date, 'MM-YYYY') AS month,
    SUM(s.quantity) AS sale_units
FROM 
    sales s
JOIN 
    stores st USING(store_id)
WHERE 
    s.sale_date >= CURRENT_DATE - INTERVAL '4 year'
    AND st.country = 'USA'
GROUP BY 
    month
HAVING 
    SUM(s.quantity) > 5000;

-- Finding the product category with the most warranty claims in the last 3 years.
-- Highlights product lines with recurring issues and can guide improvements in design, sourcing, or customer support.
SELECT 
    c.category_name,
    COUNT(*) AS num_claims
FROM 
    warranty w
LEFT JOIN 
    sales s USING(sale_id)
JOIN 
    products p USING(product_id)
JOIN 
    category c USING(category_id)
WHERE 
    w.claim_date >= CURRENT_DATE - INTERVAL '3 year'
GROUP BY 
    c.category_name
ORDER BY 
    num_claims DESC
LIMIT 1;

-- Estimating the percentage of purchases that resulted in warranty claims per country.
-- Helps assess post-sale service load and customer satisfaction differences across regions.
SELECT 
    st.country,
    SUM(s.quantity) AS total_units_sold,
    COUNT(w.claim_id) AS total_claims,
    ROUND(COUNT(w.claim_id)::NUMERIC / SUM(s.quantity) * 100, 2) AS claim_ratio
FROM 
    sales s
JOIN 
    stores st USING(store_id)
LEFT JOIN 
    warranty w USING(sale_id)
GROUP BY 
    st.country
ORDER BY 
    claim_ratio DESC;

-- Calculating year-over-year sales growth for each Apple Store.
-- Enables performance tracking and helps leadership evaluate which stores are improving and which need support.
WITH cte AS (
    SELECT 
        st.store_id,
        st.store_name,
        EXTRACT(YEAR FROM s.sale_date) AS year,
        SUM(p.price * s.quantity) AS current_total_sale
    FROM 
        sales s
    JOIN 
        stores st USING(store_id)
    JOIN 
        products p USING(product_id)
    GROUP BY 
        st.store_id, st.store_name, year
),
prev_year AS (
    SELECT 
        *,
        LAG(current_total_sale, 1) OVER (PARTITION BY store_id ORDER BY year) AS prev_total_sale
    FROM 
        cte
)
SELECT 
    *,
    ROUND((current_total_sale - prev_total_sale)::NUMERIC / NULLIF(prev_total_sale, 0)::NUMERIC, 2) AS growth_ratio
FROM 
    prev_year;

-- Segmenting product prices and examining how they correlate with warranty claim volume in the past 5 years.
-- Offers insight into whether more expensive products are more likely to result in warranty issues.
SELECT
    CASE
        WHEN p.price BETWEEN 0 AND 499 THEN 'Less Expensive'
        WHEN p.price BETWEEN 500 AND 999 THEN 'Moderately Expensive'
        WHEN p.price >= 1000 THEN 'Highly Expensive'
        ELSE 'Invalid'
    END AS price_bucket,
    COUNT(w.claim_id) AS num_claims
FROM 
    warranty w
LEFT JOIN 
    sales s USING(sale_id)
JOIN 
    products p USING(product_id)
WHERE 
    s.sale_date >= CURRENT_DATE - INTERVAL '5 year'
GROUP BY 
    price_bucket;

-- Identifying the store with the highest share of "Paid Repaired" warranty claims.
-- Highlights service efficiency or customer willingness to invest in repair, which may indicate brand trust or product longevity.
WITH paid_repaired AS (
    SELECT 
        s.store_id,
        COUNT(w.claim_id) AS total_claims_repaired
    FROM 
        sales s
    RIGHT JOIN 
        warranty w USING(sale_id)
    WHERE 
        w.repair_status = 'Paid Repaired'
    GROUP BY 
        s.store_id
),
total AS (
    SELECT 
        s.store_id,
        COUNT(w.claim_id) AS total_claims
    FROM 
        sales s
    RIGHT JOIN 
        warranty w USING(sale_id)
    GROUP BY 
        s.store_id
)
SELECT 
    t.store_id,
    st.store_name,
    t.total_claims,
    COALESCE(pr.total_claims_repaired, 0) AS total_claims_repaired,
    ROUND(COALESCE(pr.total_claims_repaired, 0)::NUMERIC / NULLIF(t.total_claims, 0)::NUMERIC * 100, 2) AS percentage_paid_repair
FROM 
    total t
LEFT JOIN 
    paid_repaired pr USING(store_id)
JOIN 
    stores st USING(store_id);

-- Calculating monthly running total revenue for each store over the past 5 years.
-- Supports revenue trend analysis and helps compare seasonal/store-level performance over time.
WITH cte AS (
    SELECT 
        s.store_id,
        EXTRACT(YEAR FROM s.sale_date) AS year,
        TO_CHAR(s.sale_date, 'MM') AS month,
        SUM(s.quantity * p.price) AS total_revenue
    FROM 
        sales s
    JOIN 
        products p USING(product_id)
    WHERE 
        s.sale_date >= CURRENT_DATE - INTERVAL '5 year'
    GROUP BY 
        s.store_id, year, month
)
SELECT 
    *,
    SUM(total_revenue) OVER (PARTITION BY store_id ORDER BY year, month) AS running_total
FROM 
    cte;

-- Analyzing product sales over key time intervals since launch.
-- Helps evaluate product lifecycle performance: early adoption vs. long-term traction.

SELECT 
    CASE 
        WHEN s.sale_date BETWEEN p.launch_date AND p.launch_date + INTERVAL '6 month' THEN 'Within 6 Months'
        WHEN s.sale_date BETWEEN p.launch_date + INTERVAL '6 month' AND p.launch_date + INTERVAL '12 month' THEN '6-12 Months'
        WHEN s.sale_date BETWEEN p.launch_date + INTERVAL '12 month' AND p.launch_date + INTERVAL '18 month' THEN '12-18 Months'
        ELSE 'Beyond 18 Months'
    END AS month_segment,
    SUM(s.quantity) AS total_units_sold
FROM 
    sales s
JOIN 
    products p USING(product_id)
GROUP BY 
    month_segment
ORDER BY 
    month_segment;

