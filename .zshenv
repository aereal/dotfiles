# vim:set ft=zsh:

export GEM_HOME=/var/lib/gems/1.8
export EDITOR=vim
export LS_COLORS='di=33:ln=36:so=35:ex=31:su=41;32:sg=41;34:'
#export GAE_SDK_HOME=$HOME/sdk/google_appengine

PATHS=(
	$HOME/bin
	$HOME/local/bin
	$GEM_HOME/bin
	$GAE_SDK_HOME
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

