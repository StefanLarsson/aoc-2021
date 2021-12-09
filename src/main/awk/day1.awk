BEGIN {
		inc = 0
}
{
		old = current
		current = $0
		if ( NR != 1 && current > old)
				inc++
}
END {
		print inc
}

