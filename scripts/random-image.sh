#!/bin/bash
taengoo_index="$(($RANDOM % 18 + 1))"
winter_index="$(($RANDOM % 23 + 1))"
while IFS= read -r line
do
	if grep -q alt=\"탱구\" <<< $line 
	then
		echo "<img src=\"https://marshallku.github.io/marshallku/assets/images/taengoo$taengoo_index.gif\" alt=\"탱구\" height=\"150\" /><img src=\"https://marshallku.github.io/marshallku/assets/images/winter$winter_index.gif\" alt=\"윈터\" height=\"150\" />"
	else
		echo $line
	fi
done < "./README.md" > "tmp.md"
mv tmp.md ./README.md
