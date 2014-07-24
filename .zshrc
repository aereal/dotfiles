# fpath {{{
typeset -Ua fpath
fpath=(
  $ZSH_HOME/functions(N-/)
  $HOMEBREW_HOME/share/zsh/site-functions(N-/)
  $HOMEBREW_HOME/share/zsh/functions(N-/)
  $fpath
)
# }}}

# Grep {{{
GREPPRG=grep

if which ack >/dev/null; then
  GREPPRG=ack
elif which ag >/dev/null; then
  GREPPRG=ag
fi

export GREPPRG
# }}}

# shared-mime-info {{{
if which update-mime-database >/dev/null; then
  export XDG_DATA_HOME=$HOMEBREW_HOME/opt/shared-mime-info/share
  export XDG_DATA_DIRS=$HOMEBREW_HOME/opt/shared-mime-info/share
fi
# }}}

# zsh-syntax-highlight {{{
export ZSH_SYNTAX_HIGHLIGHT_ROOT="$ZSH_HOME/plugins/zsh-syntax-highlighting"
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH_SYNTAX_HIGHLIGHT_ROOT/highlighters"
# }}}

setopt extended_glob
autoload -Uz zmv
autoload -Uz gyapbox
autoload -Uz add-zsh-hooks

export REPORTTIME=1

bindkey -v

# Colors {{{
autoload -Uz colors; colors

if [[ -f "$HOME/.dircolors" ]]; then
  source "$HOME/.dircolors"
fi
# }}}

# History {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

setopt \
  extended_history \
  hist_ignore_dups \
  hist_ignore_space \
  inc_append_history \
  share_history \
  no_flow_control

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey -v "^N" history-beginning-search-forward-end
bindkey -v "^P" history-beginning-search-backward-end
bindkey -v "^R" history-incremental-pattern-search-backward
bindkey -v "^S" history-incremental-pattern-search-forward
# }}}

# VCS {{{
autoload -U -z VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -U -z VCS_INFO_git_getaction; VCS_INFO_git_getaction 2>/dev/null
autoload -U -z git_info

zstyle ':vcs_info:git:*:-all-' command =git
# }}}

# Completion {{{
zmodload -i zsh/complist
autoload -U compinit && compinit -C

## Grouping
zstyle ':completion:*' format '%F{magenta}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{yellow}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{magenta}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{blue}-- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

## Menu
zstyle ':completion:*:default' menu select=2

## Colorize
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

## Fuzzy completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix

## Cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${ZSH_HOME:-$HOME}/.zcompcache"

## Verbose
zstyle ':completion:*' verbose yes

## SUDO_PATH
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

## cd
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

## Ignore current directory
zstyle ':completion:*' ignore-parents parent pwd

## Process
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# SSH / SCP / rsync
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Array Indexes
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Man sections
zstyle ':completion:*:manuals' separate-sections true

setopt \
  complete_in_word \
  glob_complete  \
  hist_expand \
  no_beep \
  numeric_glob_sort

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
# }}}

# Expand childa to $HOME {{{
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

# Magic abbreviations {{{
# http://subtech.g.hatena.ne.jp/cho45/20100814/1281726377
### $abbreviations {{{
typeset -A abbreviations
abbreviations=(
  " L" " | \$PAGER"
  " G" " | \$GREPPRG"
  " S" " | sort"
  " H" " | head"
  " T" " | tail"
  " C" " | pbcopy"
  " W" " | wc"
)
# }}}

function magic-abbrev-expand () { #{{{
  local MATCH
  LBUFFER=${LBUFFER%%(#m) [-_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
} #}}}

function magic-space () { #{{{
  magic-abbrev-expand
  zle self-insert
} #}}}

function magic-abbrev-expand-and-insert () { #{{{
  magic-abbrev-expand
  zle self-insert
} #}}}

function magic-abbrev-expand-and-insert-complete () { #{{{
  magic-abbrev-expand
  zle self-insert
  zle expand-or-complete
} #}}}

function magic-abbrev-expand-and-accept () { #{{{
  magic-abbrev-expand
  zle accept-line
} #}}}

function magic-abbrev-expand-and-normal-complete () { #{{{
  magic-abbrev-expand
  zle expand-or-complete
} #}}}

function no-magic-abbrev-expand () { #{{{
  LBUFFER+=' '
} #}}}

### zle {{{
zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-magic-space
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-insert-complete
zle -N magic-abbrev-expand-and-normal-complete
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
zle -N magic-space
# }}}

### Key bindings {{{
bindkey -v "\r" magic-abbrev-expand-and-accept
bindkey -v " "  magic-space
bindkey -v "."  magic-abbrev-expand-and-insert
bindkey -v "^I" magic-abbrev-expand-and-normal-complete
bindkey -v "^J" accept-line
# }}}
# }}}

# tmux split window zle {{{
function execute-in-new-horizontal-tmux-pane() { # {{{
  BUFFER="tmux split-window -p 50 -h 'LBUFFER'"
  zle accept-line
} # }}}
function execute-in-new-vertical-tmux-pane() { # {{{
  BUFFER="tmux split-window -p 50 -v '$BUFFER'"
  zle accept-line
} # }}}
zle -N execute-in-new-horizontal-tmux-pane
zle -N execute-in-new-vertical-tmux-pane
bindkey -v "^Wv" execute-in-new-horizontal-tmux-pane
bindkey -v "^Ws" execute-in-new-vertical-tmux-pane
# }}}

# wrap the current input buffer with `tsocks` {{{
execute-with-tsocks() {
  LBUFFER="tsocks $LBUFFER"
}
zle -N execute-with-tsocks
bindkey -v "^T" execute-with-tsocks
# }}}

# url-quote-magic {{{
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
# }}}

# push-line {{{
bindkey -a "O" push-line
# }}}

# run-help {{{
alias run-help >/dev/null && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
bindkey -a "H" run-help
# }}}

# Functions {{{
alias processes='ps aux | grep -v "grep" | grep -v "ps aux"'

function ps-cpu() { # {{{
  local count=${1:-10}
  processes | head -n 1 # Heading
  processes | sort --reverse --numeric-sort --key 3 | head -n $count
} # }}}

function ps-mem() { # {{{
  local count=${1:-10}
  processes | head -n 1 # Heading
  processes | sort --reverse --numeric-sort --key 4 | head -n $count
} # }}}

export GITHUB_REPOS_PATH=${GITHUB_REPOS_PATH:-$HOME/repos}
function github-clone() {
  local repo="$1"
  local destination_dir="${GITHUB_REPOS_PATH}/@${repo}"
  if [[ -d "$destination_dir" ]]; then
    echo "$destination_dir already exists" >> /dev/stderr
    return 1
  fi
  echo "Repository: https://github.com/${repo}"
  git clone git://github.com/${repo}.git ${destination_dir}
}

# cd to Git repository's root
function gg() { # {{{
  if ! (git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
    echo "Use inside of Git repository"
    return 1
  fi

  cd ./$(git rev-parse --show-cdup)
} # }}}

function 256colors() { # {{{
  declare code
  declare columns
  columns=16

  for code in {000..255}; do
    print -nP -- "%F{$code}${code} %f"
    if [ $(( ${code} % ${columns} )) -eq $(( ${columns} - 1 )) ]; then
      echo
    fi
  done
} # }}}

function run-multi-command() {
  tmux new-window "$1"
  shift
  for cmd in $*; do
    tmux split-window "$cmd"
  done
  tmux select-layout tiled >/dev/null
  tmux set-window-option synchronize-panes on >/dev/null
}
# }}}

# Prompt {{{
autoload -U promptinit && promptinit

setopt \
  prompt_subst \
  prompt_percent \
  transient_rprompt

prompt "${ZSH_THEME:-"aereal"}"
# }}}

# peco {{{
function __git-recent-branches() {
  local selected_branch=$( \
    git for-each-ref --sort=-committerdate --format="%(objectname:short)	%(committerdate:relative)	%(refname)" -- refs/heads \
    | sed -E 's/refs\/heads\///' \
    | cut -f3 \
    | peco --query "$LBUFFER")
  if [[ -n "$selected_branch" ]]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle -R -c
}
zle -N __git-recent-branches
bindkey -a "gr" __git-recent-branches

function __git-remote-branches() {
  local selected_branch=$( \
    git for-each-ref --sort=-committerdate --format="%(objectname:short)	%(committerdate:relative)	%(refname)" -- refs/remotes \
    | sed -e 's/refs\/remotes\///' \
    | cut -f3 \
    | percol --query "$LBUFFER")
  if [[ -n "$selected_branch" ]]; then
    BUFFER="git checkout -t ${selected_branch}"
    zle accept-line
  fi
  zle -R -c
}
zle -N __git-remote-branches
bindkey -a "ga" __git-remote-branches

function __cd() {
  local -aU directory_candidates
  directory_candidates=(
    $(cat $HOME/.cdd | cut -d: -f2)
    $(cdr -l | tr -s ' ' | cut -d' ' -f2)
  )
  local selected_directory=$(echo ${(F)directory_candidates} | percol)
  if [[ -n "$selected_directory" ]]; then
    BUFFER="cd ${selected_directory}"
    zle accept-line
  fi
  zle -R -c
}
zle -N __cd
bindkey -a '.' __cd

__cd_repo() { # {{{
  local selected_repo=$( ghq list | peco )
  if [[ -n "$selected_repo" ]]; then
    BUFFER="ghq look ${selected_repo}"
    zle accept-line
  fi
  zle -R -c
} # }}}
zle -N __cd_repo
bindkey -v "^]^G" __cd_repo
# }}}

# cdd {{{
if [[ -f "$ZSH_HOME/plugins/cdd/cdd" ]]; then
  source "$ZSH_HOME/plugins/cdd/cdd"
  add-zsh-hook chpwd _cdd_chpwd
fi
# }}}

# ghq {{{
if [[ -e "$ZSH_HOME/plugins/ghq/zsh" ]]; then
  fpath=(
    $ZSH_HOME/plugins/ghq/zsh
    $fpath
  )
  autoload -U ghq
  autoload -U compinit; compinit
fi
# }}}

# zsh-completions {{{
if [[ -e "$ZSH_HOME/plugins/zsh-completions/src" ]]; then
  fpath=(
    $ZSH_HOME/plugins/zsh-completions/src
    $fpath
  )
fi
# }}}

# Update window title {{{
function update_window_title() { # {{{
  emulate -L zsh
  local -a cmd
  cmd=(${(z)2})

  case $cmd[1] in
    fg)
      if (( $#cmd == 1 )); then
        cmd=(builtin jobs -l %+)
      else
        cmd=(builtin jobs -l $cmd[2])
      fi
      ;;
    %*)
      cmd=(builtin jobs -l $cmd[1])
      ;;
    *=*)
      echo -n "k$cmd[2]:t\\"
      return
      ;;
    ls|clear|pwd)
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

if [ "$TMUX" ]; then
  add-zsh-hook preexec update_window_title
fi
# }}}

# Aliases {{{
alias :q=exit
alias  l='ls --color=auto -AF'
alias ls='ls --color=auto -AF'
alias ll='ls --color=auto -AFl'

alias vim="$EDITOR"
alias  vi="$EDITOR"
# }}}

# zsh-syntax-highlight {{{
if [[ -d "$ZSH_SYNTAX_HIGHLIGHT_ROOT" ]]; then
  source "$ZSH_SYNTAX_HIGHLIGHT_ROOT/zsh-syntax-highlighting.zsh"
fi
# # }}}

# zsh-bundle-exec {{{
if [[ -f $ZSH_HOME/plugins/zsh-bundle-exec/zsh-bundle-exec.zsh ]]; then
  source $ZSH_HOME/plugins/zsh-bundle-exec/zsh-bundle-exec.zsh
fi
# }}}

# cdr {{{
set autopushd

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  local recent_dirs_cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"

  if [[ ! -d ${recent_dirs_cache_file:h} ]]; then
    mkdir -p ${recent_dirs_cache_file:h}
  fi

  autoload -Uz chpwd_recent_dirs cdr
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*:*:cdr:*:*' menu selection
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-max 500
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-file "$recent_dirs_cache_file"
  zstyle ':chpwd:*' recent-dirs-pushd true
fi
# }}}

[[ -f "$ZSH_HOME/os/$(uname).zshrc" ]] && source "$ZSH_HOME/os/$(uname).zshrc"

if whence direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

# Launch tmux {{{
if whence tmux >/dev/null && [ -z "$TMUX" ]; then
  if $(tmux has-session 2>/dev/null); then
    tmux attach-session -t "${HOST%%.*}"
  else
    tmux new-session -s "${HOST%%.*}"
  fi
fi
# }}}

# vim:set ft=zsh foldmethod=marker:
