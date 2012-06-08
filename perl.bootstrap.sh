#!/bin/sh

echo "Install perlbrew"
curl -kL http://install.perlbrew.pl | bash

echo "Install Perl 5.14.2"
perlbrew install perl-5.14.2

echo "Install cpanm"
perlbrew install-cpanm
