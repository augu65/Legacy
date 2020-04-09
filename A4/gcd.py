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
    # ensures that y is valid
    if y == 0:
        return x
    # calculates gcd
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
        # recursivly calls itselt till gcd is calculated
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
    print("welcome to the GCD calclator\n")
    print("This will calculate the gcd of a 3000 line file in 3 different ways")
    print("All numbers must be on their own line")
    print("calcuates using recursive, non-recursive euclid, and stein")
    # gets user input for filename
    fname = input("Please Enter the filename: ")
    with open(fname,'r') as file:
        arr = file.readlines()
    # starts timer 
    start = time.time()
    # loops through array and runs the non recursive euclid gcd function
    for x in arr:
        y = arr[ctr]
        eucluidNR_GCD(int(x.strip()),int( y.strip()))
        ctr += 1
        if ctr >= len(arr):
            break
    print(f"Execution time of EuclidNR_GCD: {time.time() - start} seconds")
    ctr = 1
    # starts timer
    start2 = time.time()
    # loops through array and runs the recursive euclid gcd function
    for x in arr:
        y = arr[ctr]
        euclidR_GCD(int(x.strip()),int( y.strip()))
        ctr += 1 
        if ctr >= len(arr):
            break
    print(f"Execution time of EuclidR_GCD: {time.time() - start2} seconds")
    ctr = 1
    # starts timer
    start3 = time.time()
    # loops through array and runs the stein gcd function
    for x in arr:
        y = arr[ctr]
        stein_GCD(int(x.strip()), int(y.strip()))
        ctr += 1
        if ctr >= len(arr):
            break
    print(f"Execution time of Stein_GCD: {time.time() - start3} seconds")

if __name__ == "__main__":
    main()
