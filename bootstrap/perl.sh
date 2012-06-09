#!/bin/sh

__PERL_VERSION='perl-5.14.2'
echo "Install perlbrew"
curl -kL http://install.perlbrew.pl | bash

echo "Install $__PERL_VERSION"
perlbrew install $__PERL_VERSION

echo "Install cpanm"
perlbrew install-cpanm


echo "Switch to $__PERL_VERSION"
perlbrew switch $__PERL_VERSION
