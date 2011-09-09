set number
set encoding=utf-8

colorscheme shandy

if has("gui_gtk2")
	set guifont=Anonymous\ 12
endif

if has("gui_macvim")
	set guifont=Monaco:h12
	set guioptions-=T
	set guioptions-=m
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L
	set guioptions-=b

	if has("kaoriya")
		set transparency=5
	endif
endif

if has("gui_running")
	set fuoptions=maxvert,maxhorz
endif

