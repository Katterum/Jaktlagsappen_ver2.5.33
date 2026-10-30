-- Katterums jaktlag v2.5.17 - kalender och aktiviteter i molnet
create table if not exists public.events (
  id text primary key,
  team_id text not null,
  created_by uuid references auth.users(id) default auth.uid(),
  event_date date not null,
  title text not null,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index if not exists events_team_date_idx on public.events(team_id,event_date);
alter table public.events enable row level security;
drop policy if exists events_read on public.events;
drop policy if exists events_insert on public.events;
drop policy if exists events_update on public.events;
drop policy if exists events_delete on public.events;
create policy events_read on public.events for select to authenticated using (true);
create policy events_insert on public.events for insert to authenticated with check (created_by=auth.uid());
create policy events_update on public.events for update to authenticated using (true) with check (true);
create policy events_delete on public.events for delete to authenticated using (true);
