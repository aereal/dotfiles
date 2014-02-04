set fish_greeting ""

set -x PATH /opt/homebrew/bin $HOME/.rbenv/shims $HOME/.rbenv/bin $HOME/.plenv/shims $HOME/.plenv/bin /usr/bin /usr/sbin /bin /sbin
set -x PATH $HOME/bin $PATH

set -U PAGER less
set -U LESS "--LONG-PROMPT --RAW-CONTROL-CHARS"
set -U MACVIM_APP /Applications/MacVim.app/Contents/MacOS/Vim
set -U EDITOR "reatach-to-user-namespace -l $MACVIM_APP"

function fish_prompt
  set -l last_status $status
  printf ' '
  if test $last_status -eq 0
    set_color yellow
    printf '✘╹◡╹✘'
  else
    set_color red
    printf '✘>﹏<✘'
  end
  set_color normal
  printf " < \n"
end

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_cleanstate green
function fish_right_prompt
  printf "%s " (__fish_git_prompt)
  set_color cyan
  prompt_pwd
end

function mvim
  reattach-to-user-namespace -l $MACVIM_APP --remote-silent $argv
end

function vim
  env LANG=en_US.UTF-8 reattach-to-user-namespace -l $MACVIM_APP $argv
end

alias l ls\ -AFG
alias ll ls\ -AFGl

if which tmux >/dev/null; and test -z $TMUX
  if tmux has-session >/dev/null
    tmux attach-session
  else
    tmux new-session
  end
end
