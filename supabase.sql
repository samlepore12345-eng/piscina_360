-- ////////// PISCINA360: tabla de cotizaciones
-- Pégalo completo en Supabase > SQL Editor > New query > Run

create table if not exists public.cotizaciones (
  id            bigint generated always as identity primary key,
  created_at    timestamptz not null default now(),
  codigo        text,
  servicio      text,
  cliente_tipo  text,
  ciudad        text,
  largo         numeric,
  ancho         numeric,
  prof          numeric,
  m3            numeric,
  estimado_min  numeric,
  estimado_max  numeric,
  nombre        text not null,
  celular       text not null,
  origen        text default 'directo',
  estado        text not null default 'nuevo'
                check (estado in ('nuevo','contactado','enviado','cerrado','perdido')),
  valor_cierre  numeric,
  notas         text
);

alter table public.cotizaciones enable row level security;

-- El público (la página) SOLO puede crear cotizaciones, no verlas
drop policy if exists "publico_inserta" on public.cotizaciones;
create policy "publico_inserta" on public.cotizaciones
  for insert to anon with check (true);

-- Solo tú (usuario con login) puedes ver y actualizar
drop policy if exists "dueno_lee" on public.cotizaciones;
create policy "dueno_lee" on public.cotizaciones
  for select to authenticated using (true);

drop policy if exists "dueno_actualiza" on public.cotizaciones;
create policy "dueno_actualiza" on public.cotizaciones
  for update to authenticated using (true) with check (true);
