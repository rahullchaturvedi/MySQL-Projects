SELECT * FROM retail_db.products;

-- Total_revenue
select unit_price * units_sold as total_sales from 
products join sales on products.Product_id = sales.Product_id;

-- TOTAL UNIT PRICE
select sum(Unit_price) from 
products;

-- Total Unit sold 
select sum(Units_sold) from sales;

-- Top 5 selling product
select products.Product , sales.units_sold 
	as top_products
		from products join sales 
on products.Product_ID = sales.Product_id order by  top_products desc limit 5;

-- Top 5 Sales Region Wise
select products.Unit_price, sales.Region as Region_Sales
from products join sales on Products.Product_ID = sales.Product_id order by products.Unit_price desc limit 5;

-- best selling Category
Select products.Category, sum(sales.Units_sold) AS total_sold
from products join sales group by category order by Total_sold desc Limit 2;

-- % revenue contribution by each product
select products.Product,
round(sum(products.Unit_price  * sales.Units_sold) * 100.0 / 
(select sum(products.Unit_price * sales.Units_sold)
from products join sales on products.Product_ID = sales.Product_ID),2)
as revenue_pct
from products join sales on products.Product_ID = sales.Product_id 
group by products.Product;

-- Which Product has the highest unit price in each category
select * from (
select products.Category,products.Product, products.unit_price,
RANK() over (PARTITION BY products.Category ORDER BY Unit_price asc) AS rnk
FROM products
) as ranked 
where rnk = 1 limit 1;


