h$ = "<table border=1>\n<tr><th>"
repeat
   s$ = input
   until s$ = ""
   write h$
   for c$ in strchars s$
      if c$ = ","
         if scnd = 0
            c$ = "</th><th>"
         else
            c$ = "</td><td>"
         .
      elif c$ = "<"
         c$ = "<"
      elif c$ = ">"
         c$ = ">"
      elif c$ = "&"
         c$ = "&"
      .
      write c$
   .
   if scnd = 0
      h$ = "</th></tr>\n<tr><td>"
      scnd = 1
   else
      h$ = "</td></tr>\n<tr><td>"
   .
.
print "</td></tr>\n</table>"
# 
input_data
Character,Speech
The multitude,The messiah! Show us the messiah!
Brians mother,<angry>Now you listen here! He's not the messiah; he's a very naughty boy! Now go away!</angry>
The multitude,Who are you?
Brians mother,I'm his mother; that's who!
The multitude,Behold his mother! Behold his mother!
