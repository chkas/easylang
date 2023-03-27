# AoC-18 - Day 2: Inventory Management System
# 
repeat
   s$ = input
   until s$ = ""
   s$[] &= s$
.
# 
len let[] 26
for s$ in s$[]
   a$[] = strchars s$
   for c$ in a$[]
      let[strcode c$ - strcode "a" + 1] += 1
   .
   for i to len let[]
      if let[i] = 2
         s2 = 1
      elif let[i] = 3
         s3 = 1
      .
      let[i] = 0
   .
   s2all += s2
   s3all += s3
   s2 = 0
   s3 = 0
.
print s2all * s3all
# 
for ii to len s$[]
   a$[] = strchars s$[ii]
   for ij = ii + 1 to len s$[]
      b$[] = strchars s$[ij]
      cnt = 0
      for i to len a$[]
         if a$[i] <> b$[i]
            pos = i
            cnt += 1
            if cnt = 2
               break 1
            .
         .
      .
      if cnt = 1
         a$[pos] = ""
         print strjoin a$[]
         break 2
      .
   .
.
# 
input_data
abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab

abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz


