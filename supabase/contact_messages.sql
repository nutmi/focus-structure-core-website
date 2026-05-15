create extension if not exists pgcrypto;

create table if not exists public.contact_messages (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  surname text,
  email text not null,
  message text not null,
  created_at timestamptz not null default now()
);

alter table public.contact_messages enable row level security;

grant usage on schema public to anon;
grant insert on public.contact_messages to anon;

drop policy if exists "public can submit contact messages" on public.contact_messages;

create policy "public can submit contact messages"
on public.contact_messages
for insert
to anon
with check (
  length(trim(name)) > 0
  and length(trim(email)) > 3
  and length(trim(message)) > 0
);
