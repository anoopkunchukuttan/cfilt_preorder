#!/bin/bash
#created by Raj Nath Patel on Mar 21, 2013

CURDIR=`pwd`

python $CURDIR/getAttValue.py $1

bash $CURDIR/rajnath.reorderEnglish.sh $1.sent

python $CURDIR/changeAtt.py $1 $1.sent.v1.0codkilled
rm $1.*
