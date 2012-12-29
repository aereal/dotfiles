# vim:set ft=zsh foldmethod=marker:

# ZSH_HOME {{{
export ZSH_HOME=${HOME}/.zsh.d
# }}}

# Locale {{{
if [[ -n "$LANG" ]]; then
  eval "$(locale)"
fi
# }}}

# fpath {{{
typeset -U fpath
fpath=(
  ${ZSH_HOME}/site-functions
  ${fpath}
)
# }}}

# PATH {{{
typeset -U path
path=(
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  $path
)
# }}}

# SUDO_PATH {{{
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=(
  /usr/local/sbin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)
# }}}

# MANPATH {{{
typeset -u manpath
manpath=(
  ${HOME}/local/share/man(N-/)
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)
# }}}

# PAGER {{{
if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

# LV {{{
export LV="-c -l"
# }}}

# LESS {{{
export LESS="-R"
# }}}
# }}}

# EDITOR {{{
export EDITOR="vim"
# }}}

# LS_COLORS {{{
if [[ -f "$HOME/.dir_colors" ]]; then
  eval "$(dircolors "$HOME/.dir_colors")"
fi
# }}}

# Private Environment Variables {{{
if [[ -f "$HOME/.local.env" ]]; then
  source "$HOME/.local.env"
fi
# }}}

# Initializer {{{
initializers=(${ZSH_HOME}/init/*.zshenv(N-.))

for initializer in ${initializers}; do
  source "${initializer}"
done
# }}}

# OS {{{
case ${OSTYPE} in
  darwin*)
    os_envs=(${ZSH_HOME}/os/osx{.zshenv,/*.zshenv}(N-.))

    for os_env in ${os_envs}; do
      source "$os_env"
    done
    ;;
  *)
    ;;
esac
# }}}

# Host {{{
shorten_host="${HOST%%.*}"
host_envs=(${ZSH_HOME}/hosts/${shorten_host}{.zshenv,/*.zshenv}(N-.))

for host_env in ${host_envs}; do
  source "$host_env"
done
# }}}

# Abbreviations {{{
typeset -A abbreviations
abbreviations=(
  "L" "| \$PAGER"
  "G" "| grep"
  "S" "| sort"
  "H" "| head"
  "T" "| tail"
)
# }}}

# User-specific paths {{{
path=(
  ${HOME}/bin(N-/)
  ${HOME}/local/bin(N-/)
  $path
)
# }}}
