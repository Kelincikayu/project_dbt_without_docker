WITH monthly_revenue AS (
select
TO_CHAR(TO_DATE(o."orderDate", 'YYYY-MM-DD'), 'YYYY-Mon') AS "SalesYear_Month",
e."employeeID",
CONCAT(e."firstName", ' ', e."lastName") AS employee_name,
ROUND(SUM((od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity")::numeric ,2) AS monthly_revenue,
ROW_NUMBER() OVER(PARTITION BY EXTRACT(YEAR FROM TO_DATE(o."orderDate", 'YYYY-MM-DD')), EXTRACT(MONTH FROM TO_DATE(o."orderDate", 'YYYY-MM-DD')) ORDER BY ROUND(SUM((od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity")::numeric ,2) DESC) as rank
from
employees e
join 
orders o on e."employeeID"  = o."employeeID"
join 
order_details od on o."orderID" = od."orderID"
group by 
"SalesYear_Month",
employee_name,
e."employeeID" ,
o."orderID",
e."firstName",
e."lastName",
o."orderDate"
)
SELECT * FROM monthly_revenue WHERE rank = 1