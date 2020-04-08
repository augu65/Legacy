/*
Assignment 4
CIS 3190
Jonah Stegman
*/
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
long eucluidNR_GCD(long x, long y);
long euclidR_GCD(long a, long b);
long stein_GCD(long x, long y);
int main(){
    long * arr = (long *)malloc(sizeof(long)*1);
    FILE *fp;
    char num[100];
    int ctr = 0;
    char fname[100] = "";
    printf("Enter the filename: ");
    scanf("%s",fname);
    fp = fopen(fname, "r");
    while (fgets(num, sizeof(long), fp) != NULL){
        arr = (long *)realloc(arr, sizeof(long)*ctr+1);
        arr[ctr] = atol(num);
        ctr ++;
    }
    fclose(fp)
    clock_t start, end;
    float cpu_time;
    start = clock();
    for (int i=0; i < ctr-1; i++){
        eucluidNR_GCD(arr[i], arr[i+1]);
    }
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time of euclidNR_GCD: %f seconds\n", cpu_time);
    start = clock();
    for (int i=0; i < ctr-1; i++){
        euclidR_GCD(arr[i], arr[i+1]);
    }
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time of EuclidR_GCD: %f seconds\n", cpu_time);
    start = clock();
    for (int i=0; i < ctr-1; i++){
        stein_GCD(arr[i], arr[i+1]);
    }
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time of Stein_GCD: %f seconds\n", cpu_time);
    return 0;
    }

long eucluidNR_GCD(long x, long y)
{
    long r;
    if (y == 0){
        return x;
    }
    r = x % y;
    while (r != 0){
        x = y;
        y = r;
        r = x % y;
        }
    return y;
}

long euclidR_GCD(long a, long b){
    if (b == 0)
        return a;
    else
        return euclidR_GCD(b, (a % b));
}

long stein_GCD(long x, long y)
{
    if (x == y)
        return x;
    if (x == 0)
        return y;
    if (y == 0)
        return x; // look for factors of 2
    if (~x & 1){ // x is even
        if (y & 1) // y is odd
            return stein_GCD(x>>1, y);
        else // both x and y are even
            return stein_GCD(x>>1, y>>1) << 1;
    }
    if (~y & 1) //x is odd, y is even
        return stein_GCD(x, y>>1); 
    // reduce larger parameter
    if (x > y)
        return stein_GCD((x - y)>>1, y);
    return stein_GCD((y - x)>>1, x);
}