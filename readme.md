
# ![Apple Logo](https://github.com/najirh/Apple-Retail-Sales-SQL-Project---Analyzing-Millions-of-Sales-Rows/blob/main/Apple_Changsha_RetailTeamMembers_09012021_big.jpg.slideshow-xlarge_2x.jpg) Apple Retail Sales SQL Project - Analyzing Millions of Sales Rows

**Get the guided project/datasets here**: [Get the Project Datasets](https://topmate.io/zero_analyst/1237072)

## Project Overview

This project is designed to showcase advanced SQL querying techniques through the analysis of over 1 million rows of Apple retail sales data. The dataset includes information about products, stores, sales transactions, and warranty claims across various Apple retail locations globally. By tackling a variety of questions, from basic to complex, you'll demonstrate your ability to write sophisticated SQL queries that extract valuable insights from large datasets.


## Entity Relationship Diagram (ERD)

![ERD](https://github.com/najirh/Apple-Retail-Sales-SQL-Project---Analyzing-Millions-of-Sales-Rows/blob/main/erd.png)



---

### What’s Included:
- **100 SQL Practice Problems**: Extensive coverage of major SQL topics for mastering concepts with real-world data.
- **20 Advanced SQL Queries**: Step-by-step solutions for complex queries, enhancing your skills in performance tuning and optimization.
- **5 Detailed Tables**: Comprehensive datasets with over 1 million rows, including sales, stores, product categories, products, and warranties.
- **Query Performance Tuning**: Learn to optimize queries for real-world data handling.
- **Portfolio-Ready Project**: Showcase your SQL expertise through large-scale data analysis.

### Why Choose This Project?
- **Hands-on Learning**: Practical experience with complex datasets and advanced business problem-solving.
- **Comprehensive Coverage**: Each table provides new opportunities to explore SQL concepts.
- **Exceptional Value**: For just **$9**, access 100 SQL problems, 20 advanced query solutions, and a real-world project.
- **Limited Offer**: Special price available for the **first 100 students**!

**Get the guided project/datasets here**: [Get the Project Datasets](https://topmate.io/zero_analyst/1237072)

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

The project is split into three tiers of questions to test SQL skills of increasing complexity:


A breakdown of store distribution across countries helps us understand geographic presence and market reach.

Total units sold by each store reveals performance rankings and highlights top-selling locations.

Analyzing December 2023 sales quantifies peak-season demand and helps plan for holiday inventory and staffing.

Identifying stores with no warranty claims provides insight into exceptional product handling or underreporting issues.

The proportion of claims marked as “Warranty Void” gives visibility into customer misuse or policy misalignment.

The top-performing store in the last year is spotlighted based on total units sold, guiding recognition and resource allocation.

The count of distinct products sold last year reflects inventory diversity and customer product engagement.

Category-wise average pricing outlines how product value is structured across segments, useful for pricing strategy.

The number of warranty claims from 2020 helps assess post-sale support load during that period.

Discovering each store’s best-selling day identifies high-traffic periods for better operational planning.


Tracking the least-selling product annually by country helps detect inventory laggards and regional mismatches.

Warranty claims filed within 180 days of purchase indicate early-life product issues and quality concerns.

Measuring claims for products launched in the last two years sheds light on how well new offerings are performing post-launch.

Monthly USA sales that crossed the 5,000-unit threshold highlight peak months for demand over the past three years.

Identifying the most claim-prone category provides actionable insight into product design, manufacturing, or support weaknesses.

 
The percentage chance of receiving a claim after purchase per country reflects product reliability and customer expectations regionally.

Year-over-year growth analysis of each store tracks momentum and helps distinguish thriving versus stagnant locations.

Correlating product price with claim volume reveals whether premium or budget products are more frequently serviced.

Identifying the store with the highest percentage of "Paid Repaired" claims shows where repair services are most utilized, possibly reflecting trust or pricing strategy.

Monthly running sales totals for each store over the past four years help uncover long-term sales patterns and seasonal trends.

Segmenting product sales into lifecycle stages (launch to 6 months, 6–12 months, 12–18 months, beyond 18 months) reveals how quickly products gain traction, sustain demand, or phase out—critical for lifecycle and promotion planning.


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
