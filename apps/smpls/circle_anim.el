n = 8
on animate
   clear
   color 970
   move 50 50
   circle 50
   color 999
   circle 49
   color 970
   for i to n
      y = sin (180 / n * (i + k / 24))
      x = cos (180 / n * (i + k / 24))
      move 50 - x * 49 50 - y * 49
      line 50 + x * 49 50 + y * 49
   .
   color 900
   for i to n
      y = sin (180 / n * (i + k / 24))
      x = cos (180 / n * (i + k / 24))
      d = (k / 2 + 12 * i) mod 196 - 98
      if d > 49
         d = 98 - d
      elif d < -49
         d = -98 - d
      .
      move 50 + x * d 50 + y * d
      circle 1.5
   .
   k += 1
.