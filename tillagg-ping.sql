-- Liten "ping"-funktion som håller Supabase-projektet vaket.
-- Klistra in i SQL Editor i Supabase och tryck "Run". Kan köras flera gånger.
-- Funktionen svarar bara med siffran 1. Den kan inte läsa eller ändra någon data.

create or replace function public.ping()
returns integer
language sql
stable
security invoker
set search_path = ''
as $$ select 1 $$;

revoke all on function public.ping() from public;
grant execute on function public.ping() to anon, authenticated;
