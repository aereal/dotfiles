export ZSH_HOME=$HOME/.zsh.d
export HOMEBREW_HOME=$HOME/opt/homebrew
export RBENV_HOME=$HOME/.rbenv
export PLENV_HOME=$HOME/.plenv
export EDITOR=vim

typeset -Ua fpath
fpath=(
  $ZSH_HOME/site-functions(N-/)
  $HOMEBREW_HOME/share/zsh-completions(N-/)
  $HOMEBREW_HOME/share/zsh/site-functions(N-/)
  $HOMEBREW_HOME/share/zsh/functions(N-/)
  $fpath
)

typeset -Ua \
  user_path \
  homebrew_path \
  sudo_path \
  system_path
user_path=(
  $HOME/bin(N-/)
)
homebrew_path=(
  $HOMEBREW_HOME/share/npm/bin(N-/)
  $HOMEBREW_HOME/share/python(N-/)
  $HOMEBREW_HOME/bin(N-/)
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
  $user_path
  $homebrew_path
  $system_path
  $sudo_path
)

typeset -U manpath
manpath=(
  $HOME/local/share/man(N-/)
  $HOMEBREW_HOME/opt/coreutils/libexec/gnuman(N-/)
  $HOMEBREW_HOME/share/man(N-/)
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)

if $(/usr/bin/which lv 2>/dev/null); then
  PAGER=lv
else
  PAGER=less
fi
export PAGER
export LV="-c -l"
export LESS="--LONG-PROMPT --RAW-CONTROL-CHARS"

# Grep {{{
GREPPRG=grep

if /usr/bin/which -s ack; then
  GREPPRG=ack
elif /usr/bin/which -s ag; then
  GREPPRG=ag
fi

export GREPPRG
# }}}

if [[ -e "$HOME/.local.env" ]]; then
  source "$HOME/.local.env"
fi

# rbenv {{{
if /usr/bin/which -s rbenv; then
  eval "$(rbenv init - --no-rehash)"
fi
# }}}

# plenv {{{
if which plenv >/dev/null; then
  eval "$(plenv init - --no-rehash)"
fi
# }}}

# shared-mime-info {{{
if /usr/bin/which -s update-mime-database; then
  export XDG_DATA_HOME=$(brew --prefix shared-mime-info)/share
  export XDG_DATA_DIRS=$(brew --prefix shared-mime-info)/share
fi
# }}}

# vim:set ft=zsh:
