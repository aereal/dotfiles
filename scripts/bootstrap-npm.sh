#!/bin/sh -v

if [[ -x `which npm` ]]; then
  curl http://npmjs.org/install.sh | sh
fi

npm -g update

echo "Install coffee-script"
npm -g install coffee-script

echo "Install jshint"
npm -g install jshint
