# vim:set ft=zsh:

export __CF_USER_TEXT_ENCODING=0x1F6:0x08000100:14

MACVIM="/Applications/MacVim.app/Contents/MacOS/Vim"
if [[ -x "${MACVIM}" ]]; then
  export EDITOR="${MACVIM}"
  export MACVIM
fi

if [[ -z "$abbreviations" ]]; then
  abbreviations=(
    "C" "| pbcopy"
    $abbreviations
  )
fi
