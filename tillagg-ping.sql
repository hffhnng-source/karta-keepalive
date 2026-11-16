-- "Ping" som håller Supabase-projektet vaket.
-- Klistra in i SQL Editor i Supabase och tryck "Run". Kan köras flera gånger.
--
-- Version 2: den gamla ping() svarade bara "select 1" och rörde ingen tabell.
-- Supabase räknar "user database activity" och verkar inte räkna det som aktivitet.
-- Nu skriver ping() en tidsstämpel i en egen liten tabell, så varje anrop blir
-- en riktig skrivning i databasen. Den kan fortfarande inte läsa eller ändra
-- någon annan data, och tabellen går inte att nå direkt med den publika nyckeln.

create table if not exists public.keepalive (
  id      integer primary key default 1 check (id = 1),
  senast  timestamptz not null default now(),
  antal   bigint not null default 0
);

alter table public.keepalive enable row level security;  -- inga policys = ingen direktåtkomst
revoke all on table public.keepalive from anon, authenticated;

insert into public.keepalive (id) values (1) on conflict (id) do nothing;

create or replace function public.ping()
returns integer
language sql
volatile
security definer
set search_path = ''
as $$
  update public.keepalive set senast = now(), antal = antal + 1 where id = 1;
  select 1;
$$;

revoke all on function public.ping() from public;
grant execute on function public.ping() to anon, authenticated;

-- Kontroll: visar när senaste pingen kom och hur många det blivit.
select * from public.keepalive;
