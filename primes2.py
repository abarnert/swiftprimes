#!/usr/bin/env python
    
def make_isprime():
    memo = []
    def isprime(n):
        for prime in memo:
            if not n % prime: return False
        memo.append(n)
        return True
    return isprime

if __name__ == '__main__':
    import sys
    try:
        limit = int(sys.argv[1])
    except:
        print("{} LIMIT".format(sys.argv[0]))
    else:
        primes = filter(make_isprime(), range(2, limit+1))
        print(' '.join(map(str, primes)))
