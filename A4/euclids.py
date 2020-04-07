'''
Assignment 4
CIS 3190
Jonah Stegman
'''
import math
import time

def gcd(x, y):
    '''
    The non recursive version of euclids gcd algorthm
    '''
    if y == 0:
        return x
    r = x % y
    while r !=0:
        x = y
        y = r
        r = x % y
    return y

def euclids(x, y):
    '''
    The recursive version of euclids gcd algorthm
    '''
    if y == 0:
        return x
    else:
        return euclids (y, x % y)

def stein_gcd(x, y):
    '''
    The stein version of gcd
    '''
    if x == y or y == 0:
        return x
    elif x == 0:
        return y
    if ~x & 1: # x is even
        if y & 1: # y is odd
            return stein_gcd(x >> 1, y)
        else: # both x and y are even
            return stein_gcd(x >> 1, y >> 1) << 1
    if (~y & 1): # x is odd, y is even
        return stein_gcd(x, y >> 1)
    # reduce larger parameter
    if (x > y):
        return stein_gcd((x - y) >> 1, y)
    return stein_gcd((y - x) >> 1, x)

def main():
    '''
    The Main function
    '''
    start = time.time()
    gcd(34964, 13434)
    print(f"Execution Time : {time.time() - start} seconds")
    start2 = time.time()
    euclids(3496, 13)
    print(f"Execution Time : {time.time() - start2} seconds")
    start3 = time.time()
    stein_gcd(3496, 13)
    print(f"Execution Time : {time.time() - start3} seconds")

if __name__ == "__main__":
    main()
