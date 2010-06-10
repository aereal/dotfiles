# vim:set ft=zsh:

export PAGER='less --RAW-CONTROL-CHARS'
export EDITOR=vim
export LS_COLORS='di=33:ln=36:so=35:ex=31:su=41;32:sg=41;34:'
#export GAE_SDK_HOME=$HOME/sdk/google_appengine

PATHS=(
	$HOME/bin
	$HOME/local/bin
	$PATH
)

RUBYLIBS=(
	/usr/lib/ruby/1.8
)

export PATH=${(j.:.)PATHS}
export RUBYLIB=${(j.:.)RUBYLIBS}

case $TERM in
	linux) LANG=C ;;
	*) LANG=ja_JP.UTF-8 ;;
esac

export SCREENDIR=$HOME/.screen/sessions

