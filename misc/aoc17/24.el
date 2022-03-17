# AoC-17 - Day 24: Electromagnetic Moat
# 
repeat
  s$ = input
  until s$ = ""
  h[] = number strsplit s$ "/"
  a[] &= h[0]
  b[] &= h[1]
.
n = len a[]
func con pins used[] ln . str0 ln0 ln0str .
  str0 = 0
  ln0 = 0
  for i range n
    if used[i] = 0 and (a[i] = pins or b[i] = pins)
      used[i] = 1
      if a[i] = pins
        call con b[i] used[] ln + 1 str ln lnstr
      else
        call con a[i] used[] ln + 1 str ln lnstr
      .
      used[i] = 0
      str += a[i] + b[i]
      if str > str0
        str0 = str
      .
      ln = ln + 1
      if ln > ln0
        ln0 = ln
        ln0str = a[i] + b[i] + lnstr
      elif ln = ln0 and str > ln0str
        ln0str = a[i] + b[i] + lnstr
      .
    .
  .
.
# 
len used[] n
call con 0 used[] 0 str ln lnstr
print str
print lnstr
# 
input_data
42/37
28/28
29/25
45/8
35/23
49/20
44/4
15/33
14/19
31/44
39/14
25/17
34/34
38/42
8/42
15/28
0/7
49/12
18/36
45/45
28/7
30/43
23/41
0/35
18/9
3/31
20/31
10/40
0/22
1/23
20/47
38/36
15/8
34/32
30/30
30/44
19/28
46/15
34/50
40/20
27/39
3/14
43/45
50/42
1/33
6/39
46/44
22/35
15/20
43/31
23/23
19/27
47/15
43/43
25/36
26/38
1/10

