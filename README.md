# CFILT-Preorder 

### _Source reordering Rules for English-Indian language SMT_

This package contains a rule based system for reordering English sentences to conform to the word order in Indian languages. It has been developed keeping Hindi in mind as the target language, but has been found to work for other Indian languages too. The reordered English sentences can be used instead of the original sentences for training a phrase SMT system from English to Indian languages. 

## Pre-requisites

- OS - Linux, Mac OS X
- Perl
- Perl Recursive Descent Parser require: Module: Parse::RecDescent 
- Java 7.xx (haven't tested with Java 8)
- Stanford Parser Version 3.2.0 (haven't tested with new versions of Stanford parser) 

## Instructions

1. Download and unzip cfilt_preorder.tar.gz

2. Export an environment variable 'STANFORD_PARSER_HOME' 

    > export STANFORD_PARSER_HOME=<path to the Stanford parser home directory>

## Usage: 

1. Change to the *cfilt_preorder* home directory.
2. Run the command 
  > ./reorderEnglish.sh <input_file_path> [generic/hindi_tuned] 

    _generic_ uses reordering rules that are generic to all Indian languages
    _hindi\_tuned_ uses additional reordering rules that were tuned for Hindi. However, these have been found to work well for other Indian languages. We recommend that you use this option. 
    
    The input file is reordered and the reordered sentences are stored in the file <input_file_path>.v1.0codkilled


## Contributors

- Ananthakrishnan Ramanathan
- Ritesh Shah
- Jayprasad Hegde
- Rajnath Patel 
- Rajen Chatterjee
- Anoop Kunchukuttan

## Contact

For any queries/information, please contact Prof. Pushpak Bhattacharyya (pb@cse.iitb.ac.in) or Anoop Kunchukuttan (anoopk@cse.iitb.ac.in)

## License

Copyright CFILT 2014 - present
 
CFILT Preorder is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

CFILT Preorder is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU General Public License for more details. 

You should have received a copy of the GNU General Public License 
along with CFILT Preorder.  If not, see <http://www.gnu.org/licenses/>.
