# Sistem Basis Data Perpustakaan

## 1. Deskripsi Proyek
Proyek ini merupakan implementasi basis data sistem perpustakaan menggunakan PostgreSQL 16 dan pgAdmin 4. Basis data digunakan untuk mengelola data anggota, buku, kategori buku, penerbit, petugas, peminjaman, detail peminjaman, dan pengembalian.

## 2. Teknologi yang Digunakan
- PostgreSQL 16
- pgAdmin 4
- Visual Studio Code
- SQL

## 3. Struktur Basis Data
Basis data terdiri dari delapan tabel:
1. `anggota`
2. `buku`
3. `kategori_buku`
4. `penerbit`
5. `petugas`
6. `peminjaman`
7. `detail_peminjaman`
8. `pengembalian`

Tabel-tabel tersebut saling terhubung menggunakan primary key dan foreign key untuk menjaga konsistensi data.

## 4. Implementasi Database
Implementasi dilakukan dengan membuat tabel, menentukan tipe data, menetapkan primary key dan foreign key, serta menambahkan constraint untuk membatasi data yang tidak valid.

## 5. Pengujian Database
Pengujian dilakukan melalui pgAdmin 4 menggunakan query SQL, meliputi:
- Pemeriksaan tabel dan kolom.
- Pemeriksaan primary key dan foreign key.
- Pengujian perubahan data menggunakan `UPDATE`.
- Pengujian constraint untuk memastikan data yang tidak valid ditolak.
- Pemeriksaan index.
- Pengukuran rencana eksekusi query menggunakan `EXPLAIN ANALYZE`.

Beberapa pengujian constraint menghasilkan error yang diharapkan karena data yang dimasukkan melanggar aturan foreign key atau check constraint.

## 6. Optimasi Query
Tiga index tambahan dibuat untuk membantu pencarian berdasarkan anggota, tanggal peminjaman, dan buku pada detail peminjaman:
- `idx_peminjaman_anggota`
- `idx_peminjaman_tanggal`
- `idx_detail_peminjaman_buku`

Query `EXPLAIN ANALYZE` menunjukkan bahwa PostgreSQL menggunakan `Seq Scan` untuk data pengujian yang masih sedikit. Hal ini dapat terjadi karena pemindaian tabel penuh dinilai lebih efisien untuk tabel berukuran kecil.

## 7. Struktur Folder
- `migrations/001_create_schema.sql`: definisi struktur tabel.
- `migrations/002_add_indexes.sql`: definisi index tambahan.
- `seeds/001_seed_perpustakaan.sql`: data awal untuk pengujian.

## 8. Kesimpulan
Implementasi basis data perpustakaan telah mencakup pembuatan tabel, relasi antartabel, pengujian constraint, serta pemeriksaan index dan eksekusi query. Pengujian dilakukan untuk memastikan integritas data dan memahami proses eksekusi query pada PostgreSQL.
