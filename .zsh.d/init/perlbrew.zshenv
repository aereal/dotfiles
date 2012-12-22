# vim:set ft=zsh:

export PERLBREW_ROOT="${HOME}/.perlbrew"
if [[ -f "${PERLBREW_ROOT}/etc/bashrc" ]]; then
  source "${PERLBREW_ROOT}/etc/bashrc"
fi

path=(
  $PERLBREW_ROOT/bin(N-/)
  $path
)
