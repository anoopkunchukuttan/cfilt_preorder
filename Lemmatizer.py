'''
Created on 10-Jun-2013

@author: rajen
'''

import nltk, sys
from nltk.tag import pos_tag
from nltk.tokenize import word_tokenize
from nltk.stem.wordnet import WordNetLemmatizer
from nltk.corpus.reader.wordnet import *

lmtzr = WordNetLemmatizer()

fin = open(sys.argv[1],'r')
fout = open(sys.argv[2],'w')

for line in fin:
    outLine = ""
    for word in line.split():
        fac = word.rsplit('/',1)
        if fac[1] in ("JJ","JJR","JJS"):
            lemma = lmtzr.lemmatize(fac[0],ADJ)
        elif fac[1] in ("RB","RBR","RBS"):
            lemma = lmtzr.lemmatize(fac[0],ADV)
        elif fac[1] in ("VB","VBD","VBG","VBN","VBP","VBZ"):
            lemma = lmtzr.lemmatize(fac[0],VERB)
        else:
            lemma = lmtzr.lemmatize(fac[0],NOUN)
        if fac[1] in (",",".","-",":","$","'","\`","\"",";"):
            fac[1] = "NA"
        outWord = fac[0]+"|"+lemma+"|"+fac[1] + " "
        outLine = outLine + outWord        
    fout.write(outLine+"\n")
fin.close()
fout.close()
