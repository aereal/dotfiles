# vim: set ft=zsh:

alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias ls="ls -G -F"
alias l="ls -G -AF"
alias la="ls -G -AFl"

# inspired by https://gist.github.com/953741
local grepish=$(([ -x `which ack` ] && echo ack) || echo grep)
abbreviations=(
	" L" " | \$PAGER"
	" G" " | $grepish"
	" C" " | pbcopy"
)

