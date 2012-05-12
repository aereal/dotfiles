set number
set encoding=utf-8

if has("gui_gtk2")
  set guifont=Anonymous\ 12
endif

if has("gui_macvim")
  set guifont=Monaco:h14
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=b

  set transparency=10
endif

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  set bg=dark
  colorscheme magica
  hi vimshellPrompt guifg=#f9d59d
endif

