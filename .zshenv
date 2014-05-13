# Environment variables {{{
export ZSH_HOME=$HOME/.zsh.d
export EDITOR=vim
export ANYENV_ROOT=$HOME/.anyenv
export GOPATH=$HOME/.go
# }}}

# paths {{{
typeset -Ua \
  anyenv_path \
  user_path \
  homebrew_path \
  sudo_path \
  system_path
anyenv_path=(
  $ANYENV_ROOT/bin(N-/)
)
user_path=(
  $HOME/local/bin(N-/)
  $HOME/bin(N-/)
)
system_path=(
  /usr/local/mysql/bin(N-/)
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
)
sudo_path=(
  /usr/local/sbin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)
go_path=(
  $GOROOT/bin
)

typeset -U path
path=(
  $anyenv_path
  $user_path
  $go_path
  $system_path
  $sudo_path
)
# }}}

# manpath {{{
typeset -U manpath
manpath=(
  $HOME/local/share/man(N-/)
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)
# }}}

# pager {{{
if which lv >/dev/null; then
  PAGER=lv
else
  PAGER=less
fi
export PAGER
export LV="-c -l"
export LESS="--LONG-PROMPT --RAW-CONTROL-CHARS"
# }}}

# anyenv {{{
eval "$(anyenv init -)"
# }}}

if [[ -e "$HOME/.local.env" ]]; then
  source "$HOME/.local.env"
fi

os_zshenv="$ZSH_HOME/os/$(uname).zshenv"
[[ -f "$os_zshenv" ]] && source $os_zshenv

# vim:set ft=zsh foldmethod=marker:
