####################
# Rezin Dilshad
# 2011-03-07
# Joins Cufflinks genes.expr with htseq.out
####################
import sys

if len(sys.argv)<2:
            print "Give a htseq.out file and an cufflinks file please"
            sys.exit(0)
            
sym = {}
for line in open(sys.argv[1]):
    c = line.split('\t')
    ensg_id = c[0]
    read_count = c[1].split()[0]
   
    sym[ensg_id]=read_count

for line in open(sys.argv[2]):
    if sym.has_key(line.strip().split()[0]):
        print line.strip() + "\t" + sym[line.strip().split()[0]]
    else:
        print line.strip() + "\tHtseq_readCount"
                        
