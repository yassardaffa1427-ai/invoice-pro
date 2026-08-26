# Sawah Invoice — Design Guide (v2)

**Status:** Draft
**Referensi gaya:** rocket.new (clean, minimalis, monokrom) + caption bergaya mono/terminal ala opencode
**Basis:** memperluas token yang sudah berjalan di `index.html` (Inter Tight, radius, dsb), dipindah dari palet olive-tint ke krem ↔ tinta monokrom.

---

## 1. Warna

Skala netral: **krem hangat** (light) ↔ **tinta hangat** (dark). Satu token brand (olive) tersisa hanya untuk aksen kecil — bukan lagi warna tombol.

### Mode Terang

| Token | Hex | Pemakaian |
|---|---|---|
| `--bg` | `#F7F5F1` | Background halaman |
| `--surface` | `#FFFFFF` | Card, panel |
| `--surface-2` | `#EFEBE4` | Hover state, blok netral |
| `--surface-3` | `#DEDBD3` | Elemen tertekan/aktif |
| `--border` | `#DEDBD3` | Border tipis |
| `--border-strong` | `#C7C2B7` | Border tombol outline |
| `--text` | `#1E1C1A` | Teks utama |
| `--text-2` | `#5E5A53` | Teks sekunder |
| `--text-3` | `#827D76` | Caption, teks pasif |
| `--ink-2` (tombol) | `#38342F` | Fill tombol primary |
| `--brand` (aksen) | `#4C6F0F` | Logo dot, focus ring — **bukan** tombol |

### Mode Gelap

| Token | Hex | Pemakaian |
|---|---|---|
| `--bg` | `#141210` | Background halaman |
| `--surface` | `#1E1C1A` | Card, panel |
| `--surface-2` | `#2A2724` | Hover state |
| `--text` | `#F7F5F1` | Teks utama |
| `--text-2` | `#A19B8E` | Teks sekunder |
| `--text-3` | `#827D76` | Caption |
| `--ink-2` (tombol) | `#F7F5F1` | Fill tombol primary (terbalik: terang di atas gelap) |
| `--brand` (aksen) | `#92C639` | Logo dot, focus ring |

### Warna Semantik (status, bukan brand)

Tetap berwarna karena ini informasi fungsional (status invoice/langganan), bukan dekorasi — dibuat muted/earthy supaya senada dengan palet krem:

| Status | Warna teks | Warna latar (soft) | Dipakai untuk |
|---|---|---|---|
| Good | `#4E6B3A` (`#9BC489` dark) | `#E9EEE1` | Invoice tersimpan, langganan aktif |
| Warn | `#8A6218` (`#E0B455` dark) | `#F3E9D2` | Draft, menunggu pembayaran |
| Critical | `#93392C` (`#E0958A` dark) | `#F4E1DC` | Kuota habis, pembayaran gagal |

> Ganti tema OS/browser untuk memverifikasi — semua warna di atas didefinisikan sebagai token, bukan nilai literal, supaya otomatis ikut light/dark.

---

## 2. Tipografi

- **Inter Tight** — semua heading & body (font yang sudah dipakai aplikasi sekarang).
- **JetBrains Mono** — dipakai lebih luas dari sebelumnya: bukan cuma angka (nomor invoice, nominal), tapi juga **semua caption, eyebrow, dan label kecil** — huruf kapital, letter-spacing lebar (`0.09em`), ukuran kecil (~10.5px). Ini yang memberi kesan terminal/CLI seperti pada opencode.

### Skala Tipe

| Peran | Font / Berat | Ukuran | Letter-spacing |
|---|---|---|---|
| H1 | Inter Tight 800 | 40px | -0.03em |
| H2 | Inter Tight 800 | 28px | -0.02em |
| H3 | Inter Tight 700 | 20px | -0.01em |
| Body | Inter Tight 400 | 15.5px | normal |
| Caption / label | JetBrains Mono 500 | 10.5px | 0.09em, uppercase |
| Angka (nominal, kuota) | JetBrains Mono 600 | 18–26px | `font-variant-numeric: tabular-nums` |

---

## 3. Radius & Bayangan

Radius diperkecil & lebih tegas dari draf pertama (tidak lagi full-pill untuk tombol/kartu):

| Token | Nilai | Dipakai untuk |
|---|---|---|
| `--radius-sm` | 6px | Tombol, input |
| `--radius` | 10px | Card standar |
| `--radius-lg` | 16px | Panel besar, kartu pricing |
| `--radius-pill` | 999px | Badge & pill kecil saja |

Bayangan: `--shadow-sm` untuk elemen datar (chip), `--shadow` untuk card mengambang (dashboard shell), `--shadow-lg` untuk modal/overlay.

---

## 4. Tombol — Monokrom

Tidak ada lagi tombol hijau/gradasi. Beda tier/plan ditandai lewat teks & badge, **bukan** warna tombol.

| Varian | Fill | Teks | Border | Dipakai untuk |
|---|---|---|---|---|
| Primary | `--ink-2` (solid) | Putih | — | Aksi utama satu per layar: Simpan, Upgrade |
| Secondary | Transparan | `--text` | `--border-strong` | Aksi kedua: Batal, Mulai Gratis |
| Ghost | Transparan | `--text-2` | — | Aksi tersier: Lihat Arsip |
| Disabled | opacity 0.4, cursor not-allowed | — | — | Kuota habis |

---

## 5. Badge & Pill

- **Badge tier** (Gratis / Berbayar): monokrom — outline untuk Gratis, isi tinta pekat untuk Berbayar (terbalik jadi isi putih di mode gelap).
- **Pill status** (Tersimpan / Menunggu Bayar / Kuota Habis): tetap pakai warna semantik dari §1, karena beda tier ≠ beda status dan keduanya tidak boleh tertukar secara visual.

---

## 6. Kartu Pricing (3 tier)

Kartu "populer" tidak lagi disorot dengan glow warna — dibalik jadi panel tinta solid (teks putih di atas latar `--ink-2`), pola kontras klasik yang tetap terasa istimewa tanpa keluar dari palet monokrom.

| | **Gratis** | **Berbayar** (populer, kartu dibalik) | **Business Pro** |
|---|---|---|---|
| Harga | $0 | $5/bulan | $15/bulan |
| Invoice/bulan | 10 | 30 | 70 |
| Badge/logo kustom | ✗ | ✓ | ✓ |
| Arsip cloud | ✓ | ✓ | ✓ |
| Perpanjangan | — | Otomatis | Otomatis |

Layout: grid 3 kolom di desktop, turun ke 1 kolom di mobile (breakpoint 820px), 2 kolom di tablet (821–1080px).

---

## 7. Dashboard Shell

Sidebar kiri tetap dengan 4 menu (Overview, Informasi Umum, Arsip Invoice, Add New Invoice). Menu aktif ditandai blok netral (`--surface-3`), **bukan** warna brand — konsisten dengan prinsip monokrom.

```
┌─────────────────────────────────────┐
│ ● ● ●                               │  ← top chrome (dekoratif)
├───────────┬─────────────────────────┤
│ Overview  │  [Stat tiles: kuota,    │
│ Info Umum │   tier, invoice         │
│ Arsip     │   tersimpan]            │
│ + Invoice │                         │
└───────────┴─────────────────────────┘
```

---

## 8. Stat Tile

Angka besar mono (`tabular-nums`), label kecil bergaya caption di atas, bar progres tipis (5px, radius pill) untuk kuota. Warna bar tetap monokrom (tinta) — status kritis (kuota >90%) ditandai lewat pill/teks di dekatnya, bukan mengubah warna bar.

```
KUOTA BULAN INI
9 / 10
▓▓▓▓▓▓▓▓▓░  (90%, warna tetap tinta)
```

---

## 9. Arsip Invoice (tabel)

Baris tabel dengan kolom: Pembeli, No. Invoice (mono, biar sejajar), Tanggal, Total (mono), Status (pill semantik). Header tabel pakai gaya caption (mono, uppercase, kecil).

---

## 10. Upload Badge

- Tersedia untuk tier Berbayar & Business Pro.
- Untuk tier Gratis: kontrol tetap terlihat tapi terkunci (opacity turun) dengan pesan mengajak upgrade — bukan disembunyikan sepenuhnya.
- Format: PNG/JPG/SVG, maks 2MB, rasio disarankan 1:1 atau 3:1.

---

## Referensi Hidup

Versi HTML interaktif dari panduan ini (dengan swatch warna, spesimen tipe, dan komponen yang bisa dilihat langsung di light/dark mode) tersedia di artifact terpisah pada percakapan ini.
