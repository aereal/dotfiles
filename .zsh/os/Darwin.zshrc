# vim: set ft=zsh:

alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias macvim='/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent "$@"'
alias ls="ls -G -F"
alias l="ls -G -AF"
alias la="ls -G -AFl"
alias ql='qlmanage -p "$@" >& /dev/null'

# inspired by https://gist.github.com/953741
abbreviations=(
	" L" " | \$PAGER"
	" G" " | grep"
	" C" " | pbcopy"
)

