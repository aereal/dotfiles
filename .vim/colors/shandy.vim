set bg=dark
hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "shandy"

" blue: #7d95a6
" red: #a67d7d
" yellow: #a6a67d
" green: #7da67d
" light green: #7da69d
" purple: #817da6
" violet: #997da6
" magenta: #a67d92

hi Normal       guifg=#aaacb3 guibg=#1a1a1a
hi Cursor       guifg=bg      guibg=fg
hi MatchParen   guifg=fg      guibg=bg      gui=underline
hi NonText      guifg=#454545
hi SpecialKey   guifg=#454545
hi LineNr       guifg=#91a7c2
hi Visual       guifg=fg      guibg=#738499
hi Title        guifg=#a6a67d

hi StatusLine   guifg=fg      guibg=#5b6477 gui=none
hi StatusLineNC guifg=#000000 guibg=#c1c8d6 gui=none
" DiffAdd
" DiffChange
" DiffDelete
" DiffText

hi ModeMsg      guifg=#98a3b2
hi MoreMsg      guifg=#98a3b2
hi ErrorMsg     guifg=#a67d7d guibg=fg      gui=reverse
hi WarningMsg   guifg=#a6a67d guibg=fg      gui=reverse

hi Pmenu        guibg=#5b6477
hi PmenuSel     guifg=fg      guibg=bg      gui=reverse

hi Comment      guifg=#98a3b2
hi Constant     guifg=#7d95a6
hi Identifier   guifg=#7d95a6
hi Statement    guifg=#7d8c7d
hi PreProc      guifg=#7d8c7d
hi Type         guifg=#997da6
hi Delimiter    guifg=#98a3b2
hi Special      guifg=#a6a67d
hi Error        guifg=#a67d7d guibg=fg      gui=reverse
hi Todo         guifg=#98a3b2 gui=underline

