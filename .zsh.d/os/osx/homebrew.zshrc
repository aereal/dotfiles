# vim:set ft=zsh:

if [[ -d "${HOMEBREW_HOME}/opt/zsh-completions" ]]; then
  fpath=(
    ${HOMEBREW_HOME}/share/zsh-completions
    ${fpath}
  )
fi

if [[ -n "${MACVIM_APP}" ]]; then
  alias vim="${MACVIM_APP}/Contents/MacOS/Vim"
  alias vi="${MACVIM_APP}/Contents/MacOS/Vim"
fi
