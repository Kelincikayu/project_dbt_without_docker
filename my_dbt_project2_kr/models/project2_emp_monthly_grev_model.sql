select
e."employeeID" ,
concat(e."firstName", ' ', e."lastName") as employee_name,
TO_CHAR(TO_DATE(o."orderDate", 'YYYY-MM-DD'), 'YYYY-Mon') AS "SalesYear_Month",
round(sum((od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity")::numeric ,2) AS employee_monthly_revenue
from
employees e
join 
orders o on e."employeeID"  = o."employeeID"
join 
order_details od on o."orderID" = od."orderID"
group by 
employee_name,
e."employeeID",
"SalesYear_Month"