#!/bin/sh

ln -s $HOME/dotfiles/bin $HOME/bin

for i in `find $HOME/dotfiles -name '.*' -prune`
do
	ln -s $i $HOME/`basename $i`
done

