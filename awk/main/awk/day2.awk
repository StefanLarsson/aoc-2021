BEGIN {
	hor = 0
	depth = 0
	aim = 0
}
{
	dir = $1
	val = $2
}
part == 1 {

	switch(dir) {
	case "up":
		depth -= val
		break
	case "down":
		depth += val
		break
	case "forward":
		hor += val
		break
   }
}

part == 2 {

	switch(dir) {
	case "up":
		aim -= val
		break
	case "down":
		aim += val
		break
	case "forward":
		hor += val
		depth += aim * val
		break
   }
}
END {
		print hor * depth
}
