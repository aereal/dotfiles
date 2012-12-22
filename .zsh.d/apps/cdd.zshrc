# vim:set ft=zsh:

if [[ -f "${ZSH_HOME}/plugins/cdd/cdd" ]]; then
  source "${ZSH_HOME}/plugins/cdd/cdd"
  add-zsh-hook chpwd _cdd_chpwd
fi
