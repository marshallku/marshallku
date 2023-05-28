#!/bin/bash
failed_pattern="FAILED: "

get_imgur_uri() {
    echo "https://i.imgur.com/$1.gif"
}

get_images_from_imgur() {
    local album_id="$1"
    local curl_options=(--location -g --header "Authorization: Client-ID $IMGUR_CLIENT_ID" --request GET)
    local response
    local ids
    local splitted

    response=$(curl "${curl_options[@]}" "https://api.imgur.com/3/album/$album_id")
    ids=$(echo "$response" | grep -Po '"id":"(\K[a-zA-Z0-9]+)')
    read -ra splitted <<<"$ids"

    if [[ "${#splitted[@]}" -eq 0 ]]; then
        echo "$failed_pattern$response"
        return 1
    fi

    echo "${splitted[@]/$album_id/}"
}

pick_random() {
    local arr=("$@")
    echo "${arr[RANDOM % ${#arr[@]}]}"
}

taengoo_array=$(get_images_from_imgur BxrOPIp)
if [[ "$taengoo_array" =~ $failed_pattern ]] || [[ ${#taengoo_array[@]} -eq 0 ]] || [[ -z "$taengoo_array" ]]; then
    echo 'Failed to get gifs of taengoo'
    echo "$taengoo_array"
    taengoo_array=('Q1CqD0J' 'pnEPoyq' '3K3TIIS' 'PfJXwd8' 'Bra4jgp' 'v0qRJlZ' 'MkFXmbG' 'EPWdCbp' 'a4ULDAi' 'V9FVWI4' 'QmlFeEv' 'DrDv29s' 'btGiSft' 'uHfjdq1' '5QAyQ2R' 'xhFKUS8' 'RJodwb7' '4PTLa7Q' '3QWo299' 'ZKub9pJ' 'HG6JYsC' 'QVvCjSp' '1biEOYk' '6Y399Oe' 'pRXU3ur' 'RthZ3K4' '6RkZXiS' 'PmOa9QF' 'zWZupLu')
fi

winter_array=$(get_images_from_imgur K6dhwze)
if [[ "$winter_array" =~ $failed_pattern ]] || [[ ${#winter_array[@]} -eq 0 ]] || [[ -z "$winter_array" ]]; then
    echo 'Failed to get gifs of winter'
    echo "$winter_array"
    winter_array=('uowBiqV' 'QIDTnem' '1Eu9QAH' 'JLFVKM6' 'S7H6eMc' 'Yb59cPJ' 'y4Rc2c1' 'ShngxA3' 'ejytsux' 'LuvCU0x' 'YR5W2iJ' 'gpxp0Hv' 'IFRL8An' 'LxBdJ5e' 'VrCzF4y' 'd1cL4mu' 'ZRFKavE' 'FFSeD8B' 'kAEoObM' 'RCIDFOf' 'nywAsm4' 'gOdAtJt' 'memWfeI' 'inmu4vG' 'rigXOP7' 'I6723IW' '3jZEMXT' '3BTaWdM' 'fHgBjBz' 'gJmDHbv' 'YHGNA7u')
fi

taengoo=$(get_imgur_uri "$(pick_random "${taengoo_array[@]}")")
winter=$(get_imgur_uri "$(pick_random "${winter_array[@]}")")

now_encoded=$(TZ=Asia/Seoul date +"%Y/%m/%d%%20%H:%M")
now=$(TZ=Asia/Seoul date +"%Y/%m/%d %H:%M")

sed -E -i "s#src=\"[^ ]+\" alt=\"탱구\"#src=\"$taengoo\" alt=\"탱구\"#g;s#src=\"[^ ]+\" alt=\"윈터\"#src=\"$winter\" alt=\"윈터\"#g;s#Last%20Modified\-.+%20#Last%20Modified\-$now_encoded%20#g;s#Last Modified - .+? \(KST\)#Last Modified - $now (KST)#g" README.md
