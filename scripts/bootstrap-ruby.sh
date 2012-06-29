#!/bin/bash

if [[ -x "$(/usr/bin/which -s rbenv)" ]]; then
  echo "rbenv is not installed"
  exit 1
fi

export CONFIGURE_OPTS=--enable-shared
current_ruby_version="1.9.3-p194"

echo "Setup rbenv"
eval "$(rbenv init -)"

echo "Install $current_ruby_version"
rbenv install $current_ruby_version

echo "Switch to $current_ruby_version"
rbenv global $current_ruby_version

gem update --system
gem update
gem install bundler hub
rbenv rehash
