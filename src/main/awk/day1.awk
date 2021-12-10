BEGIN {
		inc = 0
		idx = 0
		window=1
}
{
		oldsum = sum
		sum = sum - values[idx]
		values[idx] = $0
		sum = sum + $0
		idx = (idx + 1 ) % window
		if ( NR > window && sum > oldsum)
				inc++
}
END {
		print inc
}

