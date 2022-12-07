
## Project Data Analysis for Retail Sales Performance Report

- Overall performance DQLab Store dari tahun 2009 - 2012 untuk jumlah order dan total sales order finished

- Overall performance DQLab by subcategory product yang akan dibandingkan antara tahun 2011 dan tahun 2012

 

- Efektifitas dan efisiensi promosi yang dilakukan selama ini, dengan menghitung burn rate dari promosi yang dilakukan overall berdasarkan tahun

- Efektifitas dan efisiensi promosi yang dilakukan selama ini, dengan menghitung burn rate dari promosi yang dilakukan overall berdasarkan sub-category


- Analisa terhadap customer setiap tahunnya

- Analisa terhadap jumlah customer baru setiap tahunnya

- Cohort untuk mengetahui angka retention customer tahun 2009

---

### 1.Overall Performance by Year

![Capture.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20Retail%20Sales%20Performance%20Report/img/Capture.JPG?raw=true)



### Documentation


```sql
SELECT YEAR(order_date) as years, sum(sales) as sales, count( order_quantity) as number_of_order
FROM dqlab_sales_store
WHERE order_status = 'Order finished'
GROUP BY years
ORDER BY years 
```

### 2. Overall Performance by Product Sub Category

![Capture-2.JPG](https://user-images.githubusercontent.com/118737997/206141027-a992d989-9b01-4d03-b5ac-56e4b1900e88.png)

### Documentation


```sql
select YEAR(order_date) as years, product_sub_category, sum(sales) as sales
from dqlab_sales_store
where order_status = 'order finished' and year(order_date) > 2010
group by years, product_sub_category
order by years, sales desc
```

### 3. Promotion Effectiveness and Efficiency by Years

![Capture-3.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20Retail%20Sales%20Performance%20Report/img/Capture-3.JPG?raw=true)

### Documentation


```sql
select YEAR(order_date) as years,sum(sales) as sales, sum(discount_value) as promotion_value,
round((sum(discount_value)/sum(sales))*100,2) as burn_rate_percentage
from dqlab_sales_store
where order_status ='order finished'
group by years
order by years
```

### 4.Promotion Effectiveness and Efficiency by Product Sub Category
![Capture-4.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20Retail%20Sales%20Performance%20Report/img/Capture-4.JPG?raw=true)

### Documentation


```sql
select YEAR(order_date) as years, product_sub_category, product_category, sum(sales) as sales, sum(discount_value) as promotion_value,
round((sum(discount_value)/sum(sales))*100,2) as burn_rate_percentage
from dqlab_sales_store
where order_status ='order finished' and year(order_date) > 2011
group by years, product_sub_category, product_category
order by sales desc
```

### 5.Customers Transactions per Year
![Capture-5.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20Retail%20Sales%20Performance%20Report/img/Capture-5.JPG?raw=true)


### Documentation


```sql
select year(order_date) as years, count(distinct customer) as number_of_customer
from dqlab_sales_store
where order_status = 'order finished'
group by years
```

<details
[[📃](https://academy.dqlab.id/certificate/pdf/DQLABPRJC4AFNDGQ)]
