## Project Data Engineer Challenge with SQL

Dalam project ini berupa menguji kemampuan dasar SQL menggunakan bahasa pemrograman MySQL diantaranya, seperti:

- Left Join
- Right Join
- Inner Join
- Substring
- Filtering
- Grouping
---

<details><summary>Modul</summary>

- [[📂](https://github.com/azwarerizal/own-project/tree/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/Data)]
[[🔍](https://academy.dqlab.id/main/projectcode/99/195/956?pr=0)] [[📃](https://academy.dqlab.id/certificate/pdf/DQLABSQLTSWUWCOK)] Project Data Engineer Challenge with SQL

</details>

---

### 1. Produk DQLab Mart

![Capture.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture.JPG?raw=true)

### Documentation


```sql
select * from ms_produk
where harga BETWEEN 50000 and 150000;
```

### 2. Thumb drive di DQLab Mart

![Capture-2.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-2.JPG?raw=true)

### Documentation


```sql
select * from ms_produk
where nama_produk LIKE '%flashdisk%';
```

### 3. Pelanggan Bergelar

![Capture-3.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-3.JPG?raw=true)

### Documentation

```sql
select * from ms_pelanggan
where nama_pelanggan LIKE '%S.H%' OR nama_pelanggan LIKE '%Ir.%' OR nama_pelanggan LIKE '%Drs%';
```

### 4. Mengurutkan Nama Pelanggan

![Capture-4.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-4.JPG?raw=true)

### Documentation

```sql
select nama_pelanggan from ms_pelanggan
order by nama_pelanggan asc;
```

### 5. Mengurutkan Nama Pelanggan Tanpa Gelar

![Capture-5.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-5.JPG?raw=true)

### Documentation

```sql
select nama_pelanggan from ms_pelanggan
order by SUBSTRING_INDEX(nama_pelanggan, '. ',-1);
```

### 6. Nama Pelanggan yang Paling Panjang

![Capture-6.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-6.JPG?raw=true)

### Documentation

```sql
select nama_pelanggan from ms_pelanggan
where LENGTH(nama_pelanggan) in
(select MAX(length(nama_pelanggan)) from ms_pelanggan);
```

### 7. Nama Pelanggan yang Paling Panjang dengan Gelar

![Capture-7.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-7.JPG?raw=true)

### Documentation

```sql
select nama_pelanggan from ms_pelanggan
where LENGTH (nama_pelanggan) IN (select MAX(length(nama_pelanggan))from ms_pelanggan)
OR
LENGTH (nama_pelanggan) IN (select MIN(LENGTH(nama_pelanggan)) from ms_pelanggan)
order by LENGTH (nama_pelanggan) DESC;
```

### 8. Kuantitas Produk yang Banyak Terjual

![Capture-8.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-8.JPG?raw=true)

### Documentation

```sql
select mp.kode_produk, mp.nama_produk, sum(tr.qty) AS total_qty
from ms_produk AS mp
inner join tr_penjualan_detail AS tr ON mp.kode_produk = tr.kode_produk
group by mp.kode_produk, mp.nama_produk
having total_qty > 2
```

### 9. Pelanggan Paling Tinggi Nilai Belanjanya

![Capture-9.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-9.JPG?raw=true)

### Documentation

```sql
select tr.kode_pelanggan, mp.nama_pelanggan, SUM(trd.qty*trd.harga_satuan) AS total_harga
from ms_pelanggan as mp
inner join tr_penjualan as tr USING (kode_pelanggan)
inner join tr_penjualan_detail as trd USING (kode_transaksi)
group by tr.kode_pelanggan, mp.nama_pelanggan
order by total_harga desc
limit 1;
```

### 10. Pelanggan yang Belum Pernah Berbelanja

![Capture-10.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-10.JPG?raw=true)

### Documentation

```sql
select a.kode_pelanggan, a.nama_pelanggan, a.alamat from ms_pelanggan as a
where a.kode_pelanggan not in (select b.kode_pelanggan from tr_penjualan as b)
```

### 11. Transaksi Belanja dengan Daftar Belanja lebih dari 1

![Capture-11.JPG](https://github.com/azwarerizal/own-project/blob/master/SQL/Data%20Engineer%20Challenge%20with%20SQL/img/Capture-11.JPG?raw=true)

### Documentation

```sql
SELECT tr.kode_transaksi, tr.kode_pelanggan, ms.nama_pelanggan, tr.tanggal_transaksi, COUNT(trdet.qty) AS jumlah_detail 
FROM tr_penjualan tr
INNER JOIN ms_pelanggan ms ON tr.kode_pelanggan = ms.kode_pelanggan
INNER JOIN tr_penjualan_detail trdet ON tr.kode_transaksi = trdet.kode_transaksi
GROUP BY tr.kode_transaksi, tr.kode_pelanggan, ms.nama_pelanggan, tr.tanggal_transaksi
HAVING jumlah_detail >1;
```
