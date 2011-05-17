#vim:set ft=zsh:

[ $STY ] || screen -rx || screen -D -RR -U

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
#autoload -U -z my-expand-abbrev
#zle -N my-expand-abbrev
#typeset -A myabbrev
#myabbrev=(
#	" L" "| \$PAGER"
#	" G" "| grep"
#)

# http://subtech.g.hatena.ne.jp/cho45/20100814/1281726377
typeset -A abbreviations
abbreviations=(
	" L" " | \$PAGER"
	" G" " | grep"
)

magic-abbrev-expand () {
	local MATCH
	LBUFFER=${LBUFFER%%(#m) [-_a-zA-Z0-9^]#}
	LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-space () {
	magic-abbrev-expand
	zle self-insert
}

magic-abbrev-expand-and-insert () {
	magic-abbrev-expand
	zle self-insert
}

magic-abbrev-expand-and-insert-complete () {
	magic-abbrev-expand
	zle self-insert
	zle expand-or-complete
}

magic-abbrev-expand-and-accept () {
	magic-abbrev-expand
	zle accept-line
}

magic-abbrev-expand-and-normal-complete () {
	magic-abbrev-expand
	zle expand-or-complete
}

no-magic-abbrev-expand () {
	LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-magic-space
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-insert-complete
zle -N magic-abbrev-expand-and-normal-complete
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
zle -N magic-space

autoload -U -z show-window-title
preexec_functions=($preexec_functions show-window-title)

. $HOME/.zsh/key-bind.zsh
. $HOME/.zsh/aliases.zsh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && . "$HOME/.pythonbrew/etc/bashrc"

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

