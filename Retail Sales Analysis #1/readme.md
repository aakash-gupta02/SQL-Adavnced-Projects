# Retail Sales Analysis #1

## Project Overview

**Project Title**: Retail Sales Analysis #1
**Level**: Beginner to Intermediate
**Database**: `retail_sales`

This project demonstrates fundamental and advanced SQL techniques for performing exploratory data analysis (EDA) and business intelligence tasks on a retail dataset. It's ideal for those beginning their data analytics journey using SQL.

---

## Dataset Description

The dataset includes retail transaction data with the following columns:

* `transactions_id` (INT)
* `sale_date` (DATE)
* `sale_time` (TIME)
* `customer_id` (INT)
* `gender` (VARCHAR)
* `age` (INT)
* `category` (VARCHAR)
* `quantity` (INT)
* `price_per_unit` (FLOAT)
* `cogs` (FLOAT)
* `total_sale` (FLOAT)

---

## SQL Tasks & Queries

### Q1. Retrieve all columns for sales made on '2022-11-05'

```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

### Q2. Retrieve all transactions where the category is 'Clothing' and quantity sold is more than 4 in November 2022

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 4
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;
```

### Q3. Calculate the total sales (total\_sale) for each category

```sql
SELECT category, SUM(total_sale) AS Total_sales
FROM retail_sales
GROUP BY category
ORDER BY Total_sales DESC;
```

### Q4. Find the average age of customers who purchased items from the 'Beauty' category

```sql
SELECT ROUND(AVG(age))
FROM retail_sales
WHERE category = 'Beauty';
```

### Q5. Find all transactions where the total\_sale is greater than 1000

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000
ORDER BY total_sale DESC;
```

### Q6. Find the total number of transactions made by each gender in each category

```sql
SELECT gender, category, SUM(total_sale)
FROM retail_sales
GROUP BY gender, category
ORDER BY category;
```

### Q7. Calculate the average sale for each month and find the best-selling month in each year

```sql
-- Monthly average sale
SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, ROUND(AVG(total_sale)) AS avg_monthly_sale
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

-- Best-selling month per year
SELECT year, month, avg_monthly_sale
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_monthly_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_sales
WHERE rnk = 1;
```

### Q8. Find the top 5 customers based on the highest total sales

```sql
SELECT customer_id, COUNT(total_sale), SUM(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY COUNT(total_sale) DESC
LIMIT 5;
```

### Q9. Find the number of unique customers who purchased items from each category

```sql
SELECT category, COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY category;
```

### Q10. Create each shift (Morning, Afternoon, Evening) and find number of orders in each

```sql
SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(total_sale)
FROM retail_sales
GROUP BY Shift;
```

---

## Key Insights

* Beauty category customers are mostly middle-aged (based on avg age).
* Clothing has high demand in November.
* Evening shifts have higher transaction volume.
* The top 5 customers are responsible for significant revenue.

---

## Author

**Aakash Gupta**
This project is part of the SQL Advanced Project Series.

For more:

* [GitHub](https://github.com/aakash-gupta02)
* [LinkedIn](https://linkedin.com/in/najirr)

---

## Next Steps

* Add visualization using Python (optional)
* Create dashboards using Power BI / Tableau (optional)
* More sub-projects under `SQL-Adavnced-Projects` repo

Stay tuned!
