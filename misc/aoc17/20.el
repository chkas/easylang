# AoC-17 - Day 20: Particle Swarm
# 
repeat
   s$ = input
   until s$ = ""
   a$[] = strsplit s$ ">"
   p[][] &= number strsplit substr a$[1] 4 99 ","
   v[][] &= number strsplit substr a$[2] 6 99 ","
   a[][] &= number strsplit substr a$[3] 6 99 ","
.
# 
len del[] len p[][]
for cnt = 1 to 500
   for i = 1 to len p[][]
      for d = 1 to 3
         v[i][d] += a[i][d]
         p[i][d] += v[i][d]
      .
   .
   if cnt <= 50
      for i = 1 to len p[][]
         if del[i] = 0
            for j = i + 1 to len p[][]
               if del[j] = 0
                  if p[i][1] = p[j][1] and p[i][2] = p[j][2] and p[i][3] = p[j][3]
                     del[i] = 1
                     del[j] = 1
                  .
               .
            .
         .
      .
   .
.
min = 1 / 0
for i = 1 to len p[][]
   dist = 0
   for d = 1 to 3
      dist += abs p[i][d]
   .
   if dist < min
      min = dist
      mini = i
   .
.
print mini - 1
# 
for d in del[]
   s += 1 - d
.
print s
# 
# 
input_data
p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
p=< 4,0,0>, v=< 1,0,0>, a=<-1,0,0>
p=< 2,0,0>, v=<-2,0,0>, a=<-2,0,0>
p=< 4,0,0>, v=< 0,0,0>, a=<-1,0,0>
p=<-2,0,0>, v=<-4,0,0>, a=<-2,0,0>
p=< 3,0,0>, v=<-1,0,0>, a=<-1,0,0>
p=<-8,0,0>, v=<-6,0,0>, a=<-2,0,0> 


