# AoC-17 - Day 25: The Halting Problem 
# 
pc = ((strcode substr input 15 1) - 65) * 6
n_steps = number substr input 36 9
s$ = input
repeat
  s$ = input
  until s$ = ""
  s$ = input
  cod[] &= number substr input 22 1
  cod[] &= if substr input 27 5 = "right" * 2 - 1
  cod[] &= (strcode substr input 26 1) - 65
  s$ = input
  cod[] &= number substr input 22 1
  cod[] &= if substr input 27 5 = "right" * 2 - 1
  cod[] &= (strcode substr input 26 1) - 65
  s$ = input
.
len tape[] 100000
pos = len tape[] div 2
for step range n_steps
  if tape[pos] = 1
    pc += 3
  .
  tape[pos] = cod[pc]
  pos += cod[pc + 1]
  pc = cod[pc + 2] * 6
.
for v in tape[]
  chksum += v
.
print chksum
# 
input_data
Begin in state A.
Perform a diagnostic checksum after 12459852 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state E.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state C.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state F.

In state C:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state D.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state B.

In state D:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state E.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state C.

In state E:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state D.

In state F:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state C.



