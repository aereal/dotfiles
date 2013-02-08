export ZSH_HOME=$HOME/.zsh.d
export HOMEBREW_HOME=$HOME/Homebrew
export RBENV_HOME=$HOME/.rbenv
export PERLBREW_ROOT=$HOME/.perlbrew

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
  sudo_path \
  system_path
user_path=(
  $HOME/bin(N-/)
)
rbenv_path=(
  $RBENV_HOME/bin(N-/)
  $RBENV_HOME/shims(N-/)
)
perlbrew_path=(
  $PERLBREW_ROOT/bin(N-/)
)
homebrew_path=(
  $HOMEBREW_HOME/share/npm/bin(N-/)
  $HOMEBREW_HOME/share/python(N-/)
  $HOMEBREW_HOME/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_HOME/bin(N-/)
)
system_path=(
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

if [[ -e "$HOME/.local.env" ]]; then
  source "$HOME/.local.env"
fi

# rbenv {{{
if /usr/bin/which -s rbenv; then
  eval "$(rbenv init -)"
fi
# }}}

# perlbrew {{{
if [[ -e "$PERLBREW_ROOT/etc/bashrc" ]]; then
  source "$PERLBREW_ROOT/etc/bashrc"
fi
# }}}

# vim:set ft=zsh:
