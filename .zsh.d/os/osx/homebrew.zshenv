# vim:set ft=zsh:

export HOMEBREW_HOME="/usr/local"

path=(
  ${HOMEBREW_HOME}/bin(N-/)
  $path
)

fpath=(
  ${HOMEBREW_HOME}/share/zsh/site-functions(N-/)
  ${HOMEBREW_HOME}/share/zsh/functions(N-/)
  ${fpath}
)

typeset -a homebrew_callbacks

function setup_coreutils() {
  if [[ -n $(brew list | grep coreutils) ]]; then
    export GNU_COREUTILS=1

    path=(
      $(brew --prefix coreutils)/libexec/gnubin(N-/)
      $path
    )
  fi
}
homebrew_callbacks=($homebrew_callbacks setup_coreutils)

function setup_hub() {
  if [[ -n $(brew list | grep hub) ]]; then
    export OVERRIDE_GIT_WITH_HUB=1

    git() {
      hub "$@"
    }
  fi
}
homebrew_callbacks=($homebrew_callbacks setup_hub)

function setup_python() {
  if [[ -n $(brew list | grep python) ]]; then
    export HOMEBREW_PYTHON=1

    path=(
      ${HOMEBREW_HOME}/share/python(N-/)
      ${path}
    )
  fi
}
homebrew_callbacks=($homebrew_callbacks setup_python)

function setup_npm() {
  if [[ -n $(brew list | grep node) && -n $(which npm) ]]; then
    export USE_BREWED_NPM=1

    path=(
      ${HOMEBREW_HOME}/share/npm/bin(N-/)
      ${path}
    )
  fi
}
homebrew_callbacks=($homebrew_callbacks setup_npm)

if [[ -n $(which brew 2>/dev/null) ]]; then
  local callback
  for callback in $homebrew_callbacks; do
    $callback
  done
fi
