#!/usr/bin/env perl

# random 'fortune' using dadadodo.
# set $dir to a location where there are text files.

use strict;
use warnings;
use Getopt::Long;
use Cwd;
use File::Random qw/random_file/;
use File::Type;

my $dir = $ENV{'HOME'} . '/txt/';

sub randomfile {
    my $random_file = random_file(-dir       => $dir,
                                  -check => sub { File::Type->new()->checktype_filename($dir.$_) =~ /^text\//; },
                                  -recursive => 1);
    #print "$random_file\n";
}

sub dododo {
    my $filez = '';
    for my $i (0..3) {
        $filez .= $dir.randomfile . ' ' ;
    }
    `/usr/bin/env dadadodo -c 3 $filez 2>/dev/null`;
}

print dododo;
