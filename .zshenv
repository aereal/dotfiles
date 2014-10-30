# Environment variables {{{
export ZSH_HOME=$HOME/.zsh.d
export EDITOR=vim
export GOPATH=$HOME/.go
# }}}

typeset -A some_envs
some_envs=(
  rbenv $HOME/.rbenv
  plenv $HOME/.plenv
  ndenv $HOME/.ndenv
)

# paths {{{
typeset -Ua \
  user_path \
  homebrew_path \
  sudo_path \
  system_path
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
  $GOPATH/bin
)

typeset -U path
path=(
  $go_path
  $system_path
  $sudo_path
)
for e in ${(k)some_envs}; do
  path=(
    $some_envs[$e]/shims(N-/)
    $some_envs[$e]/bin(N-/)
    $path
  )
done
path=($user_path $path)
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

if [[ -e "$HOME/.local.env" ]]; then
  source "$HOME/.local.env"
fi

os_zshenv="$ZSH_HOME/os/$(uname).zshenv"
[[ -f "$os_zshenv" ]] && source $os_zshenv

# vim:set ft=zsh foldmethod=marker:
