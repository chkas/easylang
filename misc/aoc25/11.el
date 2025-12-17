# AoC-25 - Day 11: Reactor
#
name$[] = [ ]
func n2id n$ .
   for id to len name$[] : if name$[id] = n$ : return id
   name$[] &= n$
   return id
.
you = n2id "you"
out = n2id "out"
svr = n2id "svr"
fft = n2id "fft"
dac = n2id "dac"
#
repeat
   s$ = input
   until s$ = ""
   s$[] = strtok s$ ": "
   a = n2id s$[1]
   if a > len r[][] : len r[][] a
   for i = 2 to len s$[]
      r[a][] &= n2id s$[i]
   .
.
n = len name$[]
#
func cntout1 a .
   if a = out : return 1
   s = 0
   for b in r[a][]
      s += cntout1 b
   .
   return s
.
print cntout1 you
#
len cache[][] n
#
func[] cntout a .
   if cache[a][] = [ ]
      if a = out
         cache[a][] = [ 1 0 0 0 ]
      else
         rn[] = [ 0 0 0 0 ]
         for b in r[a][]
            r[] = cntout b
            if b = fft
               rn[2] += r[1] + r[2]
               rn[4] += r[3] + r[4]
            elif b = dac
               rn[3] += r[1] + r[3]
               rn[4] += r[2] + r[4]
            else
               rn[1] += r[1]
               rn[2] += r[2]
               rn[3] += r[3]
               rn[4] += r[4]
            .
         .
         cache[a][] = rn[]
      .
   .
   return cache[a][]
.
r[] = cntout svr
print r[4]
#
input_data
you: bbb ccc
svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out
