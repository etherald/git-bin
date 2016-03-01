#!/usr/bin/env perl

# being a perl port of
#!/bin/sh
# for i in $@
#     do
#     shuf /usr/share/dict/words | head -n $i
#     done

# january 28 2015 20:19:55 est

use strict;
use warnings;

sub random_line {
    my $line;
    my $path = shift;
    open(my $fh, '<:encoding(UTF-8)', $path) or die "Could not open file '$path' $!";
    srand;
    rand($.) < 1 && ($line = $_) while <$fh>;
    # $line is the random line
    chomp($line);
    $line;
}

sub random_word {
    my $cnt = shift;
    my $line;
    for (1...$cnt) {
        my $res = random_line('/usr/share/dict/words');
        $res =~ s/\'s//;
        $line .= lc $res . ' ';
    }
    return $line;
}

my $rpt = shift @ARGV;
my $cw = shift @ARGV;
$cw ||= '';
$rpt ||= 1;
print ("$cw ", random_word($rpt), "\n");
#print "\n";
