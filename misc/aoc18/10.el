# AoC-18 - Day 10: The Stars Align
#
sysconf topleft
repeat
   s$ = input
   until s$ = ""
   s$[] = strtok s$ "<>,"
   x[] &= number s$[2]
   y[] &= number s$[3]
   vx[] &= number s$[5]
   vy[] &= number s$[6]
.
background 000
color 999
#
global xl yl .
proc show .
   clear
   for i to len x[]
      move x[i] - xl + 10 y[i] - yl + 30
      circle 0.5
   .
   sleep 0.1
.
show
repeat
   yl = 1 / 0 ; yh = -1 / 0 ; xl = yl
   for i to len x[]
      x[i] += vx[i]
      y[i] += vy[i]
      xl = lower x[i] xl
      yl = lower y[i] yl
      yh = higher y[i] yh
   .
   sec += 1
   if yh - yl < 500
      show
   .
   s = 0
   for x in x[]
      s += if x = xl
   .
   until s > 5
.
print sec
#
input_data
position=< 9,  1> velocity=< 0,  2>
position=< 7,  0> velocity=<-1,  0>
position=< 3, -2> velocity=<-1,  1>
position=< 6, 10> velocity=<-2, -1>
position=< 2, -4> velocity=< 2,  2>
position=<-6, 10> velocity=< 2, -2>
position=< 1,  8> velocity=< 1, -1>
position=< 1,  7> velocity=< 1,  0>
position=<-3, 11> velocity=< 1, -2>
position=< 7,  6> velocity=<-1, -1>
position=<-2,  3> velocity=< 1,  0>
position=<-4,  3> velocity=< 2,  0>
position=<10, -3> velocity=<-1,  1>
position=< 5, 11> velocity=< 1, -2>
position=< 4,  7> velocity=< 0, -1>
position=< 8, -2> velocity=< 0,  1>
position=<15,  0> velocity=<-2,  0>
position=< 1,  6> velocity=< 1,  0>
position=< 8,  9> velocity=< 0, -1>
position=< 3,  3> velocity=<-1,  1>
position=< 0,  5> velocity=< 0, -1>
position=<-2,  2> velocity=< 2,  0>
position=< 5, -2> velocity=< 1,  2>
position=< 1,  4> velocity=< 2,  1>
position=<-2,  7> velocity=< 2, -2>
position=< 3,  6> velocity=<-1, -1>
position=< 5,  0> velocity=< 1,  0>
position=<-6,  0> velocity=< 2,  0>
position=< 5,  9> velocity=< 1, -2>
position=<14,  7> velocity=<-2,  0>
position=<-3,  6> velocity=< 2, -1>


