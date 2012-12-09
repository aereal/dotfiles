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
function! s:LoadPlugins() " {{{
  " Text object {{{
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
  " }}}

  " Operator {{{
  NeoBundle 'kana/vim-operator-user'
  NeoBundle 'emonkak/vim-operator-sort'
  NeoBundle 'kana/vim-operator-replace'
  NeoBundle 'tyru/operator-camelize.vim'
  NeoBundle 'tyru/operator-html-escape.vim'
  " }}}

  " Help {{{
  NeoBundle 'vim-jp/vimdoc-ja'
  NeoBundle 'thinca/vim-ref'
  " }}}

  " Unite {{{
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
  " }}}

  " Input {{{
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 't9md/vim-surround_custom_mapping'
  NeoBundle 'kana/vim-smartinput'
  NeoBundle 'sickill/vim-pasta'
  NeoBundle 'mattn/zencoding-vim'
  NeoBundle 'AndrewRadev/switch.vim'
  NeoBundle 'kana/vim-smartchr'
  NeoBundle 'h1mesuke/vim-alignta'
  NeoBundleLazy 'tpope/vim-commentary'
  " }}}

  " Language {{{
  NeoBundleLazy 'bbommarito/vim-slim', { 'stay_same' : 1 }
  NeoBundleLazy 'groenewege/vim-less', { 'stay_same' : 1 }
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundle 'hallison/vim-markdown', { 'stay_same' : 1 }
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'motemen/hatena-vim', { 'stay_same' : 1 }
  NeoBundle 'othree/html5.vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundleLazy 'vim-perl/vim-perl'
  NeoBundleLazy 'vim-ruby/vim-ruby'
  NeoBundleLazy 'juvenn/mustache.vim'
  NeoBundle 'davidoc/taskpaper.vim'
  NeoBundle 'zaiste/tmux.vim'
  " }}}

  " UI {{{
  NeoBundle 'Lokaltog/vim-powerline', 'develop'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  " }}}

  " Colors {{{
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'git@github.com:aereal/vim-magica-colors.git',
        \ { 'base' : '~/repos/@aereal' }
  NeoBundle 'nanotech/jellybeans.vim', { 'stay_same' : 1 }
  " }}}

  " Files {{{
  NeoBundle 'kana/vim-altr'
  NeoBundle 'kana/vim-gf-user'
  NeoBundle 'kana/vim-gf-diff'
  NeoBundleLazy 'thinca/vim-partedit'
  NeoBundleLazy 'Shougo/vimfiler'
  NeoBundle 'sudo.vim', { 'stay_same' : 1 }
  " }}}

  " Misc. {{{
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \   'mac' : 'make -f make_mac.mak',
        \   'unix' : 'make -f make_unix.mak',
        \   },
        \ }

  NeoBundle 'scrooloose/syntastic'

  NeoBundle 'tpope/vim-fugitive'
  NeoBundleLazy 'int3/vim-extradite'

  NeoBundleLazy 'mattn/gist-vim'
  NeoBundleLazy 'mattn/webapi-vim'

  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'LeafCage/foldCC'
  NeoBundle 'kana/vim-tabpagecd'
  NeoBundle 'tyru/current-func-info.vim'
  NeoBundleLazy 'sjl/gundo.vim'
  NeoBundleLazy 'Shougo/echodoc'
  " }}}

  " Completions (neco) {{{
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'ujihisa/neco-look'
  NeoBundle 'rhysd/neco-ruby-keyword-args'
  " }}}

  " Move {{{
  NeoBundle 'Lokaltog/vim-easymotion'
  " }}}
endfunction " }}}

if exists('g:loaded_neobundle') && g:loaded_neobundle
  call s:LoadPlugins()
endif

filetype plugin indent on
" }}}

" Configurations {{{
set nocompatible
set hidden
set history=100
set autoread
set fileformats=unix,dos,mac
set langmenu=none " メニューをローカライズしない
lang en_US.UTF-8
set wildmenu
set wildmode=list:longest,full
set nobackup
set swapfile
set directory=~/.vim/swp
set laststatus=2
set number
set ruler
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set scrolloff=100000 " 常にカーソルのある行を中心に (したい)
set splitbelow
set modeline
set showcmd
set showmode
set shortmess+=I
set ambiwidth=double
set backspace=indent,eol,start
set list
set listchars=tab:>.,precedes:<,extends:>,eol:↵
set formatoptions-=ro
set ttyfast

" Indentation {{{
set autoindent
set nosmartindent
set nocindent
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
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
  autocmd FileType sh inoremap <buffer><expr> = smartchr#loop('=', ' != ')
augroup END " }}}

augroup IoConfig " {{{
  autocmd!
  autocmd FileType io inoremap <buffer><expr> = smartchr#loop(' := ', ' = ', ' == ', ' ::= ')
augroup END " }}}

augroup JavaScriptConfig " {{{
  autocmd!
  autocmd FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
  autocmd FileType javascript inoremap <buffer><expr> \ smartchr#one_of('function ', '\')
  autocmd FileType javascript nnoremap <silent><buffer> <Space>kj :<C-u>Unite -start-insert -default-action=split ref/javascript<CR>
  autocmd FileType javascript nnoremap <silent><buffer> <Space>kq :<C-u>Unite -start-insert -default-action=split ref/jquery<CR>
augroup END " }}}

augroup RubyConfig " {{{
  autocmd!
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
  autocmd FileType coffee inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
  autocmd FileType coffee inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')

  autocmd ColorScheme * hi! link CoffeeSpecialVar Constant
augroup END " }}}

augroup HaskellConfig " {{{
  autocmd!
  autocmd FileType haskell setlocal et
  autocmd FileType haskell inoremap <buffer><expr> = smartchr#loop(' = ', '=')
  autocmd FileType haskell inoremap <buffer><expr> . smartchr#one_of(' -> ', '.')
  autocmd FileType haskell inoremap <buffer><expr> , smartchr#one_of(' <- ', ',')
augroup END " }}}

augroup PerlConfig " {{{
  autocmd!
  autocmd FileType perl    inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
  autocmd FileType perl    inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
  autocmd FileType perl    inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
  autocmd FileType perl    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/perldoc<CR>
  autocmd FileType perl    nnoremap <silent><buffer> <S-k> :<C-u>UniteWithCursorWord -default-action=split ref/perldoc<CR>
augroup END " }}}

augroup PerlDetection " {{{
  autocmd!
  autocmd BufEnter *.tt    set ft=tt2
  autocmd BufEnter */t/*.t set ft=perl.tap
augroup END " }}}

augroup VinConfig " {{{
  autocmd!
  autocmd FileType vim inoreabbrev <buffer> = =
augroup END " }}}

augroup MarkdownConfig " {{{
  autocmd!
  autocmd FileType markdown setlocal et ts=4 sts=4 sw=4
augroup END " }}}

augroup HamlConfig " {{{
  autocmd!
  autocmd FileType haml inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
augroup END " }}}

augroup NginxDetection " {{{
  autocmd!
  autocmd BufEnter */nginx/*.conf set ft=nginx
  autocmd BufEnter */*.nginx.conf set ft=nginx
augroup END " }}}

augroup HTMLConfig " {{{
  autocmd!
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
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_omni_functions = {
      \ 'ruby' : 'rubycomplete#Complete',
      \ }
let g:neocomplcache_vim_completefuncs = {
      \ 'Ref' : 'ref#complete',
      \ 'Unite' : 'unite#complete_source',
      \}

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

inoremap <expr><CR>   neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-x><C-f>  neocomplcache#manual_filename_complete()
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

nnoremap <SID>[unite] <Nop>
nmap <Space> <SID>[unite]
nnoremap <silent> <SID>[unite]o        :<C-u>UniteWithBufferDir buffer file_mru file file/new<CR>

if has('gui_running')
  nnoremap <silent> <SID>[unite]b        :<C-u>Unite buffer_tab -immediately<CR>
  nnoremap <silent> <SID>[unite]B        :<C-u>Unite buffer -immediately<CR>
else
  nnoremap <silent> <SID>[unite]b        :<C-u>Unite buffer -immediately<CR>
endif

nnoremap <silent> <SID>[unite]O        :<C-u>UniteWithCurrentDir buffer file_mru file file/new<CR>
nnoremap <silent> <SID>[unite].        :<C-u>Unite source<CR>
nnoremap <silent> <SID>[unite]s        :<C-u>Unite session<CR>
nnoremap <silent> <SID>[unite]w        :<C-u>Unite -immediately window:no-current<CR>

nnoremap <silent> / :<C-u>Unite line -buffer-name=search -start-insert<CR>
nnoremap <silent> * :<C-u>UniteWithCursorWord line -buffer-name=search<CR>
nnoremap <silent> n :<C-u>UniteResume search -no-start-insert<CR>

nnoremap <silent> <SID>[unite]T :<C-u>Unite tab<CR>

autocmd FileType unite call s:unite_local_settings()

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

function! s:unite_project(...) " {{{
  let opts = (a:0 ? join(a:000, ' ') : '')
  let dir = unite#util#path2project_directory(expand('%'))
  execute 'UniteWithBufferDir' opts 'buffer file_rec:' . dir
endfunction " }}}

" unite-outline {{{
nnoremap <silent> <SID>[unite][ :<C-u>Unite outline -buffer-name=outline -vertical -winwidth=40<CR>
nnoremap <silent> <SID>[unite]{ :<C-u>Unite outline -no-quit -vertical -winwidth=40 -buffer-name=outline<CR>
" }}}
" unite-history {{{
nnoremap <silent> <SID>[unite]: :<C-u>Unite history/command -start-insert<CR>
" }}}
" unite-qf {{{
nnoremap <silent> <SID>[unite]q :<C-u>Unite qf -no-empty -no-start-insert -auto-preview<CR>
" }}}
" unite-colorscheme {{{
nnoremap <silent> <SID>[unite]\c :<C-u>Unite colorscheme -auto-preview<CR>
" }}}
" unite-fold {{{
nnoremap <silent> <SID>[unite]d :<C-u>Unite fold<CR>
" }}}
" unite-tag {{{
nnoremap <silent> <SID>[unite]t :<C-u>Unite tag -buffer-name=tag -start-insert<CR>
" }}}
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
  call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
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
