# awk utils script

BEGIN{ printf urlencode(ARGV[1]) }

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
	result=""
	for(i=1;i<=length(da);i++){
		if(da[i] ~ /[0-9]{2}/){
			result=result""da[i]
		}else {
			result=result "" "%%" toupper(da[i])
		}
	}
	return result
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
