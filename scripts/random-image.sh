#!/bin/bash
failed_pattern="FAILED: "

get_imgur_uri() {
    echo "https://i.imgur.com/$1.gif"
}

get_images_from_imgur() {
    local album_id="$1"
    local curl_options=(--location -g --header "Authorization: Client-ID $IMGUR_CLIENT_ID" --request GET)
    local response=$(curl "${curl_options[@]}" "https://api.imgur.com/3/album/$album_id")
    local ids=($(echo "$response" | grep -Po '"id":"(\K[a-zA-Z0-9]+)'))

    if [[ "${#ids[@]}" -eq 0 ]]; then
        echo "$failed_pattern$response"
        return 1
    fi

    echo "${ids[@]/$album_id/}"
}

pick_random() {
    arr=("$@")

    echo ${arr[RANDOM % ${#arr[@]}]}
}

taengoo_array=$(get_images_from_imgur BxrOPIp)
if [[ "$taengoo_array" =~ $failed_pattern ]]; then
    echo "$taengoo_array"
    exit 1
fi

winter_array=$(get_images_from_imgur K6dhwze)
if [[ "$winter_array" =~ $failed_pattern ]]; then
    echo "$winter_array"
    exit 1
fi

taengoo=$(get_imgur_uri $(pick_random ${taengoo_array[@]}))
winter=$(get_imgur_uri $(pick_random ${winter_array[@]}))

now_encoded=$(TZ=Asia/Seoul date +"%Y/%m/%d%%20%H:%M")
now=$(TZ=Asia/Seoul date +"%Y/%m/%d %H:%M")

sed -E -i "s#src=\\\"[^ ]+\\\" alt=\\\"탱구\\\"#src=\\\"$taengoo\\\" alt=\\\"탱구\\\"#g;s#src=\\\"[^ ]+\\\" alt=\\\"윈터\\\"#src=\\\"$winter\\\" alt=\\\"윈터\\\"#g;s#Last%20Modified\-.+%20#Last%20Modified\-$now_encoded%20#g;s#Last Modified - .+? \(KST\)#Last Modified - $now (KST)#g" README.md
