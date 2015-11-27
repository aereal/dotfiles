# environment
export HOMEBREW_PATH=/usr/local
export GOPATH=$HOME/.go
export EDITOR=vim

path=(
  $HOME/bin(N-/)
  $HOME/.rbenv/bin(N-/)
  $HOME/.rbenv/shims(N-/)
  $HOME/.plenv/bin(N-/)
  $HOME/.plenv/shims(N-/)
  $HOME/.ndenv/bin(N-/)
  $HOME/.ndenv/shims(N-/)
  $GOPATH/bin(N-/)
  $HOMEBREW_PATH/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_PATH/bin(N-/)
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)
)

typeset -U manpath
manpath=(
  $HOMEBREW_PATH/share/man(N-/)
  $HOMEBREW_PATH/opt/coreutils/libexec/gnuman(N-/)
  /usr/share/man(N-/)
)

export PAGER=less
export LESS='--LONG-PROMPT --RAW-CONTROL-CHARS'
