
-- Seed data awal sistem perpustakaan

-- 1. Kategori buku
INSERT INTO kategori_buku (nama_kategori)
VALUES
    ('Novel'),
    ('Pendidikan'),
    ('Teknologi'),
    ('Sejarah');

-- 2. Penerbit
INSERT INTO penerbit (nama_penerbit)
VALUES
    ('Gramedia Pustaka Utama'),
    ('Erlangga'),
    ('Informatika');

-- 3. Anggota
INSERT INTO anggota (nama, alamat, no_hp, email)
VALUES
    ('Andi Pratama', 'Bandung', '081234567801', 'andi@email.com'),
    ('Bunga Lestari', 'Cimahi', '081234567802', 'bunga@email.com'),
    ('Dimas Saputra', 'Bandung', '081234567803', 'dimas@email.com');

-- 4. Petugas
INSERT INTO petugas (nama_petugas, username)
VALUES
    ('Siti Aminah', 'siti'),
    ('Rudi Hartono', 'rudi');

-- 5. Buku
INSERT INTO buku
    (judul, id_kategori, id_penerbit, tahun_terbit, stok)
VALUES
    ('Laskar Pelangi', 1, 1, 2005, 9),
    ('Matematika Dasar', 2, 2, 2022, 15),
    ('Belajar PostgreSQL', 3, 3, 2024, 8),
    ('Sejarah Indonesia', 4, 2, 2021, 12);

-- 6. Peminjaman
INSERT INTO peminjaman
    (id_anggota, id_petugas, tanggal_pinjam, batas_kembali, status)
VALUES
    (1, 1, '2026-10-15', '2026-10-22', 'dipinjam'),
    (2, 2, '2026-10-16', '2026-10-23', 'dipinjam'),
    (3, 1, '2026-10-10', '2026-10-17', 'selesai');

-- 7. Detail peminjaman
INSERT INTO detail_peminjaman
    (id_peminjaman, id_buku, jumlah)
VALUES
    (1, 1, 1),
    (1, 3, 1),
    (2, 2, 1),
    (3, 4, 1);

-- 8. Pengembalian
INSERT INTO pengembalian
    (id_peminjaman, tanggal_kembali, denda)
VALUES
    (3, '2026-10-16', 0);
