# vim:set ft=zsh:

export JAVA_HOME=/usr/java/default
export CASSANDRA_HOME=/var/cassandra

paths=(
	$CASSANDRA_HOME/bin
	$HOME/local/bin
	$HOME/local/sbin
	$PATH
)

export PATH=${(j.:.)paths}

