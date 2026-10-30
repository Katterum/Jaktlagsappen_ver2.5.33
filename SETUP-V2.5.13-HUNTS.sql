-- Katterums jaktlag v2.5.13 - cloud storage for completed hunts
create table if not exists public.hunts (
  id text primary key,
  team_id text not null,
  created_by uuid references auth.users(id) default auth.uid(),
  hunt_date date not null,
  hunt_type text,
  place text,
  comment text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index if not exists hunts_team_date_idx on public.hunts(team_id,hunt_date desc);
alter table public.hunts enable row level security;
drop policy if exists hunts_read on public.hunts;
drop policy if exists hunts_insert on public.hunts;
drop policy if exists hunts_update on public.hunts;
drop policy if exists hunts_delete on public.hunts;
create policy hunts_read on public.hunts for select to authenticated using (true);
create policy hunts_insert on public.hunts for insert to authenticated with check (created_by=auth.uid());
create policy hunts_update on public.hunts for update to authenticated using (true) with check (true);
create policy hunts_delete on public.hunts for delete to authenticated using (true);
