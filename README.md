# CFILT-Preorder: Source Side reordering Rules for English-Indian language SMT

This package contains a rule based system for reordering English sentences to conform to the word order in Indian languages. It has been developed keeping Hindi in mind as the target language, but has been found to work for other Indian languages too. The reordered English sentences can be used instead of the original sentences for training a phrase SMT system from English to Indian languages. 

## Prerequisites

- OS - Linux
- perl should be installed 
- python xml library(lxml) should be installed 
(Can be installed on Fedora using command "#yum install python-lxml")
- Perl Recursive Descent Parser require: Module: Parse::RecDescent 
  - In Ubuntu, this can be obtained by installing the package: libparse-recdescent-perl
- Stanford Parser Version 3.2.0

## Installation:
1. Install Stanford Parser
2. Copy the contents of this directory to the root directory of the Stanford Parser installation

## Usage: 
1. Change directory to root direction of Stanford Parser Installation
2. Run the command 
    ./reorderEnglish.sh <input_file_path> <rules_to_run>  
    <rules_to_use> can take one of two values: hindi_tuned or generic
    These are two sets of rules. The 'hindi_tuned' rules are a superset of 'generic' rules, and usually perform better. Your distribution may have only the 'generic' rules. 

    The input file is reordered and the reordered sentences are stored in the file <input_file_path>.v1.0codkilled


## Contributors

- Ananthakrishnan Ramanathan
- Ritesh Shah
- Jayprasad Hegde
- Rajnath Patel 
- Rajen Chatterjee
- Anoop Kunchukuttan