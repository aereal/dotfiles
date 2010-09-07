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
hi SpecialKey      guifg=#686861
hi Cursor          guifg=bg guibg=fg
hi LineNr          guifg=#cccc99
hi MatchParen      guifg=bg guibg=fg
hi NonText         guifg=#454545
hi Search          guibg=#cccc99
hi Visual          guibg=#686861
hi StatusLine      guibg=#223344 gui=NONE
hi StatusLineNC    guibg=#888888 gui=NONE

" Popup
hi Pmenu           guibg=#686861
hi PmenuSel        guifg=bg guibg=#99cca2

" Messages
hi ErrorMsg        guifg=#cc9999 guibg=fg gui=reverse
hi ModeMsg         guifg=#f7f7f5 gui=bold
hi MoreMsg         guifg=#a8c084 gui=bold
hi WarningMsg      guifg=#cccc99 gui=bold

" Syntax
hi Comment         guifg=#8ba393

hi Constant        guifg=#99cca2
hi Identifier      guifg=#f1c0a8
hi Statement       guifg=#cccc99
hi Operator        guifg=#686861
hi PreProc         guifg=#cc99c4
hi Type            guifg=#99aacc
hi Special         guifg=#ccae99
hi Delimiter       guifg=#686861

