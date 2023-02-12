CREATE TABLE IF NOT EXISTS "migrations"(
  "id" integer PRIMARY KEY,
  "migrated_at" timestamptz NOT NULL DEFAULT now()
);


CREATE OR REPLACE FUNCTION log_migration(
    id integer
  ) RETURNS void AS $$
  BEGIN
    INSERT INTO "migrations" (id) VALUES (id);
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION assert_latest_migration (
  id integer
  )
  RETURNS void AS $$
  DECLARE
    latest_id integer;
  BEGIN
    SELECT MAX(migrations.id) INTO latest_id FROM migrations;

    ASSERT latest_id = id, 'migration assertion ' || id || ' failed, current latest is ' || latest_id;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

SELECT log_migration(0);