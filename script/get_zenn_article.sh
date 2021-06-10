#!/bin/sh

export LC_ALL=C

# variable
ZENNURL='https://zenn.dev'

# error message function
error_and_usage() {
	echo "usage : ${0##*/} username" 2>&1
	exit 1
}
error_getuser(){
	echo "${0##*/} : not found username" 2>&1
	exit 1
}

# reponse format xml
reponse_xml_format(){
	xmllint --format --nocdata -	|
	grep -e '<title>' -e '<link>' -e '<pubDate>'	|
	sed '1,4d' |
	awk -F '[<>]' '
	BEGIN{
		split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",m," ")
		for(i=1;i<=length(m);i++){
			ma[m[i]]=i
		}
	}
	{
		if(NR%3){
			ORS="\t"
		}else {
			gsub(/:/,"",$3)
			split($3,da," ")
			$3=sprintf("%04d/%02d/%02d/%06d",da[4],ma[da[3]],da[2],da[5])
			ORS="\n"
		}
		print $3
	}
	'
}

# check argment
[ $# -eq 1 ] || error_and_usage

# get trend article
[ "$1" = "-t" ] && {
	curl -s "$ZENNURL/feed" | reponse_xml_format
	exit
}

# request url
req=$(curl -s "$ZENNURL/$1/feed")

# check username
echo $req | grep '<title>見つかりませんでした' >/dev/null
[ $? -eq 1 ] || error_getuser

# result
echo $req | reponse_xml_format
exit
