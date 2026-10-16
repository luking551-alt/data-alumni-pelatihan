-- Akses baca terbatas untuk User yang sudah login.
-- Jalankan di Supabase SQL Editor. Fungsi hanya mengembalikan enam kolom yang diizinkan.
-- Kebijakan RLS Admin yang sudah ada jangan dihapus.

CREATE OR REPLACE FUNCTION public.lihat_alumni_user()
RETURNS TABLE (
  nama_lengkap text,
  nomor_induk text,
  tahun_pelatihan integer,
  status text,
  program_pelatihan text,
  tanggal_pendataan date
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT
    a.nama_lengkap::text,
    a.nomor_induk::text,
    a.tahun_pelatihan::integer,
    a.status::text,
    a.program_pelatihan::text,
    a.tanggal_pendataan::date
  FROM public.alumni AS a
  WHERE (SELECT auth.uid()) IS NOT NULL;
$$;

REVOKE ALL ON FUNCTION public.lihat_alumni_user() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.lihat_alumni_user() FROM anon;
GRANT EXECUTE ON FUNCTION public.lihat_alumni_user() TO authenticated;
