Saya telah membuat sebuah skema database dari sebuah website yang menawarkan jual-beli mobil bekas

# ERD yang digunakan pada Database
![ERDjpg](https://user-images.githubusercontent.com/92706710/232272234-fa581e80-433c-4e0a-b790-607b31f7320b.jpg)

# Contoh Query yang dilakukan pada Database

Berikut adalah beberapa contoh query yang dapat dilakukan pada database ini, yaitu:
1. Transactional Query, terdapat 5 contoh transactional query yang saya berikan pada File dengan nama **_Transactional Query_**, 5 contoh tersebut adalah:
    * Query untuk menampilkan seluruh kolom pada tabel mobil yang diproduksi pada tahun keluaran 2015 ke atas
    * Query untuk menambahkan satu data bid produk baru pada tabel bid
    * Query untuk melihat semua mobil yang dijual oleh akun dengan id tertentu diurutkan dari yang terbaru
    * Query untuk mencari mobil bekas yang termurah berdasarkan keyword tertentu
    * Query untuk Mencari mobil bekas yang terdekat berdasarkan id dari kota tertentu
2. Analytical Query, sama seperti sebelumnya terdapat 5 contoh Analytical query yang saya berikan pada File dengan nama **_Analytical Query_**, 5 contoh tersebut adalah:
    * Query untuk menampilkan data popularitas model suatu mobil berdasarkan jumlah bid yang ada
    * Query untuk membandingkan harga suatu mobil berdasarkan harga rerata mobil tersebut di tiap kota
    * Query untuk menampilkan tanggal dan harga awal yang ditawarkan oleh pembeli untuk sebuah mobil, dan tanggal dan harga berikutnya yang ditawarkan untuk mobil yang sama
    * Query untuk menampilkan persentase perbedaan dari rerata harga suatu mobil dengan harga bidnya dalam 6 bulan terakhir
    * Query untuk menampilkan rerata harga bid dari suatu merk dan model mobil dalam 6 bulan terakhir

# DBMS yang digunakan
PostgreSQL 15.2

# Cara penggunaan
1. Clone/Download Database dari github repository ini
2. Import database tersebut pada pgAdmin4 anda
3. Enjoy! 