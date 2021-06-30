# make_sample_json

BEGIN{
	if(ARGC<=1){
		print "作成数を指定してください。(例:awk -f make_json_data.awk 10)"
		exit
	} else if(ARGC>2){
		print "引数が多い。"
		exit
	}
	srand()
	printf "["
	for(i=1;i<=ARGV[1];i++){
		printf("%s{\"id\": %d,\"name\": \"%s\"}",separator,i,random_string(10))
		separator=","
	}
	print "]"
}

function random_string(cn,  i,  word){
	if(cn==""){
		print "error"
		exit(1)
	}
	count=split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789",wa,"")
	for(i=1;i<=cn;i++){
		word = word wa[int(rand()*count)]
	}
	return word
}
