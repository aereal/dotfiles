# vim:set ft=zsh:

export HOMEBREW_HOME="${HOME}/Homebrew"

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

function setup_macvim() {
  if [[ -d "${HOMEBREW_HOME}/opt/macvim" ]] && [[ -d "${HOMEBREW_HOME}/opt/macvim/MacVim.app" ]]; then
    export MACVIM_APP="${HOMEBREW_HOME}/opt/macvim/MacVim.app"
  fi
}
homebrew_callbacks=($homebrew_callbacks setup_macvim)

function setup_zsh_completions() {
  if [[ -d "${HOMEBREW_HOME}/share/zsh-completions" ]]; then
    fpath=(
      ${HOMEBREW_HOME}/share/zsh-completions
      $fpath
    )
  fi
}
homebrew_callbacks=($homebrew_callbacks setup_zsh_completions)

if [[ -n $(which brew 2>/dev/null) ]]; then
  local callback
  for callback in $homebrew_callbacks; do
    $callback
  done
fi
