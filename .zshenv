# vim:set ft=zsh:

export ZSH_USER_DIR=$HOME/.zsh.d
export LANG=ja_JP.UTF-8
export PAGER='less --RAW-CONTROL-CHARS'
export LESS='-i'
export EDITOR=vim
export FPATH=$ZSH_USER_DIR/f:$ZSH_USER_DIR/completions:$FPATH
export LS_COLORS="di=33:ln=32:ex=31:pi=34"
export XDG_DATA_HOME=/usr/local/share
export MYSQL_PS1="$(echo -e "<\\\U> [\\\d]\\\n(L:\\\c) \e[33mX | _ | X\e[m < ")"

typeset -U path
path=(
  $HOME/bin(N-/)
  $HOME/local/bin(N-/)
  $HOME/.cabal/bin(N-/)
  $HOME/.rbenv/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)
)

if [[ -s `which tmux` ]]; then
  export MULTIPLEXOR=tmux
elif [[ -s `which tscreen` ]]; then
  export MULTIPLEXOR=tscreen
elif [[ -s `which screen` ]]; then
  export MULTIPLEXOR=screen
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  . "$HOME/.rvm/scripts/rvm"
elif [[ -s "$HOME/.rbenv" ]]; then
  eval "$(rbenv init -)"
fi
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && . "$HOME/.pythonbrew/etc/bashrc"

uname=`uname`
[[ -f "$ZSH_USER_DIR/os/$uname.zshenv" ]] && . "$ZSH_USER_DIR/os/$uname.zshenv"
[[ -f "$ZSH_USER_DIR/hosts/$HOST.zshenv" ]] && . "$ZSH_USER_DIR/hosts/$HOST.zshenv"
[[ -f "$ZSH_USER_DIR/perlbrew.zshenv" ]] && . "$ZSH_USER_DIR/perlbrew.zshenv"
