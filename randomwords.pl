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
    $line;
}

print random_line '/usr/share/dict/words';
