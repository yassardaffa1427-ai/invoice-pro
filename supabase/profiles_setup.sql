-- ════════════════════════════════════════════════════════════
-- KIRIM.IN PRO — Setup tabel profiles + gerbang pembayaran manual
-- ════════════════════════════════════════════════════════════
-- Jalankan seluruh file ini sekali lewat Supabase Dashboard → SQL Editor.
--
-- Alurnya:
--   1. User daftar (signUp) lewat form login di web.
--   2. Trigger di bawah otomatis bikin baris di "profiles" dengan is_paid = false.
--   3. Selama is_paid = false, web menampilkan layar "Menunggu Verifikasi".
--   4. Kamu (admin) cek pembayaran manual di luar sistem (transfer/WA/dsb).
--   5. Kalau sudah bayar, buka Table Editor → tabel "profiles" → cari
--      barisnya (cocokkan lewat kolom email) → ubah is_paid jadi true.
--   6. User tinggal refresh halaman, otomatis langsung masuk ke app.

-- 1. Tabel profiles: satu baris per user, nempel ke auth.users
create table if not exists public.profiles (
  id         uuid primary key references auth.users(id) on delete cascade,
  email      text,
  is_paid    boolean not null default false,
  created_at timestamptz not null default now()
);

-- 2. Aktifkan Row Level Security
alter table public.profiles enable row level security;

-- 3. User cuma boleh BACA baris miliknya sendiri (buat cek is_paid).
--    Sengaja TIDAK ada policy insert/update untuk role biasa —
--    supaya user tidak bisa mengubah is_paid miliknya sendiri jadi true.
--    Baris dibuat lewat trigger (security definer) di bawah, dan diubah
--    hanya lewat Table Editor (yang berjalan sebagai service_role, bukan
--    dibatasi RLS).
drop policy if exists "Users can view own profile" on public.profiles;
create policy "Users can view own profile"
  on public.profiles for select
  using (auth.uid() = id);

-- 4. Trigger: setiap kali ada user baru daftar di auth.users,
--    otomatis buat baris profiles dengan is_paid = false.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, is_paid)
  values (new.id, new.email, false)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
