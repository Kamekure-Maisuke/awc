# awk utils script

BEGIN{ urlencode(ARGV[1]) }

# 対象文字列のURLエンコード
function urlencode(s){
	if(s==""){
		error("変換対象がありません。")
	}
	command="printf " s " | od -tx1 -An"
	command | getline d
	close(command)
	gsub("^ +","",d)
	split(d,da," ")
	for(i=1;i<=length(da);i++){
		if(da[i] ~ /[0-9]{2}/){
			printf da[i]
		}else {
			printf "%%" toupper(da[i])
		}
	}

}

# 対象文字列のURLデコード
function urldecode(s){
	# todo
}

# エラーメッセージ関数
function error(m){
	print(m) > "/dev/stderr"
	exit(1)
}
