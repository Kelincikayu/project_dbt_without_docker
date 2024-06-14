select
TO_CHAR(TO_DATE(o."orderDate", 'YYYY-MM-DD'), 'YYYY-Mon') AS "SalesYear_Month",
c."categoryName",
sum(od."quantity") AS monthly_quantity
from
order_details od
join
orders o on od."orderID" = o."orderID"
join 
products p  on p."productID"  = od."productID"
join 
categories c on p."categoryID" = c."categoryID"
group by 
"SalesYear_Month",
c."categoryName"
