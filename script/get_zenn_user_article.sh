#!/bin/sh

# zennのユーザー記事取得RSS
ZENNURL='https://zenn.dev/'

# エラー関数
error_and_usage() {
	echo "usage : ${0##*/} username" 2>&1
	exit 1
}

error_getuser(){
	echo "${0##*/} : ユーザー名が存在しません。" 2>&1
	exit 1
}

# 引数チェック
[ $# -eq 1 ] || error_and_usage

# rssのURL整形
geturl="$ZENNURL/$1/feed"

# apiを叩く。
req=$(curl -s "$geturl")

# user存在チェック
echo $req | grep '<title>見つかりませんでした' >/dev/null
[ $? -eq 1 ] || error_getuser


# 整形して出力
echo $req |
xmllint --format --nocdata - |
grep -e '<title>' -e '<link>' |
awk -F '[<>]' '
BEGIN{
	print "title article"
}
NR>=5{
	if(NR%2){
		ORS=" "
	}else {
		ORS="\n"
	}
	print $3
}'
