CREATE TABLE Kota(
	kota_id int PRIMARY KEY,
	nama_kota varchar(100) NOT NULL,
	latitude real NOT NULL,
	longitude real NOT NULL
);

CREATE TABLE Pembeli(
	pembeli_id int PRIMARY KEY,
	kota_pembeli_id int,
	nama_depan varchar(50) NOT NULL,
	nama_belakang varchar(50) NOT NULL,
	detail_kontak varchar(100) NOT NULL,
	CONSTRAINT fk_kota_pembeli
		FOREIGN KEY(kota_pembeli_id)
		REFERENCES kota(kota_id)
);

CREATE TABLE Penjual(
	penjual_id int PRIMARY KEY,
	kota_penjual_id int,
	nama_depan varchar(50) NOT NULL,
	nama_belakang varchar(50) NOT NULL,
	detail_kontak varchar(100) NOT NULL,
	CONSTRAINT fk_kota_penjual
		FOREIGN KEY(kota_penjual_id)
		REFERENCES kota(kota_id)
);

CREATE TABLE Mobil(
	mobil_id int PRIMARY KEY,
	penjual_mobil_id int,
	merk_mobil varchar(50) NOT NULL,
	model varchar(50) NOT NULL,
	jenis_body varchar(50) NOT NULL,
	tipe_mobil varchar(50) NOT NULL,
	tahun_pembuatan int NOT NULL,
	harga_jual int NOT NULL,
	CONSTRAINT fk_penjual_mobil
		FOREIGN KEY(penjual_mobil_id)
		REFERENCES penjual(penjual_id)
);


