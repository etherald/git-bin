#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;
use 5.010;

print get shift @ARGV;

# while (my $param = shift @ARGV) {
#     say get($param);
# }
