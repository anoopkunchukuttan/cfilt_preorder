#!/usr/bin/python
#created by Raj Nath Patel on Mar 21 , 2013

from lxml import etree
import sys

if (len(sys.argv)!= 3):
        print 'Usage : python '+sys.argv[0]+' file.XML  sentence-file'
        exit(0)

inputfile1 = sys.argv[1]
inputfile2 = sys.argv[2]

fin = open(inputfile2)

sent_list = fin.readlines()
i = 0

doc1 = etree.parse(inputfile1)
root = doc1.getroot()

#for element in root.iter("*"):
for element in root.findall(".//*"):
	flag = 1
	if element.tag == 'Input':
		children = element.getchildren()
		for child in children :
			if child.tag == 'Reordered':
				child.text =sent_list[i]
				flag = 0
		if flag == 1 :
			w = etree.SubElement( element , 'Reordered')
			w.text = sent_list[i] 
		
		i = i + 1
doc1.write(inputfile1 , pretty_print=True)

#doc1.write(sys.stdout),
#doc1.write(inputfile1 , encoding='utf-8' , pretty_print=True )
