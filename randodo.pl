#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use Cwd;
use File::Random qw/random_file/;
use File::Type;


sub randomfile {
    my $pat = '^.+\.txt$'; #TODO: use file magic somehow to detect text files without extension

    #my @dirs = ((shift @ARGV) or cwd());
    #my @dirs = qw($ENV{'HOME'} . '/txt');
    my $dir = $ENV{'HOME'} . '/txt/';
    my $random_file = random_file(-dir       => $dir,
                                  -check => sub { my $ft = File::Type->new()->checktype_filename($dir.$_); defined($ft) && $ft =~ /^text\//; },
                                  -recursive => 1);
    print "$random_file\n";

}


randomfile;
