def fib(n):
	# if n<= 0: return []
	# elif n == 1: return [1]
	# elif n == 2: return [1,1]
	# result = [1,1]
	# for i in xrange(2,n):
	# 	seq.append(seq[i-1] + seq[i-2])
	# return result

	seq = []
	for i in range(n):
		if i < 2:
			seq.append(1)
		else:
			seq.append(seq[i-1] + seq[i-2])
	return seq
	
