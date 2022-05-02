#!/bin/bash
function getImgurUri() {
    echo "https://i.imgur.com/$1.gif"
}

function getImagesFromImgur() {
    curl_options=(--location -g --header "Authorization: Client-ID $IMGUR_CLIENT_ID" --request GET)
    images=($(curl "${curl_options[@]}" "https://api.imgur.com/3/album/$1" | grep -Po '"id":"(\K[a-zA-Z0-9]+)'))|| return 1

    echo "${images[@]/$1}"
}

function pickRandom() {
    arr=("$@")

    echo ${arr[RANDOM % ${#arr[@]}]}
}

taengoo_array=$(getImagesFromImgur BxrOPIp)|| exit 1
winter_array=$(getImagesFromImgur K6dhwze)|| exit 1
taengoo=$(getImgurUri $(pickRandom ${taengoo_array[@]}))
winter=$(getImgurUri $(pickRandom ${winter_array[@]}))
now_encoded=$(TZ=Asia/Seoul date +"%Y/%m/%d%%20%H:%M")
now=$(TZ=Asia/Seoul date +"%Y/%m/%d %H:%M")

sed -E -i "s#src=\\\"[^ ]+\\\" alt=\\\"탱구\\\"#src=\\\"$taengoo\\\" alt=\\\"탱구\\\"#g;s#src=\\\"[^ ]+\\\" alt=\\\"윈터\\\"#src=\\\"$winter\\\" alt=\\\"윈터\\\"#g;s#Last%20Modified\-.+%20#Last%20Modified\-$now_encoded%20#g;s#Last Modified - .+? \(KST\)#Last Modified - $now (KST)#g" README.md
