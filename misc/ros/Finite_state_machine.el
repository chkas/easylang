state$ = "ready"
repeat
   print kbd$
   until state$ = "quit"
   if state$ = "ready"
      print "Machine is ready. (d)eposit or (q)uit : "
      repeat
         kbd$ = input
         until kbd$ = "d" or kbd$ = "q"
      .
      state$ = "quit"
      if kbd$ = "d" : state$ = "waiting"
   elif state$ = "waiting"
      print "(s)elect product or choose to (r)efund : "
      repeat
         kbd$ = input
         until kbd$ = "s" or kbd$ = "r"
      .
      state$ = "dispense"
      if kbd$ = "r" : state$ = "refund"
   elif state$ = "dispense"
      print "Dispensing product ... "
      print "Please (c)ollect product. : "
      repeat
         kbd$ = input
         until kbd$ = "c"
      .
      state$ = "ready"
   elif state$ = "refund"
      print "Please collect refund."
      state$ = "ready"
      kbd$ = " "
   .
.
print "Thank you, shutting down now."
print ""
