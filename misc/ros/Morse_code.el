txt$ = "sos sos"
# 
chars$[] = strchars "abcdefghijklmnopqrstuvwxyz "
code$[] = [ ".-" "-..." "-.-." "-.." "." "..-." "--." "...." ".." ".---" "-.-" ".-.." "--" "-." "---" ".--." "--.-" ".-." "..." "-" "..-" "...-" ".--" "-..-" "-.--" "--.." " " ]
# 
proc morse ch$ . .
   ind = 1
   while ind <= len chars$[] and chars$[ind] <> ch$
      ind += 1
   .
   if ind <= len chars$[]
      write ch$ & " "
      sleep 0.4
      for c$ in strchars code$[ind]
         write c$
         if c$ = "."
            sound [ 440 0.2 ]
            sleep 0.4
         elif c$ = "-"
            sound [ 440 0.6 ]
            sleep 0.8
         elif c$ = " "
            sleep 0.8
         .
      .
      print ""
   .
.
for ch$ in strchars txt$
   morse ch$
.
