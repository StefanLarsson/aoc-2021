BEGIN {
	x = 0
}
{
		l = length($0)
		for (i = 1; i <=l ; i++)
		{
			c = substr($0, i, 1)
			if (c == "1") {
				counts[i] = counts[i] + 1
		    }
		}
}	
END {
		alpha = 0
		epsilon = 0
		for ( idx in counts) {
				if (2 * counts[idx] >  NR) {
						alpha = 2*alpha + 1
						epsilon = 2 * epsilon
				} else {
						alpha = 2 * alpha
						epsilon = 2 * epsilon + 1
				}
		}

		print alpha * epsilon
}
