CREATE DATABASE IF NOT EXISTS TemuSahamDb;

USE TemuSahamDb;

CREATE TABLE IF NOT EXISTS Categories (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(1000) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(1000) NOT NULL,
    type VARCHAR(30) NOT NULL,
    email VARCHAR(1000) NOT NULL,
    password VARCHAR(1000) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Companies (
   id INT NOT NULL AUTO_INCREMENT,
   user_id INT NOT NULL,
   category_id INT,
   name VARCHAR(1000),
   description VARCHAR(1000),
   location VARCHAR(1000),
   investment_stock INT,
   investment_target BIGINT(20),
   image TEXT,
   email VARCHAR(1000),
   phone VARCHAR(1000),
   url VARCHAR(1000),
   founded_year CHAR(4),
   is_invested CHAR(1) DEFAULT ('N'),
   is_completed CHAR(1) DEFAULT ('N'),

   PRIMARY KEY (id),
   FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
   FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Investments (
   id INT NOT NULL AUTO_INCREMENT,
   user_id INT NOT NULL,
   company_id INT NOT NULL,
   percentage DOUBLE(6, 2) NOT NULL,
   created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
   amount INT NOT NULL,

   PRIMARY KEY (id),
   FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
   FOREIGN KEY (company_id) REFERENCES Companies(id) ON DELETE CASCADE
);

INSERT INTO Users (name, type, email, password) VALUES 
('Tommie Aitkin', 'owner', 'taitkin0@homestead.com', 'jzDKrZUo'),
('Doroteya Sturney', 'owner', 'dsturney1@wikimedia.org', 'HXhew1CJ4Z'),
('Patrice Von Welldun', 'owner', 'pvon2@photobucket.com', 'HKnrQqQrCQ'),
('Bernarr Diche', 'owner', 'bdiche3@samsung.com', 'Dp81fydF'),
('Udale Gribbell', 'owner', 'ugribbell4@state.tx.us', '2ozevHSJ16'),
('Helli Farrent', 'owner', 'hfarrent2@deviantart.com', '85Qp4qwG'),
('Hieronymus Sketh', 'investor', 'hsketh5@ted.com', 'zxMLfW0uoSl'),
('Ailene Harries', 'investor', 'aharries6@whitehouse.gov', 'v8CrvUNE');

INSERT INTO Categories (name) VALUES 
('Technology'),
('Banking'),
('Food and Beverage');

INSERT INTO Companies (user_id, category_id, name, description, location, investment_stock, investment_target, image, email, phone, url, founded_year, is_completed) VALUES 
(1, 1, 'Traveloka', 'Traveloka merupakan startup yang memberikan layanan lengkap meliputi pemesanan tiket pesawat booking hotel secara daring dan layanan lainnya yang terkait perjalanan dan akomodasi. Startup ini didirikan pada tahun 2012 dan sudah beroperasi secara aktif di hampir semua wilayah di Indonesia.', 'Jakarta Indonesia', '10', '110000', '../assets/companies/traveloka.jpg', 'cs@traveloka.com', '+62 21-2910-3300', 'https://www.traveloka.com/', 2012, 'Y'),
(2, 1, 'Tokopedia', 'Tokopedia merupakan salah satu situs jual beli online di Indonesia yang perkembangannya terhitung cepat dan memiliki tujuan untuk memudahkan setiap masyarakat di Indonesia agar dapat melakukan aneka transaksi jual beli secara online.', 'Jakarta Indonesia', '15', '120000', '../assets/companies/tokopedia.jpg', 'care@tokopedia.com', '0853 1111 1010', 'https://www.tokopedia.com/', 2009, 'Y'),
(3, 2, 'Jenius', 'Jenius adalah sebuah aplikasi perbankan digital. Aplikasi ini membantu penggunanya melakukan aktivitas finansial seperti menabung bertransaksi atau mengatur keuangan serta memungkinkan nasabah untuk memiliki rekening bank. Semua dilakukan dari satu tempat dari ponsel baik yang berbasis Android maupun iOS. Aplikasi ini diluncurkan oleh Bank BTPN pada 11 Agustus 2016 setelah menjalani masa pengembangan selama 18 bulan dengan total nilai investasi Rp500 miliar. Dalam operasinya Jenius terkoneksi dengan ekosistem perbankan nasional dan sistem pembayaran internasional melalui kartu debit Visa dan Gerbang Pembayaran Nasional (GPN).', 'Jakarta Indonesia', '20', '130000', '../assets/companies/jenius.jpg', 'btpncare@btpn.com', '1500360', 'https://www.jenius.com/', 2016, 'Y'),
(4, 2, 'Dana', 'Dana adalah layanan keuangan digital yang berbasis di Jakarta Indonesia yang berperan sebagai pembayaran digital untuk menggantikan dompet konvensional. Didirikan sejak tahun 2018 DANA merupakan dompet digital yang terdaftar di Bank Indonesia dengan memiliki empat lisensi diantaranya sebagai uang elektronik dompet digital kirim uang dan Likuiditas Keuangan Digital (LKD).', 'Jakarta Indonesia', '25', '140000', '../assets/companies/dana.jpg', 'help@dana.id', '1500 445', 'https://www.dana.id/', 2018, 'Y'),
(5, 3, 'Haus', 'PT. Inspirasi Bisnis Nusantara merupakan perusahaan yang bergerak di bidang Food & Beverage dan dikenal dengan brand \Haus!\" yang menyediakan minuman dan makanan kekinian yang di gandrungi oleh generasi milenial dengan berbagai macam varian rasa serta harga yang terjangkau. Saat ini Haus! sudah memiliki 126 cabang outlet di Jabodetabek Bandung dan Surabaya. Selain ekspansi ke kota-kota besar di Indonesia Haus! juga akan terus melakukan pengembangan dan inovasi."', 'Jakarta Indonesia', '30', '150000', '../assets/companies/haus.jpg', 'hello@haus.co.id', '0877-9789-9666', 'https://haus.co.id/', 2018, 'Y'),
(6, 3, 'Hangry', 'Dibangun pada tahun 2019 Hangry hadir sebagai jawaban untuk berbagai momen \mau makan apa?\" dengan membangun multi-brand restoran cepat saji yang menjual beragam jenis kuliner lokal hingga mancanegara."', 'Jakarta Indonesia', '35', '160000', '../assets/companies/hangry.jpg', 'contact@ishangry.com', '+62 817 5092 000', 'https://www.ishangry.com/', 2019, 'Y');
