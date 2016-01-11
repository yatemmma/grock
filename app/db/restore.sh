#!/bin/sh

sqlite3 -separator , app/db/development.db ".import app/db/dump_labels.csv labels"
sqlite3 -separator , app/db/development.db ".import app/db/dump_posts.csv  posts"
sqlite3 -separator , app/db/development.db ".import app/db/dump_discs.csv  discs"
sqlite3 -separator , app/db/development.db ".import app/db/dump_videos.csv videos"
sqlite3 -separator , app/db/development.db ".import app/db/dump_bands.csv  bands"
