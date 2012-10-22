# vim:set ft=zsh:

export ZSH_HOME=$HOME/.zsh.d
export LANG=ja_JP.UTF-8
export PAGER='lv -c'
export LESS='-i'
export EDITOR=vim
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export MYSQL_PS1="$(echo -e "<\\\U> [\\\d]\\\n(L:\\\c) \e[33mX | _ | X\e[m < ")"

typeset -U fpath
fpath=(
  ${ZSH_HOME}/functions(N-/)
  ${ZSH_HOME}/completions/src(N-/)
  $fpath
)

typeset -U path
path=(
  $HOME/bin(N-/)
  $HOME/.cabal/bin(N-/)
  $HOME/.rbenv/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)
)

uname=`uname`
[[ -f "$ZSH_HOME/os/$uname.zshenv" ]] && . "$ZSH_HOME/os/$uname.zshenv"
[[ -f "$ZSH_HOME/hosts/$HOST.zshenv" ]] && . "$ZSH_HOME/hosts/$HOST.zshenv"
[[ -f "$ZSH_HOME/perlbrew.zshenv" ]] && . "$ZSH_HOME/perlbrew.zshenv"

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  . "$HOME/.rvm/scripts/rvm"
elif [[ -s "$HOME/.rbenv" ]]; then
  eval "$(rbenv init -)"
fi
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && . "$HOME/.pythonbrew/etc/bashrc"

if [[ -s `which tmux` ]]; then
  export MULTIPLEXOR=tmux
elif [[ -s `which tscreen` ]]; then
  export MULTIPLEXOR=tscreen
elif [[ -s `which screen` ]]; then
  export MULTIPLEXOR=screen
fi
