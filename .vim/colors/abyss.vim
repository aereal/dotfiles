" abyssgui

set background=dark
hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "abyss_gui"

" Black    => #0a0a0f
" Gray     => #686861
" White    => #f7f7f5
" Red      => #c44557
" Green    => #8fb0a9
" Yellow   => #dcb875
" Blue     => #5b7498
" Magenta  => #ffb9c4
" Cyan     => #88afc0
" DarkGreen => #3c4e4c
" DarkMagenta => #986771
" DarkCyan => #374a56

hi Normal          guifg=#f7f7f5 guibg=#0a0a0f
hi SpecialKey      guifg=#686861 ctermfg=darkgray
hi Cursor          guifg=bg guibg=fg cterm=reverse
hi LineNr          guifg=#dcb875 ctermfg=yellow
hi MatchParen      gui=underline cterm=underline
hi NonText         guifg=#454545 ctermfg=darkgray
hi Search          guibg=#dcb875 ctermbg=yellow
hi Visual          guibg=#686861 ctermbg=darkgray
hi StatusLine      guibg=#374a56 gui=NONE ctermbg=cyan cterm=NONE
hi StatusLineNC    guibg=#686861 gui=NONE ctermbg=gray

" Popup
hi Pmenu           guibg=#686861 ctermbg=darkgrey
hi PmenuSel        guibg=#ffb9c4 ctermbg=magenta

" Messages
hi ErrorMsg        guifg=#c44557 guibg=fg gui=reverse ctermbg=red
hi ModeMsg         guifg=#f7f7f5 gui=bold ctermfg=white cterm=bold
hi MoreMsg         guifg=#374a56 gui=bold ctermfg=cyan cterm=bold
hi WarningMsg      guifg=#dcb875 gui=bold ctermfg=yellow cterm=bold

" Syntax
hi Comment         guifg=#3c4e4c ctermfg=green

hi Constant        guifg=#8fb0a9 ctermfg=darkgreen
hi Identifier      guifg=#986771 ctermfg=magenta
hi Statement       guifg=#dcb875 ctermfg=yellow
hi Operator        guifg=#686861 ctermfg=gray
hi PreProc         guifg=#dcb875 ctermfg=yellow
hi Type            guifg=#5b7498 ctermfg=darkblue
hi Special         guifg=#ccae99 ctermfg=yellow
hi Delimiter       guifg=#686861 ctermfg=darkgrey

