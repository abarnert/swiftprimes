// Because of rdar://problem/17127940 we cannot use qualified names
// (https://devforums.apple.com/message/976286#976286), but we can still
// use modules, right? Well, no. If you build itertools with -emit-module
// and import it here, the names aren't in the main namespace, and also
// aren't in the itertools namespace, so no matter which way you write
// things you'll get either a compile error or a link error. If you 
// instead try to do what Xcode does and just compile all the source
// files together, you'll get a compiler error because there's
// top-level code in a file that isn't called main.swift in a multi-file
// compile job. (Seriously...) So, this seems like a dead end until they
// fix one of these problems.

//import itertools

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
    let primes = filter(count(start: 2), make_isprime())
    let limited = takewhile(primes, { $0 <= limit })
    let s = " ".join(map(limited, { $0.description }))
    println("\(s)")
} else {
    println("\(C_ARGV[0]) LIMIT")
}
