set hidden
set history=1000
set autoread
set fileformats=unix,dos,mac
set scrolloff=100000 " 常にカーソルのある行を中心に (したい)
set backspace=indent,eol,start
set formatoptions-=ro
set ttyfast
" set lazyredraw
set completeopt=menuone,menu

" Cache directory {{{
if !exists('$VIM_CACHE_DIR')
  if isdirectory(expand($TMPDIR))
    let tmp_dir = expand($TMPDIR)
  else
    let tmp_dir = '/tmp'
  endif
  let path_separator = '/'
  let path_cmps = split(simplify(tmp_dir), path_separator, 1)
  let $VIM_CACHE_DIR = simplify(join(extend(path_cmps, ['vim']), path_separator))
  unlet tmp_dir path_separator path_cmps
endif

if !isdirectory(expand($VIM_CACHE_DIR))
  call mkdir($VIM_CACHE_DIR, 'p')
endif
" }}}

" Backup & Swap {{{
set nobackup
set swapfile
set directory=~/.vim/swp
" }}}
" Indentation {{{
set autoindent
set nosmartindent
set nocindent
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set shiftround
" }}}
" Encoding {{{
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set encoding=utf-8
set termencoding=utf-8
" }}}
" Search {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
" }}}
" Visualization {{{
set ambiwidth=double
set list
set listchars=tab:»\ ,precedes:<,extends:>,trail:_,eol:↲
" }}}
" UI {{{
set langmenu=none " メニューをローカライズしない
set laststatus=2
set number
set ruler
set modeline
set noshowcmd
set noshowmode
set shortmess+=I

if v:version >= 704
  " set relativenumber " 7.4 以降だと絶対行数も表示される
endif
" }}}
" IME {{{
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
" }}}
" Persistent Undo {{{
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
" }}}
" Clipboard Integration {{{
if has('clipboard')
  if has('nvim')
    set clipboard+=unnamedplus
  else
    set clipboard=unnamed,autoselect
  endif
endif
" }}}
" fish-shell fix {{{
if $SHELL =~# 'fish$'
  if executable('zsh')
    set shell=zsh
  else
    set shell=sh
  endif
endif
" }}}

if has('gui_running')
  set guioptions&
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=l
  set guioptions-=L
  set guioptions-=L
  set guioptions-=b
  set guioptions-=e
endif

" vim:set foldmethod=marker:
