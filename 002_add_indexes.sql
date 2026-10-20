
-- migrate:up

-- Migration 002: Menambahkan index untuk optimasi query

CREATE INDEX idx_peminjaman_anggota
ON peminjaman (id_anggota);

CREATE INDEX idx_peminjaman_tanggal
ON peminjaman (tanggal_pinjam);

CREATE INDEX idx_detail_peminjaman_buku
ON detail_peminjaman (id_buku);


-- migrate:down

DROP INDEX IF EXISTS idx_detail_peminjaman_buku;
DROP INDEX IF EXISTS idx_peminjaman_tanggal;
DROP INDEX IF EXISTS idx_peminjaman_anggota;
