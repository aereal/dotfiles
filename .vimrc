syntax on

highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /\s\+$|　/

set listchars=tab:>.
set list
set directory=~/swp
set wildmode=longest,list
set ambiwidth=double
set completeopt=menu,preview,longest,menuone
set complete=.,w,b,u,k
set nobackup
set autoread
set scrolloff=10000000
set number
set autoindent smartindent
set smarttab
set softtabstop=4 tabstop=4 shiftwidth=4
set backspace=indent,eol,start
set ignorecase smartcase
set incsearch
set wrapscan
set showmatch
set showcmd
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set splitbelow
set nrformats="hex"
set laststatus=2
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set fileformat=unix
set hidden
set viminfo+=!
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
filetype plugin indent on

set statusline=%{expand('%:p:t')}\ %<\(%{SnipMid(expand('%:p:h'),80-len(expand('%:p:t')),'...')}\)%=\ %m%r%y%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%3l,%3c]

function! SnipMid(str, len, mask)
	if a:len >= len(a:str)
		return a:str
	elseif a:len <= len(a:mask)
		return a:mask
	endif

	let len_head = (a:len - len(a:mask)) / 2
	let len_tail = a:len - len(a:mask) - len_head

	return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0
	? a:str[-len_tail :] : '')
endfunction

let g:user_zen_settings = {'indentation': "\t"}
let g:use_zen_complete_tag = 1

function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<TAB>"
	else
		if pumvisible()
			return "\<C-N>"
		else
			return "\<C-N>\<C-P>"
		end
	endif
endfunction

" screenに編集中のファイル名を出す
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "k%\\"' | endif

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

noremap <Space> <C-f>
noremap <S-Space> <C-b>

inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

