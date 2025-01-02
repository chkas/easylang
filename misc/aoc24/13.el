# AoC-24 - Day 13: Claw Contraption
#
func fine ca cb ax ay bx by prx pry .
   sgn = sign (ax / ay - bx / by)
   repeat
      x = ca * ax + cb * bx
      y = ca * ay + cb * by
      until x >= prx or y >= pry
      if x / y * sgn < prx / pry * sgn
         ca += 1
      else
         cb += 1
      .
   .
   if x = prx and y = pry : return 3 * ca + cb
   return 0
.
func cost1 a$ b$ p$ .
   a[] = number strtok a$ " +"
   b[] = number strtok b$ " +"
   p[] = number strtok p$ " ="
   return fine 0 0 a[1] a[2] b[1] b[2] p[1] p[2]
.
func cost2 a$ b$ p$ .
   a[] = number strtok a$ " +"
   b[] = number strtok b$ " +"
   p[] = number strtok p$ " ="
   #
   f = (b[2] - b[1]) / (a[1] - a[2])
   p[1] += 10000000000000
   p[2] += 10000000000000
   cb = floor (p[1] / (f * a[1] + b[1])) - 1500
   ca = floor (f * cb)
   return fine ca cb a[1] a[2] b[1] b[2] p[1] p[2]
.
repeat
   a$ = input
   until a$ = ""
   b$ = input
   p$ = input
   sum1 += cost1 a$ b$ p$
   sum2 += cost2 a$ b$ p$
   a$ = input
.
print sum1
print sum2
#
input_data
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
