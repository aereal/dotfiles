" vim:set et foldmethod=marker:
" Setup neobundle.vim {{{
set nocompatible
filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  syntax enable
endif

call neobundle#rc(expand('~/.vim/bundle'))
" }}}
" Plugins {{{
" Quickrun {{{
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'osyo-manga/shabadou.vim'
" }}}
" Text Object {{{
NeoBundle 'kana/vim-textobj-user'

NeoBundle 'h1mesuke/textobj-wiw'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-line'
NeoBundleLazy 'thinca/vim-textobj-comment'
NeoBundleLazy 'coderifous/textobj-word-column.vim'
NeoBundleLazy 'rhysd/vim-textobj-continuous-line'
NeoBundleLazy 'rhysd/vim-textobj-ruby'
NeoBundleLazy 'thinca/vim-textobj-between'
NeoBundleLazy 'mattn/vim-textobj-url'
" }}}
" Operator {{{
NeoBundleLazy 'kana/vim-operator-user'
NeoBundleLazy 'emonkak/vim-operator-sort'
NeoBundleLazy 'kana/vim-operator-replace'
NeoBundleLazy 'tyru/operator-camelize.vim'
NeoBundleLazy 'tyru/operator-html-escape.vim'
" }}}
" Help {{{
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-ref'
" }}}
" Unite {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'sgur/unite-qf'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundleLazy 'basyura/unite-rails'
" }}}
" Completion {{{
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'ujihisa/neco-look'
NeoBundleLazy 'teramako/jscomplete-vim'
call neobundle#config('jscomplete-vim', {
      \ 'autoload' : {
      \   'filetypes' : ['javascript'],
      \ },
      \ })
" }}}
" Language, Format {{{
NeoBundle 'slim-template/vim-slim'
NeoBundle 'groenewege/vim-less', { 'stay_same' : 1 }
NeoBundleLazy 'hail2u/vim-css3-syntax'
call neobundle#config('vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['css', 'scss', 'sass', 'less'],
      \ },
      \ })
NeoBundle 'hallison/vim-markdown', { 'stay_same' : 1 }
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'motemen/hatena-vim'
NeoBundleLazy 'othree/html5.vim'
call neobundle#config('html5.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['html'],
      \ }
      \ })
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundleLazy 'juvenn/mustache.vim'
NeoBundleLazy 'davidoc/taskpaper.vim'
NeoBundleLazy 'zaiste/tmux.vim'
NeoBundleLazy 'elixir-lang/vim-elixir'
NeoBundle 'moznion/vim-cpanfile'
" }}}
" Color {{{
NeoBundle 'altercation/vim-colors-solarized'
NeoBundleLazy 'git@github.com:aereal/vim-magica-colors.git',
      \ { 'base' : '~/repos/@aereal' }
NeoBundle 'nanotech/jellybeans.vim', { 'stay_same' : 1 }
NeoBundleLazy 'tomasr/molokai', { 'stay_same' : 1 }
NeoBundleLazy 'git://gist.github.com/187578.git', { 'name' : 'h2u_colors', 'stay_same' : 1 }
NeoBundleLazy 'sickill/vim-monokai', { 'stay_same' : 1 }
NeoBundle 'w0ng/vim-hybrid'
" }}}
" Visualize {{{
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim' }
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'scrooloose/syntastic'
NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'errormarker.vim'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'tyru/current-func-info.vim'
" }}}
" Input & Edit {{{
NeoBundle 'Shougo/neosnippet'
NeoBundle 'tpope/vim-surround'
NeoBundle 't9md/vim-surround_custom_mapping'
NeoBundle 'kana/vim-smartinput'
NeoBundleLazy 'mattn/zencoding-vim'
call neobundle#config('zencoding-vim', {
      \ 'autoload' : {
      \   'filetypes' : [
      \     'html',
      \     'haml',
      \     'slim',
      \     'css',
      \   ],
      \ },
      \ })
NeoBundle 'kana/vim-smartchr'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundleLazy 'thinca/vim-partedit'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tyru/eskk.vim'
" }}}
" Organize {{{
NeoBundleLazy 'kana/vim-altr'
NeoBundleLazy 'kien/ctrlp.vim'
NeoBundle 'Shougo/neobundle.vim'
" }}}
" Utility {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \   },
      \ }
NeoBundleLazy 'sudo.vim', { 'stay_same' : 1 }
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-localrc'
" }}}

filetype plugin indent on
" }}}
" Configurations {{{
set hidden
set history=100
set autoread
set fileformats=unix,dos,mac
set scrolloff=100000 " 常にカーソルのある行を中心に (したい)
set backspace=indent,eol,start
set formatoptions-=ro
set ttyfast
set lazyredraw
set completeopt=menuone,menu

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
set listchars=tab:>.,precedes:<,extends:>,trail:_
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
" }}}
" IME {{{
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
" }}}
" Conceal {{{
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}
" Persistent Undo {{{
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
" }}}
" Clipboard Integration {{{
if has('clipboard')
  set clipboard=unnamed,autoselect
endif
" }}}
" }}}
" Tabpage {{{
function! s:tabpage_label(n) " {{{
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  let bufnrs = tabpagebuflist(a:n)
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif

  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
  let fname = pathshorten(bufname(curbufnr))
  let label = no . mod . sp . fname

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction " }}}

function! MakeTabLine() " {{{
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let separator = ' | '
  let tabpages = join(titles, separator) . separator . '%#TabLineFill#%T'
  let info = ''

  try
    let info .= cfi#format('%s()' . separator, '')
  catch /E117/
    " current-func-info is not available
  endtry

  return tabpages . '%=' . info
endfunction " }}}

set showtabline=2
set guioptions-=e
set tabline=%!MakeTabLine()
" }}}
" Weekly Report {{{
let g:weekly_report_dir = '~/Dropbox/memo/weekly'

function! s:WeeklyReport() "{{{
  if ! exists('g:weekly_report_dir')
    echo 'Set default value to g:weekly_report_dir'
    let g:weekly_report_dir = expand('~/weekly_report')
  endif

  if ! isdirectory(expand(g:weekly_report_dir))
    echoerr "g:weekly_report_dir is not directory"
    return 1
  endif

  let expanded_dir = expand(g:weekly_report_dir)
  let filename = expanded_dir . '/' . s:WeeklyReportFilename()

  execute 'edit ' . filename
endfunction "}}}

function! s:WeeklyReportFilename() "{{{
  if ! exists('g:weekly_report_format')
    let g:weekly_report_format = 'hatena'
  endif

  let basename = strftime('%Y%m%d') . '.' . g:weekly_report_format

  return basename
endfunction "}}}

command! WeeklyReport call s:WeeklyReport()
"}}}
" Key mappings {{{
let mapleader   = ';'
let g:mapleader = ';'

nnoremap j gj
nnoremap k gk
nnoremap Y y$

nnoremap <Leader><Space> :update<CR>
nnoremap <ESC><ESC>      :nohlsearch<CR>

inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', '=')
" }}}
" autocmd {{{
augroup MyInit
  autocmd!
  " screen title {{{
  if ! has('gui_running')
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%:t\\"' | endif
  endif " }}}
  " CoffeeScript {{{
  autocmd ColorScheme * hi! link CoffeeSpecialVar Constant
  " }}}
  " Haskell {{{
  autocmd FileType haskell setlocal et
  " }}}
  " Perl {{{
  autocmd BufNewFile,BufRead cpanfile set filetype=cpanfile
  autocmd BufNewFile,BufRead cpanfile set syntax=perl.cpanfile

  autocmd BufEnter *.tt    set ft=tt2
  " }}}
  " Vim {{{
  autocmd FileType vim inoreabbrev <buffer> = =
  " }}}
  " Markdown {{{
  autocmd FileType markdown setlocal et ts=4 sts=4 sw=4
  " }}}
  " Nginx {{{
  autocmd BufEnter */nginx/*.conf set ft=nginx
  autocmd BufEnter */*.nginx.conf set ft=nginx
  " }}}
  " HTML {{{
  autocmd FileType html inoremap <buffer> = =
  " }}}
  " Hatena {{{
  autocmd BufNewFile,BufRead *.hatena set filetype=hatena

  autocmd BufEnter */Hatena/*          setlocal et ts=4 sts=4 sw=4
  autocmd BufEnter */Hatena/*.html.erb setlocal ts=2 sts=2 sw=2
  autocmd BufEnter */Hatena/*.html     setlocal ts=2 sts=2 sw=2
  autocmd BufEnter */Hatena/*.html.tt  setlocal ts=2 sts=2 sw=2
  autocmd BufEnter */Hatena/*.html     set ft=tt2html
  autocmd BufEnter */Hatena/*.tt       set ft=tt2html
  " }}}
  " AutoCursorLine {{{
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline
  " }}}
  " Indent guides width {{{
  autocmd BufEnter * let g:indent_guides_guide_size = &sw
  " }}}
  " Close window with `q` key {{{
  autocmd FileType help,ref-* nnoremap <buffer> q :q<CR>
  " }}}
augroup END
" }}}
" Plugin Configurations {{{
" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
if !exists('g:neocomplcache_dictionary_filetype_lists')
  let g:neocomplcache_dictionary_filetype_lists = {}
endif
let g:neocomplcache_temporary_dir = '~/.vim/.neocon'
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_vim_completefuncs = {
      \ 'Ref' : 'ref#complete',
      \ 'Unite' : 'unite#complete_source',
      \}

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" Delimiter {{{
if !exists('g:neocomplcache_delimiter_patterns')
    let g:neocomplcache_delimiter_patterns = {}
endif

let g:neocomplcache_delimiter_patterns.vim = ['#']
let g:neocomplcache_delimiter_patterns.ruby = ['::']
let g:neocomplcache_delimiter_patterns.perl = ['::']
" }}}

let neocomplcache = neobundle#get('neocomplcache')
function! neocomplcache.hooks.on_source(bundle) " {{{
  inoremap <expr><C-h> neocomplcache#smart_close_popup() . eval(smartinput#sid() . '_trigger_or_fallback("\<BS>", "\<C-h>")')
  inoremap <expr><BS>  neocomplcache#smart_close_popup() . eval(smartinput#sid() . '_trigger_or_fallback("\<BS>", "\<BS>")')
  inoremap <expr><C-g> neocomplcache#undo_completion()
endfunction " }}}
unlet neocomplcache
" }}}
" neosnippet {{{
let g:neosnippet#disable_select_mode_mappings = 0
let g:neosnippet#snippets_directory = '~/.vim/snippets'

let neosnippet = neobundle#get('neosnippet')
function! neosnippet.hooks.on_source(bundle) " {{{
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
endfunction " }}}
unlet neosnippet
" }}}
" syntastic {{{
let g:syntastic_auto_loc_list = 2
" }}}
" fugitive {{{
let fugitive = neobundle#get('vim-fugitive')
function! fugitive.hooks.on_source(bundle) " {{{
  nnoremap [fugitive] <Nop>
  nmap ,g [fugitive]

  nnoremap [fugitive]s :<C-u>Gstatus<CR>
  nnoremap [fugitive]c :<C-u>Gcommit<CR>
  nnoremap [fugitive]C :<C-u>Gcommit --amend<CR>
  nnoremap [fugitive]b :<C-u>Gblame<CR>
  nnoremap [fugitive]a :<C-u>Gwrite<CR>
  nnoremap [fugitive]d :<C-u>Gdiff<CR>
  nnoremap [fugitive]D :<C-u>Gdiff --staged<CR>

  vmap ,go :Gbrowse<CR>

  autocmd BufReadPost fugitive://* set bufhidden=delete
endfunction " }}}
unlet fugitive
" }}}
" surround_custom_mapping {{{
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.ruby  = {
  \ '#': "#{\r}",
  \ '3': "#{\r}",
  \ '5': "%(\r)",
  \ '%': "%(\r)",
  \ 'w': "%w(\r)",
  \ }
let g:surround_custom_mapping.eruby = {
  \ '-': "<% \r %>",
  \ '=': "<%= \r %>",
  \ '#': "#{\r}",
  \ }
let g:surround_custom_mapping.tt2 = {
      \ '%': "[% \r %]",
      \ }
let g:surround_custom_mapping.tt2html = g:surround_custom_mapping.tt2
" }}}
" zencoding-vim {{{
let g:user_zen_leader_key = '<C-e>'
let g:user_zen_settings = {
      \ 'indentation': ' ',
      \ }
" }}}
" ref-vim {{{
let g:ref_cache_dir = $HOME . '/.vim/.ref'
" }}}
" unite-vim {{{
let g:unite_data_directory = '~/.vim/.unite'

if executable('ag')
  let g:unite_source_grep_command        = 'ag'
  let g:unite_source_grep_default_opts   = '--nocolor --nogroup'
  let g:unite_source_grep_recursive_opt  = ''
  let g:unite_source_grep_max_candidates = 200
endif

let unite = neobundle#get('unite.vim')
function! unite.hooks.on_source(bundle) " {{{
  autocmd FileType unite nmap <buffer><BS> <Plug>(unite_delete_backward_path)

  nnoremap <SID>[unite] <Nop>
  nmap <Space> <SID>[unite]

  nnoremap <silent> / :<C-u>Unite line -buffer-name=search -start-insert<CR>
  nnoremap <silent> * :<C-u>UniteWithCursorWord line -buffer-name=search<CR>
  nnoremap <silent> n :<C-u>UniteResume search -no-start-insert<CR>

  nnoremap <silent> <SID>[unite]o :<C-u>UniteWithBufferDir  file_mru file -no-split -buffer-name=files<CR>
  nnoremap <silent> <SID>[unite]O :<C-u>UniteWithCurrentDir file_mru file -no-split -buffer-name=files<CR>
  nnoremap <silent> <SID>[unite]f :<C-u>UniteWithBufferDir  file file/new -no-split -buffer-name=files<CR>
  nnoremap <silent> <SID>[unite]F :<C-u>UniteWithCurrentDir file file/new -no-split -buffer-name=files<CR>
  nnoremap <silent> <SID>[unite]r :<C-u>UniteWithBufferDir  file_mru -no-split -buffer-name=files<CR>
  nnoremap <silent> <SID>[unite]b :<C-u>Unite buffer -immediately<CR>
  nnoremap <silent> <SID>[unite]B :<C-u>Unite buffer -immediately<CR>
  nnoremap <silent> <SID>[unite]w :<C-u>Unite window:no-current<CR>
  nnoremap <silent> <SID>[unite][ :<C-u>Unite outline -vertical -winwidth=40 -buffer-name=outline<CR>
  nnoremap <silent> <SID>[unite]> :<C-u>Unite output<CR>
  nnoremap <silent> <SID>[unite]p :<C-u>Unite register history/yank -buffer-name=register -no-split<CR>
  nnoremap <silent> <SID>[unite]: :<C-u>Unite history/command -start-insert<CR>
  nnoremap <silent> <SID>[unite]. :<C-u>Unite source<CR>
  nnoremap <silent> <SID>[unite]q :<C-u>Unite qf -no-quit -no-empty -auto-resize -buffer-name=quickfix<CR>
  nnoremap <silent> <SID>[unite]g :<C-u>Unite grep -buffer-name=search<CR>

  " JavaScript {{{
  autocmd FileType javascript nnoremap <silent><buffer> <Space>kj :<C-u>Unite -start-insert -default-action=split ref/javascript<CR>
  autocmd FileType javascript nnoremap <silent><buffer> <Space>kq :<C-u>Unite -start-insert -default-action=split ref/jquery<CR>
  " }}}

  " Ruby {{{
  autocmd FileType ruby* nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/refe<CR>
  autocmd FileType ruby* nnoremap <silent><buffer> <S-k>    :<C-u>UniteWithCursorWord -default-action=split ref/refe<CR>
  " }}}

  " Perl {{{
  autocmd FileType perl    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/perldoc<CR>
  autocmd FileType perl    nnoremap <silent><buffer> <S-k> :<C-u>UniteWithCursorWord -default-action=split ref/perldoc<CR>
  " }}}
endfunction " }}}
unlet unite
" }}}
" foldCC {{{
let foldCC = neobundle#get('foldCC')
function! foldCC.hooks.on_source(bundle) " {{{
  set foldtext=FoldCCtext()
  set foldcolumn=4
endfunction " }}}
unlet foldCC
" }}}
" hier {{{
let g:hier_enabled = 1
" }}}
" watchdogs -- 構文検証 {{{
let g:watchdogs_check_BufWritePost_enable = 1

if !exists('g:quickrun_config')
  let g:quickrun_config = {}
endif

let g:quickrun_config['watchdogs_checker/_'] = {
      \   'hook/close_quickfix/enable_exit' : 1,
      \   'hook/hier_update/enable_exit' : 1,
      \   'runner/vimproc/updatetime' : 40,
      \   'hook/unite_quickfix/enable_failure' : 1,
      \   'hook/unite_quickfix/enable_success' : 1,
      \   'hook/unite_quickfix/unite_options' : '-no-quit -no-empty -auto-resize -resume -buffer-name=quickfix',
      \ }
let g:quickrun_config['watchdogs_checker/perl-projectlibs'] = {
      \   'command' : 'perl',
      \   'exec' : '%c %o -cw -MProject::Libs %s:p',
      \   'quickfix/errorformat' : '%m\ at\ %f\ line\ %l%.%#',
      \ }
let g:quickrun_config['perl/watchdogs_checker'] = {
      \   'type' : 'watchdogs_checker/perl-projectlibs',
      \ }

let watchdogs = neobundle#get('vim-watchdogs')
function! watchdogs.hooks.on_source(bundle) " {{{
  call watchdogs#setup(g:quickrun_config)
endfunction " }}}
unlet watchdogs
" }}}
" indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
" }}}
" operator-html-escape {{{
let operator_html_escape = neobundle#get('operator-html-escape.vim')
function! operator_html_escape.hooks.on_source(bundle) " {{{
  nmap <C-e> <Plug>(operator-html-escape)
  " nmap <C-S-e> <Plug>(operator-html-unescape)
endfunction " }}}
unlet operator_html_escape
" }}}
" smartinput {{{
" }}}
" vim-cpanfile {{{
if !exists('g:neocomplcache_dictionary_filetype_lists')
  let g:neocomplcache_dictionary_filetype_lists = {}
endif
" }}}
" vim-smartchr {{{
let smartchr = neobundle#get('vim-smartchr')
function! smartchr.hooks.on_source(bundle)
  autocmd FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
  autocmd FileType javascript inoremap <buffer><expr> \ smartchr#one_of('function ', '\')
  autocmd FileType ruby* inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
  autocmd FileType ruby* inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')
  autocmd FileType coffee inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
  autocmd FileType coffee inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')
  autocmd FileType haskell inoremap <buffer><expr> = smartchr#loop(' = ', '=')
  autocmd FileType haskell inoremap <buffer><expr> . smartchr#one_of(' -> ', '.')
  autocmd FileType haskell inoremap <buffer><expr> , smartchr#one_of(' <- ', ',')
  autocmd FileType perl    inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
  autocmd FileType perl    inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
  autocmd FileType perl    inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
endfunction
unlet smartchr
" }}}
" eskk.vim {{{
let eskk = neobundle#get('eskk.vim')
function! eskk.hooks.on_source(bundle) " {{{
  let g:eskk#directory = expand('~/.vim/.eskk')

  let user_dictionary = expand('~/Library/Application Support/AquaSKK/skk-jisyo.utf8')
  let large_dictionary = expand('~/Library/Application Support/AquaSKK/SKK-JISYO.L')

  if filereadable(user_dictionary)
    let g:eskk#dictionary = user_dictionary
  endif

  if filereadable(large_dictionary)
    let g:eskk#large_dictionary = large_dictionary
  endif

  imap <C-o> <Plug>(eskk:toggle)
endfunction " }}}
unlet eskk
" }}}
" vim-localrc {{{
let localrc = neobundle#get('vim-localrc')
function! localrc.hooks.on_source(bundle) " {{{
  call localrc#load('.local.vimrc')
endfunction " }}}
unlet localrc
" }}}
" }}}
" Colorscheme {{{
set bg=dark
colorscheme hybrid
" }}}
