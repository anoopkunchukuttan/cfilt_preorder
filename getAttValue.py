#!/usr/bin/python
#created by Raj Nath Patel on Mar 21, 2013

from lxml import etree
import sys
import codecs


if (len(sys.argv)!= 2):
        print 'Usase : python '+sys.argv[0]+' file.XML'
        exit(0)

inputfile1 = sys.argv[1]
outputfile = sys.argv[1]+'.sent' 

fout = open(outputfile , 'w')

doc1 = etree.parse(inputfile1)
root = doc1.getroot()

sent_list = root.xpath('//Anuvadaksh-Consortia/Body/Input-Text/Input')
for sent in sent_list:
	content = sent.text
	content = content.strip()
	if len(content) < 1 :
		print content
		fout.write('no-input-sentence\n')
	else:	
		print content
		fout.write(content+'\n')	
