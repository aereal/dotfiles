#vim:set ft=zsh:

if [[ -x `which tmux` ]]; then
	[ $TMUX ] || tmux attach || tmux -2u
elif	[[ -x `which screen` ]]; then
	[ $STY ] || screen -rx || screen -D -RR -U
fi

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

# sudoも補完
zstyle ':completion:*:sudo' command-path $PATH

# lower-caseでもupper-caseにマッチするように
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ファイル補完にも色つけたい
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cdで補完するときに、PATHの通っているディレクトリの優先度を下げる
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

autoload -U promptinit ; promptinit
autoload -U colors     ; colors

# Abbreviation
autoload -U -z my-expand-abbrev
zle -N my-expand-abbrev
typeset -A myabbrev
myabbrev=(
	"L" "| \$PAGER"
	"G" "| grep"
)

autoload -U -z show-window-title
preexec_functions=($preexec_functions show-window-title)

. $HOME/.zsh/key-bind.zsh
. $HOME/.zsh/aliases.zsh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

init_prompt() {
	first_line="%{${fg[yellow]}%}<%n@%m>"
	[[ -n "$rvm_ruby_string" ]] && first_line="$first_line %{${fg[red]}%}($rvm_ruby_string)"
	second_line=" %{${fg[green]}%}S | v | Z %{${reset_color}%}< "
	PROMPT="${first_line}
${second_line}"
	RPROMPT="[%{${fg[yellow]}%}%~%{${reset_color}%}]"
}

precmd_functions=($precmd_functions init_prompt)

uname=`uname`
[[ -f "$HOME/.zsh/$uname.zshrc" ]] && . "$HOME/.zsh/$uname.zshrc"
[[ -f "$HOME/.zsh/$HOST.zshrc" ]] && . "$HOME/.zsh/$HOST.zshrc"

