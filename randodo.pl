#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use Cwd;
use File::Random qw/random_file/;
use File::Type;

use constant DIR => $ENV{'HOME'} . '/txt/';

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
    `/usr/bin/env dadadodo -c 3 $filez`;
}
print dododo;
