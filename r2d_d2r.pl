#KA on Oct 16,2017
#!/usr/bin/perl


#command line - perl r2d_d2r.pl <inputfile> <outputfile> -subroutine
#Example : perl r2d_d2r.pl a b -d2r 


use strict;
use warnings;
use Getopt::Long;

my $filename = $ARGV[0] or die "cannot open input RNA FASTA file";
my $output = $ARGV[1] or die "cannot open OUTPUT DNA FASTA file";


open(FH,"$filename"); #input FASTA file
open(OP,">$output"); #output FASTA file


my $id; #initialize variable to assign sequence header


my %opts;
GetOptions (\%opts, 'r2d', 'd2r');
&rna2dna    if($opts{r2d});
&dna2rna    if($opts{d2r});

#RNA2DNA
sub rna2dna
{
    while(<FH>) #read input FASTA file 
        {
            chomp($_);
            if($_=~/^>/)    
                {
                    $id=$_; #store sequence header
                }
            else
                {
                    my $seq=$_; #store sequence
                    $seq =~ s/U/T/g;    #substitute U for T
                    $seq =~ s/u/t/g;    #substitute u for t
                    print OP "$id\n";   
                    print OP "$seq\n";
                }
        }

}


#DNA2RNA
sub dna2rna
{
    while(<FH>) #read input FASTA file 
        {
            chomp($_);
            if($_=~/^>/)
                {
                    $id=$_; #store sequence header
                }
            else
                {
                    my $seq=$_; #store sequence
                    $seq =~ s/T/U/g;    #substitute T for U
                    $seq =~ s/t/u/g;    #substitute t for u
                    print OP "$id\n";
                    print OP "$seq\n";
                }
        }
}
