global table[] .
proc mktable .
   for i = 0 to 0xff
      rem = i
      for j to 8
         if bitand rem 1 = 1
            rem = bitxor bitshift rem -1 0xedb88320
         else
            rem = bitshift rem -1
         .
      .
      table[] &= rem
   .
.
func crc32 s$ .
   crc = 0xffffffff
   for c$ in strchars s$
      c = strcode c$
      crb = bitxor bitand crc 0xff c
      crc = bitxor (bitshift crc -8) table[crb + 1]
   .
   return bitand bitnot crc 0xffffffff
.
mktable
print crc32 "The quick brown fox jumps over the lazy dog"
