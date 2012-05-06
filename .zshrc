#vim:set ft=zsh:

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

bindkey -v

# options
setopt always_last_prompt
setopt auto_cd
setopt auto_pushd
setopt auto_menu
setopt auto_param_keys
setopt auto_remove_slash
setopt correct
setopt cdable_vars
setopt complete_in_word
setopt extended_history
setopt extended_glob
setopt glob_complete
setopt hist_expand
setopt hist_ignore_dups
setopt hist_ignore_space
setopt ignore_eof
setopt inc_append_history
setopt list_types
setopt magic_equal_subst
setopt no_beep
setopt print_eight_bit
setopt pushd_ignore_dups
setopt prompt_subst
setopt sh_word_split
setopt share_history

# completion
autoload -U compinit
compinit -u

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo' command-path $PATH
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

autoload -U promptinit; promptinit
autoload -U colors;     colors

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

autoload -U -z VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -U -z rprompt-git-current-branch

init_prompt() {
  local git_branch=$(rprompt-git-current-branch)
  if [[ -x `which rvm-prompt` ]]; then
    PROMPT_RUBY="%{${fg[red]}%}(`rvm-prompt`)%{${reset_color}%}"
  elif [[ `type rbenv` = 'rbenv is a shell function' ]]; then
    PROMPT_RUBY="%{${fg[red]}%}(ruby-`rbenv version-name`)%{${reset_color}%}"
  fi
  if [[ -n "$PERLBREW_PERL" ]]; then
    PROMPT_PERLBREW="%{${fg[blue]}%}($PERLBREW_PERL)%{${reset_color}%}"
  fi
  if [[ -n "$PATH_PYTHONBREW" ]]; then
    local python_version
    python_version=$(basename $(dirname $(dirname $(which python))))
    python_version=$(ruby -e 'x=ARGV[0];puts x if x.strip[/^Python-(\d+\.?)+$/]' -- $(echo $python_version))
    if [[ -n "$python_version" ]]; then
      PROMPT_PYTHONBREW="%{${fg[yellow]}%}($python_version)%{${reset_color}%}"
    fi
  fi
  PROMPT_USER="%{${fg[red]}%}<%n%#%m>%{${reset_color}%}"
  PROMPT_CWD="[%{${fg[magenta]}%}%~%{${reset_color}%}]"
  if [[ "x$SSH_CLIENT" != "x" ]]; then
    PROMPT_CWD="$PROMPT_CWD $PROMPT_USER"
  fi
  PROMPT_CMD=" %(?,%{${fg[yellow]}%}X | _ | X%{${reset_color}%},%{${fg[red]}%}X > _ < X%{${reset_color}%}) < "
  if [[ "x$git_branch" != "x" ]]; then
    PROMPT="$PROMPT_CWD ($git_branch)
$PROMPT_CMD"
  else
    PROMPT="$PROMPT_CWD
$PROMPT_CMD"
  fi
  RPROMPT="$PROMPT_RUBY $PROMPT_PERLBREW $PROMPT_PTYHONBREW"
}

precmd_functions=(init_prompt $precmd_functions)

# key-bindings
bindkey "\r" magic-abbrev-expand-and-accept
bindkey " "  magic-space
bindkey "."  magic-abbrev-expand-and-insert
bindkey "^F" push-input
bindkey "^I" magic-abbrev-expand-and-normal-complete
bindkey "^J" accept-line
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# aliases
alias ..='cd ..'
alias l='/bin/ls --color -AF'
alias ls='/bin/ls --color -F'
alias ll='/bin/ls --color -AFl'
alias :q='exit'
alias ps='ps aux'

if [[ -d "$HOME/.zsh.d/plugins/zaw" ]] && [[ -r "$HOME/.zsh.d/plugins/zaw/zaw.zsh" ]]; then
  source "$HOME/.zsh.d/plugins/zaw/zaw.zsh"
fi

uname=`uname`
[[ -f "$ZSH_USER_DIR/os/$uname.zshrc" ]] && . "$ZSH_USER_DIR/os/$uname.zshrc"
[[ -f "$ZSH_USER_DIR/hosts/$HOST.zshrc" ]] && . "$ZSH_USER_DIR/hosts/$HOST.zshrc"

if [[ "x$MULTIPLEXOR" != "x" ]]; then
  autoload -U -z show-window-title
  preexec_functions=($preexec_functions show-window-title)
fi

case $MULTIPLEXOR in
  tmux)
    if [ -z $TMUX ]; then
      if $(tmux has-session); then
        tmux attach
      else
        tmux
      fi
    fi
    ;;
  tscreen|screen)
    if [[ $MULTIPLEXOR == "tscreen" ]]; then
      alias screen=tscreen
    fi
    [ $STY ] || screen -rx || screen -D -RR -U
    ;;
  *)
    ;;
esac
