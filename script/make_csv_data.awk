# make csv data

BEGIN{
	if(ARGC<=1){
		print "作成数をしてください。(例:awk -f make_csv_data.awk 10)"
		exit
	}else if(ARGC>2){
		print "引数が多い。"
		exit
	}
	srand()
	print "id,name"
	for(i=1;i<=ARGV[1];i++){
		printf("%d,%s\n",i,random_string(5))
	}
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
