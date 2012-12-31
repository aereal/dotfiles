# vim:set ft=zsh:

export CHRUBY_ROOT="$HOME/.chruby"

if [[ -e "$CHRUBY_ROOT/share/chruby/chruby.sh" ]]; then
  source "$CHRUBY_ROOT/share/chruby/chruby.sh"
  source "$CHRUBY_ROOT/share/chruby/auto.sh"
fi
