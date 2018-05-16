import sys
sys.path.insert(0, 'build/lib.linux-3.7')
import gmpy2
gmpy2.version()

n = gmpy2.mpz('123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')
n
n.is_prime()
(n * n).is_square()
n.digits(62)
q = gmpy2.mpq('12.4')
n + q


import time

def python():
    start = time.time()
    x = 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    for i in range(10000):
        x *= 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    print("python", time.time() - start)


def gmpy():
    start = time.time()
    x = n
    for i in range(10000):
        x *= n
    print("gmpy", time.time() - start)


print("quick warmup")
python()
gmpy()
python()
gmpy()

print("here we go")
python()
gmpy()
