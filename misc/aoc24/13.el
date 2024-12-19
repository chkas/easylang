# AoC-24 - Day 13: Claw Contraption
#
proc read inp$ . a b .
   s$[] = strsplit inp$ " "
   a = number substr s$[3] 3 99
   b = number substr s$[4] 3 99
.
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
   read a$ ax ay
   read b$ bx by
   read "x " & p$ prx pry
   return fine 0 0 ax ay bx by prx pry
.
func cost2 a$ b$ p$ .
   read a$ ax ay
   read b$ bx by
   read "x " & p$ prx pry
   #
   f = (by - bx) / (ax - ay)
   prx += 10000000000000
   pry += 10000000000000
   cb = floor (prx / (f * ax + bx)) - 1500
   ca = floor (f * cb)
   return fine ca cb ax ay bx by prx pry
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
