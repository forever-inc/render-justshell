#!/bin/sh

cd /var/data

start=`date +%s`

pg_dump $STORE_DUMP_URL -f db.dump -F c
pg_restore -c -O -F c -d $STORE_DB_URL db.dump
rm db.dump
echo "store complete"

pg_dump $NOTIFICATIONS_DUMP_URL -f db.dump -F c
pg_restore -c -O -F c -d $NOTIFICATIONS_DB_URL_RENDER db.dump
rm db.dump
echo "notifications complete"

pg_dump $DESKTOP_API_PROD_DUMP_URL -f db.dump -F c
pg_restore -c -O -F c -d $DESKTOP_API_DB_URL_RENDER db.dump
rm db.dump
echo "desktop-api complete"

pg_dump $CONVERSION_PROD_DUMP_URL -f db.dump -F c
pg_restore -c -O -F c -d $CONVERSION_DB_URL_RENDER db.dump
rm db.dump
echo "conversion complete"

pg_dump $MARS_MAIN_DUMP_URL -f db.dump -F c
pg_restore -c -O -F c -d $MARS_MAIN_DB_URL_RENDER db.dump
rm db.dump
echo "mars complete"

pg_dump $SHARD_1_DUMP -f db.dump -F c
pg_restore -c -O -F c -d $SHARD_1_URL_RENDER db.dump
rm db.dump
echo "shard 1 complete"

pg_dump $SHARD_2_DUMP -f db.dump -F c
pg_restore -c -O -F c -d $SHARD_2_URL_RENDER db.dump
rm db.dump
echo "shard 2 complete"

end=`date +%s`

runtime=$((end-start))

echo "it took $runtime to execute this script."

