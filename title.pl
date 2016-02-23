#!/usr/bin/env perl

# append bare args to file, and email

use strict;
use warnings;
use Email::MIME;
use Email::Sender::Simple qw(sendmail);
use Getopt::Long;
use Config::Simple;
use Sys::Hostname;
use 5.010;

# default defaults
my $outfile = $ENV{'HOME'}.'/.messagestest';
my $recipients;
my $format = "%s [%s]\n";
my $sender = 'nobody@'.hostname;

# config file
my $configpath = $ENV{'HOME'}.'/.titlerc';
if (-e $configpath) {
    my $cfg = new Config::Simple($configpath);
    $recipients = $cfg->param('recipients');
    $outfile = $cfg->param('outfile');
} else {
    print 'no config';
}

# args from cmd line
GetOptions(
    'o|outfile=s' => \$outfile,
    'r|recipients=s' =>\$recipients,
    's|sender=s' =>\$sender,
    );

my $message = join(' ',@ARGV);

if (!-e $outfile) open(my $fh,'>', $outfile);
open(my $fh, '>>', $outfile) or die "Could not open file '$outfile' $!";
printf $fh $format, ($message, scalar localtime);
close $fh;

my $mail = Email::MIME->create(
    header_str => [
        From    => $sender,
        To      => join(", ", split(' ',$recipients)),
        Subject => 'new messages',
    ],
    attributes => {
        encoding => 'quoted-printable',
        #charset  => 'ISO-8859-1',
        charset => 'UTF-8',
    },
    body_str => "$message\n",
    );

# send the message
sendmail($mail);
