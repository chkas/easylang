proc solve c1[] c2[] c3[] s1 s2 s3 &r[] .
   len r[] 3
   x1 = c1[1] ; y1 = c1[2] ; r1 = c1[3]
   x2 = c2[1] ; y2 = c2[2] ; r2 = c2[3]
   x3 = c3[1] ; y3 = c3[2] ; r3 = c3[3]
   # 
   v11 = 2 * x2 - 2 * x1
   v12 = 2 * y2 - 2 * y1
   v13 = x1 * x1 - x2 * x2 + y1 * y1 - y2 * y2 - r1 * r1 + r2 * r2
   v14 = 2 * s2 * r2 - 2 * s1 * r1
   v21 = 2 * x3 - 2 * x2
   v22 = 2 * y3 - 2 * y2
   v23 = x2 * x2 - x3 * x3 + y2 * y2 - y3 * y3 - r2 * r2 + r3 * r3
   v24 = 2 * s3 * r3 - 2 * s2 * r2
   w12 = v12 / v11
   w13 = v13 / v11
   w14 = v14 / v11
   w22 = v22 / v21 - w12
   w23 = v23 / v21 - w13
   w24 = v24 / v21 - w14
   P = -w23 / w22
   Q = w24 / w22
   M = -w12 * P - w13
   N = w14 - w12 * Q
   a = N * N + Q * Q - 1
   b = 2 * M * N - 2 * N * x1 + 2 * P * Q - 2 * Q * y1 + 2 * s1 * r1
   c = x1 * x1 + M * M - 2 * M * x1 + P * P + y1 * y1 - 2 * P * y1 - r1 * r1
   # 
   D = b * b - 4 * a * c
   rs = (-b - sqrt D) / (2 * a)
   r[1] = M + N * rs
   r[2] = P + Q * rs
   r[3] = rs
.
c1[] = [ 0 0 1 ]
c2[] = [ 4 0 1 ]
c3[] = [ 2 4 2 ]
solve c1[] c2[] c3[] 1 1 1 r1[]
print r1[]
solve c1[] c2[] c3[] -1 -1 -1 r2[]
print r2[]
# 
proc circ x0 y0 r .
   gpenup
   for a = 0 to 360
      x = x0 + sin a * r
      y = y0 + cos a * r
      glineto x y
   .
.
proc draw col c[] .
   gcolor col
   circ c[1] * 10 + 30 c[2] * 10 + 30 c[3] * 10
.
gbackground 888
gclear
glinewidth 0.5
gcolor 000
drawgrid
gline 30 0 30 100
gline 0 30 100 30
draw 000 c1[]
draw 000 c2[]
draw 000 c3[]
sleep 0.5
draw 070 r1[]
sleep 0.5
draw 700 r2[]
