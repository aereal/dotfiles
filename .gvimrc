if has("gui_macvim")
  set guifont=Menlo:h14

  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=b

  augroup GuiMac
    autocmd!
    autocmd GUIEnter * set fullscreen
  augroup END
endif

if has('transparency')
  set transparency=10
endif

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  set bg=light
  colorscheme solarized

  hi vimshellPrompt guifg=#f9d59d
endif

