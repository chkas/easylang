s$ = input
repeat
   s$ = input
   until s$ = ""
   pat$[][] &= strsplit s$ ","
   pat$[$][] &= ""
.
proc sort &d$[][] .
   for i = len d$[][] - 1 downto 1 : for j = 1 to i
      if strcmp d$[j][1] d$[j + 1][1] > 0
         swap d$[j][] d$[j + 1][]
      .
   .
.
sort pat$[][]
n = len pat$[][]
len sum[] n
len cnt[] n
#
s$ = input
repeat
   s$ = input
   until s$ = ""
   vis$[] = strsplit s$ ","
   for i to n
      if pat$[i][1] = vis$[1]
         if strcmp vis$[2] pat$[i][3] > 0
            pat$[i][3] = vis$[2]
         .
         sum[i] += number vis$[3]
         cnt[i] += 1
      .
   .
.
func$ f s$ n .
   s$ = " " & s$
   while len s$ < n : s$ &= " "
   return s$
.
print "PATIENT_ID | LASTNAME | LAST_VISIT | SCORE_SUM | SCORE_AVG"
for i to n
   if sum[i] > 0
      sum$ = f sum[i] 11
      cnt$ = f sum[i] / cnt[i] 11
   else
      sum$ = f "" 11
      cnt$ = f "" 11
   .
   print f pat$[i][1] 11 & "|" & f pat$[i][2] 10 & "|" & f pat$[i][3] 12 & "|" & sum$ & "|" & cnt$
.
#
input_data
PATIENT_ID,LASTNAME
1001,Hopper
4004,Wirth
3003,Kemeny
2002,Gosling
5005,Kurtz

PATIENT_ID,VISIT_DATE,SCORE
2002,2020-09-10,6.8
1001,2020-09-17,5.5
4004,2020-09-24,8.4
2002,2020-10-08,
1001,,6.6
3003,2020-11-12,
4004,2020-11-05,7.0
1001,2020-11-19,5.3
