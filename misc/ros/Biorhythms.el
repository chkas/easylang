birth$ = "1943-03-09"
date$ = "1972-07-11"
# date$ = substr timestr systime 1 10
# 
func day d$ .
   y = number substr d$ 1 4
   m = number substr d$ 6 2
   d = number substr d$ 9 2
   return 367 * y - 7 * (y + (m + 9) div 12) div 4 + 275 * m div 9 + d - 730530
.
gtextsize 4
func init b$ d$ .
   glinewidth 0.2
   gline 50 0 50 100
   gline 0 50 100 50
   for d = -20 to 20
      gcircle x 50 0.5
      x += 2.5
   .
   gtext 4 94 b$
   gtext 4 88 d$
   days = day date$ - day birth$
   gtext 4 80 days & " days"
   return days
.
proc cycle now cyc t$ col .
   gcolor col
   gtext 4 cyc * 1.2 - 20 t$
   glinewidth 0.5
   gpenup
   for d = now - 20 to now + 20
      y = 50 + 20 * sin (360 * d / cyc)
      glineto x y
      x += 2.5
   .
.
days = init birth$ date$
cycle days 23 "Physical" 900
cycle days 28 "Emotional" 090
cycle days 33 "Intellectual" 009
