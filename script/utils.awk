# awk utils script

BEGIN{ printf urldecode(urlencode(ARGV[1])) }

# 対象文字列のURLエンコード
function urlencode(s){
	if(s==""){
		error("エンコード対象を指定してください。")
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
	if(s==""){
		error("デコード対象を指定してください。")
	}
	gsub("%","",s)
	gsub("..","\\x&",s)
	l=tolower(s)
	command="printf \"" l "\""
	command | getline result
	close(command)
	return result
}

# エラーメッセージ関数
function error(m){
	print(m) > "/dev/stderr"
	exit(1)
}
