psql -f /takeon-db/tables.sql
psql -d validationdb -c "CREATE USER gnvxkjistfbuttjzzkwl WITH PASSWORD z76zt6fr8wyqq6pgskdv;"
psql -d validationdb -c "GRANT USAGE ON SCHEMA dev01 TO gnvxkjistfbuttjzzkwl;"
psql -d validationdb -c "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA dev01 TO gnvxkjistfbuttjzzkwl;"
psql -f /takeon-db/edge_case.sql;
