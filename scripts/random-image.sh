#!/bin/bash
taengoo_index="$(($RANDOM % 18 + 1))"
winter_index="$(($RANDOM % 23 + 1))"
now="$((TZ=Asia/Seoul date +"%Y/%m/%d %H:%M") | perl -pe "s/ /%20/g")"
sed -E "s/taengoo[0-9]+/taengoo$taengoo_index/g;s/winter[0-9]+/winter$winter_index/g;s#Last%20Modified\-.+%20#Last%20Modified\-$now%20#g" README.md > tmp.md
mv tmp.md ./README.md
