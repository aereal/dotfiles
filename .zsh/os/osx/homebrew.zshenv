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

if [[ -n $(which brew) && -n $(brew list | grep coreutils) ]]; then
  export GNU_COREUTILS=1

  path=(
    $(brew --prefix coreutils)/libexec/gnubin(N-/)
    $path
  )
fi

if [[ -n $(which brew) && -n $(brew list | grep hub) ]]; then
  export OVERRIDE_GIT_WITH_HUB=1

  git() {
    hub "$@"
  }
fi
