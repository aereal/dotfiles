# vim:set ft=zsh:

paths=(
	$HOME/local/bin
	$HOME/local/sbin
	$PATH
)

export PATH=${(j.:.)paths}

