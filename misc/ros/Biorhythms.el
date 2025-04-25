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
textsize 4
func init b$ d$ .
   linewidth 0.2
   move 50 0
   line 50 100
   move 0 50
   line 100 50
   for d = -20 to 20
      move x 50
      circle 0.5
      x += 2.5
   .
   move 4 94
   text b$
   move 4 88
   text d$
   days = day date$ - day birth$
   move 4 80
   text days & " days"
   return days
.
proc cycle now cyc t$ col .
   color col
   move 4 cyc * 1.2 - 20
   text t$
   linewidth 0.5
   for d = now - 20 to now + 20
      p = 20 * sin (360 * d / cyc)
      line x 50 + p
      x += 2.5
   .
.
days = init birth$ date$
cycle days 23 "Physical" 900
cycle days 28 "Emotional" 090
cycle days 33 "Intellectual" 009
