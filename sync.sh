#!/bin/sh
cd `dirname "$0"`
git pull
git commit -m "cron update" .
git push
