func[] fractran prog$ val limit .
   for s$ in strsplit prog$ " " : n[][] &= number strsplit s$ "/"
   for n to limit
      r[] &= val
      for i to len n[][]
         if val mod n[i][2] = 0 : break 1
      .
      if i > len n[][] : break 1
      val = val / n[i][2] * n[i][1]
   .
   return r[]
.
p$ = "17/91 78/85 19/51 23/38 29/33 77/29 95/23 77/19 1/17 11/13 13/11 15/14 15/2 55/1"
print fractran p$ 2 15
#
proc sort &d[] .
   for i = 1 to len d[] - 1
      for j = i + 1 to len d[]
         if d[j] < d[i] : swap d[j] d[i]
      .
   .
.
r[] = fractran p$ 2 1000
sort r[]
i = 1
prim = 2
po = 4
repeat
   repeat
      if i > len r[] : break 2
      until i > len r[] or r[i] >= po
      i += 1
   .
   until i > len r[]
   if r[i] = po : write prim & " "
   prim += 1
   po *= 2
.
