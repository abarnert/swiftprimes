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

struct Count: Sequence, Generator {
    var start: Int
    var step: Int
    init(start: Int = 0, step: Int = 1) {
        self.start = start
        self.step = step
    }
    func generate() -> Count {
        return self
    }
    mutating func next() -> Int? {
        let val = start
        start += step
        return val
    }
}

func count(start: Int = 0, step: Int = 1) -> Count { 
    return Count(start: start, step: step)
}

struct Interpose<S: Sequence, T where T == S.GeneratorType.Element>
        : Sequence, Generator {
    typealias Element = T
    let sep: T
    var gen: S.GeneratorType
    var needSep: Bool
    var nextOrNil: T?

    init(separator: T, sequence: S) {
        self.sep = separator
        self.needSep = false
        self.gen = sequence.generate()
        self.nextOrNil = self.gen.next()
    }
    func generate() -> Interpose<S, T> {
        return self
    }
    mutating func next() -> T? {
        if needSep {
            needSep = false
            return sep
        } else {
            let n = nextOrNil
            if n {
                nextOrNil = gen.next()
                needSep = nextOrNil != nil
            }
            return n
        }
    }
}

func interpose<S: Sequence, T where T == S.GeneratorType.Element>
        (separator: T, sequence: S) -> Interpose<S, T> {
    return Interpose(separator: separator, sequence: sequence)
}

struct TakeWhile<S: Sequence, T where T == S.GeneratorType.Element>
        : Sequence, Generator {
    var gen: S.GeneratorType
    let pred: T->Bool
    init(sequence: S, predicate: T->Bool) {
        gen = sequence.generate()
        pred = predicate
    }
    func generate() -> TakeWhile<S, T> {
        return self
    }
    mutating func next() -> T? {
        if let val: T = gen.next() {
            if pred(val) { return val }
        }
        return nil
    }
}

func takewhile<S: Sequence, T where T == S.GeneratorType.Element>
              (sequence: S, predicate: T->Bool) 
              -> TakeWhile<S, T> {
    return TakeWhile(sequence: sequence, predicate: predicate)
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
    let primes = takewhile(filter(count(start: 2), make_isprime()),
                           { $0 <= limit })
    let s = " ".join(map(primes, { $0.description }))
    println("\(s)")
} else {
    println("\(C_ARGV[0]) LIMIT")
}
