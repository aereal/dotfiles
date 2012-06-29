#!/bin/bash

function notify() {
  if [[ -x "$(/usr/bin/which -s growlnotify)" ]]; then
    growlnotify -m "$1"
  fi

  echo "$1"
}

export PERLBREW_ROOT=$HOME/.perlbrew
__PERL_VERSION='perl-5.14.2'
notify "Install perlbrew"
curl -kL http://install.perlbrew.pl | bash

notify "Install $__PERL_VERSION"
perlbrew install $__PERL_VERSION

notify "Install cpanm"
perlbrew install-cpanm


notify "Switch to $__PERL_VERSION"
perlbrew switch $__PERL_VERSION

notify "Install CPAN modules"
cpanm --notest \
  HTTP::Request::Common \
  Growl::GNTP \
  AnyEvent::HTTP \
  Project::Libs \
  Module::Install
