set number
set encoding=utf-8

colorscheme magica

if has("gui_gtk2")
	set guifont=Anonymous\ 14
endif

if has("gui_macvim")
	set guifont=Monaco:h14
	set guioptions-=T

	if has("kaoriya")
		set transparency=14
	endif
endif

if has("gui_running")
	set fuoptions=maxvert,maxhorz
endif

