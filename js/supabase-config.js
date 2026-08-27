/* ════════════════════════════════════════════════════════════
   KONFIGURASI SUPABASE — Login Akun Pro
   ════════════════════════════════════════════════════════════
   Isi dua nilai di bawah dengan milik project Supabase kamu sendiri.
   Ambil dari dashboard Supabase → Project Settings → API:
     - Project URL           → SUPABASE_URL
     - Project API keys/anon → SUPABASE_ANON_KEY

   Anon key AMAN ditaruh di sisi client (browser). Ia bukan rahasia —
   akses data tetap dibatasi oleh Row Level Security (RLS) di sisi
   server Supabase, bukan oleh key ini. Fitur ini hanya dipakai untuk
   login/otentikasi, tidak ada data invoice yang dikirim ke cloud.
*/
window.SUPABASE_URL = 'https://YOUR-PROJECT-REF.supabase.co';
window.SUPABASE_ANON_KEY = 'YOUR-ANON-PUBLIC-KEY';
