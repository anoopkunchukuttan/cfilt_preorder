#/usr/lib/perl
#craeted by Ananthakrishnan Ramanathan & Ritesh M. Shah
#modified by Raj Nath Patel Dec 2011-2013

#use strict;
#use warnings;
use Parse::RecDescent;

my $parser = new Parse::RecDescent q {

   sentence : dcphrase(s)
   	           #{print "@{$item[1]}"."1\n"; $return = "@{$item[1]}" }
        	   {$return = "@{$item[1]}" }
       
	text : /[^\s\(\)]*/
               #{print $item[1]."\n"; $return = "$item[1]" }
               {$return = "$item[1]"}

#        punct : /\(\S+/ /[^\)]+/ ')'
#	         { $return = "$item[2]" }
        punct : '(,' text ')'
	         { $return = "$item[2]" }

        unknownphrasetag : /\(\S+/ dcphrase(s) ')'
	                     { $return = "@{$item[2]}" }

        unknownwordtag : /\(\S+/ text ')'
		           { $return = "$item[2]" }

	whnp:	'(WHNP'  whnp whpp ')'
							{$return = "$item[3] $item[2]"}
						|'(WHNP' dcphrase(s) ')'
						{$return = "@{$item[2]}"}

	whpp	:'(WHPP' prep dcphrase(s) ')'
								{$return ="@{$item[3]} $item[2]"}
						|'(WHPP' dcphrase(s) ')'
								{$return ="@{$item[2]}"}

	whadvp	:'(WHADVP' dcphrase(s) ')'
		{$return ="@{$item[2]}"}	
	whadjp	:'(WHADJP' dcphrase(s) ')'
		{$return ="@{$item[2]}"}
	sbar	:'(SBAR' '(SBAR' dcphrase(s) ')' ')'
			{$return = "@{$item[3]}"}
		|'(SBAR' dcphrase(s) ')'
			{$return = "@{$item[2]}"}
	prt	:'(PRT' dcphrase(s) ')'
			{$return = "@{$item[2]}"}
			
	
	conjunct : '(IN' text ')'
			{$return = $item[2]}	
		|'(CC' text ')'	
			{$return = "$item[2]"}


 	vp	:'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(VP' vpw(?) '(ADJP' adj(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whnp dcphrase(s) ')' ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[14]} $item[13] @{$item[11]} @{$item[9]} @{$item[4]} @{$item[7]} @{$item[2]} @{$item[3]} @{$item[15]} $item[17] @{$item[18]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(VP' vpw(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whnp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]}  @{$item[4]} @{$item[7]} @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(VP' vpw(?) '(ADJP' adj(?) '(NP' np pp(?) punct(?) '(SBAR' whnp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]} @{$item[4]} @{$item[7]}  @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(ADJP' adj(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whnp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]} @{$item[7]} @{$item[4]} @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(NP' np(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whnp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]} @{$item[7]} @{$item[4]} @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whnp dcphrase(s) ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[10]} $item[9] @{$item[7]} @{$item[4]} @{$item[2]} @{$item[3]} @{$item[11]} $item[13] @{$item[14]}"}
		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(NP' np pp(?) punct(?) '(SBAR' whnp dcphrase(s) ')' ')' ')' 
			{$return = "@{$item[5]} @{$item[8]} $item[7] @{$item[4]} @{$item[2]} @{$item[3]} @{$item[9]} $item[11] @{$item[12]}"}



 	vp	:'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(VP' vpw(?) '(ADJP' adj(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whadvp dcphrase(s) ')' ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[14]} $item[13] @{$item[11]} @{$item[9]} @{$item[4]} @{$item[7]} @{$item[2]} @{$item[3]} @{$item[15]} $item[17] @{$item[18]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(VP' vpw(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whadvp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]}  @{$item[4]} @{$item[7]} @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(VP' vpw(?) '(ADJP' adj(?) '(NP' np pp(?) punct(?) '(SBAR' whadvp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]} @{$item[4]} @{$item[7]}  @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(ADJP' adj(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whadvp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]} @{$item[7]} @{$item[4]} @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
 		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(NP' np(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whadvp dcphrase(s) ')' ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[12]} $item[11] @{$item[9]} @{$item[7]} @{$item[4]} @{$item[2]} @{$item[3]} @{$item[13]} $item[15] @{$item[16]}"}
		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(PP' prep(?) '(NP' np pp(?) punct(?) '(SBAR' whadvp dcphrase(s) ')' ')' ')' ')'
			{$return = "@{$item[5]} @{$item[10]} $item[9] @{$item[7]} @{$item[4]} @{$item[2]} @{$item[3]} @{$item[11]} $item[13] @{$item[14]}"}
		|'(VP' vpw(s) prt(?) adv(?) advphrase(?) '(NP' np pp(?) punct(?) '(SBAR' whadvp dcphrase(s) ')' ')' ')' 
			{$return = "@{$item[5]} @{$item[8]} $item[7] @{$item[4]} @{$item[2]} @{$item[3]} @{$item[9]} $item[11] @{$item[12]}"}



		|'(VP' vpw(?) '(VP' vpw(?) '(VP' advphrase(?) vpw(?) adjphrase(?) advphrase(?) np(?) pp(s?) punct(?) '(SBAR' conjunct(?) whadvp(?) whnp(?) dcphrase(s) ')' ')' ')' ')' #For narration
			{$return = "@{$item[9]} @{$item[10]} @{$item[6]} @{$item[11]} @{$item[8]} @{$item[7]} @{$item[4]} @{$item[2]} @{$item[12]} @{$item[14]} @{$item[15]} @{$item[16]} @{$item[17]}"}
		|'(VP' vpw(?) '(VP' advphrase(?) vpw(?) adjphrase(?) advphrase(?) np(?) pp(s?) punct(?) '(SBAR' conjunct(?) whadvp(?) whnp(?) dcphrase(s) ')' ')' ')' #For narration
			{$return = "@{$item[7]} @{$item[8]} @{$item[4]} @{$item[9]} @{$item[6]} @{$item[5]} @{$item[2]} @{$item[10]} @{$item[12]} @{$item[13]} @{$item[14]} @{$item[15]}"}
		|'(VP' advphrase(?) vpw(?) adjphrase(?) advphrase(?) np(?) pp(s?) punct(?) '(SBAR' conjunct(?) whadvp(?) whnp(?) dcphrase(s) ')' ')' #For narration
			{$return = "@{$item[5]} @{$item[6]} @{$item[2]} @{$item[7]} @{$item[4]} @{$item[3]} @{$item[8]} @{$item[10]} @{$item[11]} @{$item[12]} @{$item[13]}"}

		
		|'(VP' advphrase(?) vpw adv(?) advphrase(?) adjphrase(?) pp punct(?) pp(s) punct(?) dcphrase(s?) ')'
                       {$return = "@{$item[10]} @{$item[11]} @{$item[9]} @{$item[8]} @{$item[5]} $item[7] @{$item[6]} @{$item[2]} @{$item[4]} $item[3]"}
		
		|'(VP' vpw(s) '(VP' vpw(s) np(s) pp(s) ')' ')'
			{$return = "@{$item[5]} @{$item[6]} @{$item[4]} @{$item[2]}"}
		|'(VP' vpw(s) np(s) pp(s) ')'
			{$return = "@{$item[4]} @{$item[3]} @{$item[2]}"}

		|'(VP' vpw(s) adv(?) advphrase(?) adjphrase(s?) dcphrase(s?) ')'
			{$return = "@{$item[4]} @{$item[6]} @{$item[5]} @{$item[3]} @{$item[2]}"}
		|'(VP' adv(s) vpw(s) dcphrase(s) ')'
			{$return = "@{$item[4]} @{$item[2]} @{$item[3]}"}
		|'(VP' advphrase(?) vpw(s) dcphrase(s) ')'
			{$return = "@{$item[2]} @{$item[4]} @{$item[3]}"}
			#{print "vp-advp-vpw-advp:\n"; $return = "@{$item[2]} @{$item[4]} @{$item[5]} @{$item[3]}"}
		| '(VP' prep(s) dcphrase(s) ')'
			{$return = "@{$item[3]} @{$item[2]}"}
			#{print "its working vp5 \n"; $return = "@{$item[3]} @{$item[2]}"}
		| '(VP' vpw(s) ')' #old
			{$return = "@{$item[2]}"}
			#{print "its working vp6 \n"; $return = "@{$item[2]}"}
		| '(VP' vpw(s) dcphrase(s) ')'#old
			{$return = "@{$item[3]} @{$item[2]}"}
			#{print "its working vp6 \n"; $return = "@{$item[2]}"}
		| '(VP' dcphrase(s) ')'#old
			{$return = "@{$item[2]}"}
			#{print "its working vp6 \n"; $return = "@{$item[2]}"}
	
	vbn  	:'(VBN' text ')'
			{$return = "$item[2]"}
      		|'(VBD' text ')'
			{$return = "$item[2]"}

	vbd	:'(VBD' text ')'
			{$return = "$item[2]"}

 	vpw 	:'(VBD' text ')'
			{$return = "$item[2]"}
		| '(VBG' text ')'
			{$return = "$item[2]"}
		| '(VBZ' text ')'
			{$return = "$item[2]"}
		| '(MD' text ')'
			{$return = "$item[2]"}
		| '(VB' text ')'
			{$return = "$item[2]"}
		| '(VBP' text ')'
			{$return = "$item[2]"}
		| '(VBN' text ')'
			{$return = "$item[2]"}
		|'(PRT' dcphrase(s) ')'
			{$return = "@{$item[2]}"}
		|'(VBD' dcphrase(s) ')'
			{$return = "@{$item[2]}"}
		| '(VBZ' dcphrase(s) ')'
			{$return = "@{$item[2]}"}


	pp	:'(PP' pp conjunct pp')' 
		 	#{print "ppconjunctpp\n"; $return = "$item[4] $item[3] $item[2]"}
		  	{$return = "$item[4] $item[3] $item[2]"}
		|'(PP' adv(s) prep(s?) dcphrase(s) ')'
			#{print "its workingpp3\n"; $return = "@{$item[3]} @{$item[2]}"}
			{ $return = "@{$item[4]} @{$item[3]} @{$item[2]}"}
		#Rule to solve the overfitting with vp negation rule ...
		| '(PP' advphrase(?) prep(?) dcphrase(s) ')'
            		#{print "Its workingpp3\n"; $return = "@{$item[4]} $item[3] $item[2]" }	
               		{$return = "@{$item[4]} @{$item[3]} @{$item[2]}" }	
		
	  prep  :  '(IN' text ')'
			{$return = "$item[2]"}
		|'(TO' text ')'
			{$return = "$item[2]"}
		| '(VBG' text ')'
			{$return = "$item[2]"}
		| '(VBN' text ')'
			{$return = "$item[2]"}
		| '(RB' text ')'
			{$return = "$item[2]"}
	 		
	np	: '(NP' np '(PP' prep '(NP' np sbar ')' ')' ')'
			{$return = "$item[6] $item[4] $item[2] $item[7]"}
		| '(NP' np(s) '(SBAR' '(S' dcphrase(s) ')' ')' ')'
			#{print "np-np-sbar:\n"; $return = "@{$item[5]} @{$item[2]}"}
			{$return = "@{$item[5]} @{$item[2]}"}
		| '(NP' np(s) punct advphrase(s) ')'
			#{print "itsworking-np2"; $return = "@{$item[4]} $item[3] @{$item[2]}"}
			{$return = "@{$item[4]} $item[3] @{$item[2]}"}
		| '(NP' np punct(?) vp ')'
			#{print "np-np-vp:\n"; $return = "@{$item[3]} @{$item[2]}"}
			{$return = "$item[4] @{$item[3]} $item[2]"}
		| '(NP' np(s) pp(s) ')'
			#{print "np-np-pp:\n"; $return = "@{$item[3]} @{$item[2]}"}
			{$return = "@{$item[3]} @{$item[2]}"}
	 	|'(NP' dcphrase(s) ')'
			#{print "its working-np3"; $return = "@{$item[2]}"}
			{$return = "@{$item[2]}"}
	

	adj :'(JJ' text ')'
			{$return = "$item[2]"}
		| '(JJS' text ')'	
			#{print "$item[2]"."conjunct\n"; $return = "$item[2]"}
			{$return = "$item[2]"}
		| '(JJR' text ')'
			{$return = "$item[2]"}
		|'(JJ' dcphrase(s) ')'
			{$return = "@{$item[2]}"}

	ADJdcphrase : pp
			{$return = "$item[1]"}
		|'(S' dcphrase(s) ')'
			{$return = "@{$item[2]}"}
    
    adjphrase  :'(ADJP' vpw(s) pp ')'
			{$return = "$item[3] @{$item[2]}"}
		
		|'(ADJP' adj(s) adv(?) ADJdcphrase(s) ')'
			{$return = "@{$item[4]} @{$item[3]} @{$item[2]}"}
		
		#|'(ADJP' adjphrase(s) dcphrase(s) ')'
		#	{$return = "@{$item[3]} @{$item[2]}"}
		|'(ADJP' adjphrase(s) pp(s) ')'
			{$return = "@{$item[3]} @{$item[2]}"}
		
		|'(ADJP' adjphrase punct adjphrase ')'
			{$return = "$item[4] $item[3] $item[2]"}
		|'(ADJP' dcphrase(s) ')'
			{$return = "@{$item[2]}"}
	

	adv  :	'(RB' text ')'
			{$return = "$item[2]"}
		|'(RBR' text ')'
			{$return = "$item[2]"}
		| '(RBS' text ')'
			{$return = "$item[2]"}
		| '(IN' text ')'
			{$return = "$item[2]"}
		|'(RB' dcphrase(s) ')'
			{$return = "@{$item[2]}"}

   advphrase 	:	'(ADVP' np adv pp ')'
			{$return = "$item[4] $item[2] $item[3]"}
#new rule added
				|'(ADVP' adv adv(?) dcphrase(s?) ')'
			{$return = "@{$item[4]} @{$item[3]} $item[2]"}
     		|'(ADVP' advphrase(?) dcphrase(s) ')'
			{$return = "@{$item[3]} @{$item[2]}"}

     dcphrase	: '(S' dcphrase(s) ')'
                      {$return = "@{$item[2]}"} 
                      #{print "@{$item[2]}"."2\n"; $return = "@{$item[2]}" } 
		| vp 
			#{print "$item[1]"."vp\n"; $return = "$item[1]"}
			{$return = "$item[1]"}
		| pp
                        #{print "$item[1]"."3\n"; $return = "$item[1]" } 
                        {$return = "$item[1]" } 
		| np
                        #{print "$item[1]"."3\n"; $return = "$item[1]" } 
                        {$return = "$item[1]" } 
		| adjphrase 
                        #{print "$item[1]"."3\n"; $return = "$item[1]" } 
                        {$return = "$item[1]" } 
		| advphrase 
                        #{print "$item[1]"."3\n"; $return = "$item[1]" } 
                        {$return = "$item[1]" } 

	  | unknownphrasetag
		     { $return = "$item[1]" }
    | unknownwordtag
		     { $return = "$item[1]" }

};	

$text1 = '(S (NP (NP (DT The) (NN time)) (PP (IN of) (NP (NP (DT the) (NN year)) (SBAR (WHADVP (WRB when)) (S (NP (NN nature)) (VP (VBZ dawns))))))) (VP (VBZ is) (NP (DT the) (JJS best) (NN time))) (. .))
';

while (<>) {
  chomp;
  print $parser->sentence( $_ ), "\n";
}
#    print $parser->sentence( $text9 ), "\n";
