#!/usr/bin/env perl

# stolen from https://github.com/hakobe/dotfiles/blob/master/.vim/tools/efm_perl.pl

use strict;
use warnings;

use Cwd;
use File::Basename;
use File::Spec;

my $file = shift or die "No filename to check!\n";
my $dir  = dirname( $file ) . '/lib';
my $cwd  = cwd();

my $error = qr{(.*)\sat\s(.*)\sline\s(\d+)(\.|,\snear\s\".*\"?)};

# Error messages to be skipped.
my @skip = (

  '"DB::single" used only once: possible typo',
  'BEGIN failed--compilation aborted',

);

my $skip = join '|', @skip;
my @checks;

push @checks, '-M-circular::require' if `perldoc -l circular::require 2> /dev/null`;
push @checks, '-M-indirect'          if `perldoc -l indirect 2> /dev/null`;
push @checks, '-Mwarnings::method'   if `perldoc -l warnings::method 2> /dev/null`;
push @checks, '-Mwarnings::unused'   if `perldoc -l warnings::unused 2> /dev/null`;

# uninit is not included in 5.10 and later
push @checks, '-Muninit'             if ( $] < 5.010 ) && `perldoc -l uninit 2> /dev/null`;

my @incs; 
push @incs, "-I $cwd/lib";
push @incs, "-I $cwd/t/lib";
push @incs, map { "-I $_" }  glob("$cwd/modules/*/lib");

# need to turn on taint if it's on the shebang line.
# naive check for [tT] switch ... will both t and T ever be used at the same time?
my ( $taint ) = `head -n 1 $file` =~ /\s.*-.*?(t)/i;
push @checks, "-$taint" if defined $taint;

my $checks = join(' ', @checks);
my $incs = join(' ', @incs);
my $command = (-f "$cwd/cpanfile") ?
    "carton exec @incs -- perl @incs @checks -c $file 2>&1" : # cartonのバージョン違いの吸収のために@incsが二回展開されてる
    "perl @incs @checks -c $file 2>&1";

my ( $message, $extracted_file, $lineno, $rest );

for my $line ( `$command` ) {

  chomp $line;
  next if $line =~ /$skip/;
  $line =~ s/([()])/\\$1/g;

  if ( ( $message, $extracted_file, $lineno, $rest ) = $line =~ /^$error$/ ) {

    $message .= $rest if ($rest =~ s/^,//);
    print "$file:$lineno:$message\n";

  }
}
