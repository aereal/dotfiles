# vim: set ft=zsh:

alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias macvim='/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent "$@"'
alias ls="ls -G -F"
alias l="ls -G -AF"
alias ll="ls -G -AFl"
alias ql='qlmanage -p "$@" >& /dev/null'

# inspired by https://gist.github.com/953741
abbreviations=(
  " L" " | \$PAGER"
  " G" " | grep"
  " C" " | pbcopy"
)

gyazolife() {
  screencapture -i ~/Pictures/screencaptures/$(date +'%Y%m%d%H%M%S').png
  open 'http://f.hatena.ne.jp/aereal/up?folder=screenshot'
}
