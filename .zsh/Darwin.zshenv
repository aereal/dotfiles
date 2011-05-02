# vim:set ft=zsh:

export EDITOR="/Applications/MacVim.app/MacOS/Vim"

paths=(
	$HOME/local/bin
	$HOME/local/sbin
	/usr/local/bin
	/usr/local/sbin
	$PATH
)

export PATH=${(j.:.)paths}
. $HOME/.zsh/perlbrew.zshenv

