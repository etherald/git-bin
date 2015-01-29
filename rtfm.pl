#!/usr/bin/perl -w
# rtfm - read the friendly manual/s
#
# Usage: rtfm [number of man pages to read]
#
# Originally written by Daniel N. Andersen, June 2004
# Modified by just about everyone at perlmonks.org

use strict;

my $lines = 0;
my $loop  = 1;
my $select;

if($ARGV[0]) {
    $loop = $ARGV[0] unless($ARGV[0] =~ /\D/);
}

while($loop) {
    foreach my $path (split(/:/, $ENV{'PATH'})) {
        opendir(PATH, $path);
        while(defined($_ = readdir(PATH))) {
            if(-f "$path/$_") {
                $lines++;
                $select = $_ if int(rand($lines)) == 0;
            }
        }
        closedir(PATH);
    }
    system(man => $select);
    $lines = 0;
    $loop--;
}
