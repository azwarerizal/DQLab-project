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

![capture-3.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/Capture-3.JPG?raw=true)

### Documentation

```mysql
SELECT quarter, count(customerID) as total_customers
FROM
  (select customerID, createDate, QUARTER(createDate) as quarter from customer
    where createdate between '2004-01-01' and '2004-06-30') as tabel_b
GROUP BY quarter;
```

### Seberapa banyak customers tersebut yang sudah melakukan transaksi ?

![capture-4.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/Capture-4.JPG?raw=true)

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

![capture-5.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/Capture-5.JPG?raw=true)

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
Mengetahui seberapa banyak customers yang tetap aktif menunjukkan apakah xyz.com tetap digemari oleh customers untuk memesan kebutuhan bisnis mereka. Hal ini juga dapat menjadi dasar bagi tim product dan business untuk pengembangan product dan business kedepannya. Adapun metrik yang digunakan disebut retention cohort. Untuk project ini, kita akan menghitung retention dengan query SQL sederhana, sedangkan cara lain yaitu JOIN dan SELF JOIN akan dibahas dimateri selanjutnya :

Oleh karena baru terdapat 2 periode yang Quarter 1 dan Quarter 2, maka retention yang dapat dihitung adalah retention dari customers yang berbelanja di Quarter 1 dan kembali berbelanja di Quarter 2, sedangkan untuk customers yang berbelanja di Quarter 2 baru bisa dihitung retentionnya di Quarter 3.

- Dari tabel orders_1, tambahkan kolom baru dengan value “1” dan beri nama “quarter”
- Dari tabel orders_2, pilihlah kolom customerID, gunakan distinct untuk menghilangkan duplikasi
- Filter tabel orders_1 dengan operator IN() menggunakan 'Select statement langkah 2', sehingga hanya customerID yang pernah bertransaksi di quarter 2 (customerID tercatat di tabel orders_2) yang diperhitungkan.
- Hitunglah jumlah unik customers (tidak ada duplikasi customers) dibagi dengan total_ customers dalam percentage, pada Select statement dan beri nama “Q2”

![capture-6.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Project%20Data%20Analysis%20for%20B2B%20Retail:%20Customer%20Analytics%20Report/img/Capture-6.JPG?raw=true)

```mysql
#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;

#output = 25
SELECT "1" as quarter, (COUNT(DISTINCT customerID)*100)/25 as q2 
FROM 
   orders_1 where customerid in (SELECT DISTINCT customerID FROM orders_2);
```

### Berdasarkan data yang tersedia, bagaimana analisa kamu terhadap performance xyz.com di quarter ke-2 ?

Kesimpulan: 
Berdasarkan data yang telah kita peroleh melalui query SQL, Kita dapat menarik kesimpulan bahwa :

- Performance xyz.com menurun signifikan di quarter ke-2, terlihat dari nilai penjualan dan revenue yang drop hingga 20% dan 24%,
- Perolehan customer baru juga tidak terlalu baik, dan sedikit menurun dibandingkan quarter sebelumnya.
- Ketertarikan customer baru untuk berbelanja di xyz.com masih kurang, hanya sekitar 56% saja yang sudah bertransaksi. Disarankan tim Produk untuk perlu mempelajari behaviour customer dan melakukan product improvement, sehingga conversion rate (register to transaction) dapat meningkat.
- Produk kategori S18 dan S24 berkontribusi sekitar 50% dari total order dan 60% dari total penjualan, sehingga xyz.com sebaiknya fokus untuk pengembangan category S18 dan S24.
- Retention rate customer xyz.com juga sangat rendah yaitu hanya 24%, artinya banyak customer yang sudah bertransaksi di quarter-1 tidak kembali melakukan order di quarter ke-2 (no repeat order).
- xyz.com mengalami pertumbuhan negatif di quarter ke-2 dan perlu melakukan banyak improvement baik itu di sisi produk dan bisnis marketing, jika ingin mencapai target dan positif growth di quarter ke-3. Rendahnya retention rate dan conversion rate bisa menjadi diagnosa awal bahwa customer tidak tertarik/kurang puas/kecewa berbelanja di xyz.com.
