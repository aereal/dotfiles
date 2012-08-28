# vim:set ft=zsh:

export PERLBREW_ROOT=$HOME/.perlbrew
[[ -f "$PERLBREW_ROOT/etc/bashrc" ]] && . $PERLBREW_ROOT/etc/bashrc

path=(
  $PERLBREW_ROOT/bin(N-/)
  $path
)
