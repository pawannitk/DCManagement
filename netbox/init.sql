-- Create the postgres role if it doesn't exist
DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'postgres') THEN
      CREATE ROLE postgres WITH SUPERUSER CREATEDB CREATEROLE LOGIN PASSWORD 'password';
   END IF;
END
$$;

-- Create the NetBox user if it doesn't exist
DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'netbox') THEN
      CREATE USER netbox WITH PASSWORD 'password';
   END IF;
END
$$;

-- Create the NetBox database if it doesn't exist
DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'netbox') THEN
      CREATE DATABASE netbox OWNER netbox;
   END IF;
END
$$;

-- CREATE DATABASE netbox;
-- CREATE USER netbox WITH PASSWORD 'password';
-- ALTER DATABASE netbox OWNER TO netbox;
-- the next two commands are needed on PostgreSQL 15 and later

-- Grant necessary permissions to the NetBox user
ALTER ROLE netbox SET search_path TO public;
GRANT ALL PRIVILEGES ON DATABASE netbox TO netbox;
\connect netbox;
GRANT CREATE ON SCHEMA public TO netbox;
