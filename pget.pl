#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;

while (my $param = shift @ARGV) {
    my $res = fetch_url($param);
    print "$res\n";
}

sub fetch_url {
    my $url = shift;
    my $content = get($url);
}
