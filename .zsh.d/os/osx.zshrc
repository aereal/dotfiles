# vim:set ft=zsh:

alias ql='qlmanage -p "$@" >& /dev/null'

if [[ -d "/Applications/Gyazolife.app" ]]; then
  alias gyazolife="open /Applications/Gyazolife.app"
fi

if [[ -f "$MACVIM" ]]; then
  alias vim="$MACVIM"
  alias vi="$MACVIM"

  function macvim () {
    local macvim_executables_dir=$(dirname $MACVIM)
    local mvim="${macvim_executables_dir}/mvim"

    if [[ ${#@} = 0 ]]; then
      $mvim
    else
      $mvim --remote-tab-silent $@
    fi
  }
fi

if [[ -n "$GNU_COREUTILS" ]]; then
  alias ls='ls --color --classify --almost-all'
  alias ll='ls --color --classify --almost-all --human-readable -l'
fi
