select
e."employeeID" ,
concat(e."firstName", ' ', e."lastName") as employee_name,
o."orderID",
round(sum((od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity")::numeric ,2) AS employee_gross_revenue
from
employees e
join 
orders o on e."employeeID"  = o."employeeID"
join 
order_details od on o."orderID" = od."orderID"
group by 
employee_name,
e."employeeID" ,
o."orderID" 