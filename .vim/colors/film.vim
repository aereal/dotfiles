set bg=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "film"

" http://colorschemedesigner.com/#0K61T7VkQw0w0

hi Normal       guifg=#aeaaaa guibg=#1a1a1a
hi Cursor       guifg=bg      guibg=fg
hi MatchParen   guifg=fg      guibg=bg      gui=underline
hi NonText      guifg=#454545
hi SpecialKey   guifg=#454545
hi LineNr       guifg=#7d6d65
hi Visual       guifg=fg      guibg=#998473
hi Title        guifg=#a6a67d

hi StatusLine   guifg=fg      guibg=#1b3246 gui=none
hi StatusLineNC guifg=#434a51 guibg=#96a6b5 gui=none

hi DiffAdd      guifg=#6c5c29
hi DiffChange   guifg=#6c5029
hi DiffDelete   guifg=#6c3e29
hi DiffText     guifg=#1b3246

hi ModeMsg      guifg=#b2a398
hi MoreMsg      guifg=#b2a398
hi ErrorMsg     guifg=#7d7da6 guibg=fg      gui=reverse
hi WarningMsg   guifg=#7da6a6 guibg=fg      gui=reverse

hi Pmenu                      guibg=#77645b
hi PmenuSel     guifg=fg      guibg=bg      gui=reverse

hi Comment      guifg=#7d6d65
hi Constant     guifg=#a69c7d
hi Identifier   guifg=#a68a7d
hi Statement    guifg=#53606b
hi PreProc      guifg=#53606b
hi Type         guifg=#a68a7d
hi Delimiter    guifg=#7d7365
hi Special      guifg=#7da6a6
hi Error        guifg=#7d7da6 guibg=fg      gui=reverse
hi Todo         guifg=bg      guibg=#b2a398 gui=underline

