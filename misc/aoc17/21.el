# AoC-17 - Day 21: Fractal Art
# 
func inarr s$ i d . f[] .
   len f[] d * d
   arrbase f[] 0
   for y range0 d
      for x range0 d
         f[x + d * y] = if substr s$ i 1 = "#"
         i += 1
      .
      i += 1
   .
.
func val . f[] v .
   v = 0
   for f in f[]
      v = v * 2 + f
   .
.
func rotate . f[] .
   len fp[] len f[]
   swap f[] fp[]
   arrbase f[] 0
   d = sqrt len f[]
   for x range0 d
      for y range0 d
         f[d - 1 - y + d * x] = fp[x + d * y]
      .
   .
.
func mirror . f[] .
   len fp[] len f[]
   swap f[] fp[]
   arrbase f[] 0
   d = sqrt len f[]
   for x range0 d
      for y range0 d
         f[d - 1 - x + d * y] = fp[x + d * y]
      .
   .
.
len r2[][] 16
len r3[][] 512
arrbase r2[][] 0
arrbase r3[][] 0
# 
func read_rules . .
   repeat
      s$ = input
      until len s$ > 20
      call inarr s$ 1 2 f[]
      call inarr s$ 10 3 out[]
      for flip range0 2
         for rot range0 4
            call val f[] idx
            r2[idx][] = out[]
            call rotate f[]
         .
         call mirror f[]
      .
   .
   repeat
      call inarr s$ 1 3 f[]
      call inarr s$ 16 4 out[]
      for flip range0 2
         for rot range0 4
            call val f[] idx
            r3[idx][] = out[]
            call rotate f[]
         .
         call mirror f[]
      .
      s$ = input
      until s$ = ""
   .
.
call read_rules
# 
img[] = [ 0 1 0 0 0 1 1 1 1 ]
arrbase img[] 0
nc = 3
# 
func show . .
   d = sqrt len img[]
   for y range0 d
      for x range0 d
         if img[x + y * d] = 1
            write "#"
         else
            write "."
         .
      .
      print ""
   .
   print ""
.
func val_img r c d . v .
   i = r * d * nc + c * d
   v = 0
   for _ range0 d
      for _ range0 d
         v = v * 2 + img[i]
         i += 1
      .
      i += nc - d
   .
.
func ins_img r c d . ins[] .
   arrbase ins[] 0
   i = r * d * nc + c * d
   for _ range0 d
      for _ range0 d
         img[i] = ins[ii]
         i += 1
         ii += 1
      .
      i += nc - d
   .
.
func expand . .
   if nc mod 2 = 0
      ex = 2
   else
      ex = 3
   .
   nr = nc / ex
   arrbase ids[] 0
   for r range0 nr
      for c range0 nr
         call val_img r c ex v
         ids[] &= v
      .
   .
   ex += 1
   nc = nr * ex
   img[] = [ ]
   len img[] nc * nc
   arrbase img[] 0
   for r range0 nr
      for c range0 nr
         if ex = 4
            r[] = r3[ids[r * nr + c]][]
         else
            r[] = r2[ids[r * nr + c]][]
         .
         call ins_img r c ex r[]
      .
   .
.
if len r2[0][] = 0
   call show
   for i to 2
      call expand
      call show
   .
else
   for i to 18
      call expand
      if i = 5 or i = 18
         sum = 0
         for v in img[]
            sum += v
         .
         print sum
      .
   .
.
# 
# 
input_data
../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#

