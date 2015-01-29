#!/usr/bin/env perl

# You can use this script in a pipe. It's input will become an emacs buffer
# via emacsclient (so you need server-start etc.)

# See http://mark.aufflick.com/o/886457 for more information

# Copyright (C) 2011 by Mark Aufflick <mark@aufflick.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

use strict;
use warnings;

use IO::Select;

my $emacsclient = "/usr/local/bin/emacsclient";

# This script uses emacsclient, be sure to have a running server session.
# A server-session can be started by "M-x server-start".

my $buffer_name = "*piped-$$" . '*';

exit 1
    if 0 != system("$emacsclient -n --eval '(progn (pop-to-buffer (get-buffer-create \"$buffer_name\")))'");

my $s = IO::Select->new;

if (@ARGV) {
    for my $path (@ARGV) {
        open my $fh, $path
            or die $!;
        $s->add($fh);
    }
}
else {
    $s->add(\*STDIN);
}

my $acc = "";
my $line = 0;

my @ready;
while (@ready = $s->can_read) {

    exit(0)
        if @ready == 0;

    for my $fh (@ready) {

        my $data = <$fh>;

        $s->remove($fh)
            if ! $data;

        exit(0)
            if $s->count == 0;

        # need to escape backslashes first, otherwise we end up escaping the backslashes
        # we're using to escape the quotes...
        $data =~ s/\\/\\\\/g;
        $data =~ s/"/\\"/g;
        $data =~ s/'/'\\''/g;

        $acc .= $data;

        system(qq{$emacsclient -n --eval '(with-current-buffer "$buffer_name" (goto-char (point-max)) (insert "} . $acc . qq{"))'})
            if $line++ % 100 == 0;
    }
}
