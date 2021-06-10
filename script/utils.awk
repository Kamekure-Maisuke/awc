# awk utils script

BEGIN{ print time_from_gmt("Mon, 01 Feb 2021 11:15:07 GMT") }

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

function time_from_gmt(g){
	if(s=="error"){
		error("not gmt")
	}
	split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",m," ")
	for(i=1;i<=length(m);i++){
		ma[m[i]]=i
	}
	gsub(/:|,/,"",g)
	split(g,ga," ")
	time=sprintf("%04d%02d%02d%06d",ga[4],ma[ga[3]],ga[2],ga[5])
	return time

}

# エラーメッセージ関数
function error(m){
	print(m) > "/dev/stderr"
	exit(1)
}
