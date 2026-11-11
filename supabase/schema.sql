-- Fiamma QR demo: jurnal de evenimente (comenzi, chemări, plăți)
create table if not exists public.events (
  id text primary key check (char_length(id) <= 40),
  t bigint not null,
  table_no int not null default 0,
  type text not null check (type in ('order','orderStatus','call','ack','billReq','pay','reset','resetAll')),
  ev jsonb not null check (pg_column_size(ev) < 4000),
  created_at timestamptz not null default now()
);
create index if not exists events_t_idx on public.events (t);
alter table public.events enable row level security;
create policy "demo read" on public.events for select to anon, authenticated using (true);
create policy "demo insert" on public.events for insert to anon, authenticated with check (true);
revoke all on public.events from anon, authenticated;
grant select, insert on public.events to anon, authenticated;
alter publication supabase_realtime add table public.events;
