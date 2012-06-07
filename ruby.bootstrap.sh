#!/bin/sh

if [[ ! -x `which rbenv` ]]; then
  echo "rbenv is not installed"
  exit 1
fi

export CONFIGURE_OPTS=--enable-shared

echo "Setup rbenv"
eval "$(rbenv init -)"

echo "Install 1.9.3-p194"
rbenv install 1.9.3-p194
