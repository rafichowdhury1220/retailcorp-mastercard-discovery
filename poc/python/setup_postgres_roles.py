#!/usr/bin/env python3
"""Connect to PostgreSQL and configure IAM POC roles."""

import os
import psycopg2

POSTGRES_HOST = os.environ.get("POSTGRES_HOST")
POSTGRES_PORT = int(os.environ.get("POSTGRES_PORT", "5432"))
POSTGRES_DB = os.environ.get("POSTGRES_DB", "iam_poc")
POSTGRES_USER = os.environ.get("POSTGRES_USER", "iamadmin")
POSTGRES_PASSWORD = os.environ.get("POSTGRES_PASSWORD")


def main():
    if not POSTGRES_HOST or not POSTGRES_PASSWORD:
        raise SystemExit("Missing POSTGRES_HOST or POSTGRES_PASSWORD environment variables")

    conn = psycopg2.connect(
        host=POSTGRES_HOST,
        port=POSTGRES_PORT,
        dbname=POSTGRES_DB,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD,
        sslmode="require",
    )

    conn.autocommit = True

    with conn.cursor() as cur:
        cur.execute("CREATE ROLE poc_data_eng LOGIN PASSWORD 'P0cDataEng!';")
        cur.execute("CREATE ROLE poc_analyst LOGIN PASSWORD 'P0cAnalyst!';")

        cur.execute("GRANT CREATE ON DATABASE iam_poc TO poc_data_eng;")
        cur.execute("GRANT CONNECT ON DATABASE iam_poc TO poc_data_eng, poc_analyst;")

        cur.execute("GRANT USAGE ON SCHEMA public TO poc_data_eng, poc_analyst;")
        cur.execute("GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO poc_data_eng;")
        cur.execute("GRANT SELECT ON ALL TABLES IN SCHEMA public TO poc_analyst;")

        cur.execute("ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO poc_data_eng;")
        cur.execute("ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO poc_analyst;")

    print("PostgreSQL roles and permissions configured successfully")


if __name__ == "__main__":
    main()
