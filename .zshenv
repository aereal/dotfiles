# vim:set ft=zsh:

export GEM_HOME=$HOME/lib/ruby/gems
export EDITOR=vim
export LS_COLORS='di=33:ln=36:so=35:ex=31:su=41;32:sg=41;34:'

PATHS=(
	/sbin
	/bin
	/usr/bin
	/usr/local/bin
	$HOME/bin
	$HOME/local/bin
	$HOME/lib/ruby/gems/1.8/bin
	$GEM_HOME/bin
	$PATH
)

RUBYLIBS=(
	/usr/lib/ruby/1.8
	$HOME/lib
	$HOME/lib/ruby
	$HOME/lib/ruby/site_ruby/1.8
)

export PATH=${(j.:.)PATHS}
export RUBYLIB=${(j.:.)RUBYLIBS}
case $TERM in
	linux) LANG=C ;;
	*) LANG=ja_JP.UTF-8 ;;
esac

