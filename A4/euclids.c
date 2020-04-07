/*
Assignment 4
CIS 3190
Jonah Stegman
*/
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
int gcd(long x, long y);
int euclid(long a, long b);
int stein_gcd(long x, long y);
int main(){
    clock_t start, end;
    double cpu_time;
    start = clock();
    gcd (3496,13);
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time: %f seconds\n", cpu_time);
    start = clock();
    euclid (3496,13);
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time: %f seconds\n", cpu_time);
    start = clock();
    stein_gcd (3496,13);
    end = clock();
    cpu_time = ((double)(end - start) / CLOCKS_PER_SEC);
    printf("Execution time: %f seconds\n", cpu_time);
    return 0;
}

int gcd(long x, long y){ 
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

int euclid(long a, long b){
    if (b == 0)
        return a;
    else
        return euclid(b, (a%b));
}

int stein_gcd(long x, long y){ 
    if (x == y)
        return x;
    if (x == 0)
        return y;
    if (y == 0)
        return x; // look for factors of 2
    if (~x & 1){ // x is even
        if (y & 1) // y is odd
            return stein_gcd(x>>1, y);
        else // both x and y are even
            return stein_gcd(x>>1, y>>1) << 1;
    }
    if (~y & 1) //x is odd, y is even
        return stein_gcd(x, y>>1); 
    // reduce larger parameter
    if (x > y)
        return stein_gcd((x - y)>>1, y);
    return stein_gcd((y - x)>>1, x);
}