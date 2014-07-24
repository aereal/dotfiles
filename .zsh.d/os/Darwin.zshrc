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

# Widgets {{{
# Cellar {{{
__widget_cd_cellar() { # {{{
  local selected=$(brew list | peco)
  if [[ -n "$selected" ]]; then
    BUFFER="cd $(brew --prefix $selected)"
    zle accept-line
  fi
  zle -R -c
} # }}}
zle -N __widget_cd_cellar
bindkey -v "^]^B" __widget_cd_cellar
# }}}
# }}}

# vim:set ft=zsh foldmethod=marker:
