# vim:set ft=zsh:

function update_window_title() {
  emulate -L zsh
  local -a cmd
  cmd=(${(z)2})

  case $cmd[1] in
    fg)
      if (( $#cmd == 1 )); then
        cmd=(builtin jobs -l %+)
      else
        cmd=(builtin jobs -l $cmd[2])
      fi
      ;;
    %*)
      cmd=(builtin jobs -l $cmd[1])
      ;;
    *=*)
      echo -n "k$cmd[2]:t\\"
      return
      ;;
    ls|clear|pwd)
      echo -n "k$ZSH_NAME\\"
      return
      ;;
    sudo|cd)
      echo -n "k$cmd[1] $cmd[2]:t\\"
      return
      ;;
    *)
      echo -n "k$cmd[1]:t\\"
      return
      ;;
  esac

  local -A jt
  jt=(${(kv)jobtexts})
  $cmd >>(read num rest cmd=(${(z)${(e):-\$jt$num}}) echo -n "k$cmd[1]:t\\") 2>/dev/null
}

if [ "$TMUX" ]; then
  preexec_functions=($preexec_functions update_window_title)
fi
