# vim:set ft=zsh foldmethod=marker:

setopt extended_glob

# Load Modules {{{
autoload -U -z is-at-least
autoload -U -z add-zsh-hooks
autoload colors; colors
autoload -U -z VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -U -z VCS_INFO_git_getaction; VCS_INFO_git_getaction 2>/dev/null
autoload -U -z zmv
autoload -U -z git_info
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
# }}}

# History {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

setopt extended_history # 実行時間と時刻も保存する
setopt hist_ignore_dups # 重複したコマンドは保存しない
setopt hist_ignore_space # 空白から始まるコマンドは保存しない
setopt inc_append_history # すぐに追記
setopt share_history # プロセス間でヒストリを共有
setopt no_flow_control # C-s を殺すな

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
# }}}

# Prompt {{{
autoload -U promptinit
promptinit

setopt prompt_subst # プロンプトの中で変数展開
setopt prompt_percent # '%' シーケンス
setopt transient_rprompt # 実行後は右プロンプトを消す

update_prompt() { # {{{
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
  # if [[ -n $(type rbenv) ]]; then
    _ruby_version_string="Ruby: $(rbenv version-name)"
    ruby_version="%{${fg[red]}%}$_ruby_version_string%{${reset_color}%}"
  # fi
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

  top_line="${login_info} (${additional_info})${git_info:+" (${git_info})"}"

  ok_prompt=" %{${fg[yellow]}%}✘╹◡╹✘%{${reset_color}%} < "
  ng_prompt=" %{${fg[red]}%}✘>_<✘%{${reset_color}%} < "
  command_line="%(?,$ok_prompt,$ng_prompt)"

  PROMPT="$(echo -n "${top_line}\n${command_line}")"
  RPROMPT="[${current_working_directory}]"
} # }}}

add-zsh-hook precmd update_prompt
# }}}

# Completion {{{
autoload -U compinit
compinit

## Grouping
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

## Menu
zstyle ':completion:*:default' menu select=2

## Colorize
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

## Fuzzy completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix

## Cache
zstyle ':completion:*' use-cache yes

## Verbose
zstyle ':completion:*' verbose yes

## SUDO_PATH
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

## cd
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

setopt complete_in_word # カーソル位置で補完
setopt glob_complete # glob を展開しない
setopt hist_expand # ヒストリを展開
setopt no_beep # うるさい
setopt numeric_glob_sort # 数字としてソート
# }}}

# Aliases {{{
alias :q='exit'
# }}}

# Functions {{{
  ## Easy childa {{{
  expand-to-home-or-complete() { # {{{
    if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
      LBUFFER+="~/"
    else
      zle self-insert
    fi
  } # }}}

  zle -N expand-to-home-or-complete
  bindkey "\\" expand-to-home-or-complete
  #}}}

  ## Magic abbreviations {{{
  # http://subtech.g.hatena.ne.jp/cho45/20100814/1281726377
  ### $abbreviations {{{
  typeset -A abbreviations
  abbreviations=(
    " L" " | \$PAGER"
    " G" " | grep"
    " S" " | sort"
    " H" " | head"
    " T" " | tail"
    " C" " | pbcopy"
  )
  # }}}
  magic-abbrev-expand () { #{{{
    local MATCH
    LBUFFER=${LBUFFER%%(#m) [-_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  } #}}}
  magic-space () { #{{{
    magic-abbrev-expand
    zle self-insert
  } #}}}
  magic-abbrev-expand-and-insert () { #{{{
    magic-abbrev-expand
    zle self-insert
  } #}}}
  magic-abbrev-expand-and-insert-complete () { #{{{
    magic-abbrev-expand
    zle self-insert
    zle expand-or-complete
  } #}}}
  magic-abbrev-expand-and-accept () { #{{{
    magic-abbrev-expand
    zle accept-line
  } #}}}
  magic-abbrev-expand-and-normal-complete () { #{{{
    magic-abbrev-expand
    zle expand-or-complete
  } #}}}
  no-magic-abbrev-expand () { #{{{
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
# }}}

# Applications {{{
app_rcs=(${ZSH_HOME}/apps/*.zshrc(N-.))

for app_rc in ${app_rcs}; do
  source "${app_rc}"
done
# }}}

# OS {{{
case ${OSTYPE} in
  darwin*)
    os_rcs=(${ZSH_HOME}/os/osx{.zshrc,/*.zshrc}(N-.))

    for os_rc in ${os_rcs}; do
      source "$os_rc"
    done
    ;;
  *)
    ;;
esac
# }}}

# Host {{{
shorten_host="${HOST%%.*}"
host_rcs=(${ZSH_HOME}/hosts/${shorten_host}{.zshrc,/*.zshrc}(N-.))

for host_rc in ${host_rcs}; do
  source "$host_rc"
done
# }}}

# Auto session resume {{{
if [ -z "$TMUX" ]; then
  if $(tmux has-session); then
    tmux attach-session -t "${HOST%%.*}"
  else
    tmux new-session -s "${HOST%%.*}"
  fi
fi
# }}}
