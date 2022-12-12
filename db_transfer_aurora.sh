#!/bin/sh

cd /var/data

start=`date +%s`

pg_dump $STORE_DUMP_URL_HEROKU -f db.dump -F c
pg_restore -c -O -F c -d $AURORA_STORE_URL db.dump
rm db.dump
echo "store complete"

pg_dump $NOTIFICATIONS_DUMP_URL_HEROKU -f db.dump -F c
pg_restore -c -O -F c -d $AURORA_NOTIFICATIONS_URL db.dump
rm db.dump
echo "notifications complete"

pg_dump $DESKTOP_API_PROD_DUMP_URL_HEROKU -f db.dump -F c
pg_restore -c -O -F c -d $AURORA_DESKTOP_API_URL db.dump
rm db.dump
echo "desktop-api complete"

pg_dump $CONVERSION_PROD_DUMP_URL_HEROKU -f db.dump -F c
pg_restore -c -O -F c -d $AURORA_CONVERSION_URL db.dump
rm db.dump
echo "conversion complete"

pg_dump $MARS_MAIN_DUMP_URL_HEROKU -f db.dump -F c
pg_restore -c -O -F c -d $AURORA_MARS_MAIN_URL db.dump
rm db.dump
echo "mars main complete"

end=`date +%s`

runtime=$((end-start))

echo "it took $runtime to execute this script."
