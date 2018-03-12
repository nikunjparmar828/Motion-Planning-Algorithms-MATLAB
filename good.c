#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int fun()
{
	int T,N,minX,maxX,k=0;
	
	scanf("%d",&T);
	
	while(T--)
	{	
		int i =0,j,h,final=0,even=0,odd=0;
		scanf("%d %d %d",&N,&minX,&maxX);
		
		int *w = malloc( 2*N*sizeof(int) );
		
		for(h=0;h<N*2;++h)
		{
			scanf("%d",&w[h]);
		}
		
		for(final = minX;final<=maxX;++final)
		{	
			j = final;
			k=0;
			for(i=0;i<N;++i)
			{
				j = j*w[k] + w[k+1];
				k+=2;
			}
			if(j%2 == 0){even++;}
			else{odd++;}
		
		}
		free(w);
	printf("%d %d\n",even,odd);
	}
	
	return 0;
}

int main(){
	clock_t t;
    t = clock();
    fun();
    t = clock() - t;
    double time_taken = ((double)t)/CLOCKS_PER_SEC); // in seconds
 
    printf("fun() took %f seconds to execute \n", time_taken);
    return 0;
	
}
