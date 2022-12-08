## Project Data Analysis for B2B Retail: Customer Analytics Report

### Latar Belakang

xyz.com adalah perusahan rintisan B2B yang menjual berbagai produk tidak langsung kepada end user tetapi ke bisnis/perusahaan lainnya. Sebagai data-driven company, maka setiap pengambilan keputusan di xyz.com selalu berdasarkan data. Setiap quarter xyz.com akan mengadakan townhall dimana seluruh atau perwakilan divisi akan berkumpul untuk me-review performance perusahaan selama quarter terakhir.


Untuk menyediakan data dan analisa mengenai kondisi perusahaan bulan terakhir untuk dipresentasikan di townhall tersebut. (Asumsikan tahun yang sedang berjalan adalah tahun 2004).

Adapun hal yang akan direview adalah :

Bagaimana pertumbuhan penjualan saat ini?
Apakah jumlah customers xyz.com semakin bertambah ?
Dan seberapa banyak customers tersebut yang sudah melakukan transaksi?
Category produk apa saja yang paling banyak dibeli oleh customers?
Seberapa banyak customers yang tetap aktif bertransaksi?

---

<details>
  <summary>Modul</summary>

- [[📂](https://github.com/azwarerizal/own-project/tree/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/Data)]
[[🔍](https://academy.dqlab.id/main/projectcode/246/417/2099?pr=0)] [[📃](https://academy.dqlab.id/certificate/pdf/DQLABPRJ10FEKPHS/NONTRACK)] 
Project Data Analysis for B2B Retail: Customer Analytics Report

</details>

---

### Tabel yang digunakan

![gambar-tabel.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/gambar-tabel.JPG?raw=true)

![gambar-tabel2.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/gambar-tabel2.JPG?raw=true)

---

### Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)

![capture-1.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/Capture-1.JPG?raw=true)

### Documentation

```mysql
select sum(quantity) as total_penjualan, sum(quantity*priceeach) as revenue
from orders_1
where status = 'shipped';

select sum(quantity) as total_penjualan, sum(quantity*priceeach) as revenue
from orders_2
where status = 'shipped';
```

### Menghitung persentasi keseluruhan penjualan

![capture-2.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/Capture-2.JPG?raw=true)

### Documentation

```mysql
SELECT quarter, sum(quantity) as total_penjualan,sum(quantity*priceeach)as revenue 
FROM 
  (select orderNumber, status, quantity, priceeach, '1' as quarter from orders_1
UNION
  select orderNumber, status, quantity, priceeach, '2' as quarter from orders_2) as tabel_a
WHERE status = 'shipped'
GROUP BY quarter;
```
---

### Perhitungan Growth Penjualan dan Revenue

Selanjutnya untuk project ini, perhitungan pertumbuhan penjualan akan dilakukan secara manual menggunakan formula yang disediakan di bawah. Adapun perhitungan pertumbuhan penjualan dengan SQL dapat dilakukan menggunakan “window function” yang akan dibahas di materi berikutnya.

%Growth Penjualan = (6717 – 8694)/8694 = -22%

%Growth Revenue = (607548320 – 799579310)/ 799579310 = -24%

---

### Apakah jumlah customers xyz.com semakin bertambah ?

![capture-3.JPG]()

### Documentation

```mysql
SELECT quarter, count(customerID) as total_customers
FROM
  (select customerID, createDate, QUARTER(createDate) as quarter from customer
    where createdate between '2004-01-01' and '2004-06-30') as tabel_b
GROUP BY quarter;
```

### Seberapa banyak customers tersebut yang sudah melakukan transaksi ?

![capture-4.JPG]()

### Documentation

```mysql
SELECT quarter, count(customerID) as total_customers 
FROM
   (select customerID, createDate, QUARTER(createDate) as quarter from customer
     where createdate between '2004-01-01' and '2004-06-30') as tabel_b
      where customerID in (SELECT DISTINCT(customerID) as total_customers
  FROM orders_1
UNION
   SELECT DISTINCT(customerID) as total_customers
   FROM orders_2)
GROUP BY quarter;
```

### Category produk apa saja yang paling banyak di-order oleh customers di Quarter-2 ?

![capture-5.JPG]()

```mysql
SELECT *
FROM (SELECT categoryID, COUNT(DISTINCT orderNumber) as total_order,
      SUM(quantity) as total_penjualan
      FROM (SELECT productCode, orderNumber, quantity, status,
            LEFT(productCode, 3) as categoryID
            FROM orders_2
            WHERE status = "Shipped"
           ) tabel_c
      GROUP BY categoryID) sub
ORDER BY total_order DESC;
```

### Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya ?

![capture-6.JPG]()

```mysql
#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;

#output = 25
SELECT "1" as quarter, (COUNT(DISTINCT customerID)*100)/25 as q2 
FROM 
   orders_1 where customerid in (SELECT DISTINCT customerID FROM orders_2);
```

###
