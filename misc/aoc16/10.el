# AoC-16 - Day 10: Balance Bots
# 
n = 256
len bh[] n
len bl[] n
len bv[] n
len out[] 24
# 
repeat
  inp$ = input
  until inp$ = ""
  inp$[] = strsplit inp$ " "
  if inp$[0] = "value"
    h = number inp$[5]
    bv[h] *= 100
    bv[h] += number inp$[1]
  else
    h = number inp$[1]
    bl[h] = number inp$[6]
    if inp$[5] = "output"
      bl[h] = -bl[h] - 1
    .
    bh[h] = number inp$[11]
    if inp$[10] = "output"
      bh[h] = -bh[h] - 1
    .
  .
.
repeat
  for i range n
    if bv[i] > 100
      lo = bv[i] mod 100
      hi = bv[i] div 100
      if lo > hi
        swap lo hi
      .
      if hi = 61 and lo = 17
        print i
      .
      bv[i] = 0
      h = bl[i]
      if h >= 0
        bv[h] *= 100
        bv[h] += lo
        h = bh[i]
      else
        out[-h - 1] = lo
      .
      h = bh[i]
      if h >= 0
        bv[h] *= 100
        bv[h] += hi
      else
        out[-h - 1] = hi
      .
    .
  .
  m = out[0] * out[1] * out[2]
  until m > 0
.
print m
# 
# 
input_data
bot 127 gives low to output 1 and high to bot 180
bot 139 gives low to bot 66 and high to bot 161
bot 171 gives low to bot 34 and high to bot 177
bot 160 gives low to bot 32 and high to bot 98
bot 3 gives low to bot 140 and high to bot 186
bot 143 gives low to bot 172 and high to bot 87
bot 154 gives low to bot 145 and high to bot 179
bot 55 gives low to bot 69 and high to bot 93
bot 52 gives low to bot 54 and high to bot 103
value 23 goes to bot 138
value 13 goes to bot 73
bot 104 gives low to bot 176 and high to bot 121
bot 201 gives low to bot 50 and high to bot 195
value 37 goes to bot 111
bot 186 gives low to bot 96 and high to bot 33
bot 164 gives low to bot 37 and high to bot 7
bot 133 gives low to bot 33 and high to bot 162
bot 60 gives low to bot 162 and high to bot 166
value 73 goes to bot 142
bot 155 gives low to bot 138 and high to bot 1
bot 209 gives low to bot 119 and high to bot 106
bot 119 gives low to bot 97 and high to bot 178
bot 21 gives low to bot 122 and high to bot 209
bot 126 gives low to bot 47 and high to bot 124
bot 120 gives low to bot 46 and high to bot 97
value 7 goes to bot 149
bot 13 gives low to bot 166 and high to bot 173
value 47 goes to bot 197
bot 20 gives low to bot 62 and high to bot 198
bot 165 gives low to bot 30 and high to bot 108
value 71 goes to bot 107
bot 180 gives low to output 2 and high to bot 125
bot 38 gives low to bot 163 and high to bot 159
bot 145 gives low to bot 44 and high to bot 126
bot 105 gives low to bot 199 and high to bot 145
bot 88 gives low to bot 77 and high to bot 168
bot 33 gives low to bot 51 and high to bot 160
bot 35 gives low to bot 121 and high to bot 20
bot 53 gives low to bot 35 and high to bot 76
bot 2 gives low to bot 116 and high to bot 30
bot 5 gives low to bot 36 and high to bot 141
bot 169 gives low to bot 114 and high to bot 75
bot 179 gives low to bot 126 and high to bot 134
bot 194 gives low to bot 79 and high to bot 92
bot 123 gives low to bot 153 and high to bot 37
bot 148 gives low to bot 170 and high to bot 90
bot 163 gives low to bot 90 and high to bot 8
bot 172 gives low to bot 75 and high to bot 67
bot 85 gives low to bot 208 and high to bot 0
bot 113 gives low to bot 49 and high to bot 34
bot 96 gives low to output 12 and high to bot 51
bot 91 gives low to bot 64 and high to bot 190
bot 100 gives low to bot 143 and high to bot 131
bot 159 gives low to bot 8 and high to bot 28
bot 29 gives low to bot 31 and high to bot 192
bot 141 gives low to bot 135 and high to bot 175
bot 44 gives low to bot 191 and high to bot 47
bot 9 gives low to bot 127 and high to bot 117
bot 84 gives low to bot 164 and high to bot 147
bot 71 gives low to bot 100 and high to bot 78
bot 18 gives low to output 0 and high to bot 202
bot 150 gives low to bot 117 and high to bot 157
bot 181 gives low to bot 202 and high to bot 3
bot 32 gives low to output 9 and high to bot 115
bot 109 gives low to bot 56 and high to bot 114
value 19 goes to bot 61
bot 39 gives low to bot 206 and high to bot 112
bot 192 gives low to bot 57 and high to bot 191
bot 106 gives low to bot 178 and high to bot 99
bot 62 gives low to bot 41 and high to bot 146
bot 63 gives low to bot 101 and high to bot 41
bot 202 gives low to output 19 and high to bot 140
bot 110 gives low to bot 152 and high to bot 129
bot 203 gives low to bot 1 and high to bot 4
value 5 goes to bot 128
bot 144 gives low to bot 93 and high to bot 153
value 61 goes to bot 187
bot 175 gives low to bot 29 and high to bot 199
bot 78 gives low to bot 131 and high to bot 42
bot 207 gives low to bot 99 and high to bot 113
bot 7 gives low to bot 194 and high to bot 94
bot 76 gives low to bot 20 and high to bot 198
bot 94 gives low to bot 92 and high to bot 118
bot 28 gives low to bot 21 and high to bot 206
bot 161 gives low to bot 82 and high to bot 86
bot 122 gives low to bot 120 and high to bot 119
bot 130 gives low to bot 150 and high to bot 65
bot 158 gives low to output 11 and high to bot 80
bot 92 gives low to bot 130 and high to bot 118
bot 89 gives low to bot 102 and high to bot 68
bot 183 gives low to bot 179 and high to bot 134
bot 34 gives low to bot 88 and high to bot 11
bot 54 gives low to bot 201 and high to bot 103
bot 129 gives low to bot 71 and high to bot 78
bot 40 gives low to bot 48 and high to bot 6
bot 132 gives low to bot 181 and high to bot 72
bot 47 gives low to bot 196 and high to bot 19
value 53 goes to bot 188
bot 187 gives low to bot 18 and high to bot 181
bot 79 gives low to bot 15 and high to bot 130
bot 1 gives low to bot 17 and high to bot 4
bot 108 gives low to bot 193 and high to bot 15
bot 24 gives low to bot 5 and high to bot 12
bot 66 gives low to bot 207 and high to bot 82
bot 68 gives low to bot 110 and high to bot 129
bot 176 gives low to bot 12 and high to bot 63
value 31 goes to bot 156
bot 36 gives low to bot 22 and high to bot 135
bot 162 gives low to bot 160 and high to bot 27
bot 49 gives low to bot 173 and high to bot 88
bot 26 gives low to bot 104 and high to bot 35
bot 117 gives low to bot 180 and high to bot 151
bot 125 gives low to output 4 and high to bot 50
bot 124 gives low to bot 19 and high to bot 81
bot 101 gives low to bot 175 and high to bot 105
bot 168 gives low to bot 169 and high to bot 172
bot 182 gives low to output 3 and high to bot 127
bot 178 gives low to bot 60 and high to bot 13
bot 14 gives low to bot 28 and high to bot 39
bot 51 gives low to output 15 and high to bot 32
bot 12 gives low to bot 141 and high to bot 101
bot 58 gives low to output 16 and high to bot 23
bot 167 gives low to bot 205 and high to bot 122
bot 48 gives low to bot 156 and high to bot 10
value 29 goes to bot 18
bot 131 gives low to bot 87 and high to bot 42
bot 43 gives low to bot 161 and high to bot 102
bot 16 gives low to bot 174 and high to bot 109
bot 174 gives low to bot 85 and high to bot 56
bot 140 gives low to output 17 and high to bot 96
bot 69 gives low to bot 23 and high to bot 2
bot 46 gives low to bot 186 and high to bot 133
bot 206 gives low to bot 209 and high to bot 25
bot 191 gives low to bot 189 and high to bot 196
bot 149 gives low to bot 40 and high to bot 136
bot 15 gives low to bot 9 and high to bot 150
bot 153 gives low to bot 165 and high to bot 59
bot 31 gives low to bot 14 and high to bot 57
bot 142 gives low to bot 107 and high to bot 203
bot 107 gives low to bot 155 and high to bot 203
bot 189 gives low to bot 112 and high to bot 139
value 59 goes to bot 40
bot 184 gives low to bot 38 and high to bot 95
bot 152 gives low to bot 177 and high to bot 71
bot 98 gives low to bot 115 and high to bot 85
bot 196 gives low to bot 139 and high to bot 43
bot 27 gives low to bot 98 and high to bot 174
bot 45 gives low to bot 24 and high to bot 176
bot 99 gives low to bot 13 and high to bot 49
bot 208 gives low to output 5 and high to bot 58
bot 151 gives low to bot 125 and high to bot 201
bot 128 gives low to bot 61 and high to bot 38
bot 97 gives low to bot 133 and high to bot 60
bot 73 gives low to bot 204 and high to bot 36
bot 86 gives low to bot 171 and high to bot 152
bot 90 gives low to bot 70 and high to bot 167
bot 30 gives low to bot 137 and high to bot 193
value 43 goes to bot 48
bot 56 gives low to bot 0 and high to bot 55
bot 146 gives low to bot 154 and high to bot 183
bot 134 gives low to bot 124 and high to bot 81
bot 121 gives low to bot 63 and high to bot 62
bot 74 gives low to bot 128 and high to bot 184
bot 190 gives low to bot 53 and high to bot 76
bot 188 gives low to bot 187 and high to bot 132
value 11 goes to bot 148
bot 77 gives low to bot 109 and high to bot 169
bot 116 gives low to output 14 and high to bot 137
bot 200 gives low to output 10 and high to bot 158
bot 57 gives low to bot 39 and high to bot 189
bot 61 gives low to bot 148 and high to bot 163
value 67 goes to bot 142
value 2 goes to bot 170
bot 137 gives low to output 6 and high to bot 182
value 3 goes to bot 74
bot 25 gives low to bot 106 and high to bot 207
bot 157 gives low to bot 151 and high to bot 54
bot 10 gives low to bot 45 and high to bot 104
bot 23 gives low to output 8 and high to bot 116
bot 72 gives low to bot 3 and high to bot 46
bot 59 gives low to bot 108 and high to bot 79
bot 118 gives low to bot 65 and high to bot 52
bot 87 gives low to bot 67 and high to bot 84
bot 93 gives low to bot 2 and high to bot 165
bot 198 gives low to bot 146 and high to bot 183
bot 41 gives low to bot 105 and high to bot 154
bot 111 gives low to bot 73 and high to bot 5
bot 65 gives low to bot 157 and high to bot 52
bot 170 gives low to bot 188 and high to bot 70
bot 67 gives low to bot 123 and high to bot 164
bot 197 gives low to bot 111 and high to bot 24
bot 42 gives low to bot 84 and high to bot 147
bot 138 gives low to bot 149 and high to bot 17
bot 185 gives low to bot 95 and high to bot 31
bot 95 gives low to bot 159 and high to bot 14
bot 193 gives low to bot 182 and high to bot 9
bot 205 gives low to bot 72 and high to bot 120
bot 173 gives low to bot 16 and high to bot 77
bot 81 gives low to bot 89 and high to bot 68
bot 83 gives low to bot 158 and high to bot 80
bot 102 gives low to bot 86 and high to bot 110
bot 8 gives low to bot 167 and high to bot 21
bot 199 gives low to bot 192 and high to bot 44
bot 112 gives low to bot 25 and high to bot 66
bot 75 gives low to bot 144 and high to bot 123
bot 82 gives low to bot 113 and high to bot 171
value 41 goes to bot 204
value 17 goes to bot 155
bot 70 gives low to bot 132 and high to bot 205
bot 147 gives low to bot 7 and high to bot 94
bot 22 gives low to bot 184 and high to bot 185
bot 6 gives low to bot 10 and high to bot 26
bot 19 gives low to bot 43 and high to bot 89
bot 177 gives low to bot 11 and high to bot 100
bot 0 gives low to bot 58 and high to bot 69
bot 37 gives low to bot 59 and high to bot 194
bot 50 gives low to output 18 and high to bot 200
bot 136 gives low to bot 6 and high to bot 64
bot 166 gives low to bot 27 and high to bot 16
bot 103 gives low to bot 195 and high to bot 83
bot 114 gives low to bot 55 and high to bot 144
bot 204 gives low to bot 74 and high to bot 22
bot 156 gives low to bot 197 and high to bot 45
bot 64 gives low to bot 26 and high to bot 53
bot 115 gives low to output 7 and high to bot 208
bot 17 gives low to bot 136 and high to bot 91
bot 4 gives low to bot 91 and high to bot 190
bot 11 gives low to bot 168 and high to bot 143
bot 135 gives low to bot 185 and high to bot 29
bot 195 gives low to bot 200 and high to bot 83
bot 80 gives low to output 20 and high to output 13



