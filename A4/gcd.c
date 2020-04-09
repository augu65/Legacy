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
    //variables
    long * arr = (long *)malloc(sizeof(long)*1);
    FILE *fp;
    char num[100];
    int ctr = 0;
    clock_t start, end;
    float cpu_time;
    char fname[100] = "";
    // gets the filename from the user
    printf("welcome to the GCD calclator\n");
    printf("This will calculate the gcd of a 3000 line file in 3 different ways\n");
    printf("All numbers must be on their own line\n");
    printf("calcuates using recursive, non-recursive euclid, and stein\n");
    printf("Enter the filename: ");
    scanf("%s",fname);
    fp = fopen(fname, "r");
    // reads in the file
    while (fgets(num, sizeof(long), fp) != NULL){
        arr = (long *)realloc(arr, sizeof(long)*ctr+1);
        arr[ctr] = atol(num);
        ctr ++;
    }
    fclose(fp);

    //start clock and loop through array for non recusrive euclids gcd
    start = clock();
    for (int i=0; i < ctr-1; i++){
        eucluidNR_GCD(arr[i], arr[i+1]);
    }
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time of euclidNR_GCD: %f seconds\n", cpu_time);

    //start clock and loop through array for recusrive euclids gcd
    start = clock();
    for (int i=0; i < ctr-1; i++){
        euclidR_GCD(arr[i], arr[i+1]);
    }
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time of EuclidR_GCD: %f seconds\n", cpu_time);

    //start clock and loop through array for steins euclids gcd
    start = clock();
    for (int i=0; i < ctr-1; i++){
        stein_GCD(arr[i], arr[i+1]);
    }
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time of Stein_GCD: %f seconds\n", cpu_time);
    return 0;
    }

// the non recursive version of euclid gcd
long eucluidNR_GCD(long x, long y)
{
    long r;
    // checks if y is valid
    if (y == 0){
        return x;
    }
    // calculates gcd
    r = x % y;
    while (r != 0){
        x = y;
        y = r;
        r = x % y;
        }
    return y;
}

//the recursive version of euclids gcd
long euclidR_GCD(long a, long b){
    if (b == 0)
        return a;
    else
        // recusivly calls to calculate gcd
        return euclidR_GCD(b, (a % b));
}

//the stein version of gcd
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