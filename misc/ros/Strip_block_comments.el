subr process
   i = 1
   while i <= len s$
      if inc = 0 and substr s$ i 2 = "/*"
         inc = 1
         i += 1
      elif inc = 1 and substr s$ i 2 = "*/"
         inc = 0
         i += 1
      elif inc = 0
         write substr s$ i 1
      .
      i += 1
   .
   if inc = 0
      print ""
   .
.
repeat
   s$ = input
   until error = 1
   process
.
input_data
/**
 * Some comments
 * longer comments here that we can parse.
 *
 * Rahoo 
 */
 function subroutine() {
  a = /* inline comment */ b + c ;
 }
 /*/ <-- tricky comments */

 /**
  * Another comment.
  */
  function something() {
  }
