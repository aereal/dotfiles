#vim:set ft=zsh:

bindkey -v

# options
setopt always_last_prompt auto_cd auto_pushd auto_menu auto_param_keys
setopt auto_remove_slash correct cdable_vars extended_history extended_glob
setopt hist_ignore_dups hist_ignore_space ignore_eof list_types no_beep
setopt print_eight_bit pushd_ignore_dups prompt_subst sh_word_split 

# completion
autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# command alias
alias ..='cd ..'
alias ls='ls -aFh --color'
alias unt='tar zxvf '
alias vsm='ruby ~/code/vim-script-manager/vsm.rb '

autoload -U promptinit ; promptinit
autoload -U colors     ; colors
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
	# http://d.hatena.ne.jp/uasi/20091025/1256458798
	local name st color gitdir action
	if [[ "$PWD" =~ '\.git(/.*)?$' ]]; then
		return
	fi
	name=`git branch 2> /dev/null | grep '^\*' | cut -b 3-`
	if [[ -z $name ]]; then
		return
	fi

	gitdir=`git rev-parse --git-dir 2> /dev/null`
	action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

	st=`git status 2> /dev/null`
	if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
		color=%F{green}
	elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
		color=%F{yellow}
	elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
		color=%B%F{red}
	else
		color=%F{red}
	fi

	echo "$color$name$action%f%b "
}

function resume () {
	screen -x workspace || screen -r workspace || screen -S workspace
}

RPROMPT='[`rprompt-git-current-branch`%~]'
PROMPT='%{[34m%} S | v | Z < %{[m%}'

ostype=`uname`
if [[ -f "$HOME/.zsh/$ostype.zshrc" ]]; then
	source "$HOME/.zsh/$ostype.zshrc"
fi

tty > /tmp/screen-tty-$WINDOW

