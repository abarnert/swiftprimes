all: primes1 primes2

%: %.swift
	xcrun swift $<
