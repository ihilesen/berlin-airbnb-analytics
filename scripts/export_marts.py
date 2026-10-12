# scripts/export_marts.py
# Exports the final dbt tables to CSV for Power BI.
import duckdb
from pathlib import Path

out = Path("dashboard/data")
out.mkdir(parents=True, exist_ok=True)
con = duckdb.connect("warehouse/airbnb.duckdb", read_only=True)
for table in ["dim_hosts", "dim_listings", "fct_reviews"]:
    con.execute(f"copy {table} to '{out}/{table}.csv' (header)")
    print("exported", table)
con.close()