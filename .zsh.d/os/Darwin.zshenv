export HOMEBREW_PATH=${HOMEBREW_PATH:-/usr/local}

typeset -Ua homebrew_path
homebrew_paths=(
  $HOMEBREW_PATH/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_PATH/share/npm/bin(N-/)
  $HOMEBREW_PATH/share/python(N-/)
  $HOMEBREW_PATH/bin(N-/)
)
path=(
  $HOME/Library/Haskell/bin(N-/)
  $homebrew_paths
  $path
)

manpath=(
  $HOMEBREW_PATH/share/man(N-/)
  $HOMEBREW_PATH/opt/coreutils/libexec/gnuman(N-/)
)

# vim:set ft=zsh:
