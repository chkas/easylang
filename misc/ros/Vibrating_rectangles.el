on timer
  sz -= 2
  if sz < 0
    sz = 49
    color random 1000 - 1
  .
  move 50 - sz 50 - sz
  line 50 + sz 50 - sz
  line 50 + sz 50 + sz
  line 50 - sz 50 + sz
  line 50 - sz 50 - sz
  timer 0.2
.
timer 0.2
