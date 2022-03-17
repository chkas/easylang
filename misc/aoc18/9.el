# AoC-18 - Day 9: Marble Mania
# 
a$[] = strsplit input " "
n_player = number a$[0]
n_marple = number a$[6] + 1
len nxt[] n_marple * 100
len pre[] n_marple * 100
len score[] n_player
#
func run n_moves . .
  pre[0] = 0
  nxt[0] = 0
  cur = 0
  pl = 0
  # 
  for n = 1 to n_moves - 1
    if n mod 23 = 0
      for i range 8
        cur = pre[cur]
      .
      del = nxt[cur]
      nxt[cur] = nxt[del]
      cur = nxt[del]
      pre[cur] = pre[del]
      score[pl] += del + n
    else
      cur = nxt[cur]
      nxt[n] = nxt[cur]
      nxt[cur] = n
      pre[n] = cur
      pre[nxt[n]] = n
      # 
      cur = n
    .
    pl = (pl + 1) mod n_player
  .
  for i range len score[]
    if score[i] > max
      max = score[i]
    .
    score[i] = 0
  .
  print max
.
call run n_marple
call run n_marple * 100
# 
# 
input_data
459 players; last marble is worth 71790 points

