# AoC-20 - Day 4: Passport Processing
# 
repeat
   s$ = input
   until s$ = "" and sx$ = ""
   if s$ = ""
      inp$[] &= sx$
      sx$ = ""
   else
      if sx$ <> ""
         sx$ &= " "
      .
      sx$ &= s$
   .
.
# 
for inp to len inp$[]
   h$[] = strsplit inp$[inp] " "
   msk = 0
   pass_valid = 1
   for i to len h$[]
      valid = 0
      e$[] = strsplit h$[i] ":"
      h = number e$[2]
      if e$[1] = "cid"
         valid = 1
      elif e$[1] = "byr"
         msk += 2
         if h >= 1920 and h <= 2002
            valid = 1
         .
      elif e$[1] = "iyr"
         msk += 4
         if h >= 2010 and h <= 2020
            valid = 1
         .
      elif e$[1] = "eyr"
         msk += 8
         if h >= 2020 and h <= 2030
            valid = 1
         .
      elif e$[1] = "hgt"
         msk += 16
         l = len e$[2]
         h$ = substr e$[2] l - 1 2
         h = number substr e$[2] 1 l - 2
         if h$ = "cm"
            if h >= 150 and h <= 193
               valid = 1
            .
         elif h$ = "in"
            if h >= 59 and h <= 76
               valid = 1
            .
         .
      elif e$[1] = "hcl"
         msk += 32
         x$[] = strchars e$[2]
         if len x$[] = 7 and x$[1] = "#"
            valid = 1
            for j = 2 to 7
               h = strcode x$[j]
               if h >= strcode "0" and h <= strcode "9"
               elif h >= strcode "a" and h <= strcode "f"
               else
                  valid = 0
               .
            .
         .
      elif e$[1] = "ecl"
         msk += 64
         s$ = e$[2]
         if s$ = "amb" or s$ = "blu" or s$ = "brn" or s$ = "gry"
            valid = 1
         elif s$ = "grn" or s$ = "hzl" or s$ = "oth"
            valid = 1
         .
      elif e$[1] = "pid"
         msk += 128
         x$[] = strchars e$[2]
         if len x$[] = 9
            valid = 1
            for j to 9
               h = strcode x$[j]
               if h < strcode "0" or h > strcode "9"
                  valid = 0
               .
            .
         .
      .
      pass_valid *= valid
   .
   if msk = 254
      n_valid1 += 1
      if pass_valid = 1
         n_valid2 += 1
      .
   .
.
print n_valid1
print n_valid2
# 
input_data
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in

eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007

pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719




