-- Katterums jaktlag v2.5.28 - info/anslag i molnet
create table if not exists public.info_posts (
  id text primary key,
  team_id text not null,
  created_by uuid references auth.users(id) default auth.uid(),
  title text,
  message text not null,
  priority text not null default 'general',
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index if not exists info_posts_team_created_idx on public.info_posts(team_id,created_at desc);
alter table public.info_posts enable row level security;
drop policy if exists info_posts_read on public.info_posts;
drop policy if exists info_posts_insert on public.info_posts;
drop policy if exists info_posts_update on public.info_posts;
drop policy if exists info_posts_delete on public.info_posts;
create policy info_posts_read on public.info_posts for select to authenticated using (true);
create policy info_posts_insert on public.info_posts for insert to authenticated with check (created_by=auth.uid());
create policy info_posts_update on public.info_posts for update to authenticated using (true) with check (true);
create policy info_posts_delete on public.info_posts for delete to authenticated using (true);
