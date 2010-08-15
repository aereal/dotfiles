# vim:set ft=zsh:

export LANG=ja_JP.UTF-8
export PAGER='less --RAW-CONTROL-CHARS'
export EDITOR=vim
export FPATH=$HOME/.zsh/f:$FPATH
export GEM_HOME=$HOME/gems/1.8
export PERLBREW_ROOT=$HOME/perlbrew

PATHS=(
	$HOME/bin
	$HOME/local/bin
	$GEM_HOME/bin
	$PERLBREW_ROOT/bin
	$PERLBREW_ROOT/perls/current/bin
	$PATH
)

RUBYLIBS=(
	$GEM_HOME/lib
	/usr/lib/ruby/1.8
)

export PERL5LIB="$HOME/perl5/lib/perl5:$HOME/perl5/lib/perl5/i486-linux-gnu-thread-multi:$PERL5LIB"
export PATH=${(j.:.)PATHS}
export RUBYLIB=${(j.:.)RUBYLIBS}

