# AoC-16 - Day 6: Signals and Noise
# 
repeat
   s$ = input
   until s$ = ""
   w$[][] &= strchars s$
.
for col to len w$[1][]
   let[] = [ ]
   len let[] 26
   for i to len w$[][]
      let[strcode w$[i][col] - 96] += 1
   .
   m = 1
   for i to 26
      if let[i] > let[m]
         m = i
      .
   .
   w$ &= strchar m + 96
   for i to 26
      if let[i] > 0 and let[i] < let[m]
         m = i
      .
   .
   w2$ &= strchar m + 96
.
print w$
print w2$
# 
input_data
eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar


