# keepalive

Schemalagt anrop som håller en databas vaken.

`.github/workflows/keepalive.yml` anropar databasfunktionen `ping()` varannan dag.
Funktionen svarar bara med siffran 1 och kan inte läsa eller ändra data.

Adress och nyckel ligger som hemligheter i repots inställningar
(`SUPABASE_URL`, `SUPABASE_ANON_KEY`) och syns inte i koden eller i loggarna.
