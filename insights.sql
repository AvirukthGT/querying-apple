select * from category;
select * from products;
select * from sales;
select * from stores;
select * from warranty;

--Improving Query Performance

create index sales_product_id on sales(product_id);
create index sales_store_id on sales(store_id);
create index sales_sale_date on sales(sale_date);

-- 1.Find each country and number of stores

select country,count(store_id) from stores
group by 1
order by 2 desc;
-- 2. What is the total number of units sold by each store?
select st.store_name,sum(s.quantity) as total_units_sold from sales s join stores st using(store_id)
group by 1
order by 2 desc;
-- 3. How many sales occurred in December 2023?
-- 4. How many stores have never had a warranty claim filed against any of their products?
-- 5. What percentage of warranty claims are marked as "Warranty Void"?
-- 6. Which store had the highest total units sold in the last year?
-- 7. Count the number of unique products sold in the last year.
-- 8. What is the average price of products in each category?
-- 9. How many warranty claims were filed in 2020?
-- 10. Identify each store and best selling day based on highest qty sold
