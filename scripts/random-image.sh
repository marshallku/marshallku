#!/bin/bash
function getImgurUri() {
    echo "https://i.imgur.com/$1.gif"
}

curl_options=(--location -g --header "Authorization: Client-ID $IMGUR_CLIENT_ID" --request GET)
taengoo_array=($(curl "${curl_options[@]}" 'https://api.imgur.com/3/album/BxrOPIp' | grep -Eo '"id":"([a-zA-Z0-9]+)"' | grep -Eo [a-zA-Z0-9]\{3,\}))
winter_array=($(curl "${curl_options[@]}" 'https://api.imgur.com/3/album/K6dhwze' | grep -Eo '"id":"([a-zA-Z0-9]+)"' | grep -Eo [a-zA-Z0-9]\{3,\}))
taengoo="$(getImgurUri ${taengoo_array[$RANDOM % (${#taengoo_array[@]} - 1) + 1]})"
winter="$(getImgurUri ${winter_array[$RANDOM % (${#winter_array[@]} - 1) + 1]})"
now="$(TZ=Asia/Seoul date +"%Y/%m/%d %H:%M" | perl -pe "s/ /%20/g")"
sed -E "s#src=\\\"[^ ]+\\\" alt=\\\"탱구\\\"#src=\\\"$taengoo\\\" alt=\\\"탱구\\\"#g;s#src=\\\"[^ ]+\\\" alt=\\\"윈터\\\"#src=\\\"$winter\\\" alt=\\\"윈터\\\"#g;s#Last%20Modified\-.+%20#Last%20Modified\-$now%20#g" README.md > tmp.md
mv tmp.md ./README.md
