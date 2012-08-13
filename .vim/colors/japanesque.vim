" japanesque.vim
" ----------------------------------------
" Author: Aoki Hanae (http://kerare.org/)
" License: Creative Commons Attribution-NonCommercial 3.0 Unported License
" ----------------------------------------

" Setup {{{
hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'japanesque'
" }}}

" Utilities {{{

" Original from Hemisu Color Scheme for Vim
" (http://noahfrederick.com/vim-color-scheme-hemisu/)
"
" Author: Noah Frederick (http://noahfrederick.com/)
" License: Creative Commons Attribution-NonCommercial 3.0 Unported License
function! s:h(group, style)
  execute "highlight" a:group
      \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
      \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
      \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
      \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
      \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
      \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
      \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction
" }}}

" Colors {{{
let s:black      = {'gui': '#373c38', 'cterm': 'Black'} " Aisumicha
let s:gray       = {'gui': '#828282', 'cterm': 'Gray'} " Hai
let s:dark_gray  = {'gui': '#656765', 'cterm': 'DarkGray'} " Nibi
let s:white      = {'gui': '#fcfaf2', 'cterm': 'White'} " Shironeri
let s:red        = {'gui': '#e87a90', 'cterm': 'Red'} " Usubeni
let s:green      = {'gui': '#90b44b', 'cterm': 'Green'} " Hiwamoegi
let s:yellow     = {'gui': '#f7c242', 'cterm': 'Yellow'} " Nanohana
let s:blue       = {'gui': '#3a8fb7', 'cterm': 'Blue'} " Rurikon
let s:pink       = {'gui': '#f596aa', 'cterm': 'Magenta'} " Momo
let s:cyan       = {'gui': '#8b81c3', 'cterm': 'Cyan'} " Fuji
let s:dark_red   = {'gui': '#8e354a', 'cterm': 'DarkRed'} " Suoh
let s:dark_green = {'gui': '#516e41', 'cterm': 'DarkGreen'} " Aoni
let s:brown      = {'gui': '#6c6a2d', 'cterm': 'DarkYellow'} " Uguisu
let s:dark_blue  = {'gui': '#6699a1', 'cterm': 'DarkBlue'} " Sabiasagi
let s:magenta    = {'gui': '#c1328e', 'cterm': 'DarkMagenta'} " Botan

if &background == 'dark'
  let s:normal           = s:white
  let s:bg               = s:black
  let s:obbligato        = s:pink
  let s:plain            = s:pink
  let s:ok               = s:blue
  let s:annotate         = s:green
  let s:fatal            = s:red
  let s:invisible        = s:gray
  let s:hidden           = s:dark_gray
  let s:charm            = s:yellow
  let s:subdued_annotate = s:dark_blue
  let s:accent           = s:red
  let s:composed         = s:green
  let s:highlight        = s:cyan
else
  let s:normal           = s:gray
  let s:bg               = s:white
  let s:obbligato        = s:pink
  let s:plain            = s:magenta
  let s:ok               = s:green
  let s:annotate         = s:blue
  let s:fatal            = s:dark_red
  let s:invisible        = s:gray
  let s:hidden           = s:gray
  let s:charm            = s:magenta
  let s:subdued_annotate = s:brown
  let s:accent           = s:red
  let s:composed         = s:dark_green
  let s:highlight        = s:blue
endif
" }}}

" UI {{{
call s:h('Normal', {'fg': s:normal, 'bg': s:bg})
call s:h('Visual', {'bg': s:magenta})
call s:h('Cursor', {'fg': s:bg, 'bg': s:obbligato})
call s:h('Folded', {'fg': s:invisible})
call s:h('FoldColumn', {'fg': s:normal})
call s:h('ModeMsg', {'fg': s:ok, 'gui': 'bold', 'cterm': 'bold'})
call s:h('WarningMsg', {'fg': s:annotate, 'gui': 'bold', 'cterm': 'bold'})
call s:h('ErrorMsg', {'fg': s:fatal, 'gui': 'bold', 'cterm': 'bold'})
call s:h('LineNr', {'fg': s:hidden})
call s:h('SpecialKey', {'fg': s:hidden})
call s:h('NonText', {'fg': s:hidden})
call s:h('MatchParen', {'fg': s:obbligato, 'bg': s:hidden})
call s:h('CursorLine', {'bg': s:hidden})
call s:h('Pmenu', {'bg': s:subdued_annotate})
call s:h('PmenuSel', {'bg': s:charm})
call s:h('Title', {'fg': s:accent, 'gui': 'bold', 'cterm': 'bold'})
call s:h('VertSplit', {'fg': s:hidden, 'bg': s:invisible})
call s:h('Question', {'fg': s:ok, 'gui': 'bold', 'cterm': 'bold'})
call s:h('Search', {'bg': s:highlight})
call s:h('SpellBad', {'sp': s:fatal, 'gui': 'undercurl'})
" }}}
" Diff {{{
call s:h('DiffAdd', {'fg': s:ok})
call s:h('DiffChange', {'fg': s:annotate})
call s:h('DiffDelete', {'fg': s:fatal})
call s:h('DiffText', {'fg': s:charm, 'gui': 'bold', 'cterm': 'bold'})
" }}}
" Syntax {{{
call s:h('Delimiter', {'fg': s:invisible})
call s:h('Comment', {'fg': s:invisible})
call s:h('Underlined', {'gui': 'underline', 'cterm': 'underline'})
call s:h('Type', {'fg': s:annotate})
call s:h('Identifier', {'fg': s:accent})
call s:h('Constant', {'fg': s:composed})
call s:h('Statement', {'fg': s:plain})
call s:h('Todo', {'bg': s:subdued_annotate})
" }}}
hi! link IncSearch Search
hi! link MoreMsg ModeMsg
hi! link Function Identifier
hi! link PreProc Statement
hi! link Special NonText
hi! link Error ErrorMsg
hi! link htmlTag Type
hi! link htmlEndTag htmlTag

" vim:set foldmethod=marker:
