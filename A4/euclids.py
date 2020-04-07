'''
Assignment 4
CIS 3190
Jonah Stegman
'''
import math


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
    val = gcd(34964,13434)
    print(val)
    val = euclids(3496, 13)
    print(val)
    val = stein_gcd(3496, 13)
    print(val)

if __name__ == "__main__":
    main()
