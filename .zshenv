# vim:set ft=zsh:

export LANG=ja_JP.UTF-8
export PAGER='less --RAW-CONTROL-CHARS'
export EDITOR=vim
export FPATH=$HOME/.zsh/f:$FPATH

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
	*-256color)
		eval $(dircolors -b $HOME/.dir_colors256)
		;;
	*)
		eval $(dircolors -b $HOME/.dir_colors)
		;;
esac

export SCREENDIR=$HOME/.screen/sessions

