#!/bin/bash

file="README.md"
response=$(curl --location -g --request GET 'https://marshallku.com/recent?type=post') || exit 5
mapfile -t results < <(echo "$response" | grep -Po '"title":"\K.+?(?=")|"uri":"\K(.+?)(?=")|"date":"\K(.+?)(?=")')

for ((i = 0; i < ${#results[@]}; i += 3)); do
    titles+=("${results[i]}")
    links+=("${results[i + 1]}")
    dates+=("${results[i + 2]}")
done

pattern='<!-- Blog-Post -->'

if [[ ${#titles[@]} -eq 0 || ${#links[@]} -eq 0 || ${#dates[@]} -eq 0 ]]; then
    exit 5
fi

result="$pattern\n\n"
for ((i = 0; i < 5; i++)); do
    formattedDate="$(LANG=en_US date '+%b %-d, %Y' -d "${dates[i]}")"
    result+="- [${titles[i]}](${links[i]}) - ${formattedDate}\n"
done
result+="\n$pattern"

sed -i -e "/$pattern/,/$pattern/c\\$result" $file
