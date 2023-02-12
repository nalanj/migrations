SELECT assert_latest_migration(0);

CREATE TABLE "users" (
  id serial PRIMARY KEY,
  username varchar(255) NOT NULL,
  encrypted_password varchar(255) NOT NULL,
  created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL
);

SELECT log_migration(1);