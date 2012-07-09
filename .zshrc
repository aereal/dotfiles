# vim:set ft=zsh foldmethod=marker:

# Zsh Environment {{{
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
REPORTTIME=3
# }}}
# Autoload{{{
autoload -U promptinit; promptinit
autoload -U colors;     colors
autoload -U -z VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -U -z rprompt-git-current-branch
autoload -U -z add-zsh-hook
autoload -U -z show-window-title
# }}}
# Options{{{
setopt always_last_prompt # カーソル位置を保持したまま補完表示
# setopt auto_cd # ディレクトリ名だけでcd
setopt auto_menu # TABで補完候補をめぐる
setopt auto_param_keys # 括弧などを補完
setopt auto_pushd # 自動的にpushd
setopt auto_remove_slash # 最後のスラッシュを自動的に削除する
setopt auto_resume # suspendされているプロセスと同じコマンドを叩いたらfg
setopt cdable_vars # ディレクトリ名として展開しようとする
setopt complete_in_word # カーソル位置で補完
setopt correct # スペルチェック
setopt extended_glob # 拡張glob
setopt extended_history # 開始、終了時刻をヒストリに書き込む
setopt glob_complete # globを展開しないで候補から補完する
setopt hist_expand # 補完したらヒストリを展開
setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_space # スペースから始まる場合ヒストリに追加しない
setopt ignore_eof # ^Dでログアウトしない
setopt inc_append_history # すぐにヒストリを追記
setopt list_types # 補完候補にファイル種別を表示
setopt magic_equal_subst # --prefix= とかも補完する
setopt no_beep # うるさい
setopt print_eight_bit # 8-bitを通す
setopt prompt_subst # いいプロンプト
setopt pushd_ignore_dups # 同じディレクトリはpushdしない
setopt sh_word_split # 互換性のある空白の扱い
setopt share_history # ヒストリを共有する
setopt transient_rprompt # コマンド実行後は右プロンプトを消す
# }}}
# Completion{{{
autoload -U compinit
compinit -u

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo' command-path $PATH
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# }}}
# History{{{
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# }}}
# magic abbreviations (http://subtech.g.hatena.ne.jp/cho45/20100814/1281726377){{{
# abbreviations{{{
typeset -A abbreviations
abbreviations=(
  " L" " | \$PAGER"
  " G" " | grep"
)
# }}}

magic-abbrev-expand () { #{{{
  local MATCH
  LBUFFER=${LBUFFER%%(#m) [-_a-zA-Z0-9^]#}
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

  # zle {{{
  zle -N magic-abbrev-expand
  zle -N magic-abbrev-expand-and-magic-space
  zle -N magic-abbrev-expand-and-insert
  zle -N magic-abbrev-expand-and-insert-complete
  zle -N magic-abbrev-expand-and-normal-complete
  zle -N magic-abbrev-expand-and-accept
  zle -N no-magic-abbrev-expand
  zle -N magic-space
  # }}}
# }}}
# Easy-childa{{{
function expand-to-home-or-complete() { #{{{
  if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
    LBUFFER+="~/"
  else
    zle self-insert
  fi
} #}}}

zle -N expand-to-home-or-complete
# }}}
# prompt{{{
init_prompt() { #{{{
  local \
    git_branch _python_version python_version ruby_version perl_version \
    prompt_account prompt_user prompt_command prompt_cwd first_line next_line
  git_branch=$(rprompt-git-current-branch)

  if [[ `type rbenv` = 'rbenv is a shell function' ]]; then
    ruby_version="%{${fg[red]}%}(ruby-`rbenv version-name`)%{${reset_color}%}"
  elif [[ -x `which rvm-prompt` ]]; then
    ruby_version="%{${fg[red]}%}(`rvm-prompt`)%{${reset_color}%}"
  fi

  if [[ -n "$PERLBREW_PERL" ]]; then
    perl_version="%{${fg[blue]}%}($PERLBREW_PERL)%{${reset_color}%}"
  fi

  if [[ -n "$PATH_PYTHONBREW" ]]; then
    _python_version=$(basename $(dirname $(dirname $(which python))))
    _python_version=$(ruby -e 'x=ARGV[0];puts x if x.strip[/^Python-(\d+\.?)+$/]' -- $(echo $_python_version))
    if [[ -n "$python_version" ]]; then
      python_version="%{${fg[yellow]}%}($_python_version)%{${reset_color}%}"
    fi
  fi

  prompt_cwd="%{${fg[magenta]}%}%~%{${reset_color}%}"
  prompt_command=" %(?,%{${fg[yellow]}%}X | _ | X%{${reset_color}%},%{${fg[red]}%}X > _ < X%{${reset_color}%}) < "
  # if [[ "x$SSH_CLIENT" != "x" ]]; then
  #   prompt_cwd="$prompt_cwd $prompt_user"
  # fi
  if [[ "x$git_branch" != "x" ]]; then
    first_line="$git_branch $prompt_cwd"
  else
    first_line=" $prompt_cwd"
  fi
  next_line="$prompt_command"
  PROMPT="$first_line
$next_line"
  RPROMPT="$ruby_version $perl_version $python_version"
} #}}}

add-zsh-hook precmd init_prompt
# }}}
# key-bindings{{{
# Vi風キーバインド
bindkey -v

bindkey "\\" expand-to-home-or-complete
bindkey "\r" magic-abbrev-expand-and-accept
bindkey " "  magic-space
bindkey "."  magic-abbrev-expand-and-insert
bindkey "^F" push-input
bindkey "^I" magic-abbrev-expand-and-normal-complete
bindkey "^J" accept-line
bindkey "^O" complete-word
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
# }}}
# aliases{{{
alias ..='cd ..'
alias l='ls --color -AF'
alias ls='ls --color -F'
alias ll='ls --color -AFl'
alias :q='exit'
alias ps='ps aux'

  # hub{{{
  if [[ -x `which hub` ]]; then
    eval "$(hub alias -s zsh)"
  fi
  # }}}
# }}}
# zaw.zsh{{{
if [[ -d "$HOME/.zsh.d/plugins/zaw" ]] && [[ -r "$HOME/.zsh.d/plugins/zaw/zaw.zsh" ]]; then
  source "$HOME/.zsh.d/plugins/zaw/zaw.zsh"
fi
# }}}
# cdd{{{
if [[ -r "$ZSH_USER_DIR/plugins/cdd/cdd" ]]; then
  . "$ZSH_USER_DIR/plugins/cdd/cdd"
  add-zsh-hook chpwd _cdd_chpwd
fi
# }}}
# Host or Operating System specific configurations{{{
uname=`uname`
[[ -f "$ZSH_USER_DIR/os/$uname.zshrc" ]] && . "$ZSH_USER_DIR/os/$uname.zshrc"
[[ -f "$ZSH_USER_DIR/hosts/$HOST.zshrc" ]] && . "$ZSH_USER_DIR/hosts/$HOST.zshrc"
# }}}
# show-window-title{{{
if [[ "x$MULTIPLEXOR" != "x" ]]; then
  add-zsh-hook preexec show-window-title
fi
# }}}
# Auto-reattaching{{{
case $MULTIPLEXOR in
  tmux)
    autoload -U -z nw
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
# }}}
