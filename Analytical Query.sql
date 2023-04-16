-- 1. Ranking popularitas model mobil berdasarkan jumlah bid

CREATE MATERIALIZED VIEW jumlah_mobil 
as
select model,
	   count(model) as jumlah_model
from mobil
group by 1;

with bid_iklan as(
	select iklan.mobil_iklan_id,
		   bid.iklan_bid_id
	from iklan
	join bid
	on iklan.iklan_id = bid.iklan_bid_id
)
select mobil.model,
	   jumlah_mobil.jumlah_model,
	   count(iklan_bid_id) as jumlah_bid
from mobil
join jumlah_mobil
on mobil.model = jumlah_mobil.model
join bid_iklan
on mobil.mobil_id = bid_iklan.mobil_iklan_id
group by 1,2
order by 3 desc;

-- 2. Membandingkan harga mobil berdasarkan harga rata-rata per kota

with kota_penjual as(
	select penjual.penjual_id,
		   kota.nama_kota
	from penjual
	join kota
	on penjual.kota_penjual_id = kota.kota_id
)
select kota_penjual.nama_kota,
	   mobil.merk_mobil,
	   mobil.model,
	   mobil.tahun_pembuatan,
	   mobil.harga_jual,
	   avg(mobil.harga_jual) over(partition by nama_kota)::float as rerata_harga_mobil
from kota_penjual
join mobil
on kota_penjual.penjual_id = mobil.mobil_id
group by 1,2,3,4,5
order by 1 asc;

-- 3. Dari penawaran suatu model mobil, cari perbandingan tanggal user melakukan bid dengan bid selanjutnya beserta harga tawar yang diberikan

with model_mobil_iklan as (
	select iklan.iklan_id,
		   mobil.model
	from iklan
	join mobil
	on iklan.mobil_iklan_id = mobil.mobil_id
)
select model_mobil_iklan.model,
	   bid.pembeli_bid_id as id_pembeli,
	   bid.tanggal_bid as tanggal_bid_awal,
	   LEAD(bid.tanggal_bid, 1) over(partition by pembeli_bid_id order by tanggal_bid asc) as tanggal_bid_kedua,
	   bid.harga_bid as harga_bid_awal,
	   LEAD(bid.harga_bid, 1) over(partition by pembeli_bid_id order by tanggal_bid asc) as harga_bid_kedua
from model_mobil_iklan
join bid
on model_mobil_iklan.iklan_id = bid.iklan_bid_id
where model ilike 'toyota agya';

-- 4. Membandingkan persentase perbedaan rata-rata harga mobil berdasarkan modelnya dan rata-rata harga bid yang ditawarkan oleh customer pada 6 bulan terakhir

create materialized view rerata_harga_mobil
as
select model, 
	   avg(harga_jual)::float as rerata_harga
from mobil 
group by 1;

with bid_iklan as(
	select iklan.mobil_iklan_id,
		   bid.harga_bid,
		   bid.tanggal_bid
	from iklan
	join bid
	on iklan.iklan_id = bid.iklan_bid_id
)
select mobil.model,
	   rerata_harga_mobil.rerata_harga,
	   avg(bid_iklan.harga_bid)::float as rerata_bid_6_bulan,
	   (rerata_harga_mobil.rerata_harga - avg(bid_iklan.harga_bid))::float as selisih,
	   ((rerata_harga_mobil.rerata_harga - avg(bid_iklan.harga_bid))/rerata_harga_mobil.rerata_harga)*100 as persentase_selisih
from mobil
join bid_iklan
on mobil.mobil_id = bid_iklan.mobil_iklan_id
join rerata_harga_mobil
on mobil.model = rerata_harga_mobil.model
where tanggal_bid >= now() - interval '6 months'
group by 1,2;

-- 5. Membuat window function rata-rata harga bid sebuah merk dan model mobil selama 6 bulan terakhir

with bid_iklan as(
	select iklan.mobil_iklan_id,
		   tanggal_bid,
		   avg(bid.harga_bid) over(order by bid.tanggal_bid RANGE BETWEEN INTERVAL '6 MONTHS' PRECEDING AND CURRENT ROW) as rerata_6_bulan,
		   avg(bid.harga_bid) over(order by bid.tanggal_bid RANGE BETWEEN INTERVAL '5 MONTHS' PRECEDING AND CURRENT ROW) as rerata_5_bulan,
		   avg(bid.harga_bid) over(order by bid.tanggal_bid RANGE BETWEEN INTERVAL '4 MONTHS' PRECEDING AND CURRENT ROW) as rerata_4_bulan,
		   avg(bid.harga_bid) over(order by bid.tanggal_bid RANGE BETWEEN INTERVAL '3 MONTHS' PRECEDING AND CURRENT ROW) as rerata_3_bulan,
		   avg(bid.harga_bid) over(order by bid.tanggal_bid RANGE BETWEEN INTERVAL '2 MONTHS' PRECEDING AND CURRENT ROW) as rerata_2_bulan,
		   avg(bid.harga_bid) over(order by bid.tanggal_bid RANGE BETWEEN INTERVAL '1 MONTHS' PRECEDING AND CURRENT ROW) as rerata_1_bulan
	from iklan
	join bid
	on iklan.iklan_id = bid.iklan_bid_id
)
select mobil.merk_mobil,
	   mobil.model,
	   sum(rerata_6_bulan)/count(rerata_6_bulan) as rerata_bid_6_bulan,
	   sum(rerata_5_bulan)/count(rerata_5_bulan) as rerata_bid_5_bulan,
	   sum(rerata_4_bulan)/count(rerata_4_bulan) as rerata_bid_4_bulan,
	   sum(rerata_3_bulan)/count(rerata_3_bulan) as rerata_bid_3_bulan,
	   sum(rerata_2_bulan)/count(rerata_2_bulan) as rerata_bid_2_bulan,
	   sum(rerata_1_bulan)/count(rerata_1_bulan) as rerata_bid_1_bulan
from mobil
join bid_iklan
on mobil.mobil_id = bid_iklan.mobil_iklan_id
where tanggal_bid >= now() - interval '6 months' and model ilike 'toyota agya'
group by 1,2;