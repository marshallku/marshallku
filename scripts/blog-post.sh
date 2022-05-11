#!/bin/bash
# Replace IFS to newline for creating array with spaces
# https://stackoverflow.com/a/8822083
IFS=$'\n'

response=$(curl --location -g --request GET 'https://marshallku.com/recent?type=post')|| exit 1
titles=(`echo $response | grep -Po '"title":"\K.+?(?=")'`)
links=(`echo $response | grep -Po '"uri":"\K(.+?)(?=")'`)
dates=(`echo $response | grep -Po '"date":"\K(.+?)(?=")'`)

result="<!-- Blog-Post -->\n\n"

for i in {0..4}
do
    formattedDate="$(LANG=en_US date '+%b %-d, %Y' -d "${dates[i]}")"
    result+="-   [${titles[i]}](${links[i]}) - ${formattedDate}\n"
done

result+="\n<!-- Blog-Post -->"

sed -E -z -i "s#<!-- Blog-Post -->.+?<!-- Blog-Post -->#$result#g" README.md
