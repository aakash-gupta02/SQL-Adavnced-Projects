# Q1. Retrieve all columns for sales made on '2022-11-05'


SELECT * from retail_sales where sale_date = '2022-11-05';



# Q2. Retrieve all transactions where the category is 'Clothing' and quantity sold is more than 4 in November 2022

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND total_sale > 3
        AND MONTH(sale_date) = 11
        AND YEAR(sale_date) = 2022;


# Q3. Calculate the total sales (total_sale) for each category


SELECT 
    category, SUM(total_sale) AS Total_sales
FROM
    retail_sales
GROUP BY category
ORDER BY Total_Sales DESC;


# Q4. Find the average age of customers who purchased items from the 'Beauty' category


SELECT 
    ROUND(AVG(age))
FROM
    retail_sales
WHERE
    category = 'Beauty';



# Q5. Find all transactions where the total_sale is greater than 1000



SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000
    ORDER BY total_sale DESC
    ;



# Q6. Find the total number of transactions made by each gender in each category

SELECT 
    gender, category, SUM(total_sale)
FROM
    retail_sales
GROUP BY gender , category
ORDER BY category  ;


# Q7. Calculate the average sale for each month and find the best-selling month in each year


SELECT 
    YEAR(sale_date), MONTH(sale_date), round(avg(total_sale))
FROM
    retail_sales
GROUP BY YEAR(sale_date) , MONTH(sale_date)
ORDER BY year(sale_date)
;

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    ROUND(AVG(total_sale), 2) AS avg_monthly_sale
FROM
    retail_sales
GROUP BY 
    YEAR(sale_date), MONTH(sale_date)
ORDER BY 
    YEAR(sale_date), MONTH(sale_date);


SELECT 
    year,
    month,
    avg_monthly_sale
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



# Q8. Find the top 5 customers based on the highest total sales


SELECT 
    customer_id, COUNT(total_sale), SUM(total_sale)
FROM
    retail_sales
GROUP BY customer_id
ORDER BY count(total_sale) DESC 
LIMIT 5
;


# Q9. Find the number of unique customers who purchased items from each category

SELECT  category, COUNT( DISTINCT customer_id) FROM retail_sales GROUP BY category ;


# Q10. Create each shift (Morning, Afternoon, Evening) and find number of orders in each


SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(total_sale)
    FROM retail_sales 
    GROUP BY Shift;
    





