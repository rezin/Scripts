##############
# Rezin Dilshad
# 2011-05-06
# Parse Illumina Summary/read1.xml files
# 
##############
#!/usr/bin/perl -w                                                                                                                                      

use warnings;
use strict;
use Getopt::Std;


#my (@files)= @ARGV;
my $string;
my @cols;
my @lane;

open(IN, $ARGV[0]);
open(OUT, ">>$ARGV[1]");

print OUT "key\tTileCount\tClustersRaw\tClustersRawSD\tClustersPF\tClustersPFSD\tPrcPFClusters\tPrcPFClustersSD\tPhasing\tPrephasing\tCalledCyclesMin\tCalledCyclesMax\tPrcAlign\tPrcAlignSD\tErrRatePhiX\tErrRatePhiXSD\tErrRate35\tErrRate35SD\tErrRate75\tErrRate75SD\tErrRate100\tErrRate100SD\tFirstCycleIntPF\tFirstCycleIntPFSD\tPrcIntensityAfter20CyclesPF\tPrcIntensityAfter20CyclesPFSD\n";
my $line = <IN>;

# split by lane
@lane = split('Lane', $line);

foreach my $elem (@lane){
    if ($elem=~/^.+xml/){
    }
    else {
#	Split by space. Both name of param and value together
	my @row = split('\s',$elem);
	chomp(@row);
	foreach my $elem2 (@row){
#	    Split by "=". Only value selected
	    my @param = split('=',$elem2);
	    if(scalar(@param)<2){
		print "";
	    }
	    else{
		print OUT $param[1] . "\t";
	    }
	}
	print OUT "\n";
    }
}
