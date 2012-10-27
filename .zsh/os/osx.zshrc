# vim:set ft=zsh:

alias ql='qlmanage -p "$@" >& /dev/null'

if [[ -d "/Applications/Gyazolife.app" ]]; then
  alias gyazolife="open /Applications/Gyazolife.app"
fi

if [[ -f "$MACVIM" ]]; then
  alias vim="$MACVIM"
  alias vi="$MACVIM"
fi

if [[ -n "$GNU_COREUTILS" ]]; then
  alias ls='ls --color -AF'
fi
