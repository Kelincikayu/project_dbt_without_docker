select
o."orderID",
o."orderDate",
p."productName",
c."categoryName",
sum(od."quantity") as total_quantity_order
from
order_details od
join
orders o on od."orderID" = o."orderID"
join 
products p  on p."productID"  = od."productID"
join 
categories c on p."categoryID" = c."categoryID"
group by 
o."orderDate",
o."orderID",
p."productName",
c."categoryName"