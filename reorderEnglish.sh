#!/bin/sh
#created by Raj Nath Patel Mar 21 , 2013
#modified by Rajen Chatterjee, IIT Bombay. This code will now support factored reordering. July 20, 2013.
# modified by Anoop Kunchukuttan, IIT Bombay to ensure that blank lines in the input file are returned as they are. Sep 26, 2013

#WORKDIR=`pwd`

WORKDIR=`dirname $0`

if [ $# -lt 2 ]
then
	echo "Usage: $0 unfactored_input_file rules_to_use [factored_input_file] "
    echo "rules_to_use <hindi_tuned> <generic>"
	exit 1
else
    sed 's,^\s*$,MAGIC_SENTENCE_FROM_CFILT,g' $1 > $1.in
	sh $WORKDIR/runstanfordparser.sh $1.in
    mv $1.in.parsed $1.parsed
    if [ $# -eq 3 ]
    then     
	python  $WORKDIR/addFactorToParseTree.py $3 $1.parsed $1.parsed.factored
	cp $1.parsed $1.parsed.temp
	mv $1.parsed.factored $1.parsed
    fi
	python $WORKDIR/convert.py $1
    if [ $2 = "hindi_tuned" ]
    then         
        echo "Running rules tuned for Hindi"
	    cat $1.stanford.parsed | perl $WORKDIR/codkiller-V1.0.pl > $1.cod
    else
        echo "Running generic Indian language rules"
	    cat $1.stanford.parsed | perl $WORKDIR/codkiller-V1.0_generic.pl > $1.cod
    fi
	cat $1.cod |tr -s ' ' >$1.codk
    cat $1.codk |  sed 's/^ //' | sed 's,^MAGIC_SENTENCE_FROM_CFILT$,,g' >$1.v1.0codkilled
	echo 'Cheers!'
fi
