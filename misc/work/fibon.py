import time
def fib(n):
	if n < 2: return n
	else: return fib(n - 1) + fib(n - 2)

start = time.time()
print("%d - %.2f" % (fib(35), time.time() - start))





