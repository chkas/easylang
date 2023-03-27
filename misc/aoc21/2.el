# AoC-21 - Day 2: Dive!
#
# Straighforward.
# 
repeat
  s$ = input
  until s$ = ""
  s$[] = strsplit s$ " "
  if s$[1] = "forward"
    horiz += number s$[2]
    depth += aim * number s$[2]
  elif s$[1] = "down"
    aim += number s$[2]
  elif s$[1] = "up"
    aim -= number s$[2]
  .
.
print aim * horiz
print depth * horiz
# 
input_data
forward 5
down 5
forward 8
up 3
down 8
forward 2

