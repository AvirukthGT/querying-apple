# Apple Retail Sales SQL Analysis - Analyzing Millions of Sales Rows
# ![Apple Logo](https://github.com/najirh/Apple-Retail-Sales-SQL-Project---Analyzing-Millions-of-Sales-Rows/blob/main/Apple_Changsha_RetailTeamMembers_09012021_big.jpg.slideshow-xlarge_2x.jpg) 


## Project Overview

This project is designed to showcase advanced SQL querying techniques through the analysis of over 1 million rows of Apple retail sales data. The dataset includes information about products, stores, sales transactions, and warranty claims across various Apple retail locations globally. By tackling a variety of questions, from basic to complex, you'll demonstrate your ability to write sophisticated SQL queries that extract valuable insights from large datasets.


## Entity Relationship Diagram (ERD)

![ERD](https://github.com/najirh/Apple-Retail-Sales-SQL-Project---Analyzing-Millions-of-Sales-Rows/blob/main/erd.png)



---

## Database Schema

The project uses five main tables:

1. **stores**: Contains information about Apple retail stores.
   - `store_id`: Unique identifier for each store.
   - `store_name`: Name of the store.
   - `city`: City where the store is located.
   - `country`: Country of the store.

2. **category**: Holds product category information.
   - `category_id`: Unique identifier for each product category.
   - `category_name`: Name of the category.

3. **products**: Details about Apple products.
   - `product_id`: Unique identifier for each product.
   - `product_name`: Name of the product.
   - `category_id`: References the category table.
   - `launch_date`: Date when the product was launched.
   - `price`: Price of the product.

4. **sales**: Stores sales transactions.
   - `sale_id`: Unique identifier for each sale.
   - `sale_date`: Date of the sale.
   - `store_id`: References the store table.
   - `product_id`: References the product table.
   - `quantity`: Number of units sold.

5. **warranty**: Contains information about warranty claims.
   - `claim_id`: Unique identifier for each warranty claim.
   - `claim_date`: Date the claim was made.
   - `sale_id`: References the sales table.
   - `repair_status`: Status of the warranty claim (e.g., Paid Repaired, Warranty Void).

## Objectives

The project is split into different categories of insights:


## 🏬 Store Performance & Operations
Objective: Understand how Apple Stores perform individually and across regions.

1. Store Distribution by Country
Reveals geographic market presence and helps guide expansion or resource reallocation.

2. Total Units Sold per Store
Highlights top-performing stores and supports benchmarking performance.

3. Best-Selling Day per Store
Identifies high-traffic days for optimizing staffing, inventory, and promotions.

4. Year-over-Year Store Growth
Tracks performance momentum to distinguish growing stores from stagnating ones.

5. Store with Highest "Paid Repaired" Claim Percentage
Sheds light on customer trust, service uptake, and possible pricing or support effectiveness.

## 📦 Product Lifecycle & Demand Patterns
Objective: Evaluate how products perform over time, across price points, and by region.

1. Product Sales Segmented by Launch Period
Analyzes demand trends from launch to maturity, guiding lifecycle and marketing strategies.

2. Top Store by Units Sold in the Last Year
Measures product traction through sales concentration at top locations.

3. Number of Unique Products Sold in the Last Year
Reflects product catalog diversity and customer engagement.

4. Least-Selling Product by Country & Year
Detects underperforming SKUs, enabling targeted portfolio optimization.

5. Monthly Sales > 5,000 Units in the USA (Last 3 Years)
Uncovers high-demand periods for focused marketing or seasonal planning.

## 💰 Revenue, Pricing, & Category Insights
Objective: Assess product pricing strategies and category-level financial impact.

1. Average Price per Category
Informs pricing strategy and market positioning across product lines.

2. Monthly Running Total of Store Sales (Last 4 Years)
Identifies revenue trends and enables historical comparisons and forecasting.

3. Correlation Between Price Ranges & Warranty Claims
Reveals how product cost influences claim behavior, guiding design and support policies.

## 🛠 Warranty & Support Analysis
Objective: Gauge product reliability and post-sale service effectiveness.

1. Percentage of "Warranty Void" Claims
Highlights customer misuse, policy issues, or communication gaps.

2. Stores with No Warranty Claims
Spotlights locations with high product reliability or reporting inconsistencies.

3. Warranty Claims within 180 Days of Purchase
Flags potential early-life product failures or manufacturing issues.

4. Warranty Claims for Products Launched in the Last 2 Years
Measures reliability of recent launches, helping evaluate product readiness.

5. Category with Most Warranty Claims (Last 2 Years)
Identifies problematic product lines for engineering, quality, or support intervention.

6. Percentage of Purchases Leading to Claims (Per Country)
Compares claim rates regionally to uncover support needs or product design improvements.

## 📅 Time-Based Sales Trends
Objective: Analyze temporal patterns in sales and customer behavior.

1. Sales in December 2023
Evaluates holiday season demand and supports year-end planning.

2. Warranty Claims Filed in 2020
Provides historical context to service volumes during specific periods.

3. Monthly Revenue Trends (Running Total)
Helps track growth patterns, revenue momentum, and performance consistency.

## Project Focus

This project primarily focuses on developing and showcasing the following SQL skills:

- **Complex Joins and Aggregations**: Demonstrating the ability to perform complex SQL joins and aggregate data meaningfully.
- **Window Functions**: Using advanced window functions for running totals, growth analysis, and time-based queries.
- **Data Segmentation**: Analyzing data across different time frames to gain insights into product performance.
- **Correlation Analysis**: Applying SQL functions to determine relationships between variables, such as product price and warranty claims.
- **Real-World Problem Solving**: Answering business-related questions that reflect real-world scenarios faced by data analysts.


## Dataset

- **Size**: 1 million+ rows of sales data.
- **Period Covered**: The data spans multiple years, allowing for long-term trend analysis.
- **Geographical Coverage**: Sales data from Apple stores across various countries.

## Conclusion

By completing this project, you will develop advanced SQL querying skills, improve your ability to handle large datasets, and gain practical experience in solving complex data analysis problems that are crucial for business decision-making. This project is an excellent addition to your portfolio and will demonstrate your expertise in SQL to potential employers.

---
