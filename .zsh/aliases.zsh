# vim:set ft=zsh:

alias ..='cd ..'
alias l='/bin/ls --color -AF'
alias ls='/bin/ls --color -F'
alias la='/bin/ls --color -AFl'
alias unt='tar zxvf'
alias :q='exit'
alias ps='ps aux'

if [[ -x `which screen` ]]; then
	alias j='screen'
elif [[ -x `which tmux` ]]; then
	alias j='tmux new-window'
fi

