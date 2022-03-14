#!/bin/bash
function getImgurUri() {
    echo "https://i.imgur.com/$1.gif"
}

function getImagesFromImgur() {
    curl_options=(--location -g --header "Authorization: Client-ID $IMGUR_CLIENT_ID" --request GET)
    images=($(curl "${curl_options[@]}" "https://api.imgur.com/3/album/$1" | grep -Eo '"id":"([a-zA-Z0-9]+)"' | grep -Eo [a-zA-Z0-9]\{3,\}))

    echo "${images[@]/$1}"
}

function pickRandom() {
    arr=("$@")

    echo ${arr[RANDOM % ${#arr[@]}]}
}

taengoo_array=$(getImagesFromImgur BxrOPIp)
winter_array=$(getImagesFromImgur K6dhwze)
taengoo=$(getImgurUri $(pickRandom ${taengoo_array[@]}))
winter=$(getImgurUri $(pickRandom ${winter_array[@]}))
now=$(TZ=Asia/Seoul date +"%Y/%m/%d%%20%H:%M")

sed -E -i "s#src=\\\"[^ ]+\\\" alt=\\\"탱구\\\"#src=\\\"$taengoo\\\" alt=\\\"탱구\\\"#g;s#src=\\\"[^ ]+\\\" alt=\\\"윈터\\\"#src=\\\"$winter\\\" alt=\\\"윈터\\\"#g;s#Last%20Modified\-.+%20#Last%20Modified\-$now%20#g" README.md
