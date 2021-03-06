#!/bin/sh

export LC_ALL=C

NOGI_INFO_URL="https://ja.wikipedia.org/wiki/%E4%B9%83%E6%9C%A8%E5%9D%8246"

error_and_usage(){
	echo "usage : ${0##*/}"
	exit 1
}

[ $# -eq 0 ] || error_and_usage

curl -s "$NOGI_INFO_URL" |
grep -E -B 1 '<td>[ぁ-ん]+ .+</td>' |
sed -e '/--/d' -e 's/<a href=.\{1,\} title=.\{1,\}">//g' |
awk -F '[<>]' '
{
	ORS=(NR%2) ? "\t" : "\n"
	print $3
}'
