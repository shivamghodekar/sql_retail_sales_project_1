# sql_retail_sales

This project contains a set of SQL queries to analyze retail sales data. The queries are designed to answer common business questions and gain insights from a hypothetical or real retail sales database.

## 📊 Project Description

In this project, I have solved 10 SQL problems related to retail sales data. The dataset includes information such as transaction details, categories, total_sale, customer_is.

The goal is to demonstrate proficiency in writing SQL queries for data analysis, including filtering, aggregation, grouping, and performing complex calculations.

---

## ✅ SQL Questions and Objectives

Below are the questions covered in this project:

1. **Retrieve all columns for sales made on `2022-11-05`.**

    ```sql
    SELECT * 
    FROM retail_sales
    WHERE sale_date = '2022-11-05';
    ```

2. **Retrieve all transactions where the category is `Clothing` and the quantity sold is more than 10 in November 2022.**

    ```sql
    SELECT *
    FROM retail_sales
    WHERE category = 'Clothing' 
      AND TO_CHAR(sale_date, 'yyyy-mm') = '2022-11'
      AND quantity > 10;
    ```

3. **Calculate the total sales (`total_sale`) for each category.**

    ```sql
    SELECT category, SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY category;
    ```

4. **Find the average age of customers who purchased items from the `Beauty` category.**

    ```sql
    SELECT category, ROUND(AVG(age), 0) AS average_age
    FROM retail_sales
    WHERE category = 'Beauty'
    GROUP BY category;
    ```

5. **Find all transactions where the `total_sale` is greater than 1000.**

    ```sql
    SELECT * 
    FROM retail_sales
    WHERE total_sale > 1000;
    ```

6. **Find the total number of transactions (`transaction_id`) made by each gender in each category.**

    ```sql
    SELECT category, gender, COUNT(transactions_id) AS total_transactions
    FROM retail_sales
    GROUP BY category, gender
    ORDER BY category;
    ```

7. **Calculate the average sale for each month and find the best-selling month in each year.**

    ```sql
    SELECT EXTRACT(YEAR FROM sale_date) AS year, 
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS avg_sales
    FROM retail_sales
    GROUP BY year, month
    ORDER BY avg_sales DESC
    LIMIT 2;
    ```

8. **Find the top 5 customers based on the highest total sales.**

    ```sql
    SELECT customer_id, 
           SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY customer_id
    ORDER BY total_sales DESC
    LIMIT 5;
    ```

9. **Find the number of unique customers who purchased items from each category.**

    ```sql
    SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
    FROM retail_sales
    GROUP BY category;
    ```

10. **Create a report showing each shift (Morning, Afternoon, Evening) and the number of orders in each shift:**
    - Morning: Time <= 12
    - Afternoon: 12 < Time <= 17
    - Evening: Time > 17

    ```sql
    WITH Hourly_sales AS (
        SELECT *,
            CASE
                WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'morning'
                WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
                ELSE 'evening'
            END AS shift
        FROM retail_sales
    )
    SELECT shift, COUNT(*) AS total_orders
    FROM Hourly_sales
    GROUP BY shift;
    ```

---

## 🛠️ Technologies Used

- SQL ( MySQL / PostgreSQL )
- Any SQL IDE (e.g., MySQL, pgAdmin)

---
