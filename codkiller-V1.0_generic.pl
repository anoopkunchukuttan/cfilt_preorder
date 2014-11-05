# Program for Syntactic Reordering
#   Reads English parse trees (one tree per line) from stdin and
#   and writes out English sentences in Hindi word-order to stdout.
# Example usage: cat <input_file> | perl syn-reorder.pl
# Author: Ananthakrishnan R (anand@cse.iitb.ac.in)

#!/usr/bin/perl

use Parse::RecDescent;

my $parser = new Parse::RecDescent q{
        sentence : dcphrase(s)
  	             { $return = "@{$item[1]}" }
        text : /[^\s\(\)]+/
                 { $return = "$item[1]" }
        punct : /\(\S+/ /[^\)]+/ ')'
	         { $return = "$item[2]" }
        unknownphrasetag : /\(\S+/ dcphrase(s) ')'
	                     { $return = "@{$item[2]}" }
        unknownwordtag : /\(\S+/ text ')'
		           { $return = "$item[2]" }
        advword : '(RB' text ')'
                     { $return = "$item[2]" }
                | '(RBR' text ')'
           	     { $return = "$item[2]" }
                | '(RBS' text ')'
		     { $return = "$item[2]" }
                | '(DT' text ')'
		     { $return = "$item[2]" }
        prepword : '(IN' text ')'
                     { $return = "$item[2]" }
                 | '(TO' text ')'
           	     { $return = "$item[2]" }
                 | '(VBG' text ')'
		     { $return = "$item[2]" }
        prepvp : '(VP' prepword vp ')'
	         { $return = "$item[3] $item[2]" } 
        vp : '(VP' vgword(s) dcphrase(s) ')' 
	       { $return = "@{$item[3]} @{$item[2]}" }
           | '(VP' vgword(s) ')' 
	       { $return = "@{$item[2]}" }
           | '(VP' dcphrase(s) ')'
               { $return = "@{$item[2]}" }
        nppp : '(NP' np pp(s) ')'
	         { $return = "@{$item[3]} $item[2]" } 
        np : '(NP' dcphrase(s) ')'
               { $return = "@{$item[2]}" }
        pp : '(PP' prepword(s) dcphrase(s) ')' 
	       { $return = "@{$item[3]} @{$item[2]}" }
	   | '(PP' '(ADVP' advword(s) ')' prepword(s) dcphrase(s) ')'
	       { $return = "@{$item[3]} @{$item[6]} @{$item[5]}" }
        pnp : '(PP' dcphrase(s) ')'
               { $return = "@{$item[2]}" }
        vgword : '(VB' text ')'
                   { $return = "$item[2]" }
               | '(VBD' text ')' 
                   { $return = "$item[2]" }
               | '(VBG' text ')' 
                   { $return = "$item[2]" }
               | '(VBN' text ')' 
                   { $return = "$item[2]" }
               | '(VBP' text ')' 
                   { $return = "$item[2]" }
               | '(VBZ' text ')' 
                   { $return = "$item[2]" }
               | '(PRT' dcphrase(s) ')' 
                   { $return = "@{$item[2]}" }
               | '(MD' text ')'
	           { $return = "$item[2]"; }
        dcphrase : '(ADJP' dcphrase(s) ')' 
	             { $return = "@{$item[2]}" }
                 | '(ADVP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(CONJP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(FRAG' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(INTJ' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(LST' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(NAC' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(NX' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(PRN' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(PRT' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(QP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(RRC' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(UCP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(WHADJP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(WHADVP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(WHNP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(WHPP' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(X' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(ROOT' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(S' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(SBAR' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(SBARQ' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(SINV' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | '(SQ' dcphrase(s) ')'
	              { $return = "@{$item[2]}" }
                 | prepvp 
                     { $return = "$item[1]" }
                 | vp 
                     { $return = "$item[1]" }
                 | nppp
		     { $return = "$item[1]" } 
                 | np
		     { $return = "$item[1]" } 
                 | pp
		     { $return = "$item[1]" } 
                 | pnp
		     { $return = "$item[1]" } 
                 | '(CC' text ')'
                     { $return = "$item[2]" }
                 | '(CD' text ')'
                     { $return = "$item[2]" }
                 | '(DT' text ')'
                     { $return = "$item[2]" }
                 | '(EX' text ')'
                     { $return = "$item[2]" }
                 | '(FW' text ')'
                     { $return = "$item[2]" }
                 | '(JJ' text ')'
                     { $return = "$item[2]" }
                 | '(JJR' text ')'
                     { $return = "$item[2]" }
                 | '(JJS' text ')'
                     { $return = "$item[2]" }
                 | '(LS' text ')'
                     { $return = "$item[2]" }
                 | '(NN' text ')'
                     { $return = "$item[2]" }
                 | '(NNS' text ')'
                     { $return = "$item[2]" }
                 | '(NNP' text ')'
                     { $return = "$item[2]" }
                 | '(NNPS' text ')'
                     { $return = "$item[2]" }
                 | '(PDT' text ')'
                     { $return = "$item[2]" }
                 | '(POS' text ')'
                     { $return = "$item[2]" }
                 | '(PRP' text ')'
                     { $return = "$item[2]" }
                 | '(PRP$' text ')'
                     { $return = "$item[2]" }
                 | '(RB' text ')'
                     { $return = "$item[2]" }
                 | '(RBR' text ')'
                     { $return = "$item[2]" }
                 | '(RBS' text ')'
                     { $return = "$item[2]" }
                 | '(RP' text ')'
                     { $return = "$item[2]" }
                 | '(SYM' text ')'
                     { $return = "$item[2]" }
                 | '(UH' text ')'
                     { $return = "$item[2]" }
                 | '(WDT' text ')'
                     { $return = "$item[2]" }
                 | '(WP' text ')'
                     { $return = "$item[2]" }
                 | '(WP$' text ')'
                     { $return = "$item[2]" }
                 | '(WRB' text ')'
                     { $return = "$item[2]" }
                 | punct
		     { $return = "$item[1]" }
                 | unknownphrasetag
		     { $return = "$item[1]" }
                 | unknownwordtag
		     { $return = "$item[1]" }
};

while (<>) {
    chomp;
    print $parser->sentence( $_ ), "\n";
}

