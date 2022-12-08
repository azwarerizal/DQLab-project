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

### 1. Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)

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

### 2. Menghitung persentasi keseluruhan penjualan

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

