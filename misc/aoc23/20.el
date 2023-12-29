# AoC-23 - Day 20: Pulse Propagation
# 
global name$[] con[][] confr[][] typ[] broadc exitnd[] .
# 
func n2id n$ .
   for id to len name$[]
      if name$[id] = n$
         return id
      .
   .
   name$[] &= n$
   typ[] &= 0
   con[][] &= [ ]
   confr[][] &= [ ]
   return id
.
# 
proc read . .
   broadc = n2id "roadcaster"
   rx = n2id "rx"
   repeat
      s$ = input
      until s$ = ""
      s$[] = strsplit s$ ">, "
      # 
      id = n2id substr s$[1] 2 -1
      if substr s$[1] 1 1 = "%"
         # flipflop
         typ[id] = -1
      .
      for i = 4 step 2 to len s$[]
         h = n2id s$[i]
         con[id][] &= h
         confr[h][] &= id
      .
      if len con[id][] = 1 and con[id][1] = rx
         exitnd = id
      .
   .
   for id to len con[][]
      if len con[id][] = 1 and con[id][1] = exitnd
         exitnd[] &= id
      .
   .
.
read
# 
# 
len lowhigh[] 2
# 
proc run ncnt . .
   len stat[] len typ[]
   len exitcnt[] len exitnd[]
   for cnt to ncnt
      lowhigh[1] += 1
      todo[] &= broadc
      while len todo[] > 0
         todon[] = [ ]
         for id in todo[]
            if typ[id] = -1
               stat[id] = 1 - stat[id]
               sig = stat[id]
            else
               h = 0
               for fr in confr[id][]
                  h += stat[fr]
               .
               sig = if h <> len confr[id][]
               stat[id] = sig
               # 
               if sig = 1
                  # part 2
                  for i to len exitnd[]
                     if exitnd[i] = id and exitcnt[i] = 0
                        exitcnt[i] = cnt
                        p = 1
                        for v in exitcnt[]
                           p *= v
                        .
                        if p > 0
                           print p
                           return
                        .
                     .
                  .
               .
            .
            for d in con[id][]
               if typ[d] = -1
                  if sig = 0
                     todon[] &= d
                  .
               else
                  todon[] &= d
               .
               lowhigh[sig + 1] += 1
            .
         .
         swap todo[] todon[]
      .
   .
.
run 1000
print lowhigh[1] * lowhigh[2]
run 10000
#
input_data
%a -> inv, con
&inv -> b
broadcaster -> a
%b -> con
&con -> output
