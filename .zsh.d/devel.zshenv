# vim:set ft=zsh:

export CASSANDRA_HOME=$HOME/local/casssandra

paths=(
	$CASSANDRA_HOME/bin
	$HOME/local/bin
	$HOME/local/sbin
	$PATH
)

export PATH=${(j.:.)paths}

