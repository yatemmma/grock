#!/bin/sh

URL=`heroku config | grep DATABASE_URL | awk '{print $2;}'`
psql $URL -c "\copy labels from app/db/dump_labels.csv WITH CSV"
psql $URL -c "\copy bands from app/db/dump_bands.csv WITH CSV"
psql $URL -c "\copy posts from app/db/dump_posts.csv WITH CSV"
psql $URL -c "\copy discs from app/db/dump_discs.csv WITH CSV"
psql $URL -c "\copy videos from app/db/dump_videos.csv WITH CSV"
