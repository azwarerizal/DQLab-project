##Overall Performance by Year

select YEAR(order_date) as years, sum(sales) as sales, count( order_quantity) as number_of_order
from dqlab_sales_store
where order_status = 'Order finished'
group by years
order by years 

##Overall Performance by Product Sub Category

select YEAR(order_date) as years, product_sub_category, sum(sales) as sales
from dqlab_sales_store
where order_status = 'order finished' and year(order_date) > 2010
group by years, product_sub_category
order by years, sales desc

##Promotion Effectiveness and Efficiency by Years

select YEAR(order_date) as years,sum(sales) as sales, sum(discount_value) as promotion_value,
round((sum(discount_value)/sum(sales))*100,2) as burn_rate_percentage
from dqlab_sales_store
where order_status ='order finished'
group by years
order by years

##Promotion Effectiveness and Efficiency by Product Sub Category

select YEAR(order_date) as years, product_sub_category, product_category, sum(sales) as sales, sum(discount_value) as promotion_value,
round((sum(discount_value)/sum(sales))*100,2) as burn_rate_percentage
from dqlab_sales_store
where order_status ='order finished' and year(order_date) > 2011
group by years, product_sub_category, product_category
order by sales desc

##Customers Transactions per Year

select year(order_date) as years, count(distinct customer) as number_of_customer
from dqlab_sales_store
where order_status = 'order finished'
group by years