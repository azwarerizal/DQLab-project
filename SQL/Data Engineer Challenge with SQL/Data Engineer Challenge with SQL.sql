## Produk DQLab Mart

select * from ms_produk
where harga BETWEEN 50000 and 150000;

##Thumb drive di DQLab Mart

select * from ms_produk
where nama_produk LIKE '%flashdisk%';

##Pelanggan Bergelar

select * from ms_pelanggan
where nama_pelanggan LIKE '%S.H%' OR nama_pelanggan LIKE '%Ir.%' OR nama_pelanggan LIKE '%Drs%';

##Mengurutkan Nama Pelanggan
select nama_pelanggan from ms_pelanggan
order by nama_pelanggan asc;

##Mengurutkan Nama Pelanggan Tanpa Gelar

select nama_pelanggan from ms_pelanggan
order by SUBSTRING_INDEX(nama_pelanggan, '. ',-1);

##Nama Pelanggan yang Paling Panjang

select nama_pelanggan from ms_pelanggan
where LENGTH(nama_pelanggan) in
(select MAX(length(nama_pelanggan)) from ms_pelanggan);

##Nama Pelanggan yang Paling Panjang dengan Gelar

select nama_pelanggan from ms_pelanggan
where LENGTH (nama_pelanggan) IN (select MAX(length(nama_pelanggan))from ms_pelanggan)
OR
LENGTH (nama_pelanggan) IN (select MIN(LENGTH(nama_pelanggan)) from ms_pelanggan)
order by LENGTH (nama_pelanggan) DESC;

##Kuantitas Produk yang Banyak Terjual

select mp.kode_produk, mp.nama_produk, sum(tr.qty) AS total_qty
from ms_produk AS mp
inner join tr_penjualan_detail AS tr ON mp.kode_produk = tr.kode_produk
group by mp.kode_produk, mp.nama_produk
having total_qty > 2

##Pelanggan Paling Tinggi Nilai Belanjanya

select tr.kode_pelanggan, mp.nama_pelanggan, SUM(trd.qty*trd.harga_satuan) AS total_harga
from ms_pelanggan as mp
inner join tr_penjualan as tr USING (kode_pelanggan)
inner join tr_penjualan_detail as trd USING (kode_transaksi)
group by tr.kode_pelanggan, mp.nama_pelanggan
order by total_harga desc
limit 1;

##Pelanggan yang Belum Pernah Berbelanja

select a.kode_pelanggan, a.nama_pelanggan, a.alamat from ms_pelanggan as a
where a.kode_pelanggan not in (select b.kode_pelanggan from tr_penjualan as b)

##Transaksi Belanja dengan Daftar Belanja lebih dari 1

SELECT tr.kode_transaksi, tr.kode_pelanggan, ms.nama_pelanggan, tr.tanggal_transaksi, COUNT(trdet.qty) AS jumlah_detail FROM tr_penjualan tr
INNER JOIN ms_pelanggan ms ON tr.kode_pelanggan = ms.kode_pelanggan
INNER JOIN tr_penjualan_detail trdet ON tr.kode_transaksi = trdet.kode_transaksi
GROUP BY tr.kode_transaksi, tr.kode_pelanggan, ms.nama_pelanggan, tr.tanggal_transaksi
HAVING jumlah_detail >1;