-- Bake Book: run this once in Supabase -> SQL Editor -> New query -> Run.
-- It creates one table for your orders, pantry and settings, and locks it so
-- only the signed-in owner can read or change their own rows.

create table if not exists public.docs (
  owner      uuid not null default auth.uid() references auth.users(id) on delete cascade,
  collection text not null,               -- 'orders', 'inventory' or 'config'
  id         text not null,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (owner, collection, id)
);

alter table public.docs enable row level security;

create policy "read own"   on public.docs for select to authenticated using (owner = auth.uid());
create policy "add own"    on public.docs for insert to authenticated with check (owner = auth.uid());
create policy "change own" on public.docs for update to authenticated using (owner = auth.uid()) with check (owner = auth.uid());
create policy "delete own" on public.docs for delete to authenticated using (owner = auth.uid());

-- live sync between phone and iPad
alter publication supabase_realtime add table public.docs;
