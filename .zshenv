# vim:set ft=zsh:

export LANG=ja_JP.UTF-8
export PAGER='less --RAW-CONTROL-CHARS'
export EDITOR=vim
export FPATH=$HOME/.zsh/f:$FPATH
export LS_COLORS="di=33:ln=32:ex=31:pi=34"
export PERLBREW_ROOT=$HOME/perlbrew

paths=(
	$PERLBREW_ROOT/bin
	$PERLBREW_ROOT/perls/current/bin
	$PATH
)

export PATH=${(j.:.)paths}

uname=`uname`
[[ -f "$HOME/.zsh/$uname.zshenv" ]] && . "$HOME/.zsh/$uname.zshenv"
[[ -f "$HOME/.zsh/$HOST.zshenv" ]] && . "$HOME/.zsh/$HOST.zshenv"

