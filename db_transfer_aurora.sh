#!/bin/sh

cd /var/data

start=`date +%s`

pg_dump $STORE_DUMP_URL_HEROKU -f db.dump -F c
pg_restore --verbose --clean --no-acl --no-owner -h $STORE_DB -U postgres -d store_db db.dump
rm db.dump
echo "store complete"

pg_dump $NOTIFICATIONS_DUMP_URL_HEROKU -f db.dump -F c
pg_restore --verbose --clean --no-acl --no-owner -h $NOTIFICATIONS_DB -U postgres -d notifications_db db.dump
rm db.dump
echo "notifications complete"

pg_dump $DESKTOP_API_PROD_DUMP_URL_HEROKU -f db.dump -F c
pg_restore --verbose --clean --no-acl --no-owner -h $DESKTOP_API_DB -U postgres -d desktop_db db.dump
rm db.dump
echo "desktop-api complete"

pg_dump $CONVERSION_PROD_DUMP_URL_HEROKU -f db.dump -F c
pg_restore --verbose --clean --no-acl --no-owner -h $CONVERSION_DB -U postgres -d conversion_db db.dump
rm db.dump
echo "conversion complete"

pg_dump $MARS_MAIN_DUMP_URL_HEROKU -f db.dump -F c
pg_restore --verbose --clean --no-acl --no-owner -h $MARS_MAIN_DB -U postgres -d mars_main db.dump
rm db.dump
echo "mars main complete"

end=`date +%s`

runtime=$((end-start))

echo "it took $runtime to execute this script."
