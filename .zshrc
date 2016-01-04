# function load path {{{
typeset -Ua fpath
fpath=(
  $HOME/.zsh.d/functions(N-/)
  $HOMEBREW_PATH/share/zsh-completions(N-/)
  $HOMEBREW_PATH/share/zsh/site-functions(N-/)
  $HOMEBREW_PATH/share/zsh/functions(N-/)
  $fpath
)
# }}}

# fundamental options {{{
export REPORTTIME=1

setopt extended_glob
# }}}

# history {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
set \
  extended_history \
  hist_ignore_dups \
  hist_ignore_space \
  inc_append_history \
  share_history \
  no_flow_control
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -e "^N" history-beginning-search-forward-end
bindkey -e "^P" history-beginning-search-backward-end
bindkey -e "^R" history-incremental-pattern-search-backward
bindkey -e "^S" history-incremental-pattern-search-forward
# }}}

# color {{{
autoload -Uz colors; colors
[[ -f "$HOME/.dircolors" ]] && source "$HOME/.dircolors"
# }}}

# completion {{{
zmodload -i zsh/complist
autoload -U compinit && compinit -C
setopt \
  complete_in_word \
  glob_complete  \
  hist_expand \
  no_beep \
  numeric_glob_sort

# Format {{{
zstyle ':completion:*' format '%F{magenta}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{yellow}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{magenta}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{blue}-- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Show selected candidate
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# Fuzzy match
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix

# sudo
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

# Directory candidates order
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

# Ignore current directory from directory candidates
zstyle ':completion:*' ignore-parents parent pwd

# Process candidates
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Show man candidates with section
zstyle ':completion:*:manuals' separate-sections true
# }}}

# key mapping {{{
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
# }}}

# }}}

# url-quote-magic {{{
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
# }}}

# expand childa to $HOME {{{
expand-to-home-or-complete() { # {{{
  if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
    LBUFFER+="~/"
  else
    zle self-insert
  fi
} # }}}

zle -N expand-to-home-or-complete
bindkey -e "\\" expand-to-home-or-complete
# }}}

# ghq {{{
__widget_cd_repo() {
  local selected_repo=$( ghq list | peco )
  if [[ -n "$selected_repo" ]]; then
    BUFFER="ghq look ${selected_repo}"
    zle accept-line
  fi
  zle -R -c
}
zle -N __widget_cd_repo
bindkey -e "^]^G" __widget_cd_repo
# }}}

# git {{{
__widget_git_recent_branches() {
  local selected_branch=$( \
    git for-each-ref --sort=-committerdate --format="%(refname)	||| %(subject) %(committerdate:relative)" -- refs/heads \
    | sed -E 's/refs\/heads\///' \
    | peco --query "$LBUFFER" \
    | cut -f1 \
    )
  if [[ -n "$selected_branch" ]]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle -R -c
}
zle -N __widget_git_recent_branches
bindkey -e "^]gr" __widget_git_recent_branches
# }}}

# tmux: split window with vim-like key mappings {{{
# vertical split {{{
tmux_vsplit() {
  BUFFER="tmux split-window -d -p 50 -h '$BUFFER'" # TODO: escape
  zle accept-line
}
zle -N tmux_vsplit
bindkey -e "^Wv" tmux_vsplit
# }}}

# horizontal split {{{
tmux_split() {
  BUFFER="tmux split-window -d -p 50 -v '$BUFFER'" # TODO: escape
  zle accept-line
}
zle -N tmux_split
bindkey -e "^Ws" tmux_split
# }}}
# }}}

# alias {{{
alias :q=exit
if whence gls >/dev/null; then
  alias  l='gls --color=auto -AF'
  alias ls='gls --color=auto -AF'
  alias ll='gls --color=auto -AFl'
else
  alias  l='ls -GAF'
  alias ls='ls -GAF'
  alias ll='ls -GAFl'
fi
whence hub >/dev/null 2>&1 && alias git=hub
# }}}

# prompt {{{
setopt \
  prompt_subst \
  prompt_percent \
  transient_rprompt
autoload -U promptinit && promptinit

__configure_prompt() {
  local ok_yuno="%F{yellow}✘╹◡╹✘%f"
  local bad_yuno="%F{red}✘>﹏<✘%f"
  local command_line="%(?.${ok_yuno}.${bad_yuno}) < "

  local git_is_dirty git_local_changes git_upstream_changes
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    command git diff --no-ext-diff --quiet --exit-code || git_is_dirty='%F{yellow}*%f'
    local git_upstream_status=$(command git rev-list --left-right --count ...@{u} 2>/dev/null)
    git_upstream_status=(${(ps:\t:)git_upstream_status})
    local left=${git_upstream_status[1]} right=${git_upstream_status[2]}
    (( ${left:-0} > 0 )) && git_local_changes='%F{green}⇡%f'
    (( ${right:-0} > 0 )) && git_upstream_changes='%F{red}⇣%f'
  fi

  export PROMPT="${command_line}"

  export RPROMPT="${git_is_dirty}${git_local_changes}${git_upstream_changes}[%~]"
}
autoload -Uz add-zsh-hooks
add-zsh-hook precmd __configure_prompt
# }}}

# Show anyenv version {{{
notify_llenv_version() {
  for llenv in rbenv plenv ndenv; do
    llenv_root="${HOME}/.${llenv}" # XXX
    if whence $llenv >/dev/null && [[ "$(${llenv} version-origin)" != "$llenv_root/version" ]]; then
      echo "$fg[yellow]${llenv} changed version: $(${llenv} version-name)$reset_color"
    fi
  done
}
add-zsh-hook chpwd notify_llenv_version
# }}}

# direnv {{{
if whence direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi
# }}}

# tmux {{{
if whence tmux >/dev/null && [ -z "$TMUX" ]; then
  if $(tmux has-session 2>/dev/null); then
    tmux attach-session -t "${HOST%%.*}"
  else
    tmux new-session -s "${HOST%%.*}"
  fi
fi
# }}}

# vim:set foldmethod=marker:
