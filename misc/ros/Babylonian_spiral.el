global ptsx[] ptsy[] .
# 
fastproc babylon_spiral nsteps .
   len ptsx[] 2
   len ptsy[] 2
   ptsx[1] = 0
   ptsx[2] = 0
   ptsy[1] = 0
   ptsy[2] = 1
   norm = 1
   lastx = ptsx[$]
   lasty = ptsy[$]
   for k to nsteps - 2
      theta = atan2 lasty lastx
      len candsi[] 0
      len candsj[] 0
      while len candsi[] = 0
         norm += 1
         for i = 0 to nsteps
            a = i * i
            if a > norm div 2 : break 1
            for j = floor sqrt norm + 1 downto 0
               b = j * j
               if a + b < norm : break 1
               if a + b = norm
                  candsi[] &= i
                  candsj[] &= j
               .
            .
         .
      .
      min = 1 / 0
      for i to len candsi[] : for sw to 2
         for sj = -1 step 2 to 1 : for si = -1 step 2 to 1
            hx = si * candsi[i]
            hy = sj * candsj[i]
            if sw = 2 : swap hx hy
            h = (theta - atan2 hy hx) mod 360
            if h < min
               min = h
               lastx = hx
               lasty = hy
            .
         .
      .
      ptsx[] &= ptsx[$] + lastx
      ptsy[] &= ptsy[$] + lasty
   .
.
babylon_spiral 40
for i to len ptsx[]
   write "(" & ptsx[i] & " " & ptsy[i] & ") "
.
babylon_spiral 10000
for i to len ptsx[]
   minx = lower minx ptsx[i]
   maxx = higher maxx ptsx[i]
   miny = lower miny ptsy[i]
   maxy = higher maxy ptsy[i]
.
scx = 100 / (maxx - minx) * 0.96
scy = 100 / (maxy - miny) * 0.96
ty = -miny * scy + 2
tx = -minx * scx + 2
glinewidth 0.1
gline 0 ty 100 ty
gline tx 0 tx 100
gpenup
for i to len ptsx[]
   glineto ptsx[i] * scx + tx, ptsy[i] * scy + ty
.
