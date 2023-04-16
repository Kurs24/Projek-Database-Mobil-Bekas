-- 1. Mencari mobil keluaran 2015 ke atas 
select * from mobil
where tahun_pembuatan >= 2015

-- 2. Menambahkan satu data bid produk baru
insert into bid values (201, 25, 6, '2023-03-12', 120000000, 'Sent')

-- 3. Melihat semua mobil yg dijual 1 akun dari yg paling baru
select mobil.mobil_id,
	   mobil.merk_mobil,
	   mobil.model,
	   mobil.tahun_pembuatan,
	   mobil.harga_jual,
	   iklan.tanggal_posting
	   from iklan
join mobil
on iklan.mobil_iklan_id = mobil.mobil_id
where penjual_iklan_id = 28
order by tanggal_posting desc

-- 4. Mencari mobil bekas yang termurah berdasarkan keyword
select * from mobil
where model ilike '%yaris%'
order by harga_jual asc

-- 5. Mencari mobil bekas yang terdekat berdasarkan sebuah id kota
-- Buat fungsi harversine distance
CREATE FUNCTION heversine_distance(latitude1 real, latitude2 real, longitude1 real, longitude2 real)
RETURNS FLOAT AS $$
DECLARE
	lon1 float := radians(longitude1);
	lon2 float := radians(longitude2);
	lat1 float := radians(latitude1);
	lat2 float := radians(latitude2);
	
	dlon float := lon2 - lon1;
	dlat float := lat2 - lat1;
	a float;
	c float;
	r float := 6371;
	jarak float;
	
	BEGIN
	a := sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2;
	c := 2 * asin(sqrt(a));
	jarak := r * c;
	
	RETURN jarak;
END;
$$ LANGUAGE plpgsql;

with pin_lokasi as(
	select penjual.penjual_id,
		   kota.kota_id,
		   kota.latitude,
	       kota.longitude
	from penjual
	join kota
	on penjual.kota_penjual_id = kota.kota_id
),
mobil_lokasi as(
	select penjual_id,
	   	   kota_id,
	   	   mobil.merk_mobil,
		   mobil.model,
		   mobil.tahun_pembuatan,
	       mobil.harga_jual,
	       latitude,
	       longitude
	from pin_lokasi
	join mobil
	on pin_lokasi.penjual_id = mobil.penjual_mobil_id
)
select merk_mobil,
	   model,
	   tahun_pembuatan,
	   harga_jual,
	   heversine_distance((select latitude where kota_id = 3173), (select latitude where kota_id = 3173), (select longitude where kota_id = 3173), (select longitude where kota_id = 3173)) as Jarak
from mobil_lokasi
where kota_id = 3173