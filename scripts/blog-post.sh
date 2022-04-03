#!/bin/bash
# Replace IFS to newline for creating array with spaces
# https://stackoverflow.com/a/8822083
IFS=$'\n'

response=$(curl --location -g --request GET 'https://marshallku.com/recent?type=post')
titles=(`echo $response | grep -Po '"title":"\K.+?(?=")'`)
links=(`echo $response | grep -Po '"uri":"\K(.+?)(?=")'`)
dates=(`echo $response | grep -Po '"dateFormat":"\K(.+?)(?=")'`)

result="<!-- Blog-Post -->\n\n"

for i in {0..4}
do
    result+="-   [${titles[i]}](${links[i]})\n"
done

result+="\n<!-- Blog-Post -->"

sed -E -z -i "s#<!-- Blog-Post -->.+?<!-- Blog-Post -->#$result#g" README.md
