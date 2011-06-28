"" メッセージを英語に
language message C

"" シンタニックス・ハイライト
syntax on

"" カラースキーム
colorscheme desert

filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'motemen/git-vim'
Bundle 'motemen/hatena-vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'tpope/vim-surround'
Bundle 'kchmck/vim-coffee-script'
Bundle 'ujihisa/unite-rake'
Bundle 'ujihisa/unite-colorscheme'
Bundle 'wavded/vim-stylus'

"" ファイル・タイプごとの設定を有効にする
filetype plugin indent on

"" マルチバイト文字をよしなに
set ambiwidth=double

"" インデントをよしなに
set autoindent
set smartindent
set smarttab
set shiftwidth=3
set tabstop=3
set softtabstop=3

"" 自動的に読み直して
set autoread

"" Backspaceの動作について
set backspace=indent,eol,start

"" バックアップなどいらぬ
set nobackup

"" Viのことなどとうに忘れた
set nocompatible

"" ハードタブこそ至高の存在
set noexpandtab

"" よりタブエディタっぽく
set hidden

"" イカした検索
set hlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan

"" 多めのコマンドヒストリ
set history=100

"" ステータス・ラインを表示する
set laststatus=2

"" 見える化
set list
set listchars=tab:>.,precedes:<,extends:>

"" 行番号を表示
set number

"" 括弧のマッチングをチェック
set showmatch

"" イカしたカーソル移動
set whichwrap=b,s,h,l,<,>,[,]

"" 補完
set complete=.,w,b,u,k,i
set completeopt=menu,preview,longest,menuone
set wildmenu
set wildmode=longest:full,list:longest

"" カーソルを常に世界の中心に
set scrolloff=100000

set splitbelow
set swapfile
set modeline
set showcmd
set showmode
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set encoding=utf-8
set termencoding=utf-8
set fileformat=unix
set directory=~/swp

set statusline=[#%n]\ %f\ %=%h%w%r%m%y[%3l/%3L,%3c]

"" hatena.vim
let g:hatena_users = ['aereal','teq:aereal']

"" zencoding.vim
let g:use_zen_complete_tag = 1
let g:user_zen_settings = {'indentation': "\t"}

"" autocmd
"" screenに編集中のファイル名を出す
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%\\"' | endif
"" HTMLとかはネストが深くなるのでインデント幅を小さく
autocmd FileType html :set shiftwidth=2 tabstop=2 softtabstop=2

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
	inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
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
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

" unite.vim
nnoremap <silent> ;ub :<C-u>Unite buffer<CR>
nnoremap <silent> ;uo :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ;ur :<C-u>UniteWithBufferDir file_mru<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

