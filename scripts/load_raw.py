# scripts/load_raw.py
# Copies the three raw CSV files, untouched, into a DuckDB database.
import duckdb
import sys

source = sys.argv[1] if len(sys.argv) > 1 else "data/raw"
con = duckdb.connect("warehouse/airbnb.duckdb")
con.execute("create schema if not exists raw")

files = {"hosts": "RAW_HOST.csv", "listings": "RAW_LISTING.csv", "reviews": "RAW_REVIEWS.csv"}
for table, file in files.items():
    con.execute(f"""
        create or replace table raw.{table} as
        select * from read_csv('{source}/{file}', header = true, all_varchar = true)
    """)
    count = con.execute(f"select count(*) from raw.{table}").fetchone()[0]
    print(f"raw.{table}: {count:,} rows")