syntax on

" vundle
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" from vim.org
Bundle 'Align'

" from GitHub
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'bbommarito/vim-slim'
Bundle 'davidoc/taskpaper.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'hallison/vim-markdown'
Bundle 'kana/vim-smartchr'
Bundle 'kana/vim-textobj-indent'
Bundle 'mattn/gist-vim'
Bundle 'mattn/zencoding-vim'
Bundle 'motemen/git-vim'
Bundle 'msanders/snipmate.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-surround'
Bundle 'ujihisa/unite-colorscheme'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wavded/vim-stylus'
Bundle 't9md/vim-surround_custom_mapping'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'soh335/vim-ref-jquery'

" from others
Bundle 'git://github.com/vim-jp/vimdoc-ja.git'

filetype plugin indent on
set ambiwidth=double
set autoindent
set autoread
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoread
set backspace=indent,eol,start
set nobackup
set nocompatible
set noexpandtab
set hidden
set hlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan
set history=100
set laststatus=2
set list
set listchars=tab:>.,precedes:<,extends:>
set number
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set complete=.,w,b,u,k,i
set completeopt=menu,preview,longest,menuone
set wildmenu
set wildmode=longest:full,list:longest
set scrolloff=100000
set splitbelow
set swapfile
set modeline
set showcmd
set showmode
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set encoding=utf-8
set termencoding=utf-8
set fileformats=unix,dos,mac
set directory=~/swp
set statusline=%<\ %f%=%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}[%3l/%3L,%3c]

nnoremap <Space><Space> :update<CR>

"" autocmd
"" screenに編集中のファイル名を出す
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%\\"' | endif
"" HTMLとかはネストが深くなるのでインデント幅を小さく
autocmd FileType html :set shiftwidth=2 tabstop=2 softtabstop=2

"" zencoding.vim
let g:user_zen_leader_key = '<C-e>'

" http://vim-users.jp/2010/07/hack161/
nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>
nmap : <sid>(command-line-enter)
xmap : <sid>(command-line-enter)

autocmd CmdwinEnter * call s:init_cmdwin()

function! s:init_cmdwin()
	nnoremap <buffer> q :<C-u>quit<CR>
	nnoremap <buffer> <TAB> :<C-u>quit<CR>
	inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
	inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
	inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
	inoremap <buffer><expr><C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
	inoremap <buffer><expr>: col('.') == 1 ? "VimProcBang " : col('.') == 2 && getline('.')[0] == 'r' ? "<BS>VimProcRead " : ":"
	inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	setlocal nonumber
	startinsert!
endfunction

" http://vim-users.jp/2009/07/hack42/
nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>j <C-w>j:call <SID>good_width()<CR>
nnoremap <C-w>k <C-w>k:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>

function! s:good_width()
	if winwidth(0) < 84
		vertical resize 84
	endif
endfunction

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" unite.vim
nnoremap <silent> ,b :<C-u>Unite buffer<CR>
nnoremap <silent> ,o :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>UniteWithBufferDir file_mru<CR>
nnoremap <silent> ,u :<C-u>Unite outline<CR>
au FileType unite nnoremap <silent><buffer><expr><C-s> unite#do_action('split')
au FileType unite inoremap <silent><buffer><expr><C-s> unite#do_action('split')
au FileType unite nnoremap <silent><buffer><expr><C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent><buffer><expr><C-v> unite#do_action('vsplit')

" indent
au BufEnter,BufWritePost */hekk/* setlocal ts=2 sts=2 sw=2 noet
au BufEnter,BufWritePost */hekk/* %retab!
au BufEnter,BufWritePost */hekk/* setlocal ts=4 sts=4 sw=4
au BufWritePre */hekk/* setlocal ts=2 sts=2 sw=2 et
au BufWritePre */hekk/* %retab

" surround.vim
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.ruby  = {
	\ '#': "#{\r}",
	\ }
let g:surround_custom_mapping.eruby = {
	\ '-': "<% \r %>",
	\ '=': "<%= \r %>",
	\ '#': "#{\r}",
	\ }
