# keepalive

Schemalagt anrop som håller en databas vaken.

`.github/workflows/keepalive.yml` anropar databasfunktionen `ping()` tre gånger om dagen.
Funktionen skriver en tidsstämpel i den egna tabellen `keepalive` (så att Supabase ser
riktig databasaktivitet) och svarar med siffran 1. Den kan inte läsa eller ändra annan data.

Kontrollera i Supabase: `select * from public.keepalive;` visar senaste ping och antal.

Adress och nyckel ligger som hemligheter i repots inställningar
(`SUPABASE_URL`, `SUPABASE_ANON_KEY`) och syns inte i koden eller i loggarna.
