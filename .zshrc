bindkey -v

# function load path {{{
typeset -Ua fpath
fpath=(
  $HOME/.zsh.d/functions(N-/)
  $HOMEBREW_PATH/share/zsh-completions(N-/)
  $HOMEBREW_PATH/share/zsh/site-functions(N-/)
  $HOMEBREW_PATH/share/zsh/functions(N-/)
  $HOMEBREW_PATH/opt/docker-completion/share/zsh/site-functions(N-/)
  $HOMEBREW_PATH/opt/docker-compose-completion/share/zsh/site-functions(N-/)
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
  no_flow_control \
  hist_save_no_dups \
  hist_ignore_all_dups
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -v "^N" history-beginning-search-forward-end
bindkey -v "^P" history-beginning-search-backward-end
bindkey -v "^R" history-incremental-pattern-search-backward
bindkey -v "^S" history-incremental-pattern-search-forward
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

# expand backslash to tilde {{{
# Originally from: https://github.com/cho45/dotfiles/blob/64ea90d17aaf6c46a2cb090f2e12a6e3d7df6034/.zshrc#L245
expand-to-home-or-complete() { # {{{
  if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
    LBUFFER+="~/"
  else
    zle self-insert
  fi
} # }}}

zle -N expand-to-home-or-complete
bindkey -v "\\" expand-to-home-or-complete
# }}}

# ghq {{{
__widget_cd_repo() {
  local selected_repo=$( ghq list | fzf )
  if [[ -n "$selected_repo" ]]; then
    BUFFER="pushd $(ghq root)/${selected_repo}"
    zle accept-line
  fi
  zle -R -c
}
zle -N __widget_cd_repo
bindkey -v "^]^G" __widget_cd_repo
# }}}

# git {{{
__widget_git_recent_branches() {
  local selected_branch=$( \
    git for-each-ref --sort=-committerdate --format="%(refname)	%(committerdate:relative)" -- refs/heads \
    | sed -E 's/refs\/heads\///' \
    | fzf --query "$LBUFFER" \
    | cut -f1 \
    )
  if [[ -n "$selected_branch" ]]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle -R -c
}
zle -N __widget_git_recent_branches
bindkey -v "^]gr" __widget_git_recent_branches
# }}}

# tmux: split window with vim-like key mappings {{{
# vertical split {{{
tmux_vsplit() {
  BUFFER="tmux split-window -d -p 50 -h '$BUFFER'" # TODO: escape
  zle accept-line
}
zle -N tmux_vsplit
bindkey -v "^Wv" tmux_vsplit
# }}}

# horizontal split {{{
tmux_split() {
  BUFFER="tmux split-window -d -p 50 -v '$BUFFER'" # TODO: escape
  zle accept-line
}
zle -N tmux_split
bindkey -v "^Ws" tmux_split
# }}}
# }}}

# alias {{{
alias :q=exit
if whence eza >/dev/null 2>&1; then
  alias  l='eza -aF'
  alias ls='eza -aF'
  alias ll='eza -alF'
else
  if whence gls >/dev/null; then
    alias  l='gls --color=auto -AF'
    alias ls='gls --color=auto -AF'
    alias ll='gls --color=auto -AFl'
  else
    alias  l='ls -GAF'
    alias ls='ls -GAF'
    alias ll='ls -GAFl'
  fi
fi
whence hub >/dev/null 2>&1 && alias git=hub
# }}}

# abbrev {{{
setopt extended_glob
typeset -A abbreviations
abbreviations=(
  'Ig' '| rg'
  'It' '| tail'
  'Ij' '| jq'
  'DC' 'docker-compose'
)

magic-abbrev-expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey -v " " magic-abbrev-expand
bindkey -v "^x " no-magic-abbrev-expand
# }}}

# prompt {{{
setopt \
  prompt_subst \
  prompt_percent \
  transient_rprompt
autoload -U promptinit && promptinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' max-exports 4
zstyle ':vcs_info:(git|svn):*' formats '%R' '%S' '%b' '%s'
zstyle ':vcs_info:(git|svn):*' actionformats '%R' '%S' '%b|%a' '%s'
zstyle ':vcs_info:*' formats '%R' '%S' '%s:%b' '%s'
zstyle ':vcs_info:*' actionformats '%R' '%S' '%s:%b|%a' '%s'

__configure_prompt() {
  local ok_yuno="%F{yellow}✘╹◡╹✘%f"
  local bad_yuno="%F{red}✘>﹏<✘%f"
  local command_line="[%D{%Y-%m-%d} %*] %(?.${ok_yuno}.${bad_yuno}) < "

  psvar=()
  STY= LANG=en_US.UTF-8 vcs_info
  repos=`print -nD "$vcs_info_msg_0_"`
  if [[ -n "$vcs_info_msg_1_" ]]; then
      vcs="$vcs_info_msg_3_"
  else
      vcs=''
  fi
  [[ -n "$repos" ]] && psvar[2]="$repos"
  [[ -n "$vcs_info_msg_1_" ]] && psvar[3]="$vcs_info_msg_1_"
  [[ -n "$vcs_info_msg_2_" ]] && psvar[1]="$vcs_info_msg_2_"

  local psdirs='[%F{yellow}%3(v|%32<..<%3v%<<|%60<..<%~%<<)%f]'
  local psvcs='%3(v|[%25<\<<%F{yellow}%2v%f@%F{blue}%1v%f%<<]|)'

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

  export RPROMPT="${psdirs}${git_is_dirty}${git_local_changes}${git_upstream_changes}${psvcs}"
}
autoload -Uz add-zsh-hooks
add-zsh-hook precmd __configure_prompt
# }}}

# Show anyenv version {{{
notify_llenv_version() {
  for llenv in rbenv plenv ndenv pyenv; do
    llenv_root="${HOME}/.${llenv}" # XXX
    if whence $llenv >/dev/null && [[ "$(${llenv} version-origin)" != "$llenv_root/version" ]]; then
      echo "$fg[yellow]${llenv} changed version: $(${llenv} version-name)$reset_color"
    fi
  done
}
add-zsh-hook chpwd notify_llenv_version
# }}}

# Update current window name {{{
update_window_title() { # {{{
  emulate -L zsh
  local -a cmd
  cmd=(${(z)2})

  case $cmd[1] in
    *=*) # PLENV_VERSION=5.14.2 plenv exec perl -v => plenv
      echo -n "k$cmd[2]:t\\"
      return
      ;;
    ls|gls|clear|pwd)
      echo -n "k$ZSH_NAME\\"
      return
      ;;
    sudo|cd)
      echo -n "k$cmd[1] $cmd[2]:t\\"
      return
      ;;
    *)
      echo -n "k$cmd[1]:t\\"
      return
      ;;
  esac

  local -A jt
  jt=(${(kv)jobtexts})
  $cmd >>(read num rest cmd=(${(z)${(e):-\$jt$num}}) echo -n "k$cmd[1]:t\\") 2>/dev/null
} # }}}

if [ "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  add-zsh-hook preexec update_window_title
fi
# }}}

# direnv {{{
if whence direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi
# }}}

# syntax highlight {{{
if [[ -f "$HOMEBREW_PATH/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source $HOMEBREW_PATH/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# }}}

# substring-search {{{
if [[ -f "$HOMEBREW_PATH/opt/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source $HOMEBREW_PATH/opt/zsh-history-substring-search/zsh-history-substring-search.zsh

  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down
fi
# }}}

if ! ssh-add -l 2>/dev/null; then
  echo '---> Add SSH private key'
  ssh-add
fi


if [[ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

if whence op >/dev/null; then
  eval "$(op completion zsh)"
  compdef _op op
fi

FZF_DEFAULT_OPTS='--layout reverse'

# tmux {{{
if whence tmux >/dev/null && [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  if $(tmux has-session 2>/dev/null); then
    tmux attach-session -t "${HOST%%.*}"
  else
    tmux new-session -s "${HOST%%.*}"
  fi
  FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --tmux"
fi
# }}}

export FZF_DEFAULT_OPTS

# vim:set foldmethod=marker:
