#author: Piyush Dungarwal, IIT Bombay
import sys
from itertools import izip

fw = open(sys.argv[3], "w")

with open(sys.argv[1]) as fr1, open(sys.argv[2]) as fr2:
	for x, y in izip(fr1, fr2):
		word_poss = x.split()
		for word_pos in word_poss:
			word = word_pos.split("|")[0]			
			y = y.replace(" "+word+")"," "+word_pos+")",1)
		fw.write(y) 
'''
			if word!="(" and word!=")" and word!="[" and word!="]" and word!="{" and word!="}":
				y = y.replace(" "+word+")"," "+word_pos+")",1)
			elif word=="(":
				factor=word_pos.split("|",1)[1]
				y = y.replace(" -LRB-"+")"," -LRB-"+"|"+factor+")",1)
			elif word=="-LSB-":
				factor=word_pos.split("|",1)[1]
				y = y.replace(" -LSB-"+")"," -LSB-"+"|"+factor+")",1)
			elif word=="{":
				factor=word_pos.split("|",1)[1]
				y = y.replace(" -LCB-"+")"," -LCB-"+"|"+factor+")",1)
			elif word==")":
				factor=word_pos.split("|",1)[1]
				y = y.replace(" -RRB-"+")"," -RRB-"+"|"+factor+")",1)
			elif word=="]":
				factor=word_pos.split("|",1)[1]
				y = y.replace(" -RSB-"+")"," -RSB-"+"|"+factor+")",1)
			elif word=="}":
				factor=word_pos.split("|",1)[1]
				y = y.replace(" -RCB-"+")"," -RCB-"+"|"+factor+")",1)

		fw.write(y) 
'''

