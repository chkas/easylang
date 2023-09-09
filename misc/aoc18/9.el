# AoC-18 - Day 9: Marble Mania
# 
a$[] = strsplit input " "
n_player = number a$[1]
n_marple = number a$[7] + 1
len nxt[] n_marple * 100
len pre[] n_marple * 100
len score[] n_player
# 
proc run n_moves . .
   pre[1] = 1
   nxt[1] = 1
   cur = 1
   pl = 1
   # 
   for n to n_moves - 1
      if n mod 23 = 1
         for i to 8
            cur = pre[cur]
         .
         del = nxt[cur]
         nxt[cur] = nxt[del]
         cur = nxt[del]
         pre[cur] = pre[del]
         score[pl] += del + n - 2
      else
         cur = nxt[cur]
         nxt[n] = nxt[cur]
         nxt[cur] = n
         pre[n] = cur
         pre[nxt[n]] = n
         # 
         cur = n
      .
      pl = pl mod n_player + 1
   .
   for i to len score[]
      if score[i] > max
         max = score[i]
      .
      score[i] = 0
   .
   print max
.
run n_marple
run n_marple * 100
# 
input_data
30 players; last marble is worth 5807 points

