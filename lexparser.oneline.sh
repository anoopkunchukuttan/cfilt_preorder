#!/usr/bin/env bash
#
# Runs the English PCFG parser on one or more files, printing trees only

if [ ! $# -ge 1 ]; then
  echo Usage: `basename $0` 'file(s)'
  echo
  exit
fi

scriptdir=`dirname $0`

java -mx4g -cp "$STANFORD_PARSER_HOME/*:" edu.stanford.nlp.parser.lexparser.LexicalizedParser \
 -sentences "newline" -outputFormat "oneline" edu/stanford/nlp/models/lexparser/englishPCFG.ser.gz $*
