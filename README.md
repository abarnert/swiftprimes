swiftprimes
===========

A stupid testbed for playing with Apple's swift language.

After compiling, just "./primes1 100" to get all primes up to 100.

primes1
-------

The implementation comes from http://stackoverflow.com/a/3941967,
mainly as an exercize in porting Python to Swift. Which turns out to
be pretty simple in this case.

The "fun" part is reading argv[1] as an Int, failing if argc != 2 or
argv[1] is not convertible to Int. I expected that to be a one-liner,
but I can't see any way to write a single if statement that checks a
condition and also tries to bind an optional value, or to index an
UnsafePointer and bind only if not NULL, or to index an
UnsafePointer<CString> and get a CString? so the toInt() method will
pass through and return an Int?.  Obviously I need a bit more
research.

primes2
-------

A lazy Sequence seems to be like an iterator in Python--and map and
filter work pretty much the same as in Python. The only trick is that
we want to filter with a closure, but that turns out to be easy.
