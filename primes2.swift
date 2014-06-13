//func upto<T, U where T: Sequence, U: T.GeneratorType.Element: Comparable>(seq, limit): 

func make_isprime() -> (Int -> Bool) {
    var memo = Int[]()
    func isprime(n: Int) -> Bool {
        for prime in memo {
            if n % prime == 0 { return false }
	}
        memo.append(n)
        return true
    }
    return isprime
}

func intifyarg1() -> Int? {
    if C_ARGC == 2 {
        let limitstr = String.fromCString(C_ARGV[1])
	if let limit = limitstr.toInt() {
	    return limit
        }
    }
    return nil
}

if let limit = intifyarg1() {
    let isprime = make_isprime()
    for prime in filter(2...limit, make_isprime()) {
	print("\(prime) ")
    }
    println("")
} else {
    println("primes LIMIT")
}
