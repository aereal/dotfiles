# Environment variables {{{
export ZSH_HOME=$HOME/.zsh.d
export HOMEBREW_HOME=$HOME/opt/homebrew
export RBENV_HOME=$HOME/.rbenv
export PLENV_HOME=$HOME/.plenv
export EDITOR=vim
# }}}

# fpath {{{
typeset -Ua fpath
fpath=(
  $ZSH_HOME/site-functions(N-/)
  $HOMEBREW_HOME/share/zsh-completions(N-/)
  $HOMEBREW_HOME/share/zsh/site-functions(N-/)
  $HOMEBREW_HOME/share/zsh/functions(N-/)
  $fpath
)
# }}}

# paths {{{
typeset -Ua \
  user_path \
  homebrew_path \
  sudo_path \
  system_path
user_path=(
  $HOME/bin(N-/)
)
homebrew_path=(
  $HOMEBREW_HOME/opt/coreutils/libexec/gnubin(N-/)
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
# }}}

# manpath {{{
typeset -U manpath
manpath=(
  $HOME/local/share/man(N-/)
  $HOMEBREW_HOME/opt/coreutils/libexec/gnuman(N-/)
  $HOMEBREW_HOME/share/man(N-/)
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

# Grep {{{
GREPPRG=grep

if which ack >/dev/null; then
  GREPPRG=ack
elif which ag >/dev/null; then
  GREPPRG=ag
fi

export GREPPRG
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

# shared-mime-info {{{
if which update-mime-database >/dev/null; then
  export XDG_DATA_HOME=$HOMEBREW_HOME/opt/shared-mime-info/share
  export XDG_DATA_DIRS=$HOMEBREW_HOME/opt/shared-mime-info/share
fi
# }}}

# SSL certificates {{{
if [[ -f "$HOMEBREW_HOME/opt/curl-ca-bundle/share/ca-bundle.crt" ]]; then
  export SSL_CERT_FILE="$HOMEBREW_HOME/opt/curl-ca-bundle/share/ca-bundle.crt"
fi
# }}}

# zsh-syntax-highlight {{{
export ZSH_SYNTAX_HIGHLIGHT_ROOT="$HOMEBREW_HOME/share/zsh-syntax-highlighting"
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH_SYNTAX_HIGHLIGHT_ROOT/highlighters"
# }}}

# vim:set ft=zsh foldmethod=marker:
