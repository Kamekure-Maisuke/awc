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
	random_string="LC_ALL=C tr -dc '[:alnum:]' </dev/urandom | head -c 5"  # ランダム文字列生成
	for(i=1;i<=ARGV[1];i++){
		random_string | getline name  # ランダム生成結果をnameへ格納
		close(random_string)          # メモリ枯渇防止のため。
		score=rand()*1000             # ランダムスコア
		printf("{\"id\": %d,\"name\": %s,\"score\":%d}\n",i,name,score)
	}
}
