syntax on
set bg=dark

" NeoBundle.vim {{{
filetype off
if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle'))
endif
" }}}

" Bundles {{{

" Awesome {{{
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'errormarker.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kana/vim-altr'
NeoBundle 'kana/vim-gf-diff'
NeoBundle 'kana/vim-gf-user'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'sjl/gundo.vim'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'sudo.vim'
NeoBundle 'kana/vim-arpeggio'
" }}}

" Text Object Extensions {{{
NeoBundle 'h1mesuke/textobj-wiw'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 't9md/vim-surround_custom_mapping'
NeoBundle 'thinca/vim-textobj-comment'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vimtaku/vim-textobj-sigil'
" }}}

" Help & Document {{{
NeoBundle 'mojako/ref-sources.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'ujihisa/ref-hoogle'
NeoBundle 'vim-jp/vimdoc-ja'
" }}}

" unite sources {{{
NeoBundle 'basyura/unite-rails'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'sgur/unite-qf'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'ujihisa/unite-colorscheme'
" }}}

" Language Support {{{
NeoBundle 'bbommarito/vim-slim'
NeoBundle 'davidoc/taskpaper.vim'
NeoBundle 'depuracao/vim-rdoc'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'hallison/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'nginx.vim'
NeoBundle 'nono/jquery.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'petdance/vim-perl'
NeoBundle 'rosstimson/scala-vim-support'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'vim-ruby/vim-ruby'
" }}}

" Colors {{{
NeoBundle 'git@github.com:aereal/vim-magica-colors.git'
NeoBundle 'mayansmoke.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'noahfrederick/Hemisu'
NeoBundle 'tomasr/molokai.vim'
NeoBundle 'git://gist.github.com/187578.git'
NeoBundle 'nelstrom/vim-mac-classic-theme'
" }}}

NeoBundle 'mattn/sonictemplate-vim'

" }}}

" Configurations {{{

" indentation {{{
set autoindent
set nosmartindent
set nocindent
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
" }}}

set ambiwidth=double
set autoread
set backspace=indent,eol,start
set nobackup
set nocompatible
set hidden
set hlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan
set history=100
set laststatus=2
set list
set listchars=tab:>.,precedes:<,extends:>,eol:¬
set number
set ruler
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
set directory=~/.vim/swp
set shortmess+=I
set cursorline
"set statusline=%<\ %f%=%m%r%h%w%{fugitive#statusline()}%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}[%3l/%3L,%3c]

filetype plugin indent on
" }}}

" Key mappings {{{
let mapleader   = ';'
let g:mapleader = ';'

nnoremap <Space><Space> :update<CR>
nnoremap <ESC><ESC>      :nohlsearch<CR>

inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', '=')
" }}}

" autocmd {{{
" screenに編集中のファイル名を出す
autocmd BufEnter *       if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%\\"' | endif
autocmd FileType sh      inoremap <buffer><expr> = smartchr#loop('=', ' != ')

" io {{{
autocmd FileType io inoremap <buffer><expr> = smartchr#loop(' := ', ' = ', ' == ', ' ::= ')
" }}}

" javascript {{{
autocmd FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
autocmd FileType javascript inoremap <buffer><expr> \ smartchr#one_of('function ', '\')
autocmd FileType javascript nnoremap <silent><buffer> <Space>kj :<C-u>Unite -start-insert -default-action=split ref/javascript<CR>
autocmd FileType javascript nnoremap <silent><buffer> <Space>kq :<C-u>Unite -start-insert -default-action=split ref/jquery<CR>
" }}}

" ruby {{{
autocmd FileType ruby    inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
autocmd FileType ruby    inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')
"autocmd FileType ruby    inoremap <buffer><expr> < smartchr#loop(' < ', ' <= ', '<')
"autocmd FileType ruby    inoremap <buffer><expr> > smartchr#loop(' > ', ' >= ', '>')
autocmd FileType ruby    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/refe<CR>
"autocmd FileType ruby    setlocal foldmethod=syntax
" }}}

" coffee {{{
autocmd FileType coffee  inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
autocmd FileType coffee  inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')
" }}}

" haskell {{{
autocmd FileType haskell setlocal et
autocmd FileType haskell inoremap <buffer><expr> = smartchr#loop(' = ', '=')
autocmd FileType haskell inoremap <buffer><expr> . smartchr#one_of(' -> ', '.')
autocmd FileType haskell inoremap <buffer><expr> , smartchr#one_of(' <- ', ',')
" }}}

" perl {{{
autocmd FileType perl    inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
autocmd FileType perl    inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
autocmd FileType perl    inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
autocmd FileType perl    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/perldoc<CR>
autocmd BufEnter *.tt    set ft=tt2
autocmd BufEnter */t/*.t set ft=perl.tap
" }}}

autocmd BufEnter */Hatena/*          setlocal et ts=4 sts=4 sw=4
autocmd BufEnter */Hatena/*.html.erb setlocal ts=2 sts=2 sw=2
autocmd BufEnter */Hatena/*.html     setlocal ts=2 sts=2 sw=2
autocmd BufEnter */Hatena/*.html.tt  setlocal ts=2 sts=2 sw=2
autocmd BufEnter */Hatena/*.html     set ft=tt2.html
autocmd BufEnter */Hatena/*.tt       set ft=tt2.html

autocmd BufEnter */nginx/*.conf set ft=nginx
autocmd BufEnter */*.nginx.conf set ft=nginx
" }}}

" Command-line Window {{{
" http://vim-users.jp/2010/07/hack161/
nnoremap   <sid>(command-line-enter) q:
xnoremap   <sid>(command-line-enter) q:
nnoremap   <sid>(command-line-norange) q:<C-u>
nmap     : <sid>(command-line-enter)
xmap     : <sid>(command-line-enter)

autocmd CmdwinEnter * call s:init_cmdwin()

function! s:init_cmdwin()
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
endfunction
" }}}

" Adjust splitted-window width {{{
" http://vim-users.jp/2009/07/hack42/
nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>j <C-w>j:call <SID>good_width()<CR>
nnoremap <C-w>k <C-w>k:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>

function! s:good_width()
  if winwidth(0) < 80
    vertical resize 80
  endif
endfunction
" }}}

" ref.vim {{{
let g:ref_jquery_doc_path = $HOME . '/Downloads/jqapi-latest'
let g:ref_jquery_use_cache = 1
let g:ref_cache_dir = $HOME . '/.vim/.ref'
" }}}

" zencoding.vim {{{
let g:user_zen_leader_key = '<C-e>'
let g:user_zen_settings = {
      \ 'indentation': ' ',
      \ }
" }}}

" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_temporary_dir = '~/.vim/.neocon'

inoremap <expr><CR>   neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
imap     <C-k> <Plug>(neocomplcache_snippets_expand)
smap     <C-k> <Plug>(neocomplcache_snippets_expand)
imap     <C-s> <Plug>(neocomplcache_start_unite_snippet)
" }}}

" unite.vim {{{
let g:unite_data_directory = '~/.vim/.unite'

nnoremap [unite] <Nop>
nmap <Space> [unite]
nnoremap <silent> [unite]o        :<C-u>UniteWithBufferDir buffer file_mru file file/new<CR>
nnoremap <silent> [unite]b        :<C-u>Unite buffer -immediately<CR>
nnoremap <silent> [unite]O        :<C-u>UniteWithCurrentDir buffer file_mru file file/new<CR>
nnoremap <silent> [unite]h        :<C-u>Unite help -start-insert<CR>
nnoremap <silent> [unite][        :<C-u>Unite outline<CR>
nnoremap <silent> [unite].        :<C-u>Unite source<CR>
nnoremap <silent> //               :<C-u>Unite line -start-insert -no-quit<CR>
nnoremap <silent> [unite]s        :<C-u>Unite session<CR>
nnoremap <silent> [unite]q        :<C-u>Unite qf -no-quit<CR>
nnoremap <silent> [unite]w        :<C-u>Unite -immediately window:no-current<CR>
nnoremap <silent> [unite]r<Space> :<C-u>Unite source -start-insert -input=rails/<CR>
nnoremap <silent> [unite]rc       :<C-u>Unite rails/controller<CR>
nnoremap <silent> [unite]rv       :<C-u>Unite rails/view<CR>
nnoremap <silent> [unite]rm       :<C-u>Unite rails/model<CR>
nnoremap <silent> [unite]rh       :<C-u>Unite rails/helper<CR>

autocmd FileType unite call s:unite_local_settings()
function! s:unite_local_settings()"{{{
  nnoremap <silent><buffer><expr> <C-w>h unite#do_action('left')
  inoremap <silent><buffer><expr> <C-w>h unite#do_action('left')
  nnoremap <silent><buffer><expr> <C-w>l unite#do_action('right')
  inoremap <silent><buffer><expr> <C-w>l unite#do_action('right')
  nnoremap <silent><buffer><expr> <C-w>k unite#do_action('above')
  inoremap <silent><buffer><expr> <C-w>k unite#do_action('above')
  nnoremap <silent><buffer><expr> <C-w>j unite#do_action('below')
  inoremap <silent><buffer><expr> <C-w>j unite#do_action('below')
endfunction " }}}

function! s:unite_project(...) " s:unite_project(...) {{{
  let opts = (a:0 ? join(a:000, ' ') : '')
  let dir = unite#util#path2project_directory(expand('%'))
  execute 'UniteWithBufferDir' opts 'buffer file_rec:' . dir
endfunction " }}}
" }}}

" surround.vim {{{
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.ruby  = {
  \ '#': "#{\r}",
  \ }
let g:surround_custom_mapping.eruby = {
  \ '-': "<% \r %>",
  \ '=': "<%= \r %>",
  \ '#': "#{\r}",
  \ }
" }}}

" indent-guides.vim {{{
let g:indent_guides_auto_colors           = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent  = 10
let g:indent_guides_guide_size            = &sw
" }}}

" vim-fugitive {{{
nnoremap <Leader>gs :<C-u>Gstatus<CR>
nnoremap <Leader>gc :<C-u>Gcommit<CR>
nnoremap <Leader>gC :<C-u>Gcommit --amend<CR>
nnoremap <Leader>gb :<C-u>Gblame<CR>
nnoremap <Leader>ga :<C-u>Gwrite<CR>
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gD :<C-u>Gdiff --staged<CR>
" }}}

" vim-textmanip {{{
vmap <Down> <Plug>(Textmanip.move_selection_down)
vmap <Up> <Plug>(Textmanip.move_selection_up)
vmap <Left> <Plug>(Textmanip.move_selection_left)
vmap <Right> <Plug>(Textmanip.move_selection_right)
" }}}

" vim-altr {{{
nmap <Leader><C-[> <Plug>(altr-forward)
nmap <Leader><C-]> <Plug>(altr-back)

"call altr#define('models/%.rb', 'spec/models/%_spec.rb', 'spec/fabricators/%s_fabricator.rb')
"call altr#define('app/controllers/%.rb', 'spec/app/controllers/%_controller_spec.rb')

" Rails rules
call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')
call altr#define('spec/routing/%_spec.rb', 'config/routes.rb')
" }}}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['perl.tap'] = {'command': 'prove'}
" }}}

" vimshell {{{
nnoremap <silent> <Leader>; :VimShell<CR>
let g:vimshell_prompt = " X | _ | X < "
let g:vimshell_right_prompt = 'getcwd()'
let g:vimshell_escape_colors = ['#1a1c1a', '#d64073', '#90b1aa', '#f9d59d', '#5b7397', '#b15e6e', '#88afc0', '#f5f5f5', '#6a6767', '#8f2b43', '#4d625e', '#b7a670', '#333c57', '#a97984', '#495c69', '#ebebeb']

hi vimshellPrompt ctermfg=yellow
" }}}

" Color scheme {{{
if &term =~ '256color'
  colorscheme magica
else
  colorscheme desert
endif
" }}}

hi! link CoffeeSpecialVar Constant
" vim:set et foldmethod=marker:
