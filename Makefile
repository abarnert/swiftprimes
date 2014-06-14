all: primes1 primes2 primes3 primes4 primes5 primes6

primes6: primes6.swift itertools.swiftmodule
	xcrun swift $(CFLAGS) $(LDFLAGS) $^

CFLAGS := -I.
LDFLAGS := -L.

%.swiftmodule: %.swift
	xcrun swift -emit-module $(CFLAGS) $(LDFLAGS) $<

%: %.swift
	xcrun swift $(CFLAGS) $(LDFLAGS) $<
