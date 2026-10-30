-- Katterums jaktlag v2.5.25 - chatmeddelanden i molnet
create table if not exists public.messages (
  id text primary key,
  team_id text not null,
  created_by uuid references auth.users(id) default auth.uid(),
  author text not null,
  message_text text not null,
  message_date timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index if not exists messages_team_date_idx on public.messages(team_id,message_date);
alter table public.messages enable row level security;
drop policy if exists messages_read on public.messages;
drop policy if exists messages_insert on public.messages;
drop policy if exists messages_update on public.messages;
drop policy if exists messages_delete on public.messages;
create policy messages_read on public.messages for select to authenticated using (true);
create policy messages_insert on public.messages for insert to authenticated with check (created_by=auth.uid());
create policy messages_update on public.messages for update to authenticated using (true) with check (true);
create policy messages_delete on public.messages for delete to authenticated using (true);
