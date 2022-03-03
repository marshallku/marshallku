#!/bin/bash
function getImgurUri() {
    echo "https://i.imgur.com/$1.gif"
}

function requestApi() {
    curl_options=(--location -g --header "Authorization: Client-ID $IMGUR_CLIENT_ID" --request GET)

    curl "${curl_options[@]}" "https://api.imgur.com/3/album/$1" | grep -Eo '"id":"([a-zA-Z0-9]+)"' | grep -Eo [a-zA-Z0-9]\{3,\}
}

taengoo_array=($(requestApi BxrOPIp))
winter_array=($(requestApi K6dhwze))

taengoo="$(getImgurUri ${taengoo_array[$RANDOM % (${#taengoo_array[@]} - 1) + 1]})"
winter="$(getImgurUri ${winter_array[$RANDOM % (${#winter_array[@]} - 1) + 1]})"

now="$(TZ=Asia/Seoul date +"%Y/%m/%d%%20%H:%M")"

sed -E "s#src=\\\"[^ ]+\\\" alt=\\\"탱구\\\"#src=\\\"$taengoo\\\" alt=\\\"탱구\\\"#g;s#src=\\\"[^ ]+\\\" alt=\\\"윈터\\\"#src=\\\"$winter\\\" alt=\\\"윈터\\\"#g;s#Last%20Modified\-.+%20#Last%20Modified\-$now%20#g" README.md > tmp.md
mv tmp.md ./README.md
