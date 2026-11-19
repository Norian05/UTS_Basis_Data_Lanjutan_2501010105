-- Nama: Putu Mahesa Candradinata 
-- NIM : 2501010105
-- Hari/Tanggal : Kamis, 19 November 2026

-- DDL: Pembuatan Database dan Tabel --
 
-- 1a.--
CREATE DATABASE uts_bdl_2501010105;
USE uts_bdl_2501010105;

-- 1b. --
CREATE TABLE destinasi (
id_destinasi CHAR (4) PRIMARY KEY,
nama_destinasi VARCHAR (50) NOT NULL,
kabupaten VARCHAR (30) NOT NULL,
harga_tiket INT NOT NULL
);

CREATE  TABLE paket_tur (
id_paket CHAR (4) PRIMARY KEY,
nama_paket VARCHAR (50) NOT NULL UNIQUE,
id_destinasi CHAR (4) NOT NULL,
harga INT NOT NULL,
durasi_jam INT NULL,
FOREIGN KEY (id_destinasi) REFERENCES destinasi (id_destinasi)
);

CREATE TABLE wisatawan (
id_wisatawan CHAR (5) PRIMARY KEY,
nama VARCHAR (50) NOT NULL,
asal_negara VARCHAR (30) NOT NULL,
email VARCHAR (50) UNIQUE
);

CREATE TABLE pemesanan (
id_pesan INT PRIMARY KEY,
id_wisatawan CHAR (5) NOT NULL,
id_paket CHAR (4) NOT NULL,
tgl_tur DATE NOT NULL,
jumlah_orang INT NOT NULL,
`status` VARCHAR (10) NOT NULL DEFAULT 'Pending',
FOREIGN KEY (id_paket) REFERENCES paket_tur (id_paket),
FOREIGN KEY (id_wisatawan) REFERENCES wisatawan (id_wisatawan)
);

-- 1c. --
ALTER TABLE destinasi
ADD rating DECIMAL (2,1) NULL;

-- DML: Mengisi dan Mengubah Data --

-- 2a. --
INSERT INTO destinasi (id_destinasi, nama_destinasi, kabupaten, harga_tiket, rating)
VALUE
('D001', 'Tanah Lot', 'Tabanan', '30000', ''),
('D002', 'Ulun Danu Beratan', 'Tabanan', '50000', ''),
('D003', 'Tirta Empul', 'Gianyar', '50000', ''),
('D004', 'Goa Gajah', 'Gianyar', '50000', ''),
('D005', 'Desa Penglipuran', 'Bangli', '25000', ''),
('D006', 'Pura Besakih', 'Karangasem', '60000', ''),
('D007', 'Jatiluwih', 'Tabanan', '50000', '');

INSERT INTO paket_tur (id_paket, nama_paket, id_destinasi, harga, durasi_jam)
VALUE
('P001', 'Sunset Tanah Lot', 'D001', '35000', '5'),
('P002', 'Bedugul Lake Tour', 'D002', '45000', '8'),
('P003', 'Ubud Water Temple', 'D003', '400000', '6'),
('P004', 'Ubud Heritage Walk', 'D004', '30000', '4'),
('P005', 'Panglipuran Culture Trip', 'D005', '37500', '6'),
('P006', 'Besakih Spiritual Journtey', 'D006', '50000', '8'),
('P007', 'Tanah Lot Photo Tour', 'D001', '250000', '3');

INSERT INTO wisatawan (id_wisatawan, nama, asal_negara, email)
VALUE
('W001', 'Made Ayu', 'Indonesia', 'made.ayu@mail.com'),
('W002', 'John Smith', 'Australia', 'john.s@mail.com'),
('W003', 'Sarah Lee', 'Singapura', 'sarah.lee@mail.com'),	
('W004', 'Kenji Tanaka', 'Jepang', 'kenji.t@mail.com'),
('W005', 'Putu Arya', 'Indonesia', 'putu.arya@mail.com'),
('W006', 'Emma Brown', 'Australia', 'emma.b@mail.com'),
('W007', 'Li Wei', 'Tiongkok', 'li.wei@mail.com'),
('W008', 'Komang Sari', 'Indonesia', 'komang.s@mail.com');

INSERT INTO pemesanan (id_pesan, id_wisatawan, id_paket, tgl_tur, jumlah_orang, `status`)
VALUE
('1', 'W001', 'P001', '2026-09-05', '2', 'Lunas'),
('2', 'W002', 'P003', '2026-09-12', '4', 'Lunas'),
('3', 'W003', 'P002', '2026-09-20', '2', 'Batal'),	
('4', 'W004', 'P004', '2026-10-02', '3', 'Lunas'),
('5', 'W002', 'P001', '2026-10-03', '4', 'Lunas'),
('6', 'W005', 'P005', '2026-10-10', '5', 'Lunas'),
('7', 'W006', 'P003', '2026-10-15', '2', 'Pending'),
('8', 'W004', 'P002', '2026-10-18', '1', 'Lunas'),
('9', 'W007', 'P007', '2026-10-25', '3', 'Lunas'),
('10', 'W001', 'P004', '2026-11-01', '2', 'Lunas'),
('11', 'W006', 'P001', '2026-11-07', '6', 'Lunas'),
('12', 'W003', 'P005', '2026-11-09', '2', 'Pending');

-- 2b. --
UPDATE destinasi
SET harga_tiket = '30000'
WHERE id_destinasi = 'D005';
SELECT * FROM destinasi;

-- 2c. --
UPDATE pemesanan
SET `status` = 'Lunas'
WHERE id_pesan = '12';
SELECT * FROM pemesanan;

-- 2d. --
DELETE FROM pemesanan
WHERE `status` = 'Batal';
SELECT * FROM pemesanan;

-- 2e. --
INSERT INTO wisatawan (id_wisatawan, nama, asal_negara, email)
VALUE
('W009', 'Anna Schmidt', 'Jerman', 'anna@mail.com');
SELECT * FROM wisatawan;

-- 2f. --
INSERT INTO wisatawan VALUES
 ('W0010','Budi Santoso','Indonesia','made.ayu@mail.com');
 
-- Error Code: 1062
-- Duplicate entry 'made.ayu@mail.com' for key 'email'
-- Penjelasan: Terjadinya duplikasi data pada values email karena data yang baru dimasukkan sudah ada pada kolom email dan datanya bersifat unique jadi tidak bisa ada data yang sama diinput dua kali

-- Query Satu Tabel --

-- 3a. --
SELECT nama_paket, harga
FROM paket_tur
WHERE harga BETWEEN 30000 AND 45000
ORDER BY harga ASC;

-- 3b. --
SELECT id_wisatawan, nama
FROM wisatawan
WHERE nama LIKE '%an%'
ORDER BY nama ASC;

-- 3c. --
SELECT id_pesan, id_wisatawan, jumlah_orang
FROM pemesanan
ORDER BY jumlah_orang DESC, id_pesan ASC
LIMIT 3;

-- 3d. --
SELECT id_pesan, tgl_tur, `status`
FROM pemesanan
WHERE STATUS = 'Lunas'
AND tgl_tur >= '2026-10-01'
AND tgl_tur <= '2026-10-31'
ORDER BY tgl_tur ASC;

-- JOIN --

-- 4a. --
SELECT w.nama, pt.nama_paket, p.tgl_tur
FROM pemesanan p
INNER JOIN wisatawan w ON p.id_wisatawan = w.id_wisatawan
INNER JOIN paket_tur pt ON p.id_paket = pt.id_paket
WHERE p.status = 'Lunas'
ORDER BY p.tgl_tur ASC;

-- 4b. --
SELECT pt.nama_paket, d.nama_destinasi, d.kabupaten
FROM paket_tur pt
INNER JOIN destinasi d ON pt.id_destinasi = d.id_destinasi
WHERE d.kabupaten = 'Gianyar'
ORDER BY pt.nama_paket ASC;

-- 4c. --
SELECT w.id_wisatawan, w.nama
FROM wisatawan w
LEFT JOIN pemesanan p ON w.id_wisatawan = p.id_wisatawan
WHERE p.id_pesan IS NULL
ORDER BY w.id_wisatawan ASC;

-- 4d. --
SELECT pt.id_paket, pt.nama_paket
FROM pemesanan p
RIGHT JOIN paket_tur pt ON p.id_paket = pt.id_paket
WHERE p.id_pesan IS NULL;

-- Fungsi Agregasi dan GROUP BY --

-- 5a. --
SELECT `status`, 
COUNT(id_pesan) AS jumlah_pesanan,
SUM(jumlah_orang) AS total_peserta
FROM pemesanan
GROUP BY `status`
ORDER BY `status` ASC;

-- 5b. --
SELECT pt.nama_paket,
SUM(pt.harga * p.jumlah_orang) AS pendapatan
FROM paket_tur pt
INNER JOIN pemesanan p ON pt.id_paket = p.id_paket
WHERE p.status = 'Lunas'
GROUP BY pt.id_paket, pt.nama_paket
ORDER BY pendapatan DESC;

-- 5c. --
SELECT asal_negara, 
COUNT(id_wisatawan) AS jumlah_wisatawan
FROM wisatawan
GROUP BY asal_negara
ORDER BY jumlah_wisatawan DESC, asal_negara ASC;

-- 5d. --
SELECT kabupaten,
ROUND(AVG(harga_tiket), 2) AS rata_rata,
MAX(harga_tiket) AS tertinggi, 
MIN(harga_tiket) AS terendah
FROM destinasi
GROUP BY kabupaten
ORDER BY rata_rata DESC;

-- 5e. --
SELECT w.nama,
SUM(p.jumlah_orang) AS total_peserta
FROM wisatawan w
INNER JOIN pemesanan p ON w.id_wisatawan = p.id_wisatawan
WHERE p.status = 'Lunas'
GROUP BY w.id_wisatawan, w.nama
ORDER BY total_peserta DESC
LIMIT 3;