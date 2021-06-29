# awk utils script

BEGIN{ print urldecode(ARGV[1]) }

# 対象文字列のURLエンコード
function urlencode(s){
	if(s==""){
		error("エンコード対象を指定してください。")
	}
	command="printf " s " | od -tx1 -An | xargs"
	command | getline d
	close(command)
	split(d,da," ")
	result=""
	for(i=1;i<=length(da);i++){
		if(da[i] ~ /[0-9]{2}/){
			result=result""da[i]
		}else {
			result=result "" "%" toupper(da[i])
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

# GMT形式を数字時間に変更
function time_from_gmt(g){
	if(g==""){
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

# ランダム文字列生成
function random_string(cn,  i,  n,  word){
  if(cn == ""){
    print "error"
    exit
  }
  w="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXXYZ123456789"
  count=split(w,a,"")
  for(i=1;i<=cn;i++){
    n=int(rand()*count)
    word = word a[n]
  }
  return word
}

# エラーメッセージ関数
function error(m){
	print(m) > "/dev/stderr"
	exit(1)
}
