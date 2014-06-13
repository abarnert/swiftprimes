func primes(limit: Int) -> Int[] {
    var prime = Array(count: limit+1, repeatedValue: true)
    prime[0...1] = [false, false]
    var primes = Int[]()
    for (i, isprime) in enumerate(prime) {
        if isprime {
	    primes.append(i)
	    for var n=i*i; n<=limit; n+=i {
	        prime[n] = false
	    }
	}
    }
    return primes
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
    let result = " ".join(map(primes(limit)) { 
        (var number) -> String in return number.description
    })
    println("\(result)")
} else {
    println("\(C_ARGV[0]) LIMIT")
}
