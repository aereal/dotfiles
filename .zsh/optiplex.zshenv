# vim:set ft=zsh:

export GEM_HOME=$HOME/gems/1.8
export PERLBREW_ROOT=$HOME/perlbrew

paths=(
	$HOME/bin
	$GEM_HOME/bin
	$PERLBREW_ROOT/bin
	$PERLBREW_ROOT/perls/current/bin
	$PATH
)

rubylibs=(
	$GEM_HOME/lib
)

perl5libs=(
	$HOME/perl5/lib/perl5
	$HOME/perl5/lib/perl5/i486-linux-gnu-thread-multi
)

export PERL5LIB=${(j.:.)perl5libs}
export RUBYLIB=${(j.:.)rubylibs}
export PATH=${(j.:.)paths}

