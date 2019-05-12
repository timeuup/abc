#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/wait.h>
#include<unistd.h>

//logic for bubble sort
void bubbleSort(int arr[], int n, int flag) {
	int i,j;
	for(i=0;i<n-1;i++) {
		for(j=0;j<n-i-1;j++) {
			if(flag == 0 && arr[j]>arr[j+1]) {
				arr[j] = arr[j] + arr[j+1];
				arr[j+1] = arr[j] - arr[j+1];
				arr[j] = arr[j] - arr[j+1];
			} else if(flag == 1 && arr[j]<arr[j+1]) {
				arr[j] = arr[j] + arr[j+1];
				arr[j+1] = arr[j] - arr[j+1];
				arr[j] = arr[j] - arr[j+1];
			}
		}
	}
	
	for(i=0;i<n;i++) {
		printf(" %d ", arr[i]);
	}
}


int main() {
	int arr[10],i,j,n,status;
	
	printf("\n Enter the size ");
	scanf("%d",&n);
	
	printf("\n Enter the array ");
	for(i=0;i<n;i++) {
		scanf("%d",&arr[i]);
	}
	
	//creating the fork process
	pid_t myPid = fork();
	
	if(myPid == 0) {
	
		printf("\nDescending ");
		bubbleSort(arr,n,1);
		
		printf("\n\nIn the child");
		printf("\nchild - %d",getpid());
		printf("\nparent - %d \n",getppid());
		
		exit(0);
	}
	
	else if(myPid > 0) {
		
		//sleep(10);
		//wait(NULL);
		printf("\nparent");
		printf("\nchild - %d",getpid());
		printf("\nparent - %d \n",getppid());
	
		printf("\nAscending ");
		bubbleSort(arr,n,0);
		
		wait(&status);
		printf("\nPrinting wait status- %d \n", WEXITSTATUS(status));
		
	} else {
		printf("\n Not working");
	}
	return 0;
}


