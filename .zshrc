#vim:set ft=zsh:

export GEM_HOME=/var/lib/gems/1.8
export PAGER=less
export EDITOR=vim
export LS_COLORS='di=33:ln=36:so=35:ex=31:su=41;32:sg=41;34:'
export SCALA_HOME=/usr/share/scala
export GAE_SDK_HOME=$HOME/sdk/google_appengine

PATHS=(
	$HOME/bin
	$HOME/local/bin
	$HOME/lib/ruby/gems/1.8/bin
	$GEM_HOME/bin
	$SCALA_HOME/bin
	$GAE_SDK_HOME
	$PATH
)

RUBYLIBS=(
	/usr/lib/ruby/1.8
	$HOME/lib
	$HOME/lib/ruby
	$HOME/lib/ruby/site_ruby/1.8
)

export PATH=${(j.:.)PATHS}
export RUBYLIB=${(j.:.)RUBYLIBS}

case $TERM in
	linux) LANG=C ;;
	*) LANG=ja_JP.UTF-8 ;;
esac

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
alias l='/bin/ls --color -AF'
alias ls='/bin/ls --color -F'
alias la='/bin/ls --color -AFl'
alias unt='tar zxvf '

autoload -U promptinit ; promptinit
autoload -U colors     ; colors
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

typeset -A myabbrev
myabbrev=(
	"L" "| \$PAGER"
	"G" "| grep"
)

my-expand-abbrev() {
	local left prefix
	left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
	prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
	LBUFFER=$left${myabbrev[$prefix]:-$prefix}" "
}

zle -N my-expand-abbrev
bindkey " " my-expand-abbrev

function screen-new-window-with-command-as-window-title () {
	screen -t $1 $@
}

alias n='screen-new-window-with-command-as-window-title'

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

RPROMPT='[`rprompt-git-current-branch`%~]'
PROMPT='%{[34m%} S | v | Z < %{[m%}'

ostype=`uname`
if [[ -f "$HOME/.zsh/$ostype.zshrc" ]]; then
	source "$HOME/.zsh/$ostype.zshrc"
fi

tty > /tmp/screen-tty-$WINDOW

if [[ $SHLVL = 1 ]]; then
	screen
fi

