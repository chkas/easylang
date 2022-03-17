# AoC-15 - Day 19: Medicine for Rudolph
# 
global name$[] .
func add_name n$ . .
  for id range len name$[]
    if name$[id] = n$
      break 2
    .
  .
  name$[] &= n$
.
global na$[] r$[][] .
func id n$ . id .
  for id range len na$[]
    if na$[id] = n$
      break 2
    .
  .
  na$[] &= n$
  r$[][] &= [ ]
.
global na2$[] id2[] .
func add n$ s$ . id .
  call id n$ id
  r$[id][] &= s$
  na2$[] &= s$
  id2[] &= id
.
# 
repeat
  s$ = input
  until s$ = ""
  h$[] = strsplit s$ " "
  call add h$[0] h$[2] id
.
targ$ = input
# 
for i range len targ$
  s1$ = substr targ$ 0 i
  h$ = substr targ$ i 1
  if i + 1 < len targ$ and strcode substr targ$ i + 1 1 >= 97
    h$ = substr targ$ i 2
    i += 1
  .
  s2$ = substr targ$ i + 1 999
  call id h$ id
  for r$ in r$[id][]
    call add_name s1$ & r$ & s2$
  .
.
print len name$[]
# 
# 
repeat
  for i range len targ$
    for j range len na2$[]
      s$ = na2$[j]
      l = len s$
      if substr targ$ i l = s$
        steps += 1
        t$ &= na$[id2[j]]
        i += l - 1
        break 1
      .
    .
    if j = len na2$[]
      t$ &= substr targ$ i 1
    .
  .
  targ$ = t$
  until targ$ = "e"
  t$ = ""
.
print steps
# 
input_data
Al => ThF
Al => ThRnFAr
B => BCa
B => TiB
B => TiRnFAr
Ca => CaCa
Ca => PB
Ca => PRnFAr
Ca => SiRnFYFAr
Ca => SiRnMgAr
Ca => SiTh
F => CaF
F => PMg
F => SiAl
H => CRnAlAr
H => CRnFYFYFAr
H => CRnFYMgAr
H => CRnMgYFAr
H => HCa
H => NRnFYFAr
H => NRnMgAr
H => NTh
H => OB
H => ORnFAr
Mg => BF
Mg => TiMg
N => CRnFAr
N => HSi
O => CRnFYFAr
O => CRnMgAr
O => HP
O => NRnFAr
O => OTi
P => CaP
P => PTi
P => SiRnFAr
Si => CaSi
Th => ThCa
Ti => BP
Ti => TiTi
e => HF
e => NAl
e => OMg

ORnPBPMgArCaCaCaSiThCaCaSiThCaCaPBSiRnFArRnFArCaCaSiThCaCaSiThCaCaCaCaCaCaSiRnFYFArSiRnMgArCaSiRnPTiTiBFYPBFArSiRnCaSiRnTiRnFArSiAlArPTiBPTiRnCaSiAlArCaPTiTiBPMgYFArPTiRnFArSiRnCaCaFArRnCaFArCaSiRnSiRnMgArFYCaSiRnMgArCaCaSiThPRnFArPBCaSiRnMgArCaCaSiThCaSiRnTiMgArFArSiThSiThCaCaSiRnMgArCaCaSiRnFArTiBPTiRnCaSiAlArCaPTiRnFArPBPBCaCaSiThCaPBSiThPRnFArSiThCaSiThCaSiThCaPTiBSiRnFYFArCaCaPRnFArPBCaCaPBSiRnTiRnFArCaPRnFArSiRnCaCaCaSiThCaRnCaFArYCaSiRnFArBCaCaCaSiThFArPBFArCaSiRnFArRnCaCaCaFArSiRnFArTiRnPMgArF

