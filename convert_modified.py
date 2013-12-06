#!/usr/bin/python
#created by Rajen Chatterjee, Research Engineer, IIT Bombay

import sys

fin = open(sys.argv[1],'r')
fout = open(sys.argv[2],'w')

for line in fin:
	line=line[+6:-2]+'\n'
	fout.write(line)
fout.close()
fin.close()
