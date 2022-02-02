#!/bin/bash
taengoo_index="$(($RANDOM % 18 + 1))"
winter_index="$(($RANDOM % 23 + 1))"
now="$(echo $(TZ=Asia/Seoul date +"%Y/%m/%d %H:%M") | perl -pe "s/ /%20/g")"
while IFS= read -r line
do
	if grep -q alt=\"탱구\" <<< $line 
	then
		echo $line | perl -pe "s/taengoo[0-9]+/taengoo$taengoo_index/g and s/winter[0-9]+/winter$winter_index/g"
	elif grep -q "Last Modified" <<< $line
	then
		echo "![Last Modified](<https://img.shields.io/badge/Last%20Modified-$now%20(KST)-%23121212?style=flat>)"
	else
		echo $line
	fi
done < "./README.md" > "tmp.md"
mv tmp.md ./README.md
