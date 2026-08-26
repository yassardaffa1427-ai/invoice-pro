# Invoice Pro — Sawah Studio

Kalkulator invoice satu halaman, sekarang dijalankan lewat dev server (Vite) supaya ada live-reload saat mengedit.

## Menjalankan

```bash
npm install
npm run dev
```

Buka URL yang ditampilkan di terminal (default `http://localhost:5173`).

## Build untuk produksi

```bash
npm run build
npm run preview   # cek hasil build
```

Hasil build ada di folder `dist/`.

## Struktur

- `index.html` — aplikasi (dulu `invoice-edit-pro.html`)
- `public/assets/` — taruh logo bisnis (`logo sawah.png`) di sini, dirujuk sebagai `/assets/logo sawah.png`
- `DESIGN_GUIDE.md` — panduan desain (warna, tipografi, komponen)
