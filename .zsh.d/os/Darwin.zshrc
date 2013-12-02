if whence qlmanage >/dev/null; then
  alias ql='qlmanage -p "$@" >& /dev/null'
fi

if [[ ! -d "$HOMEBREW_PATH/opt/coreutils" ]]; then
  alias  l='ls -GAF'
  alias ls='ls -GAF'
  alias ll='ls -GAFl'
fi

function macvim_client() { # {{{
  declare editor="/Applications/MacVim.app/Contents/MacOS/mvim"
  declare wrapper

  if whence reattach-to-user-namespace >/dev/null; then
    wrapper=reattach-to-user-namespace
  fi

  declare -a args
  args=($*)

  if [[ $#args > 0 ]]; then
    args=("--remote-silent" $args)
  fi

  $wrapper $editor "$args"
} # }}}

if whence brew >/dev/null && [[ -e "$(brew --prefix macvim)/MacVim.app/Contents/MacOS/Vim" ]]; then
  export EDITOR="$(brew --prefix macvim)/MacVim.app/Contents/MacOS/Vim"
fi

# vim:set ft=zsh foldmethod=marker:
