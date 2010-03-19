# vim:set ft=zsh:

export GEM_HOME=$HOME/lib/ruby/gems
export EDITOR=vim

PATHS=(
	/sbin
	/bin
	/usr/bin
	/usr/local/bin
	$HOME/bin
	$HOME/local/bin
	$HOME/lib/ruby/gems/1.8/bin
	$GEM_HOME/bin
	$PATH
)

RUBYLIBS=(
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
setopt print_eight_bit
setopt auto_menu
setopt correct
setopt auto_remove_slash
setopt auto_param_keys
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt prompt_subst
setopt extended_glob
setopt list_types
setopt no_beep
setopt always_last_prompt
setopt cdable_vars
setopt sh_word_split
setopt ignore_eof

# completion
autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=100000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-begenning-search-backward-end
bindkey "" history-begenning-search-forward-end

# command alias
alias ..='cd ..'
alias ls='ls -f --color'
alias unt='tar zxvf '
alias vsm='ruby ~/code/vim-script-manager/vsm.rb '

autoload -U promptinit ; promptinit
autoload -U colors     ; colors
PROMPT_EXIT="%(?..exit %?
)
"
PROMPT_CWD="%{$reset_color%}[%{$fg[yellow]%}%~%{$reset_color%}]
"
PROMPT_CMD=" %{$reset_color%}%{$fg[green]%}S | v | Z < %{$reset_color%}"

function reload() {
	local j
	jobs > /tmp/$$-jobs
	j=$(</tmp/$$-jobs)
	if [ "$j" = "" ]; then
		exec zsh
	else
		fg
	fi
}

precmd () {
	PROMPT="$PROMPT_EXIT$PROMPT_CMD"
	RPROMPT="%{$reset_color%}[%{$fg[yellow]%}%~%{$reset_color%}]"
}

function n () {
	screen -X eval "chdir $PWD" "screen" "chdir"
}

