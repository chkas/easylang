on animate
   clear
   for c = 0 to 1319
      h = c + tick
      x = sin (6 * h / pi) + sin (3 * h)
      h = c + tick * 2
      y = cos (6 * h / pi) + cos (3 * h)
      move 20 * x + 50 20 * y + 50
      circle 0.5
   .
   tick += 1
.
