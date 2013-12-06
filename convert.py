#!/usr/bin/python
#created by Raj Nath Patel on Dec, 2011

import sys

#Open a file
if len(sys.argv)!=2: 
	print "Usase: python"+argv[0]+' inputfile_BASELINE'
	sys.exit(1)

fr1=sys.argv[1]
inputfile=fr1+'.parsed'
outputfile=fr1+'.stanford.parsed'

fr=open(inputfile,'r')
fout =open(outputfile,'w')

for line in fr:
	line=line[+6:-2]+'\n'
	fout.write(line)

fout.close()
fr.close()
