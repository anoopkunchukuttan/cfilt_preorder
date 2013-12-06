'''
Created on 08-Aug-2013

@author: rajen
'''
import sys
from itertools import izip

fw = open(sys.argv[3], "w")

with open(sys.argv[1]) as fr1, open(sys.argv[2]) as fr2:
	for x, y in izip(fr1, fr2):
		word_poss = x.split()
		count = 1
		for word_pos in word_poss:
			word = word_pos.split("|")[0]			
			y = y.replace(" "+word+")"," "+word+"_#"+str(count)+")",1)
			count = count+1
		fw.write(y)
