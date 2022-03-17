# AoC-21 - Day 14: Extended Polymerization
#
# The string is irrelevant. Only the pairs
# count. And these multiply, as in the
# lanternfish example. 
#
f$ = input
s$ = input
global pair$[] let$[] cnt[] .
func get p$ . id .
  for id range len pair$[]
    if pair$[id] = p$
      break 2
    .
  .
  print "error"
.
func output . .
  len cntl[] 26
  for i range len cnt[]
    cntl[(strcode substr pair$[i] 0 1) - 65] += cnt[i]
  .
  cntl[(strcode substr f$ (len f$ - 1) 1) - 65] += 1
  min = 1 / 0
  for c in cntl[]
    max = higher c max
    if c > 0 and c < min
      min = c
    .
  .
  print max - min
.
repeat
  s$ = input
  until s$ = ""
  h$[] = strsplit s$ " "
  pair$[] &= h$[0]
  let$[] &= h$[2]
  cnt[] &= 0
.
for i range len f$ - 1
  h$ = substr f$ i 2
  call get h$ id
  cnt[id] += 1
.
len cntn[] len cnt[]
# 
for round range 40
  for i range len cnt[]
    p$ = substr pair$[i] 0 1 & let$[i]
    call get p$ id
    cntn[id] += cnt[i]
    p$ = let$[i] & substr pair$[i] 1 1
    call get p$ id
    cntn[id] += cnt[i]
    cnt[i] = 0
  .
  swap cntn[] cnt[]
  if round = 9
    call output
  .
.
call output
# 
input_data
VHCKBFOVCHHKOHBPNCKO

SO -> F
OP -> V
NF -> F
BO -> V
BH -> S
VB -> B
SV -> B
BK -> S
KC -> N
SP -> O
CP -> O
VN -> O
HO -> S
PC -> B
CS -> O
PO -> K
KF -> B
BP -> K
VO -> O
HB -> N
PH -> O
FF -> O
FB -> K
CC -> H
FK -> F
HV -> P
CO -> S
OC -> N
KV -> V
SS -> O
FC -> O
NP -> B
OH -> B
OF -> K
KB -> K
BN -> C
OK -> C
NC -> O
NO -> O
FS -> C
VP -> K
KP -> S
VS -> B
VV -> N
NN -> P
KH -> P
OB -> H
HP -> H
KK -> H
FH -> F
KS -> V
BS -> V
SN -> H
CB -> B
HN -> K
SB -> O
OS -> K
BC -> H
OV -> N
PN -> B
VH -> N
SK -> C
PV -> K
VC -> N
PF -> S
NB -> B
PP -> S
NS -> F
PB -> B
CV -> C
HK -> P
PK -> S
NH -> B
SH -> V
KO -> H
NV -> B
HH -> V
FO -> O
CK -> O
VK -> F
HF -> O
BF -> C
BV -> P
KN -> K
VF -> C
FN -> V
ON -> C
SF -> F
SC -> C
OO -> S
FP -> K
PS -> C
NK -> O
BB -> V
HC -> H
FV -> V
CH -> N
HS -> V
CF -> F
CN -> S

