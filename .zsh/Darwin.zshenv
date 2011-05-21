# vim:set ft=zsh:

export EDITOR="/Applications/MacVim.app/MacOS/Vim"
export FLEX_HOME=$HOME/sdk/flex

paths=(
	$HOME/bin
	$FLEX_HOME/bin
	$HOME/local/bin
	$HOME/local/sbin
	/usr/local/bin
	/usr/local/sbin
	$PATH
)

export PATH=${(j.:.)paths}

