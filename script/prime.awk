BEGIN{
  count=0
  if(ARGV[1] == "" || ARGV[1] > 10000){
	print "引数が0または上限10000を超えています。"
	exit(1)
  }
  for(i=2;i<=ARGV[1];i++){
    for(j=2;j<=i;j++){
      if(i==j){
        print i
		count = count + 1
      }else if(i%j==0){
        break
      }
    }
  }
  printf("素数の数は%d個です\n",count)
}
