# vim:set ft=zsh:

if [[ -d "${HOMEBREW_HOME}/opt/zsh-completions" ]]; then
  fpath=(
    ${HOMEBREW_HOME}/share/zsh-completions
    ${fpath}
  )
fi
