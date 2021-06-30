BEGIN{
	print is_prime(473978)
}

function is_prime(n){
	if(n==1){
		return "素数ではありません"
	}
	count=int(sqrt(n))
	for(i=2;i<=count;i++){
		if(n%i==0){
			return "素数ではありません"
		}
	}
	return "素数です"
}
