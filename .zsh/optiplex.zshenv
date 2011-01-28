# vim:set ft=zsh:

export PERLBREW_ROOT=$HOME/perlbrew
source $PERLBREW_ROOT/etc/bashrc

paths=(
	$HOME/bin
	$GEM_HOME/bin
	$PERLBREW_ROOT/bin
	$PERLBREW_ROOT/perls/current/bin
	$PATH
)

perl5libs=(
	$HOME/perl5/lib/perl5
	$HOME/perl5/lib/perl5/i486-linux-gnu-thread-multi
)

export PERL5LIB=${(j.:.)perl5libs}
export PATH=${(j.:.)paths}

