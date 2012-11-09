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
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

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

# Python
if [[ -n $(which brew) && -n $(brew list | grep python) ]]; then
  export HOMEBREW_PYTHON=1

  path=(
    ${HOMEBREW_HOME}/share/python(N-/)
    ${path}
  )
fi
