# vim:set ft=zsh:

export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
export FLEX_HOME=$HOME/sdk/flex
export LSCOLORS="cxexfxdxbxegedabagacad"
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export __CF_USER_TEXT_ENCODING=0x1F6:0x08000100:14
export HOMEBREW_HOME=$HOME/local

path=(
  $HOMEBREW_HOME/bin(N-/)
  $FLEX_HOME/bin(N-/)
  $path
)

if [[ -n $(brew list | grep coreutils) ]]; then
  path=(
    $(brew --prefix coreutils)/libexec/gnubin(N-/)
    $path
  )
fi

fpath=(
  $HOMEBREW_HOME/share/zsh/site-functions(N-/)
  $HOMEBREW_HOME/share/zsh/functions(N-/)
  $fpath
)
