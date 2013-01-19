" vim:set et foldmethod=marker:
" Setup neobundle.vim {{{
set nocompatible
filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  syntax enable
endif

try
  call neobundle#rc(expand('~/.vim/bundle'))
catch /E117/
endtry
" }}}

" Plugins {{{
if ! exists('g:bundles_loaded_expected_event')
  let g:bundles_loaded_expected_event = {}
endif

function! s:RegisterLazyBundle(event_name, event_args, bundle_name) " {{{
  let event_key = a:event_name . ' ' . a:event_args

  if ! has_key(g:bundles_loaded_expected_event, event_key)
    let g:bundles_loaded_expected_event[event_key] = []
  endif

  call add(g:bundles_loaded_expected_event[event_key], a:bundle_name)
endfunction " }}}

function! s:RegisterFileTypeBundle(file_type, bundle_name) " {{{
  call s:RegisterLazyBundle('FileType', a:file_type, a:bundle_name)
endfunction " }}}

function! s:IsRegisteredFileTypeBundles(file_type) " {{{
  call has_key(g:bundles_loaded_expected_event, 'FileType ' . a:file_type)
endfunction " }}}

function! s:LoadFileTypeBundles(file_type) " {{{
  call g:bundles_loaded_expected_event['FileType ' . a:file_type]
endfunction " }}}

function! s:LoadPlugins() " {{{
  NeoBundle 'kana/vim-textobj-user'

  NeoBundle 'h1mesuke/textobj-wiw'
  NeoBundle 'kana/vim-textobj-indent'
  NeoBundle 'kana/vim-textobj-line'
  NeoBundle 'thinca/vim-textobj-comment'
  NeoBundle 'coderifous/textobj-word-column.vim'
  NeoBundle 'rhysd/vim-textobj-continuous-line'
  NeoBundleLazy 'rhysd/vim-textobj-ruby'
  NeoBundle 'thinca/vim-textobj-between'
  NeoBundle 'mattn/vim-textobj-url'

  NeoBundle 'kana/vim-operator-user'
  NeoBundle 'emonkak/vim-operator-sort'
  NeoBundle 'kana/vim-operator-replace'
  NeoBundle 'tyru/operator-camelize.vim'
  NeoBundle 'tyru/operator-html-escape.vim'

  NeoBundle 'vim-jp/vimdoc-ja'
  NeoBundle 'thinca/vim-ref'

  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/unite-outline'
  NeoBundle 'sgur/unite-git_grep'
  NeoBundle 'sgur/unite-qf'
  NeoBundle 'thinca/vim-unite-history'
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'osyo-manga/unite-filetype'
  NeoBundle 'osyo-manga/unite-quickrun_config'
  NeoBundle 'osyo-manga/unite-fold'
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'taka84u9/unite-git'
  NeoBundleLazy 'rhysd/unite-ruby-require.vim'
  NeoBundle 'rhysd/unite-mac-apps'
  NeoBundle 'basyura/unite-rails'

  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 't9md/vim-surround_custom_mapping'
  NeoBundle 'kana/vim-smartinput'
  NeoBundle 'sickill/vim-pasta'
  NeoBundle 'mattn/zencoding-vim'
  NeoBundleLazy 'AndrewRadev/switch.vim'
  NeoBundle 'kana/vim-smartchr'
  NeoBundle 'h1mesuke/vim-alignta'
  NeoBundleLazy 'tpope/vim-commentary'

  NeoBundle 'bbommarito/vim-slim', { 'stay_same' : 1 }
  NeoBundle 'groenewege/vim-less', { 'stay_same' : 1 }
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundle 'hallison/vim-markdown', { 'stay_same' : 1 }
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'motemen/hatena-vim', { 'stay_same' : 1 }
  NeoBundle 'othree/html5.vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'vim-perl/vim-perl'
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'juvenn/mustache.vim'
  NeoBundle 'davidoc/taskpaper.vim'
  NeoBundle 'zaiste/tmux.vim'
  NeoBundle 'elixir-lang/vim-elixir'

  NeoBundle 'Lokaltog/vim-powerline', 'develop'
  NeoBundle 'nathanaelkane/vim-indent-guides'

  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'git@github.com:aereal/vim-magica-colors.git',
        \ { 'base' : '~/repos/@aereal' }
  NeoBundle 'nanotech/jellybeans.vim', { 'stay_same' : 1 }
  NeoBundle 'tomasr/molokai', { 'stay_same' : 1 }
  NeoBundle 'git://gist.github.com/187578.git', { 'name' : 'h2u_colors', 'stay_same' : 1 }
  NeoBundle 'sickill/vim-monokai', { 'stay_same' : 1 }

  NeoBundle 'kana/vim-altr'
  NeoBundle 'kana/vim-gf-user'
  NeoBundle 'kana/vim-gf-diff'
  NeoBundleLazy 'thinca/vim-partedit'
  NeoBundleLazy 'Shougo/vimfiler'
  NeoBundle 'sudo.vim', { 'stay_same' : 1 }

  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \   'mac' : 'make -f make_mac.mak',
        \   'unix' : 'make -f make_unix.mak',
        \   },
        \ }

  NeoBundle 'Shougo/vimshell'

  NeoBundle 'scrooloose/syntastic'

  NeoBundle 'tpope/vim-fugitive'
  NeoBundleLazy 'int3/vim-extradite'

  NeoBundleLazy 'mattn/gist-vim'
  NeoBundleLazy 'mattn/webapi-vim'

  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'LeafCage/foldCC', '57c75f63ea706616f61a3aa1ed14aa1d21b6a56b'
  NeoBundle 'kana/vim-tabpagecd'
  NeoBundle 'tyru/current-func-info.vim'
  NeoBundleLazy 'sjl/gundo.vim'
  NeoBundleLazy 'Shougo/echodoc'

  NeoBundle 'kien/ctrlp.vim'
  NeoBundle 'vimtaku/hl_matchit.vim'
  NeoBundle 'spolu/dwm.vim'

  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'ujihisa/neco-look'
  NeoBundleLazy 'rhysd/neco-ruby-keyword-args'

  NeoBundleLazy 'Lokaltog/vim-easymotion'
endfunction " }}}

if exists('g:loaded_neobundle') && g:loaded_neobundle
  call s:LoadPlugins()
endif

" Register filetype-spcific bundles {{{
call s:RegisterFileTypeBundle('ruby', 'vim-textobj-ruby')
call s:RegisterFileTypeBundle('ruby', 'unite-ruby-require.vim')
call s:RegisterFileTypeBundle('css', 'vim-css3-syntax')
call s:RegisterFileTypeBundle('perl', 'vim-perl')
call s:RegisterFileTypeBundle('ruby', 'vim-ruby')
call s:RegisterFileTypeBundle('ruby', 'neco-ruby-keyword-args')
" }}}

filetype plugin indent on
" }}}

" Configurations {{{
set nocompatible
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
set listchars=tab:>.,precedes:<,extends:>,eol:↵
" }}}

" UI {{{
lang en_US.UTF-8

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

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

if has('clipboard')
  set clipboard=unnamed,autoselect
endif

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

" Command-line Window http://vim-users.jp/2010/07/hack161/ {{{
nnoremap   <sid>(command-line-enter) q:
xnoremap   <sid>(command-line-enter) q:
nnoremap   <sid>(command-line-norange) q:<C-u>
nmap     : <sid>(command-line-enter)
xmap     : <sid>(command-line-enter)

augroup InitializeCommandLineWindow " {{{
  autocmd!
  autocmd CmdwinEnter * call s:init_cmdwin()
augroup END " }}}

function! s:init_cmdwin() "{{{
  nnoremap <buffer>       q     :<C-u>quit<CR>
  nnoremap <buffer>       <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr> <CR>  pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr> <C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr> <BS>  pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr> <C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr> :     col('.') == 1 ? "VimProcBang " : col('.') == 2 && getline('.')[0] == 'r' ? "<BS>VimProcRead " : ":"
  inoremap <buffer><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  setlocal nonumber
  startinsert!
endfunction " }}}
" }}}

" Adjust splitted-window width http://vim-users.jp/2009/07/hack42/ {{{
nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>j <C-w>j:call <SID>good_width()<CR>
nnoremap <C-w>k <C-w>k:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>

function! s:good_width() "{{{
  if winwidth(0) < 80
    vertical resize 80
  endif
endfunction " }}}
" }}}

" autocmd {{{
augroup ShowFilenameScreenWindow " screenに編集中のファイル名を出す {{{
  autocmd!
  if ! has('gui_running')
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%:t\\"' | endif
  endif
augroup END " }}}

augroup ShellConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('sh')
    autocmd FileType sh call s:LoadFileTypeBundles('sh')
  endif

  autocmd FileType sh inoremap <buffer><expr> = smartchr#loop('=', ' != ')
augroup END " }}}

augroup IoConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('io')
    autocmd FileType io call s:LoadFileTypeBundles('io')
  endif

  autocmd FileType io inoremap <buffer><expr> = smartchr#loop(' := ', ' = ', ' == ', ' ::= ')
augroup END " }}}

augroup JavaScriptConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('javascript')
    autocmd FileType javascript call s:LoadFileTypeBundles('javascript')
  endif

  autocmd FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
  autocmd FileType javascript inoremap <buffer><expr> \ smartchr#one_of('function ', '\')
  autocmd FileType javascript nnoremap <silent><buffer> <Space>kj :<C-u>Unite -start-insert -default-action=split ref/javascript<CR>
  autocmd FileType javascript nnoremap <silent><buffer> <Space>kq :<C-u>Unite -start-insert -default-action=split ref/jquery<CR>
augroup END " }}}

augroup RubyConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('ruby')
    autocmd FileType ruby call s:LoadFileTypeBundles('ruby')
  endif

  autocmd FileType ruby* inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
  autocmd FileType ruby* inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')
  autocmd FileType ruby* nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/refe<CR>
  autocmd FileType ruby* nnoremap <silent><buffer> <S-k>    :<C-u>UniteWithCursorWord -default-action=split ref/refe<CR>

  autocmd FileType ruby* NeoBundleSource vim-ruby
  autocmd FileType ruby* NeoBundleSource vim-textobj-ruby
  autocmd FileType ruby* NeoBundleSource unite-ruby-require.vim
augroup END " }}}

augroup RubyDetection " {{{
  autocmd!
  autocmd BufEnter */.gemrc set ft=yaml
  autocmd BufEnter *.rb set ft=ruby
  autocmd BufEnter Rakefile,*.rake set ft=ruby.rake
  autocmd BufEnter Capfile,deploy.rb,*/deploy/*.rb set ft=ruby.cap
  autocmd BufEnter [tT]horfile,*.thor set ft=ruby.thor
  autocmd BufEnter *.ru set ft=ruby.rack
  autocmd BufEnter .pryrc set ft=ruby.pry
  autocmd BufEnter .irbrc,irbrc set ft=ruby.irb
  autocmd BufEnter *.gemspec set ft=ruby.gemspec
  autocmd BufEnter *.erb set ft=eruby
augroup END " }}}

augroup CoffeeScriptConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('coffee')
    autocmd FileType coffee call s:LoadFileTypeBundles('coffee')
  endif

  autocmd FileType coffee inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
  autocmd FileType coffee inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')

  autocmd ColorScheme * hi! link CoffeeSpecialVar Constant
augroup END " }}}

augroup HaskellConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('haskell')
    autocmd FileType haskell call s:LoadFileTypeBundles('haskell')
  endif

  autocmd FileType haskell setlocal et
  autocmd FileType haskell inoremap <buffer><expr> = smartchr#loop(' = ', '=')
  autocmd FileType haskell inoremap <buffer><expr> . smartchr#one_of(' -> ', '.')
  autocmd FileType haskell inoremap <buffer><expr> , smartchr#one_of(' <- ', ',')
augroup END " }}}

augroup PerlConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('perl')
    autocmd FileType perl call s:LoadFileTypeBundles('perl')
  endif

  autocmd FileType perl    inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
  autocmd FileType perl    inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
  autocmd FileType perl    inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
  autocmd FileType perl    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/perldoc<CR>
  autocmd FileType perl    nnoremap <silent><buffer> <S-k> :<C-u>UniteWithCursorWord -default-action=split ref/perldoc<CR>
augroup END " }}}

augroup PerlDetection " {{{
  autocmd!
  autocmd BufEnter *.tt    set ft=tt2
augroup END " }}}

augroup VinConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('vim')
    autocmd FileType vim call s:LoadFileTypeBundles('vim')
  endif

  autocmd FileType vim inoreabbrev <buffer> = =
augroup END " }}}

augroup MarkdownConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('markdown')
    autocmd FileType markdown call s:LoadFileTypeBundles('markdown')
  endif

  autocmd FileType markdown setlocal et ts=4 sts=4 sw=4
augroup END " }}}

augroup HamlConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('haml')
    autocmd FileType haml call s:LoadFileTypeBundles('haml')
  endif

  autocmd FileType haml inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
augroup END " }}}

augroup NginxDetection " {{{
  autocmd!
  autocmd BufEnter */nginx/*.conf set ft=nginx
  autocmd BufEnter */*.nginx.conf set ft=nginx
augroup END " }}}

augroup HTMLConfig " {{{
  autocmd!

  if s:IsRegisteredFileTypeBundles('ruby')
    autocmd FileType ruby call s:LoadFileTypeBundles('ruby')
  endif

  autocmd FileType html inoremap <buffer> = =
augroup END " }}}

augroup Hatena " {{{
  autocmd!
  autocmd BufEnter */@hatena/*          setlocal et ts=4 sts=4 sw=4
  autocmd BufEnter */@hatena/*.html.erb setlocal ts=2 sts=2 sw=2
  autocmd BufEnter */@hatena/*.html     setlocal ts=2 sts=2 sw=2
  autocmd BufEnter */@hatena/*.html.tt  setlocal ts=2 sts=2 sw=2
  autocmd BufEnter */@hatena/*.html     set ft=tt2.html
  autocmd BufEnter */@hatena/*.tt       set ft=tt2.html
augroup END " }}}

augroup AutoCursorLine " http://d.hatena.ne.jp/thinca/20090530/1243615055 {{{
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline
augroup END " }}}
" }}}

" Plugin Configurations {{{
" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
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

inoremap <expr><CR>   neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-g> neocomplcache#undo_completion()
" }}}
" neosnippet {{{
let g:neosnippet#disable_select_mode_mappings = 0
let g:neosnippet#snippets_directory = '~/.vim/snippets'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" }}}
" syntastic {{{
let g:syntastic_auto_loc_list  = 2
let g:syntastic_perl_efm_program = $HOME . '/.vim/bin/efm_perl.pl'
" }}}
" fugitive {{{
nnoremap [fugitive] <Nop>
nmap git [fugitive]

nnoremap [fugitive]s :<C-u>Gstatus<CR>
nnoremap [fugitive]c :<C-u>Gcommit<CR>
nnoremap [fugitive]C :<C-u>Gcommit --amend<CR>
nnoremap [fugitive]b :<C-u>Gblame<CR>
nnoremap [fugitive]a :<C-u>Gwrite<CR>
nnoremap [fugitive]d :<C-u>Gdiff<CR>
nnoremap [fugitive]D :<C-u>Gdiff --staged<CR>

vmap ,go :Gbrowse<CR>

autocmd BufReadPost fugitive://* set bufhidden=delete
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
" }}}
" zencoding-vim {{{
let g:user_zen_leader_key = '<C-e>'
let g:user_zen_settings = {
      \ 'indentation': ' ',
      \ }
" }}}
" ref-vim {{{
let g:ref_jquery_doc_path = $HOME . '/Downloads/jqapi-latest'
let g:ref_jquery_use_cache = 1
let g:ref_cache_dir = $HOME . '/.vim/.ref'
" }}}
" unite-vim {{{
let g:unite_data_directory = '~/.vim/.unite'

function! s:unite_local_settings() "{{{
  imap <buffer> .. <Plug>(unite_delete_backward_path)
  nmap <buffer><BS> <Plug>(unite_delete_backward_path)

  let current = unite#get_current_unite()
  if current.buffer_name =~# '^search'
    nnoremap <silent><buffer><expr> r unite#do_action('replace')
  endif

  nnoremap <silent><buffer><expr> wh unite#smart_map('wh', unite#do_action('left'))
  inoremap <silent><buffer><expr> wh unite#smart_map('wh', unite#do_action('left'))
  nnoremap <silent><buffer><expr> wl unite#smart_map('wl', unite#do_action('right'))
  inoremap <silent><buffer><expr> wl unite#smart_map('wl', unite#do_action('right'))
  nnoremap <silent><buffer><expr> wk unite#smart_map('wk', unite#do_action('above'))
  inoremap <silent><buffer><expr> wk unite#smart_map('wk', unite#do_action('above'))
  nnoremap <silent><buffer><expr> wj unite#smart_map('wj', unite#do_action('below'))
  inoremap <silent><buffer><expr> wj unite#smart_map('wj', unite#do_action('below'))
endfunction " }}}

autocmd FileType unite call s:unite_local_settings()

function! s:unite_keymap(mode, key, definition) " {{{
  execute a:mode . 'noremap <silent> <SID>[unite]' . a:key . ' :<C-u>' . a:definition . '<CR>'
endfunction " }}}

function! s:unite_normal_keymap(...) " {{{
  call s:unite_keymap('n', a:1, a:2)
endfunction " }}}

nnoremap <SID>[unite] <Nop>
nmap <Space> <SID>[unite]

nnoremap <silent> / :<C-u>Unite line -buffer-name=search -start-insert<CR>
nnoremap <silent> * :<C-u>UniteWithCursorWord line -buffer-name=search<CR>
nnoremap <silent> n :<C-u>UniteResume search -no-start-insert<CR>

call s:unite_normal_keymap('m', 'UniteWithBufferDir file_mru -buffer-name=files')
call s:unite_normal_keymap('f', 'UniteWithBufferDir file_mru file file/new -no-split -buffer-name=files')
call s:unite_normal_keymap('b', 'Unite buffer_tab -immediately')
call s:unite_normal_keymap('B', 'Unite buffer -immediately')
call s:unite_normal_keymap('T', 'Unite tab -immediately -no-empty')
call s:unite_normal_keymap('w', 'Unite window:no-current -immediately')
call s:unite_normal_keymap('[', 'Unite outline -vertical -winwidth=40 -buffer-name=outline')
call s:unite_normal_keymap('{', 'Unite outline fold -vertical -winwidth=40 -buffer-name=outline')
call s:unite_normal_keymap('>', 'Unite output')
call s:unite_normal_keymap('n', 'Unite register history/yank -buffer-name=register -no-split')
call s:unite_normal_keymap(':', 'Unite history/command -start-insert')
call s:unite_normal_keymap('q', 'Unite qf -no-empty -no-start-insert -auto-preview')
call s:unite_normal_keymap('t', 'Unite tag -start-insert -no-empty -no-split -buffer-name=tag')
call s:unite_normal_keymap('c', 'Unite colorscheme -auto-preview')
call s:unite_normal_keymap('.', 'Unite source')
call s:unite_normal_keymap('Rm', 'Unite rails/model -vertical -winwidth=40')
call s:unite_normal_keymap('Rc', 'Unite rails/controller -vertical -winwidth=40')
call s:unite_normal_keymap('Rv', 'Unite rails/view -vertical -winwidth=40')
call s:unite_normal_keymap('\c', 'Unite colorscheme -auto-preview -vertical -winwidth=30')
" }}}
" vim-powerline {{{
let g:Powerline_symbols = 'fancy'
let g:Powerline_mode_n = ' N '
" }}}
" vim-indent-guides {{{
let g:indent_guides_auto_colors           = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent  = 10

autocmd BufEnter * let g:indent_guides_guide_size = &sw
" }}}
" vim-altr {{{
function! s:ConfigureAltr() " {{{
  nmap <Leader><C-[> <Plug>(altr-forward)
  nmap <Leader><C-]> <Plug>(altr-back)

  " Rails rules
  call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%_factory.rb')
  call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
  call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')
  call altr#define('spec/routing/%_spec.rb', 'config/routes.rb')
endfunction " }}}

try
  call s:ConfigureAltr()
catch /E117/
endtry
" }}}
" foldCC {{{
set foldtext=FoldCCtext()
set foldcolumn=4
" }}}
" switch.vim {{{
nnoremap - :<C-u>Switch<CR>
" }}}
" }}}

" Colorscheme {{{
set bg=light
colorscheme solarized
" }}}
