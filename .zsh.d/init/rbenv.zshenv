# vim:set ft=zsh:

export RBENV_HOME="${HOME}/.rbenv"
eval "$(${RBENV_HOME}/bin/rbenv init -)"

path=(
  ${RBENV_HOME}/bin(N-/)
  $path
)
