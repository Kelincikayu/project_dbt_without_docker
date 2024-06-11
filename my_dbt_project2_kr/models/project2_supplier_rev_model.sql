SELECT
o."orderID",
TO_CHAR(TO_DATE(o."orderDate", 'YYYY-MM-DD'), 'Mon-YYYY') AS "SalesMonthYear",
p."productName",
s."companyName",
SUM(od."quantity") as total_quantity_order_supplier,
ROUND(SUM((od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity")::numeric ,2) AS monthly_revenue_supplier
FROM
order_details od
JOIN
orders o ON od."orderID" = o."orderID"
JOIN 
products p  ON p."productID"  = od."productID"
JOIN 
suppliers s  ON p."supplierID" = s."supplierID"
GROUP BY 
"SalesMonthYear",
o."orderID",
p."productName",
s."companyName" 