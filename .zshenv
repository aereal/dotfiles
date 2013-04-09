export ZSH_HOME=$HOME/.zsh.d
export HOMEBREW_HOME=$HOME/opt/homebrew
export RBENV_HOME=$HOME/.rbenv
export PLENV_HOME=$HOME/.plenv

if [[ -e "$HOMEBREW_HOME/opt/macvim/MacVim.app" ]]; then
  export EDITOR="$HOMEBREW_HOME/opt/macvim/MacVim.app/Contents/MacOS/Vim"
elif [[ -e "/Applications/MacVim.app" ]]; then
  export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
else
  export EDITOR=vim
fi

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
  rbenv_path \
  plenv_path \
  sudo_path \
  system_path
user_path=(
  $HOME/bin(N-/)
)
rbenv_path=(
  $RBENV_HOME/shims(N-/)
)
plenv_path=(
  $PLENV_HOME/shims(N-/)
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
  $rbenv_path
  $plenv_path
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
export LESS="-R"

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
  eval "$(rbenv init -)"
fi
# }}}


# shared-mime-info {{{
if /usr/bin/which -s update-mime-database; then
  export XDG_DATA_HOME=$(brew --prefix shared-mime-info)/share
  export XDG_DATA_DIRS=$(brew --prefix shared-mime-info)/share
fi
# }}}

# vim:set ft=zsh:
