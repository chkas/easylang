func f x .
   return sin (x / pi * 180)
.
proc simpson a fa b fb &m &fm &whole .
   m = (a + b) / 2
   fm = f m
   whole = abs (b - a) / 6 * (fa + 4 * fm + fb)
.
func rsimpson a fa b fb eps whole m fm .
   simpson a fa m fm lm flm left
   simpson m fm b fb rm frm right
   delta = left + right - whole
   if abs delta <= 15 * eps
      return left + right + delta / 15
   .
   l = rsimpson a fa m fm (eps / 2) left lm flm
   r = rsimpson m fm b fb (eps / 2) right rm frm
   return l + r
.
func quadasr a b eps .
   fa = f a
   fb = f b
   simpson a fa b fb m fm whole
   return rsimpson a fa b fb eps whole m fm
.
numfmt 0 10
print quadasr 0 1 1e-9
