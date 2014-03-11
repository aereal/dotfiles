export HOMEBREW_PATH=${HOMEBREW_PATH:-/usr/local}

typeset -Ua homebrew_path
homebrew_paths=(
  $HOMEBREW_PATH/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_PATH/share/npm/bin(N-/)
  $HOMEBREW_PATH/share/python(N-/)
  $HOMEBREW_PATH/bin(N-/)
)
path=(
  $HOME/Library/Haskell/bin(N-/)
  $homebrew_paths
  $path
)

manpath=(
  $HOMEBREW_PATH/share/man(N-/)
  $HOMEBREW_PATH/opt/coreutils/libexec/gnuman(N-/)
)

export MACVIM_APP=${MACVIM_APP:-/Applications/MacVim.app}
EDITOR="${MACVIM_APP}/Contents/MacOS/Vim"

if whence reattach-to-user-namespace >/dev/null; then
  EDITOR="reattach-to-user-namespace -l ${EDITOR}"
fi
export EDITOR

# SSL certificates {{{
if [[ -f "$HOMEBREW_PATH/opt/curl-ca-bundle/share/ca-bundle.crt" ]]; then
  export SSL_CERT_FILE="$HOMEBREW_PATH/opt/curl-ca-bundle/share/ca-bundle.crt"
fi
# }}}

if [[ -d "${HOMEBREW_PATH}/opt/shared-mime-info/share" ]]; then
  export \
    XDG_DATA_HOME="${HOMEBREW_PATH}/opt/shared-mime-info/share" \
    XDG_DATA_DIRS="${HOMEBREW_PATH}/opt/shared-mime-info/share"
fi

# vim:set ft=zsh:
