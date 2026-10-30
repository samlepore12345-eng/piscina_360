-- ////////// PISCINA360: agrega la línea de fumigación
-- Pégalo en Supabase > SQL Editor > New query > Run  (ANTES de subir la página nueva)
alter table public.cotizaciones add column if not exists linea   text default 'piscinas';
alter table public.cotizaciones add column if not exists area_m2 numeric;
