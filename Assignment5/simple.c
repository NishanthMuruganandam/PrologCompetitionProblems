#include<stdio.h>

int main(){

	int i = 1;
	int x;
	scanf("%d",&x);
	while(x-- >= 0){
		printf("%d\n",i);
		i = i<<1;
	}
	return 0;
}
