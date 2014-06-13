#!/usr/bin/env python

def primes(limit):
    prime = [True] * (limit+1)
    prime[0:2] = False, False
    primes = []
    for (i, isprime) in enumerate(prime):
        if isprime:
            primes.append(i)
            for n in range(i*i, limit+1, i):
                prime[n] = False
    return primes

if __name__ == '__main__':
    import sys
    try:
        limit = int(sys.argv[1])
    except:
        print("{} LIMIT".format(sys.argv[0]))
    else:
        print(' '.join(map(str, primes(limit))))
