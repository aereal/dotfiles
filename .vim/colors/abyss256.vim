set background=dark

hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name="abyss"

hi NonText ctermfg=240
hi LineNr ctermfg=111
hi ModeMsg ctermfg=253 cterm=bold
hi DiffAdd ctermbg=33
hi DiffChange ctermbg=34
hi DiffDelete ctermfg=7 ctermbg=124
hi Pmenu ctermfg=7 ctermbg=242
hi PmenuSel ctermfg=7 ctermbg=204
hi StatusLine ctermfg=67

hi MatchParen ctermfg=231 ctermbg=214 cterm=underline
hi Comment ctermfg=103
hi Constant ctermfg=203
hi Identifier ctermfg=221 cterm=NONE
hi Statement ctermfg=115
hi PreProc ctermfg=117
hi Type ctermfg=221
hi Special ctermfg=215
hi SpecialKey ctermfg=240

