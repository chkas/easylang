# AoC-21 - Day 24: Arithmetic Logic Unit
# 
# Add digits one by one. Then test if at 
# a certain digit value "z" becomes smaller 
# (like at a bad bicycle lock, if it 
# clicks). If not, then try the previous 
# digits again.  
# 
visualization = 1
# 
global cod$[] a1[] a2[] a3[] v[] in[] is_part2 .
func run . .
  v[] = [ 0 0 0 0 ]
  for i range len cod$[]
    v2 = a3[i]
    if a2[i] <> -1
      v2 = v[a2[i]]
    .
    if cod$[i] = "inp"
      if inpos = len in[]
        break 1
      .
      v[a1[i]] = in[inpos]
      inpos += 1
    elif cod$[i] = "add"
      v[a1[i]] += v2
    elif cod$[i] = "mul"
      v[a1[i]] *= v2
    elif cod$[i] = "div"
      v[a1[i]] = v[a1[i]] div v2
    elif cod$[i] = "mod"
      v[a1[i]] = v[a1[i]] mod v2
    elif cod$[i] = "eql"
      v[a1[i]] = if v[a1[i]] = v2
    .
  .
.
background 000
clear
# 
func show . .
  if visualization = 0
    break 1
  .
  for d in in[]
    s$ &= d
  .
  move 8 is_part2 * 35 + 15
  color 000
  rect 100 25
  color 555
  textsize 10
  text s$
  move 8 is_part2 * 35 + 30
  textsize 6
  text "z:" & v[3]
  sleep 0.02
.
func find . .
  in[] = [ ]
  for i range 14
    call run
    min = v[3]
    in[] &= 0
    for d = 1 to 9
      in[i] = d
      call run
      call show
      if v[3] < min / 10
        break 1
      .
    .
    if d = 10
      if is_part2 = 1
        in[i] = 1
      .
      for j range i
        ds = in[j]
        for d = 1 to 9
          in[j] = d
          call run
          call show
          if v[3] < min / 10
            break 2
          .
        .
        in[j] = ds
      .
    .
  .
  if v[3] <> 0
    print "error: z not 0"
  .
  for d in in[]
    write d
  .
  print ""
.
func read . .
  repeat
    in$ = input
    until in$ = ""
    a$[] = strsplit in$ " "
    cod$[] &= a$[0]
    a1[] &= strcode a$[1] - strcode "w"
    if len a$[] > 2
      a3[] &= number a$[2]
      if error = 1
        a2[] &= strcode a$[2] - strcode "w"
      else
        a2[] &= -1
      .
    else
      a2[] &= 0
      a3[] &= 0
    .
  .
.
call read
call find
is_part2 = 1
call find
# 
input_data
inp w
mul x 0
add x z
mod x 26
div z 1
add x 12
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 9
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 12
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 11
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 6
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 6
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 15
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -14
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 12
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 5
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -8
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 7
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 14
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 2
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -9
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 10
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 14
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -6
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 7
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -5
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1
mul y x
add z y





