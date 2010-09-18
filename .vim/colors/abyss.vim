" abyssgui

set background=dark
hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "abyss_gui"

" Black   => #0a0a0f
" Gray    => #686861
" White   => #f7f7f5
" Red     => #cc9999
" Orange  => #ccae99
" Yellow  => #cccc99
" Green   => #99cca2
" Cyan    => #99ccc8
" Blue    => #99aacc
" Magenta => #cc99c4

hi Normal          guifg=#f7f7f5 guibg=#0a0a0f
hi SpecialKey      guifg=#686861 ctermfg=darkgray
hi Cursor          guifg=bg guibg=fg cterm=reverse
hi LineNr          guifg=#cccc99 ctermfg=yellow
hi MatchParen      guifg=bg guibg=fg cterm=reverse
hi NonText         guifg=#454545 ctermfg=darkgray
hi Search          guibg=#cccc99 ctermbg=yellow
hi Visual          guibg=#686861 ctermbg=gray
hi StatusLine      guibg=#223344 gui=NONE ctermbg=darkcyan cterm=NONE
hi StatusLineNC    guibg=#888888 gui=NONE ctermbg=gray

" Popup
hi Pmenu           guibg=#686861 ctermbg=gray
hi PmenuSel        guifg=bg guibg=#99cca2 ctermfg=black ctermbg=green

" Messages
hi ErrorMsg        guifg=#cc9999 guibg=fg gui=reverse ctermbg=red
hi ModeMsg         guifg=#f7f7f5 gui=bold ctermfg=white cterm=bold
hi MoreMsg         guifg=#a8c084 gui=bold ctermfg=darkgreen  cterm=bold
hi WarningMsg      guifg=#cccc99 gui=bold ctermfg=yellow cterm=bold

" Syntax
hi Comment         guifg=#8ba393 ctermfg=darkgreen

hi Constant        guifg=#99cca2 ctermfg=green
hi Identifier      guifg=#f1c0a8 ctermfg=darkred
hi Statement       guifg=#cccc99 ctermfg=yellow
hi Operator        guifg=#686861 ctermfg=gray
hi PreProc         guifg=#cc99c4 ctermfg=magenta
hi Type            guifg=#99aacc ctermfg=darkblue
hi Special         guifg=#ccae99 ctermfg=darkmagenta
hi Delimiter       guifg=#686861 ctermfg=gray

