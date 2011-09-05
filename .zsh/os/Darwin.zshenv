# vim:set ft=zsh:

export EDITOR="/Applications/MacVim.app/MacOS/Vim"
export FLEX_HOME=$HOME/sdk/flex

paths=(
	$HOME/bin(N-/)
	$FLEX_HOME/bin(N-/)
	$HOME/local/bin(N-/)
	$HOME/local/sbin(N-/)
	/usr/local/bin(N-/)
	/usr/local/sbin(N-/)
	$PATH
)

export PATH=${(j.:.)paths}

