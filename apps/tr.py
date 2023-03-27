#!/usr/bin/python3
import sys
while 1:
	c = sys.stdin.read(1)
	if not c: break         
	if c == '\\': sys.stdout.write('\\')
	sys.stdout.write(c)

