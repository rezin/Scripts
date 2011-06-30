########################################
# Mikael Huss
# Modified by Rezin Dilshad
# 2011-04-28
# The program takes a number (number of alignmnets you want to keep) and a sam file.
# Shufles the file and return the randomly selected alignmnets in an output file, starting with down_
#######################################

import sys
import random

if len(sys.argv)<2:
    print "python ", sys.argv[0], "<fraction to keep> <input file >"
    sys.exit(0)

f1 = open(sys.argv[2])

o1 = open("down_"+sys.argv[1]+"."+sys.argv[2],'w')

number = int(sys.argv[1])

line = f1.readline() #@HD line
o1.write(line)
line = f1.readline() #@RG line
o1.write(line)
line = f1.readline() #@PG line
o1.write(line)
line = f1.readline() #@setting line
o1.write(line)
line = f1.readline() 

list = []
while ( line ):
    list.append(line)
    line = f1.readline()
    
random.shuffle(list)

element = 0
seq = range(number-1)

for el in seq:
    o1.write(list.pop(el))

