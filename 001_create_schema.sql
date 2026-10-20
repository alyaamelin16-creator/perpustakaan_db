
-- migrate:up

-- Migration 001: Struktur database perpustakaan

CREATE TABLE anggota (
    id_anggota INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat TEXT,
    no_hp VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE petugas (
    id_petugas INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_petugas VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE kategori_buku (
    id_kategori INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE penerbit (
    id_penerbit INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_penerbit VARCHAR(100) NOT NULL
);

CREATE TABLE buku (
    id_buku INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul VARCHAR(150) NOT NULL,
    id_kategori INTEGER NOT NULL,
    id_penerbit INTEGER NOT NULL,
    tahun_terbit SMALLINT,
    stok INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT fk_buku_kategori
        FOREIGN KEY (id_kategori)
        REFERENCES kategori_buku(id_kategori)
        ON DELETE RESTRICT,
    CONSTRAINT fk_buku_penerbit
        FOREIGN KEY (id_penerbit)
        REFERENCES penerbit(id_penerbit)
        ON DELETE RESTRICT,
    CONSTRAINT ck_buku_stok
        CHECK (stok >= 0),
    CONSTRAINT ck_buku_tahun
        CHECK (tahun_terbit IS NULL OR tahun_terbit BETWEEN 1000 AND 2100)
);

CREATE TABLE peminjaman (
    id_peminjaman INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INTEGER NOT NULL,
    id_petugas INTEGER NOT NULL,
    tanggal_pinjam DATE NOT NULL DEFAULT CURRENT_DATE,
    batas_kembali DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'dipinjam',
    CONSTRAINT fk_peminjaman_anggota
        FOREIGN KEY (id_anggota)
        REFERENCES anggota(id_anggota)
        ON DELETE RESTRICT,
    CONSTRAINT fk_peminjaman_petugas
        FOREIGN KEY (id_petugas)
        REFERENCES petugas(id_petugas)
        ON DELETE RESTRICT,
    CONSTRAINT ck_peminjaman_status
        CHECK (status IN ('dipinjam', 'selesai', 'terlambat')),
    CONSTRAINT ck_peminjaman_tanggal
        CHECK (batas_kembali >= tanggal_pinjam)
);

CREATE TABLE detail_peminjaman (
    id_peminjaman INTEGER NOT NULL,
    id_buku INTEGER NOT NULL,
    jumlah INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT pk_detail_peminjaman
        PRIMARY KEY (id_peminjaman, id_buku),
    CONSTRAINT fk_detail_peminjaman
        FOREIGN KEY (id_peminjaman)
        REFERENCES peminjaman(id_peminjaman)
        ON DELETE CASCADE,
    CONSTRAINT fk_detail_buku
        FOREIGN KEY (id_buku)
        REFERENCES buku(id_buku)
        ON DELETE RESTRICT,
    CONSTRAINT ck_detail_jumlah
        CHECK (jumlah > 0)
);

CREATE TABLE pengembalian (
    id_pengembalian INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_peminjaman INTEGER NOT NULL UNIQUE,
    tanggal_kembali DATE NOT NULL DEFAULT CURRENT_DATE,
    denda NUMERIC(12,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_pengembalian_peminjaman
        FOREIGN KEY (id_peminjaman)
        REFERENCES peminjaman(id_peminjaman)
        ON DELETE RESTRICT,
    CONSTRAINT ck_pengembalian_denda
        CHECK (denda >= 0)
);

-- migrate:down
-- Jalankan bagian DOWN secara terpisah, dari tabel anak ke induk.

DROP TABLE IF EXISTS pengembalian;
DROP TABLE IF EXISTS detail_peminjaman;
DROP TABLE IF EXISTS peminjaman;
DROP TABLE IF EXISTS buku;
DROP TABLE IF EXISTS penerbit;
DROP TABLE IF EXISTS kategori_buku;
DROP TABLE IF EXISTS petugas;
DROP TABLE IF EXISTS anggota;
