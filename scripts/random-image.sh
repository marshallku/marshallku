#!/bin/bash
taengoo_array=($(curl --location -g --request GET 'https://api.imgur.com/3/album/BxrOPIp' --header "Authorization: Client-ID $IMGUR_CLIENT_ID" | grep -Eo '"id":"([a-zA-Z0-9]+)"' | grep -Eo [a-zA-Z0-9]\{3,\} ))
winter_array=($(curl --location -g --request GET 'https://api.imgur.com/3/album/K6dhwze' --header "Authorization: Client-ID $IMGUR_CLIENT_ID" | grep -Eo '"id":"([a-zA-Z0-9]+)"' | grep -Eo [a-zA-Z0-9]\{3,\} ))
unset taengoo_array[0]
unset winter_array[0]
taengoo=${taengoo_array[$RANDOM % ${#taengoo_array[@]}]}
winter=${winter_array[$RANDOM % ${#winter_array[@]}]}
now="$(TZ=Asia/Seoul date +"%Y/%m/%d %H:%M" | perl -pe "s/ /%20/g")"
sed -E "s#src=[^ ]+ alt=탱구#src=https://i.imgur.com/$taengoo.gif alt=탱구#g;s#src=[^ ]+ alt=윈터#src=https://i.imgur.com/$winter.gif alt=윈터#g;s#Last%20Modified\-.+%20#Last%20Modified\-$now%20#g" README.md > tmp.md
mv tmp.md ./README.md
