#vim:set ft=zsh:

# screenが起動していなければ、attachを試みる。attachするセッションがなければ新しくセッションを張る。
[ ${STY} ] || screen -rx || screen -D -RR -U

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
#autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

# Abbreviation
autoload -U -z my-expand-abbrev
zle -N my-expand-abbrev
typeset -A myabbrev
myabbrev=(
	"L" "| \$PAGER"
	"G" "| grep"
	"C" "| xsel --input --clipboard"
	"N" "&& notify-send -i /usr/share/icons/Humaniti/actions/48/dialog-apply.svg Finished!"
)

RPROMPT='[%{${fg[yellow]}%}%~%{${reset_color}%}]'
PROMPT="%{${fg[blue]}%} -[] _ []- <%{${reset_color}%} "

# SSHで接続した先だと、ホスト名を派手に出す。
[ -n "${SSH_CONNECTION}" ] && PROMPT=" %{${fg[red]}%}[${HOST}]:
${PROMPT}"

autoload -U -z show-window-title
preexec_functions=($preexec_functions show-window-title)

. $HOME/.zsh/key-bind.zsh
. $HOME/.zsh/aliases.zsh

[[ -f "$HOME/.zsh/$HOST.zshrc" ]] && . "$HOME/.zsh/$HOST.zshrc"

tty > /tmp/screen-tty-$WINDOW

