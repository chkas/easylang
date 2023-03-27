# AoC-21 - Day 16: Packet Decoder
# 
# Recursive parsing 
# 
global b[] bi .
func init . .
   hex$[] = strchars input
   for h$ in hex$[]
      v = strcode h$ - 48
      if v > 9
         v -= 7
      .
      h = 8
      for i to 4
         if v >= h
            v -= h
            b[] &= 1
         else
            b[] &= 0
         .
         h /= 2
      .
   .
   bi = 1
.
call init
# 
func getnum cnt . v .
   v = 0
   for bi = bi to bi + cnt - 1
      v = v * 2 + b[bi]
   .
.
global vers_sum .
func parse_pack . val .
   call getnum 3 h
   vers_sum += h
   call getnum 3 id
   if id = 4
      val = 0
      repeat
         call getnum 5 h
         until h < 16
         val = val * 16 + h - 16
      .
      val = val * 16 + h
   else
      call getnum 1 mode
      if mode = 0
         call getnum 15 lng
         bi2 = bi + lng
         while bi <> bi2
            call parse_pack h
            list[] &= h
         .
      else
         call getnum 11 lng
         for i to lng
            call parse_pack h
            list[] &= h
         .
      .
      if id = 0
         val = 0
         for h in list[]
            val += h
         .
      elif id = 1
         val = 1
         for h in list[]
            val *= h
         .
      elif id = 2
         val = 1 / 0
         for h in list[]
            val = lower val h
         .
      elif id = 3
         val = 0
         for h in list[]
            val = higher val h
         .
      elif id = 5
         val = if list[1] > list[2]
      elif id = 6
         val = if list[1] < list[2]
      elif id = 7
         val = if list[1] = list[2]
      .
   .
.
call parse_pack val
print vers_sum
print val
# 
input_data
9C0141080250320F1802104A08


