m2 = 1
m3 = 1
for o = 1 to 1000000
   if m2 < m3
      m = m2
   else
      m = m3
   .
   klarner_rado[] &= m
   if m2 = m
      i2 += 1
      m2 = klarner_rado[i2] * 2 + 1
   .
   if m3 = m
      i3 += 1
      m3 = klarner_rado[i3] * 3 + 1
   .
.
for i = 1 to 100
   write klarner_rado[i] & " "
.
print ""
print ""
i = 1000
while i < o
   write klarner_rado[i] & " "
   i *= 10
.
