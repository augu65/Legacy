#!Python3
'''
Assignment 4
CIS 3190
Jonah Stegman
'''
import math
import time

def eucluidNR_GCD(x, y):
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

def euclidR_GCD(x, y):
    '''
    The recursive version of euclids gcd algorthm
    '''
    if y == 0:
        return x
    else:
        return euclidR_GCD(y, x % y)

def stein_GCD(x, y):
    '''
    The stein version of gcd
    '''
    if x == y or y == 0:
        return x
    elif x == 0:
        return y
    if ~x & 1: # x is even
        if y & 1: # y is odd
            return stein_GCD(x >> 1, y)
        else: # both x and y are even
            return stein_GCD(x >> 1, y >> 1) << 1
    if (~y & 1): # x is odd, y is even
        return stein_GCD(x, y >> 1)
    # reduce larger parameter
    if (x > y):
        return stein_GCD((x - y) >> 1, y)
    return stein_GCD((y - x) >> 1, x)

def main():
    '''
    The Main function
    '''
    arr = []
    ctr = 1
    fname = input("Please Enter the filename: ")
    with open(fname,'r') as file:
        arr = file.readlines()
    start = time.time()
    for x in arr:
        y = arr[ctr]
        eucluidNR_GCD(int(x.strip()),int( y.strip()))
        ctr += 1
        if ctr >= len(arr):
            break
    print(f"Execution time of EuclidNR_GCD: {time.time() - start} seconds")
    ctr = 1
    start2 = time.time()
    for x in arr:
        y = arr[ctr]
        euclidR_GCD(int(x.strip()),int( y.strip()))
        ctr += 1 
        if ctr >= len(arr):
            break
    print(f"Execution time of EuclidR_GCD: {time.time() - start2} seconds")
    ctr = 1
    start3 = time.time()
    for x in arr:
        y = arr[ctr]
        stein_GCD(int(x.strip()), int(y.strip()))
        ctr += 1
        if ctr >= len(arr):
            break
    print(f"Execution time of Stein_GCD: {time.time() - start3} seconds")

if __name__ == "__main__":
    main()
