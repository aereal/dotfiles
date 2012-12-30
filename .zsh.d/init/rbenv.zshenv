# vim:set ft=zsh:

export RBENV_HOME="${HOME}/.rbenv"

if [[ -e "$RBENV_HOME/bin/rbenv" ]]; then
  eval "$(${RBENV_HOME}/bin/rbenv init -)"
  path=(
    ${RBENV_HOME}/bin(N-/)
    $path
  )
fi
