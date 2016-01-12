#!/bin/sh

URL=`heroku config | grep DATABASE_URL | awk '{print $2;}'`
psql $URL -c "\copy (SELECT * FROM labels) TO app/db/dump_labels.csv CSV DELIMITER ','"
psql $URL -c "\copy (SELECT * FROM bands)  TO app/db/dump_bands.csv  CSV DELIMITER ','"
psql $URL -c "\copy (SELECT * FROM posts)  TO app/db/dump_posts.csv  CSV DELIMITER ','"
psql $URL -c "\copy (SELECT * FROM discs)  TO app/db/dump_discs.csv  CSV DELIMITER ','"
psql $URL -c "\copy (SELECT * FROM videos) TO app/db/dump_videos.csv CSV DELIMITER ','"
