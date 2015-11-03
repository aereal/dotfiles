filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  syntax enable
endif

call neobundle#begin(expand('~/.vim/bundle'))

" Quickrun {{{
NeoBundle 'thinca/vim-quickrun' " {{{
if neobundle#tap('vim-quickrun')
  function! neobundle#tapped.hooks.on_source(bundle)
    if !exists('g:quickrun_config')
      let g:quickrun_config = {}
    endif
    let g:quickrun_config['prove/carton'] = {
          \ 'exec'    : 'carton exec -- %c %o %s',
          \ 'command' : 'prove',
          \ }
    let g:quickrun_config['prove/carton/contextual'] = extend(g:quickrun_config['prove/carton'], {
          \ 'exec' : 'TEST_METHOD=%a ' . g:quickrun_config['prove/carton'].exec,
          \ })
    " let g:quickrun_config.vim = {
    "       \ 'outputter' : 'error',
    "       \ 'outputter/error/success' : 'null',
    "       \ 'outputter/error/error' : 'buffer',
    "       \ }
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundle 'osyo-manga/vim-watchdogs' " {{{
if neobundle#tap('vim-watchdogs')
  function! neobundle#tapped.hooks.on_source(bundle) " {{{
    let g:watchdogs_check_BufWritePost_enable = 1
    let g:watchdogs_check_BufWritePost_enables = {
          \ "typescript": 0,
          \ }

    let g:quickrun_config['watchdogs_checker/_'] = {
          \   'outputter/quickfix/open_cmd' : '',
          \   'hook/hier_update/enable_exit' : 1,
          \   'runner/vimproc/updatetime' : 40,
          \ }
    let g:quickrun_config['watchdogs_checker/efm_perl'] = {
          \   'command' : expand('~/.vim/tools/efm_perl.pl'),
          \   'exec' : '%c %o %s:p',
          \   'quickfix/errorformat' : '%f:%l:%m',
          \ }
    let g:quickrun_config['watchdogs_checker/cpanfile'] = {
          \   'command' : 'perl',
          \   'exec' : '%c %o -w -MModule::CPANfile -e "Module::CPANfile->load(q|%S:p|)"',
          \   'quickfix/errorformat' : '%m\ at\ %f\ line\ %l%.%#',
          \ }
    let g:quickrun_config['perl/watchdogs_checker'] = {
          \   'type' : 'watchdogs_checker/efm_perl',
          \ }
    let g:quickrun_config['cpanfile/watchdogs_checker'] = {
          \   'type' : 'watchdogs_checker/cpanfile',
          \ }
    call watchdogs#setup(g:quickrun_config)
  endfunction " }}}
  call neobundle#untap()
endif " }}}
NeoBundle 'osyo-manga/shabadou.vim'
" }}}
" Text Object {{{
NeoBundle 'machakann/vim-textobj-delimited'        , { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-indent'                , { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-line'                  , { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'deris/vim-textobj-ipmac', { 'depends': 'kana/vim-textobj-user' }
" }}}
" Operator {{{
NeoBundleLazy 'rhysd/vim-operator-surround' " {{{
if neobundle#tap('vim-operator-surround')
  call neobundle#config({
        \ 'depends' : 'kana/vim-operator-user',
        \ 'autoload' : {
        \     'mappings' : '<Plug>(operator-surround-',
        \   },
        \ })
  map <silent> sa <Plug>(operator-surround-append)
  map <silent> sd <Plug>(operator-surround-delete)
  map <silent> sr <Plug>(operator-surround-replace)
  call neobundle#untap()
endif " }}}
" }}}
" Help {{{
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-ref' " {{{
if neobundle#tap('vim-ref')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:ref_cache_dir = $VIM_CACHE_DIR . '/ref'
    if !isdirectory(g:ref_cache_dir)
      call mkdir(g:ref_cache_dir, '-p')
    endif
  endfunction
  call neobundle#untap()
endif " }}}
" }}}
" Unite {{{
NeoBundle 'Shougo/unite.vim' " {{{
if neobundle#tap('unite.vim')
  function! neobundle#tapped.hooks.on_source(bundle) " {{{
    function! s:unite_my_settings() " {{{
      let unite = unite#get_current_unite()

      nmap <buffer> <BS> <Plug>(unite_delete_backward_path)

      nnoremap <buffer><silent><expr> <C-w>h unite#do_action('left')
      nnoremap <buffer><silent><expr> <C-w>l unite#do_action('right')
      nnoremap <buffer><silent><expr> <C-w>j unite#do_action('below')
      nnoremap <buffer><silent><expr> <C-w>k unite#do_action('above')

      nnoremap <buffer><silent><expr> p unite#do_action('preview')

      if unite.buffer_name == 'files'
        nnoremap <buffer><silent><expr> r unite#do_action('rename')
      endif
    endfunction " }}}
    " variables {{{
    let g:unite_data_directory = $VIM_CACHE_DIR . '/unite'
    let g:unite_force_overwrite_statusline = 0

    if executable('ag')
      let g:unite_source_grep_command        = 'ag'
      let g:unite_source_grep_default_opts   = '--nocolor --nogroup'
      let g:unite_source_grep_recursive_opt  = ''
      let g:unite_source_grep_max_candidates = 200
    endif
    " }}}
    " mappings {{{
    nnoremap <SID>[unite] <Nop>
    nmap <C-u> <SID>[unite]

    nnoremap <silent> <SID>[unite]<C-g> :<C-u>Unite buffer_tab file_mru file_rec/git file/new -hide-source-names -buffer-name=files<CR>

    nnoremap <silent> <SID>[unite]<C-u> :<C-u>Unite file_rec/git -hide-source-names -buffer-name=files<CR>

    nnoremap <silent> <SID>[unite]f :<C-u>UniteWithCurrentDir file file/new -hide-source-names -buffer-name=files<CR>
    nnoremap <silent> <SID>[unite]r :<C-u>UniteWithCurrentDir  file_mru -no-split -buffer-name=files<CR>
    nnoremap <silent> <SID>[unite]w :<C-u>Unite window:no-current -no-empty<CR>
    nnoremap <silent> <SID>[unite][ :<C-u>Unite outline -vertical -hide-source-names -winwidth=40 -buffer-name=outline<CR>
    nnoremap <silent> <SID>[unite]p :<C-u>Unite register history/yank -buffer-name=register -no-split<CR>
    nnoremap <silent> <SID>[unite]: :<C-u>Unite history/command -start-insert<CR>
    nnoremap <silent> <SID>[unite]q :<C-u>Unite quickfix -no-quit -no-empty -auto-resize -buffer-name=quickfix<CR>
    nnoremap <silent> <SID>[unite]t :<C-u>Unite tab:no-current -no-empty<CR>

    if has('gui_running')
      nnoremap <silent> <SID>[unite]b :<C-u>Unite buffer_tab<CR>
    else
      nnoremap <silent> <SID>[unite]b :<C-u>Unite buffer<CR>
    endif
    " }}}
    " autocmd {{{
    autocmd MyInit FileType unite nmap <buffer><BS> <Plug>(unite_delete_backward_path)
    autocmd MyInit FileType unite call s:unite_my_settings()
    " JavaScript {{{
    autocmd MyInit FileType javascript nnoremap <silent><buffer> <Space>kj :<C-u>Unite -start-insert -default-action=split ref/javascript<CR>
    autocmd MyInit FileType javascript nnoremap <silent><buffer> <Space>kq :<C-u>Unite -start-insert -default-action=split ref/jquery<CR>
    " }}}
    " Ruby {{{
    autocmd MyInit FileType ruby* nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/refe<CR>
    autocmd MyInit FileType ruby* nnoremap <silent><buffer> <S-k>    :<C-u>UniteWithCursorWord -default-action=split ref/refe<CR>
    " }}}
    " Perl {{{
    autocmd MyInit FileType perl    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/perldoc<CR>
    autocmd MyInit FileType perl    nnoremap <silent><buffer> <S-k> :<C-u>UniteWithCursorWord -default-action=split ref/perldoc<CR>
    " }}}
    " }}}
    " Custom sources {{{
    " unite-git-files-conflict {{{
    let s:unite_git_files_conflict = {
          \   'name' : 'git/files/conflict',
          \ }
    function! s:unite_git_files_conflict.gather_candidates(args, context)
      let output = unite#util#system('git diff-files --name-only --diff-filter=U')
      let candidates = map(split(output, "\n"), '{
            \ "word" : fnamemodify(v:val, ":p"),
            \ "source" : "git/files/conflict",
            \ "kind" : "file",
            \ "action__path" : fnamemodify(v:val, ":p"),
            \ }')
      return candidates
    endfunction
    call unite#define_source(s:unite_git_files_conflict)
    " }}}
    " unite-git-files-modified {{{
    let s:unite_git_files_modified = {
          \   'name' : 'git/files/modified',
          \ }
    function! s:unite_git_files_modified.gather_candidates(args, context)
      let output = unite#util#system('git ls-files --modified')
      let candidates = map(split(output, "\n"), '{
            \ "word" : fnamemodify(v:val, ":p"),
            \ "source" : "git/files/modified",
            \ "kind" : "file",
            \ "action__path" : fnamemodify(v:val, ":p"),
            \ }')
      return candidates
    endfunction
    call unite#define_source(s:unite_git_files_modified)
    " }}}
    " unite-git-files-others {{{
    let s:unite_git_files_others = {
          \   'name' : 'git/files/others',
          \ }
    function! s:unite_git_files_others.gather_candidates(args, context)
      let output = unite#util#system('git ls-files --others --exclude-standard')
      let candidates = map(split(output, "\n"), '{
            \ "word" : fnamemodify(v:val, ":p"),
            \ "source" : "git/files/others",
            \ "kind" : "file",
            \ "action__path" : fnamemodify(v:val, ":p"),
            \ }')
      return candidates
    endfunction
    call unite#define_source(s:unite_git_files_others)
    " }}}
    " }}}
  endfunction " }}}
  function! neobundle#tapped.hooks.on_post_source(bundle) " {{{
    call unite#custom#default_action('source/ghq/*', 'tabnew_lcd')

    " converter_relative_abbr: 候補を表示するときに相対パスに
    " matcher_project_files: 候補はリポジトリのファイルからのみ
    call unite#custom#source('file_mru', 'matchers', ['converter_relative_abbr', 'matcher_project_files', 'matcher_fuzzy'])
  endfunction " }}}
  call neobundle#untap()
endif " }}}
NeoBundle 'Shougo/unite-outline'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundle 'sorah/unite-ghq'
NeoBundle 'Shougo/vimfiler.vim', { 'depends': ['Shougo/unite.vim'] }
NeoBundle 'ujihisa/unite-colorscheme'
" }}}
" Completion {{{
NeoBundle 'Shougo/neocomplete.vim' " {{{
if neobundle#tap('neocomplete.vim')
  call neobundle#config({
        \ 'vim_version' : '7.3.885',
        \ 'disabled'    : !has('lua'),
        \ })
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#data_directory = $VIM_CACHE_DIR . '/neocomplete'
  function! neobundle#tapped.hooks.on_source(bundle)
    if ! exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_overwrite_completefunc = 1
    let g:neocomplete#force_omni_input_patterns.c      = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#force_omni_input_patterns.objc   = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#force_omni_input_patterns.cpp    = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#force_omni_input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    let g:neocomplete#sources#syntax#min_keyword_length = 3

    let g:neocomplete#keyword_patterns                  = {}
    let g:neocomplete#keyword_patterns.default          = '\h\w*'

    let g:neocomplete#delimiter_patterns                = {}
    let g:neocomplete#delimiter_patterns.vim            = ['#']
    let g:neocomplete#delimiter_patterns.perl = []
    let g:neocomplete#delimiter_patterns.ruby           = ['::']

    imap <expr> <C-h> neocomplete#smart_close_popup() . "\<Plug>(smartinput_C-h)"
    imap <expr> <BS>  neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
    inoremap <expr> <C-g> neocomplete#undo_completion()

    autocmd MyInit CmdwinEnter * let b:neocomplete_sources = ['vim']
  endfunction
  call neobundle#untap()
endif " }}}
" }}}
" Language, Format {{{
NeoBundleLazy 'slim-template/vim-slim' " {{{
if neobundle#tap('vim-slim')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['slim'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'groenewege/vim-less' " {{{
if neobundle#tap('vim-less')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['less'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'hail2u/vim-css3-syntax' " {{{
if neobundle#tap('vim-css3-syntax')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['css', 'scss', 'sass', 'less'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'hallison/vim-markdown' " {{{
if neobundle#tap('vim-markdown')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['markdown'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'kchmck/vim-coffee-script' " {{{
if neobundle#tap('vim-coffee-script')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['coffee'],
        \ },
        \ })
  function! neobundle#tapped.hooks.on_post_source(bundle)
    autocmd MyInit ColorScheme * hi! link CoffeeSpecialVar Constant
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'motemen/hatena-vim' " {{{
if neobundle#tap('hatena-vim')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['hatena'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'othree/html5.vim' " {{{
if neobundle#tap('html5.vim')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['html'],
        \ }
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'pangloss/vim-javascript' " {{{
if neobundle#tap('vim-javascript')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['javascript'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'vim-perl/vim-perl' " {{{
if neobundle#tap('vim-perl')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['perl'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'vim-ruby/vim-ruby' " {{{
if neobundle#tap('vim-ruby')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['ruby'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'davidoc/taskpaper.vim' " {{{
if neobundle#tap('taskpaper.vim')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['taskpaper'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'y-uuki/perl-local-lib-path.vim' " {{{
if neobundle#tap('perl-local-lib-path.vim')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['perl'],
        \ },
        \ })
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:perl_local_lib_path = "t/lib"
    autocmd MyInit FileType perl PerlLocalLibPath
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'eagletmt/ghcmod-vim' " {{{
if neobundle#tap('ghcmod-vim')
  call neobundle#config({
        \ 'external_commands' : ['ghc-mod'],
        \ 'autoload' : {
        \   'filetypes' : ['haskell'],
        \ }
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'Rip-Rip/clang_complete' " {{{
if neobundle#tap('clang_complete')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['objc'],
        \ },
        \ 'build' : {
        \   'mac' : 'make',
        \ },
        \ })
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:clang_use_library = 1
    let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
    let g:clang_complete_auto = 1
    let g:clang_auto_select = 0
    let g:clang_auto_user_options = 'path, .clang_complete'
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'mustache/vim-mustache-handlebars' " {{{
if neobundle#tap('vim-mustache-handlebars')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['mustache', 'handlebars'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'dag/vim-fish' " {{{
if neobundle#tap('vim-fish')
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : ['fish'],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'motemen/tap-vim' " {{{
let g:tap#use_vimproc = 1
" }}}
" }}}
" Color {{{
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'git@github.com:aereal/vim-magica-colors.git',
      \ { 'base' : '~/repos/@aereal' }
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'hail2u/h2u_colorscheme'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'muratas/vim-andon'
NeoBundle 'ajh17/Spacegray.vim'
NeoBundle 'junegunn/seoul256.vim'
NeoBundle 'noahfrederick/vim-hemisu'
NeoBundle 'tomasr/molokai'
NeoBundle 'Lokaltog/vim-distinguished'
NeoBundle 'rhysd/vim-color-splatoon'
" }}}
" Visualize {{{
NeoBundle 'jceb/vim-hier' " {{{
if neobundle#tap('vim-hier')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:hier_enabled = 1
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundle 'dannyob/quickfixstatus' " {{{
if neobundle#tap('quickfixstatus')
  call neobundle#untap()
endif " }}}
NeoBundle 'LeafCage/foldCC' " {{{
if neobundle#tap('foldCC')
  function! neobundle#tapped.hooks.on_source(bundle)
    set foldtext=FoldCCtext()
    set foldcolumn=4
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'Yggdroot/indentLine' " {{{
if neobundle#tap('indentLine')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:indentLine_char = '|'

    autocmd MyInit FileType * :IndentLinesReset
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundle 'itchyny/lightline.vim' " {{{
if neobundle#tap('lightline.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    if ! exists('g:lightline')
      let g:lightline = {}
    endif
    if ! has_key(g:lightline, 'component')
      let g:lightline.component = {}
    endif
    if ! has_key(g:lightline, 'component_visible_condition')
      let g:lightline.component_visible_condition = {}
    endif
    let g:lightline.colorscheme = 'solarized_light'
    let g:lightline.component.anzu     = '%{anzu#search_status()}'
    let g:lightline.component.fugitive = '%{fugitive#head()}'
    let g:lightline.component.unite    = '%{unite#get_status_string()}'
    let g:lightline.component_visible_condition.fugitive = '(exists("*fugitive#head") && ""!=fugitive#head())'
    let g:lightline.component_visible_condition.unite    = '(exists("*unite#get_status_string") && unite#get_status_string()!="")'
    let g:lightline.active = {
          \ 'left' : [
          \   ['mode', 'paste'],
          \   ['fugitive'],
          \   ['readonly', 'filename', 'modified', 'unite'],
          \ ],
          \ }
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'osyo-manga/vim-anzu' " {{{
if neobundle#tap('vim-anzu')
  call neobundle#config({
        \ 'autoload' : {
        \   'mappings' : '<Plug>(anzu-',
        \ },
        \ })
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)
  nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
  call neobundle#untap()
endif " }}}
NeoBundleLazy 't9md/vim-quickhl' " {{{
if neobundle#tap('vim-quickhl')
  call neobundle#config({
        \ 'autoload' : {
        \   'mappings' : '<Plug>(quickhl-',
        \ },
        \ })
  nmap \m <Plug>(quickhl-manual-this)
  nmap \M <Plug>(quickhl-manual-reset)
  call neobundle#untap()
endif
" }}}
" }}}
" Input & Edit {{{
NeoBundle 'Shougo/neosnippet' " {{{
if neobundle#tap('neosnippet')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:neosnippet#disable_select_mode_mappings = 0
    let g:neosnippet#snippets_directory = '~/.vim/snippets'
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundle 'kana/vim-smartinput' " {{{
if neobundle#tap('vim-smartinput')
  function! neobundle#tapped.hooks.on_source(bundle)
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',  '<BS>',    '<BS>')
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)', '<BS>',    '<C-h>')
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',  '<Enter>', '<Enter>')
    call smartinput#define_rule({
          \   'at'    : '\s\+\%#',
          \   'char'  : '<CR>',
          \   'input' : "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
          \ })
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'mattn/emmet-vim' " {{{
if neobundle#tap('emmet-vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:user_emmet_leader_key = '<C-e>'
  endfunction
  call neobundle#config({
        \ 'autoload' : {
        \   'filetypes' : [
        \     'html',
        \     'haml',
        \     'slim',
        \     'css',
        \     'tt2html',
        \   ],
        \ },
        \ })
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'kana/vim-smartchr' " {{{
if neobundle#tap('vim-smartchr')
  call neobundle#config({
        \ 'autoload' : {
        \   'function_prefix' : 'smartchr',
        \ },
        \ })

  inoremap <expr> = smartchr#loop(' = ', ' == ', '=')
  autocmd MyInit FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
  autocmd MyInit FileType ruby*      inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
  autocmd MyInit FileType ruby*      inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')
  autocmd MyInit FileType coffee     inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
  autocmd MyInit FileType coffee     inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')
  autocmd MyInit FileType haskell    inoremap <buffer><expr> = smartchr#loop(' = ', '=')
  autocmd MyInit FileType haskell    inoremap <buffer><expr> . smartchr#one_of(' -> ', '.')
  autocmd MyInit FileType haskell    inoremap <buffer><expr> , smartchr#one_of(' <- ', ',')
  autocmd MyInit FileType perl       inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
  autocmd MyInit FileType perl       inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
  autocmd MyInit FileType perl       inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
  autocmd MyInit FileType vim        inoremap <buffer> = =
  autocmd MyInit FileType html       inoremap <buffer> = =
  autocmd MyInit FileType *sh        inoremap <buffer><expr> = smartchr#loop('=', ' = ', ' != ')
  autocmd MyInit FileType go         inoremap <buffer><expr> = smartchr#loop(' := ', ' = ', ' == ', ' != ')
  autocmd MyInit FileType go         inoremap <buffer><expr> , smartchr#loop(', ', '<-', ',')

  call neobundle#untap()
endif " }}}
NeoBundle 'sickill/vim-pasta'
NeoBundle 'h1mesuke/vim-alignta' " {{{
if neobundle#tap('vim-alignta')
  function! neobundle#tapped.hooks.on_source(bundle)
    vmap ,a :Alignta
    vmap ,= :Alignta =<CR>
    vmap ,> :Alignta =><CR>
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundle 'tyru/eskk.vim' " {{{
if neobundle#tap('eskk.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
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
  endfunction

  call neobundle#untap()
endif " }}}
NeoBundle 'Shougo/neosnippet-snippets'
" }}}
" Organize {{{
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neomru.vim' " {{{
if neobundle#tap('neomru.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    if neobundle#is_sourced('unite.vim')
      call unite#custom#source(
            \ 'file_mru', 'matchers',
            \ ['matcher_project_files', 'matcher_fuzzy'],
            \ )
    endif
  endfunction
  call neobundle#untap()
endif " }}}
" }}}
" Utility {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \   },
      \ }
NeoBundle 'sudo.vim'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'haya14busa/incsearch.vim' " {{{
if neobundle#tap('incsearch.vim')
  let g:incsearch#auto_nohlsearch = 1
  function! neobundle#tapped.hooks.on_source(bundle) " {{{
    map / <Plug>(incsearch-forward)
    map ? <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)

    map n <Plug>(incsearch-nohl-n)
    map N <Plug>(incsearch-nohl-N)
    nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
    nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
  endfunction " }}}
  call neobundle#untap()
endif
" }}}
NeoBundle 'thinca/vim-localrc'
" }}}
" VCS {{{
NeoBundle 'tpope/vim-fugitive' " {{{
if neobundle#tap('vim-fugitive')
  function! neobundle#tapped.hooks.on_source(bundle)
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

    autocmd MyInit BufReadPost fugitive://* set bufhidden=delete
  endfunction
  call neobundle#untap()
endif " }}}
NeoBundleLazy 'rhysd/conflict-marker.vim'
" }}}

call neobundle#end()

filetype plugin indent on

" vim:set foldmethod=marker:
