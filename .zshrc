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
alias l='/bin/ls --color -AF'
alias ls='/bin/ls --color -F'
alias la='/bin/ls --color -AFl'
alias unt='tar zxvf '
alias s='screen'

autoload -U promptinit ; promptinit
autoload -U colors     ; colors
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

# Abbreviation
autoload -U -z my-expand-abbrev
typeset -A myabbrev
myabbrev=(
	"L" "| \$PAGER"
	"G" "| grep"
	"C" "| xsel --input --clipboard"
)

zle -N my-expand-abbrev
bindkey " " my-expand-abbrev

RPROMPT='[%~]'
PROMPT='%{[38;5;75m%} S | v | Z < %{[m%}'

autoload -U -z show-window-title
preexec_functions=($preexec_functions show-window-title)

ostype=`uname`
if [[ -f "$HOME/.zsh/$ostype.zshrc" ]]; then
	source "$HOME/.zsh/$ostype.zshrc"
fi

tty > /tmp/screen-tty-$WINDOW

if [[ $SHLVL = 1 ]]; then
	screen -UxR
fi

