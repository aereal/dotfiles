# Environment variables {{{
export ZSH_HOME=$HOME/.zsh.d
export RBENV_HOME=$HOME/.rbenv
export PLENV_HOME=$HOME/.plenv
export EDITOR=vim
# }}}

# paths {{{
typeset -Ua \
  rbenv_path \
  plenv_path \
  pyenv_path \
  user_path \
  homebrew_path \
  sudo_path \
  system_path
rbenv_path=(
  $HOME/.rbenv/bin(N-/)
  $HOME/.rbenv/shims(N-/)
)
plenv_path=(
  $HOME/.plenv/bin(N-/)
  $HOME/.plenv/shims(N-/)
)
pyenv_path=(
  $HOME/.pyenv/bin(N-/)
  $HOME/.pyenv/shims(N-/)
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

typeset -U path
path=(
  $rbenv_path
  $plenv_path
  $pyenv_path
  $user_path
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

if [[ -e "$HOME/.local.env" ]]; then
  source "$HOME/.local.env"
fi

# rbenv {{{
if which rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi
# }}}

# plenv {{{
if which plenv >/dev/null; then
  eval "$(plenv init - --no-rehash)"
fi
# }}}

# pyenv {{{
if which pyenv >/dev/null; then
  eval "$(pyenv init - --no-rehash)"
fi
# }}}

os_zshenv="$ZSH_HOME/os/$(uname).zshenv"
[[ -f "$os_zshenv" ]] && source $os_zshenv

# vim:set ft=zsh foldmethod=marker:
