#!/bin/bash
#created by Raj Nath Patel on Mar 21 , 2012

#WORKDIR=`pwd`
WORKDIR=`dirname $0`

if [ $# != 1 ]
then
	echo "Usage: $0 inputfile "
	echo "Please ensure that the input file is in a format acceptable to the bikelparser"
	exit 1
else
	sh $WORKDIR/lexparser.sh $1 |tee $1.parsed
	echo "runstanfordparser.sh: output file @ $1.parsed"
	echo "Have a nice day !"
fi
