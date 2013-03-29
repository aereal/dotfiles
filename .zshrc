setopt extended_glob
autoload -Uz zmv
autoload -Uz gyapbox

bindkey -e

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

bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
# }}}

# VCS {{{
autoload -U -z VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -U -z VCS_INFO_git_getaction; VCS_INFO_git_getaction 2>/dev/null
autoload -U -z git_info

zstyle ':vcs_info:git:*:-all-' command =git
# }}}

# Completion {{{
autoload -U compinit; compinit

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
zstyle ':completion:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"

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

setopt \
  complete_in_word \
  glob_complete  \
  hist_expand \
  no_beep \
  numeric_glob_sort
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
bindkey "\\" expand-to-home-or-complete
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
bindkey "\r" magic-abbrev-expand-and-accept
bindkey " "  magic-space
bindkey "."  magic-abbrev-expand-and-insert
bindkey "^I" magic-abbrev-expand-and-normal-complete
bindkey "^J" accept-line
# }}}
# }}}

# url-quote-magic {{{
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
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
# }}}

# Prompt {{{
autoload -U promptinit; promptinit

setopt \
  prompt_subst \
  prompt_percent \
  transient_rprompt

function update_prompt() { # {{{
  local \
    ruby_version \
    perl_version \
    current_ts \
    login_info \
    additional_info \
    current_user \
    current_host \
    current_working_directory \
    git_info \
    top_line \
    command_line

  # Ruby version {{{
  if /usr/bin/which -s rbenv; then
    _ruby_version_string="Ruby: $(rbenv version-name)"
    ruby_version="%{${fg[red]}%}$_ruby_version_string%{${reset_color}%}"
  fi
  # }}}

  # Perl version {{{
  if [[ -n "$PERLBREW_PERL" ]]; then
    _perl_version_string="Perl: ${PERLBREW_PERL#perl-}"
    perl_version="%{${fg[blue]}%}$_perl_version_string%{${reset_color}%}"
  fi
  # }}}

  git_info=$(git_info)
  current_ts="%D{%Y-%m-%d} %*"

  current_user="%{${fg[magenta]}%}%n%{${reset_color}%}"
  current_host="%{${fg[cyan]}%}%M%{${reset_color}%}"
  login_info="${current_user} @ ${current_host}"

  current_working_directory="%~"
  current_working_directory="%{${fg[magenta]}%}${current_working_directory}%{${reset_color}%}"

  additional_info="${ruby_version} ${perl_version}"

  top_line="${current_working_directory:+$current_working_directory }${additional_info:+"(${additional_info})"}"

  ok_prompt=" %{${fg[yellow]}%}✘╹◡╹✘%{${reset_color}%} < "
  ng_prompt=" %{${fg[red]}%}✘>_<✘%{${reset_color}%} < "
  command_line="%(?,$ok_prompt,$ng_prompt)"

  PROMPT="$(echo -n "${top_line}\n${command_line}")"
  RPROMPT="${git_info:+"[$git_info]"}"
} # }}}

autoload -Uz add-zsh-hooks
add-zsh-hook precmd update_prompt
# }}}

# zaw {{{
if [[ -e "$ZSH_HOME/plugins/zaw/zaw.zsh" ]]; then
  source "$ZSH_HOME/plugins/zaw/zaw.zsh"

  bindkey "^[." zaw-cdr
  bindkey "^[h" zaw-history
fi
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

# Abbreviated ls {{{
# https://gist.github.com/3935922
function abbreviated_ls() { # {{{
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-ACF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
} # }}}

autoload -U -z add-zsh-hooks
add-zsh-hook chpwd abbreviated_ls
# }}}

# Switch local Perl {{{
function switch-perl-version() { # {{{
  if [[ -e ".perl-version" ]]; then
    perlbrew use $(cat .perl-version)
  fi
} # }}}
add-zsh-hook chpwd switch-perl-version
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
alias ql='qlmanage -p "$@" >& /dev/null'

if [[ -d "$HOMEBREW_HOME/opt/coreutils" ]]; then
  for coreutil in $HOMEBREW_HOME/opt/coreutils/bin/*(*); do
    coreutil_basename=${coreutil:t:s/g//}
    if (( ! ${+builtins[$coreutil_basename]} )); then
      eval "alias ${coreutil_basename}=${coreutil}"
    fi
  done

  alias  l='gls --color=auto -AF'
  alias ls='gls --color=auto -AF'
  alias ll='gls --color=auto -AFl'
else
  alias  l='ls -GAF'
  alias ls='ls -GAF'
  alias ll='ls -GAFl'
fi

if /usr/bin/which -s reattach-to-user-namespace; then
  function v() {
    reattach-to-user-namespace -l "$EDITOR" "$@"
  }
  function vim() {
    reattach-to-user-namespace -l "$EDITOR" "$@"
  }
else
  alias vim="$EDITOR"
  alias  vi="$EDITOR"
fi
# }}}

# Launch tmux {{{
if /usr/bin/which -s tmux && [ -z "$TMUX" ]; then
  if $(tmux has-session 2>/dev/null); then
    tmux attach-session -t "${HOST%%.*}"
  else
    tmux new-session -s "${HOST%%.*}"
  fi
fi
# }}}

# vim:set ft=zsh:
