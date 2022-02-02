#!/bin/bash
taengoo_index="$(($RANDOM % 18 + 1))"
winter_index="$(($RANDOM % 23 + 1))"
while IFS= read -r line
do
	if grep -q alt=\"탱구\" <<< $line 
	then
		echo $line | perl -pe "s/taengoo[0-9]+/taengoo$taengoo_index/g and s/winter[0-9]+/winter$winter_index/g"
	else
		echo $line
	fi
done < "./README.md" > "tmp.md"
mv tmp.md ./README.md
