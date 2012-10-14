" vim:set et foldmethod=marker:
" Setup for neobundle.vim {{{
filetype off
if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle'))
endif
" }}}
" Configurations {{{
  " Basic {{{
    set nocompatible
    set hidden
    set history=100
    set autoread
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
  " }}}
  " Encoding & Format {{{
    set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
    set encoding=utf-8
    set termencoding=utf-8
    set fileformats=unix,dos,mac
  " }}}
  " Completion {{{
    set complete=.,w,b,u,k,i
    set completeopt=menu,preview,menuone
    set wildmenu
    set wildmode=longest:full,list:longest
  " }}}
  " Swap & Backup {{{
    set nobackup
    set swapfile
    set directory=~/.vim/swp
  " }}}
  " UI {{{
    set langmenu=none " メニューをローカライズしない
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
    "set statusline=%<\ %f%=%m%r%h%w%{fugitive#statusline()}%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}[%3l/%3L,%3c]
  " }}}
  " Charachters {{{
    set ambiwidth=double
    set backspace=indent,eol,start
    set list
    set listchars=tab:>.,precedes:<,extends:>,eol:$
    set ignorecase
    set smartcase
  " }}}
  " Search {{{
    set hlsearch
    set incsearch
    set wrapscan
  " }}}
  " Persistent Undo {{{
    if has('persistent_undo')
      set undodir=~/.vim/undo
      set undofile
    endif
  " }}}
  " Share clipboard namespace {{{
    if has('clipboard')
      set clipboard=unnamed,autoselect
    endif
  " }}}
" }}}
" Key mappings {{{
  let mapleader   = ';'
  let g:mapleader = ';'

  nnoremap <Leader><Space> :update<CR>
  nnoremap <ESC><ESC>      :nohlsearch<CR>

  inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', '=')
" }}}
" autocmd {{{
  " screenに編集中のファイル名を出す {{{
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%\\"' | endif
  " }}}
  " sh {{{
    autocmd FileType sh inoremap <buffer><expr> = smartchr#loop('=', ' != ')
  " }}}
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
    autocmd FileType    coffee inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
    autocmd FileType    coffee inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')
    autocmd ColorScheme *      hi! link CoffeeSpecialVar Constant
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
  " vim {{{
    autocmd FileType vim inoremap <buffer> = =
  " }}}
  " markdown {{{
    autocmd FileType markdown setlocal et ts=4 sts=4 sw=4
  " }}}
  " haml {{{
    autocmd FileType haml inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
  " }}}
  " nginx {{{
    autocmd BufEnter */nginx/*.conf set ft=nginx
    autocmd BufEnter */*.nginx.conf set ft=nginx
  " }}}
  " Hatena projects {{{
    autocmd BufEnter */@hatena/*          setlocal et ts=4 sts=4 sw=4
    autocmd BufEnter */@hatena/*.html.erb setlocal ts=2 sts=2 sw=2
    autocmd BufEnter */@hatena/*.html     setlocal ts=2 sts=2 sw=2
    autocmd BufEnter */@hatena/*.html.tt  setlocal ts=2 sts=2 sw=2
    autocmd BufEnter */@hatena/*.html     set ft=tt2html
    autocmd BufEnter */@hatena/*.tt       set ft=tt2html
  " }}}
" }}}
" Command-line Window http://vim-users.jp/2010/07/hack161/ {{{
  " Key mappings {{{
    nnoremap   <sid>(command-line-enter) q:
    xnoremap   <sid>(command-line-enter) q:
    nnoremap   <sid>(command-line-norange) q:<C-u>
    nmap     : <sid>(command-line-enter)
    xmap     : <sid>(command-line-enter)
  " }}}

  autocmd CmdwinEnter * call s:init_cmdwin()

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
  " Key mappings {{{
    nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
    nnoremap <C-w>j <C-w>j:call <SID>good_width()<CR>
    nnoremap <C-w>k <C-w>k:call <SID>good_width()<CR>
    nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>
  " }}}
  function! s:good_width() "{{{
    if winwidth(0) < 80
      vertical resize 80
    endif
  endfunction " }}}
" }}}
" Plugins {{{
  " Completion {{{
    NeoBundle 'Shougo/neocomplcache-snippets-complete'
    NeoBundle 'Shougo/neocomplcache' " {{{
      let g:neocomplcache_enable_at_startup = 1
      let g:neocomplcache_enable_smart_case = 1
      let g:neocomplcache_min_syntax_length = 3
      let g:neocomplcache_enable_camel_case_completion = 1
      let g:neocomplcache_enable_underbar_completion = 1
      let g:neocomplcache_temporary_dir = '~/.vim/.neocon'

      " Key mappings {{{
        inoremap <expr><CR>   neocomplcache#smart_close_popup() . "\<CR>"
        inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()
        imap     <C-k> <Plug>(neocomplcache_snippets_expand)
        smap     <C-k> <Plug>(neocomplcache_snippets_expand)
        imap     <C-s> <Plug>(neocomplcache_start_unite_snippet)
      " }}}
    " }}}
  " }}}
  " Syntax check {{{
    NeoBundle 'scrooloose/syntastic' " {{{
      let g:syntastic_auto_loc_list  = 2
      let g:syntastic_perl_efm_program = $HOME . '/.vim/bin/efm_perl.pl'
    " }}}
  " }}}
  " Git {{{
    NeoBundle 'tpope/vim-fugitive' " {{{
      " Key mappings {{{
        nnoremap <Leader>gs :<C-u>Gstatus<CR>
        nnoremap <Leader>gc :<C-u>Gcommit<CR>
        nnoremap <Leader>gC :<C-u>Gcommit --amend<CR>
        nnoremap <Leader>gb :<C-u>Gblame<CR>
        nnoremap <Leader>ga :<C-u>Gwrite<CR>
        nnoremap <Leader>gd :<C-u>Gdiff<CR>
        nnoremap <Leader>gD :<C-u>Gdiff --staged<CR>
      " }}}

      autocmd BufReadPost fugitive://* set bufhidden=delete
    " }}}
    NeoBundle 'int3/vim-extradite'
  " }}}
  " Text objects {{{
    NeoBundle 'h1mesuke/textobj-wiw'
    NeoBundle 'kana/vim-textobj-indent'
    NeoBundle 'kana/vim-textobj-line'
    NeoBundle 'kana/vim-textobj-user'
    NeoBundle 't9md/vim-surround_custom_mapping'
    NeoBundle 'thinca/vim-textobj-comment'
    NeoBundle 'tpope/vim-surround' " {{{
      let g:surround_custom_mapping = {}
      let g:surround_custom_mapping.ruby  = {
        \ '#': "#{\r}",
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
  " }}}
  " Editing {{{
    NeoBundle 'h1mesuke/vim-alignta'
    NeoBundle 'kana/vim-smartchr'
    NeoBundle 'kana/vim-smartinput'
    NeoBundle 'sickill/vim-pasta'
    NeoBundle 'mattn/zencoding-vim' " {{{
      let g:user_zen_leader_key = '<C-e>'
      let g:user_zen_settings = {
            \ 'indentation': ' ',
            \ }
    " }}}
  " }}}
  " Document {{{
    NeoBundle 'vim-jp/vimdoc-ja'
    NeoBundle 'thinca/vim-ref' " {{{
      let g:ref_jquery_doc_path = $HOME . '/Downloads/jqapi-latest'
      let g:ref_jquery_use_cache = 1
      let g:ref_cache_dir = $HOME . '/.vim/.ref'
    " }}}
  " }}}
  " Unite {{{
    NeoBundle 'Shougo/unite.vim' " {{{
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
      nnoremap <silent> /               :<C-u>Unite line -start-insert -no-quit<CR>
      nnoremap <silent> <SID>[unite]s        :<C-u>Unite session<CR>
      nnoremap <silent> <SID>[unite]w        :<C-u>Unite -immediately window:no-current<CR>

      nnoremap <silent> <SID>[unite]gc       :<C-u>UniteWithCurrentDir git/conflicts -buffer-name=files<CR>

      autocmd FileType unite call s:unite_local_settings()
      function! s:unite_local_settings() "{{{
        nnoremap <silent><buffer><expr> <C-w>h unite#do_action('left')
        inoremap <silent><buffer><expr> <C-w>h unite#do_action('left')
        nnoremap <silent><buffer><expr> <C-w>l unite#do_action('right')
        inoremap <silent><buffer><expr> <C-w>l unite#do_action('right')
        nnoremap <silent><buffer><expr> <C-w>k unite#do_action('above')
        inoremap <silent><buffer><expr> <C-w>k unite#do_action('above')
        nnoremap <silent><buffer><expr> <C-w>j unite#do_action('below')
        inoremap <silent><buffer><expr> <C-w>j unite#do_action('below')
      endfunction " }}}

      function! s:unite_project(...) " {{{
        let opts = (a:0 ? join(a:000, ' ') : '')
        let dir = unite#util#path2project_directory(expand('%'))
        execute 'UniteWithBufferDir' opts 'buffer file_rec:' . dir
      endfunction " }}}
    " }}}
    NeoBundle 'h1mesuke/unite-outline' " {{{
      nnoremap <silent> <SID>[unite][ :<C-u>Unite outline -vertical -winwidth=40<CR>
      nnoremap <silent> <SID>[unite]{ :<C-u>Unite outline -no-quit -vertical -winwidth=40 -buffer-name=outline<CR>
    " }}}
    NeoBundle 'sgur/unite-git_grep' " {{{
      nnoremap <silent> <SID>[unite]g :<C-u>Unite vcs_grep -start-insert<CR>
    " }}}
    NeoBundle 'sgur/unite-qf' " {{{
      nnoremap <silent> <SID>[unite]q :<C-u>Unite qf -no-quit<CR>
    " }}}
    NeoBundle 'thinca/vim-unite-history' " {{{
      nnoremap <silent> <SID>[unite]: :<C-u>Unite history/command -start-insert<CR>
    " }}}
    NeoBundle 'ujihisa/unite-colorscheme' " {{{
      nnoremap <silent> <SID>[unite]\c :<C-u>Unite colorscheme -auto-preview<CR>
    " }}}
    NeoBundle 'osyo-manga/unite-filetype'
    NeoBundle 'osyo-manga/unite-quickrun_config'
  " }}}
  " Language support {{{
    NeoBundle 'bbommarito/vim-slim'
    NeoBundle 'groenewege/vim-less'
    NeoBundle 'hail2u/vim-css3-syntax'
    NeoBundle 'hallison/vim-markdown'
    NeoBundle 'kchmck/vim-coffee-script'
    NeoBundle 'motemen/hatena-vim'
    NeoBundle 'othree/html5.vim'
    NeoBundle 'pangloss/vim-javascript'
    NeoBundle 'petdance/vim-perl'
    NeoBundle 'vim-ruby/vim-ruby'
    NeoBundle 'juvenn/mustache.vim'
  " }}}
  " UI {{{
    NeoBundle 'Lokaltog/vim-powerline', 'develop' " {{{
      let g:Powerline_symbols = 'fancy'
      let g:Powerline_theme = 'skwp'
      let g:Powerline_mode_n = ' N '
    " }}}
    NeoBundle 'nathanaelkane/vim-indent-guides' " {{{
      let g:indent_guides_auto_colors           = 1
      let g:indent_guides_enable_on_vim_startup = 1
      let g:indent_guides_color_change_percent  = 10
      let g:indent_guides_guide_size            = &sw
    " }}}
  " }}}
  " Colors {{{
    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'git@github.com:aereal/vim-magica-colors.git'
    NeoBundle 'nanotech/jellybeans.vim'
  " }}}
  " Misc. {{{
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/vimfiler'
    NeoBundle 'mattn/gist-vim'
    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'sudo.vim'
    NeoBundle 'kana/vim-altr' " {{{
      nmap <Leader><C-[> <Plug>(altr-forward)
      nmap <Leader><C-]> <Plug>(altr-back)

      "call altr#define('models/%.rb', 'spec/models/%_spec.rb', 'spec/fabricators/%s_fabricator.rb')
      "call altr#define('app/controllers/%.rb', 'spec/app/controllers/%_controller_spec.rb')

      " Rails rules {{{
        call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
        call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
        call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')
        call altr#define('spec/routing/%_spec.rb', 'config/routes.rb')
      " }}}
    " }}}
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'LeafCage/foldCC' " {{{
      set foldtext=FoldCCtext()
      set foldcolumn=4
      " set fillchars=vert:\|
    " }}}
    NeoBundle 'davidoc/taskpaper.vim'
    NeoBundle 'AndrewRadev/switch.vim' " {{{
      nnoremap - :<C-u>Switch<CR>
    " }}}
    NeoBundle 'kana/vim-gf-user'
    NeoBundle 'kana/vim-gf-diff'
    NeoBundle 'kana/vim-tabpagecd'
    NeoBundle 'osyo-manga/shabadou.vim'
    NeoBundle 'osyo-manga/watchdogs.vim'
    NeoBundle 'tyru/current-func-info.vim'
  " }}}
" }}}
" Background color detection {{{
  if $TERMINAL_BACKGROUND != ''
    set bg=$TERMINAL_BACKGROUND
  else
    set bg=dark
  endif
" }}}
" Color scheme {{{
  if &bg == 'dark'
    colorscheme desert
  else
    colorscheme peachpuff
  endif
" }}}
" unite-git-conflict {{{
let s:unite_git_conflicts = {
      \ 'name': 'git/conflicts',
      \ }
function! s:unite_git_conflicts.gather_candidates(args, context)
  let output = unite#util#system('git diff-files --name-status')
  let conflicts = filter(split(output, "\n"), 'v:val[0] == "U"')
  let files = map(conflicts, 'fnamemodify(split(v:val, "\\\s\\\+")[1], ":p")')
  return map(files, '{
        \ "word": v:val,
        \ "source": "git/conflicts",
        \ "kind": "file",
        \ "action__path": v:val
        \ }')
endfunction
call unite#define_source(s:unite_git_conflicts)
" }}}
syntax on
filetype plugin indent on
