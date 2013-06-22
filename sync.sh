#!/bin/sh
cd `dirname "$0"`
git pull
git add .
git commit -m "cron update" .
git push
