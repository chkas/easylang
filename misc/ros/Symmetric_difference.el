a$[] = [ "John" "Bob" "Mary" "Serena" ]
b$[] = [ "Jim" "Mary" "John" "Bob" ]
# 
for i to 2
   for a$ in a$[]
      for b$ in b$[]
         if a$ = b$
            a$ = ""
            break 1
         .
      .
      if a$ <> ""
         c$[] &= a$
      .
   .
   swap a$[] b$[]
.
print c$[]
