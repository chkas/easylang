global chrs$[] .
proc init .
   chrs$[] = strchars "!\"#$%&'()*+,-./:;<=>?@[]^_{|}~"
   for i to 26
      if i <= 10 : chrs$[] &= strchar (47 + i)
      chrs$[] &= strchar (96 + i)
      chrs$[] &= strchar (64 + i)
   .
.
init
#
proc pwdgen lngth cnt .
   nchrs = len chrs$[]
   while cnt > 0
      up = 0
      low = 0
      num = 0
      spec = 0
      pw$ = ""
      for i to lngth
         c$ = chrs$[random nchrs]
         c = strcode c$
         if c >= 65 and c <= 90
            up = 1
         elif c >= 97 and c <= 122
            low = 1
         elif c >= 48 and c <= 57
            num = 1
         else
            spec = 1
         .
         pw$ &= c$
      .
      if up + low + num + spec = 4
         print pw$
         cnt -= 1
      .
   .
.
pwdgen 8 6
