hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "tiro_finale"

set background=dark

" #e7abc2 #e78baf #c2537e #754d5c #550726
" #633008 #876d59 #e19860 #f3bc92 #f3cfb4
" #053d39 #365351 #3b8a84 #7ed1cb #9bd1cd
" #345a08 #677a50 #96cc57 #c0eb8d #cfebae

hi Normal guifg=#eaeaea guibg=#121111
hi SpecialKey guifg=#555555
hi Cursor guifg=bg guibg=fg
hi LineNr guifg=#e7abc2
hi MatchParen gui=underline cterm=underline
hi NonText guifg=#872c2a
hi DiffAdd guifg=#5f8486 guibg=bg
hi DiffChange guifg=#e19860 guibg=bg
hi DiffDelete guifg=#876d59 guibg=bg
hi DiffText guifg=fg guibg=bg gui=underline
hi Pmenu guibg=#6e0b23
hi PmenuSel guifg=#121111 guibg=#dddddd gui=bold
hi PmenuSbar guifg=#dddddd guibg=#dddddd
hi Search guifg=bg guibg=#e39343 gui=underline,bold
hi IncSearch guifg=bg guibg=#e39343 gui=underline,bold
hi StatusLine guifg=#121111 guibg=#e19860 gui=NONE
hi StatusLineNC guifg=#e19860 guibg=#121111 gui=underline
hi MoreMsg guifg=#306ada
hi ModeMsg guifg=#cccccc
hi ErrorMsg guifg=white guibg=#6e0b23
hi Todo guifg=fg guibg=bg gui=underline
hi Title guifg=#c2537e
hi WarningMsg guifg=#e39343

hi Comment guifg=#876d59
hi Constant guifg=#f3bc92
hi Statement guifg=#e19860
hi PreProc guifg=#e19860
hi Identifier guifg=#5f8486
hi Type guifg=#c2537e
hi Delimiter guifg=#555555
hi Special guifg=#e39343

