len d[] 26
pos = 1
numfmt 0 4
repeat
   s$ = input
   until s$ = ""
   for c$ in strchars s$
      if pos mod 40 = 1
         write pos & ":"
      .
      if pos mod 4 = 1
         write " "
      .
      write c$
      if pos mod 40 = 0
         print ""
      .
      pos += 1
      c = strcode c$
      d[c - 64] += 1
   .
.
print ""
for i in [ 1 3 7 20 ]
   write strchar (64 + i) & ": "
   print d[i]
.
print "Total: " & d[1] + d[3] + d[7] + d[20]
input_data
CGTAAAAAATTACAACGTCCTTTGGCTATCTCTTAAACTCCTGCTAAATG
CTCGTGCTTTCCAATTATGTAAGCGTTCCGAGACGGGGTGGTCGATTCTG
AGGACAAAGGTCAAGATGGAGCGCATCGAACGCAATAAGGATCATTTGAT
GGGACGTTTCGTCGACAAAGTCTTGTTTCGAGAGTAACGGCTACCGTCTT
CGATTCTGCTTATAACACTATGTTCTTATGAAATGGATGTTCTGAGTTGG
TCAGTCCCAATGTGCGGGGTTTCTTTTAGTACGTCGGGAGTGGTATTATA
TTTAATTTTTCTATATAGCGATCTGTATTTAAGCAATTCATTTAGGTTAT
CGCCGCGATGCTCGGTTCGGACCGCCAAGCATCTGGCTCCACTGCTAGTG
TCCTAAATTTGAATGGCAAACACAAATAAGATTTAGCAATTCGTGTAGAC
GACCGGGGACTTGCATGATGGGAGCAGCTTTGTTAAACTACGAACGTAAT