#!/bin/bash
# Replace IFS to newline for creating array with spaces
# https://stackoverflow.com/a/8822083
IFS=$'\n'

file="README.md"
response=$(curl --location -g --request GET 'https://marshallku.com/recent?type=post') || exit 5
titles=($(echo "$response" | grep -Po '"title":"\K.+?(?=")'))
links=($(echo "$response" | grep -Po '"uri":"\K(.+?)(?=")'))
dates=($(echo "$response" | grep -Po '"date":"\K(.+?)(?=")'))
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
