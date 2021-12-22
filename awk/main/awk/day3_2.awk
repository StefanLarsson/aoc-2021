#! /usr/bin/awk -f
{
		l = length($0)
		for (i = 1; i <=l ; i++)
		{
			c = substr($0, i, 1)
			input[NR,i] = c
		}
		inputs[NR] = $0
		inputs2[NR] = $0
}

function oxygenfilter(idx, values)
{
		count = 0
		onecount = 0
		for (lineno in values) {
				c = substr(values[lineno], idx, 1)
				if (c == "1")
						onecount++
				count++
		}
		for (lineno in values) {
				c = substr(values[lineno], idx, 1)
				if( (2 * onecount >= count && c == "0") || (2 * onecount < count && c == "1")) {
						delete values[lineno]
				}
	}
}

function co2filter(idx, values)
{
		count = 0
		onecount = 0
		for (lineno in values) {
				c = substr(values[lineno], idx, 1)
				if (c == "1")
						onecount++
				count++
		}
		for (lineno in values) {
				c = substr(values[lineno], idx, 1)
				if( (2 * onecount >= count && c == "1") || (2 * onecount < count && c == "0")) {
						delete values[lineno]
				}
				else {
						print values[lineno]
				}
	}
}
function parsebinary(s) {
		res = 0
		for (i = 1; i <= length(s); i++){
				res = 2 * res
				if (substr(s, i, 1) == "1")
						res = res + 1
		}
		return res
}


END {
		filteridx = 1
		while(length(inputs) > 1) {
				oxygenfilter(filteridx, inputs)
				printf "Filterd on %d\n", filteridx
				filteridx++
		}
		filteridx = 1
		while(length(inputs2) > 1) {
				co2filter(filteridx, inputs2)
				printf "Filterd on %d\n", filteridx
				filteridx++
		}
		product = 1

		for (linenum in inputs) {
				print linenum
				print inputs[linenum]
				x = parsebinary(inputs[linenum])
				product *= x
				print x
				print product
		}
		for (linenum in inputs2) {
				print linenum
				print inputs2[linenum]
				y = parsebinary(inputs2[linenum])
				print y
				product *= y
				print product
		}

		print product
}
