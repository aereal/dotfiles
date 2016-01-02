filetype off

if has('vim_starting')
  set runtimepath& runtimepath+=~/.vim/bundle/neobundle.vim
  syntax enable
endif

call neobundle#begin(expand('~/.vim/bundle'))

if neobundle#load_cache(expand('<sfile>'), '~/.vim/rc/neobundle/plugins.toml', '~/.vim/rc/neobundle/lazy.toml')
  call neobundle#load_toml('~/.vim/rc/neobundle/plugins.toml')
  call neobundle#load_toml('~/.vim/rc/neobundle/lazy.toml', { 'lazy': 1 })
  NeoBundleSaveCache
endif

" vim-quickrun {{{
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
" vim-watchdogs {{{
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
" vim-operator-surround {{{
if neobundle#tap('vim-operator-surround')
  map <silent> sa <Plug>(operator-surround-append)
  map <silent> sd <Plug>(operator-surround-delete)
  map <silent> sr <Plug>(operator-surround-replace)
  call neobundle#untap()
endif " }}}
" vim-ref {{{
if neobundle#tap('vim-ref')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:ref_cache_dir = $VIM_CACHE_DIR . '/ref'
    if !isdirectory(g:ref_cache_dir)
      call mkdir(g:ref_cache_dir, '-p')
    endif
  endfunction
  call neobundle#untap()
endif " }}}
" unite.vim {{{
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
" neocomplete.vim {{{
if neobundle#tap('neocomplete.vim')
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
" perl-local-lib-path.vim {{{
if neobundle#tap('perl-local-lib-path.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:perl_local_lib_path = "t/lib"
    autocmd MyInit FileType perl PerlLocalLibPath
  endfunction
  call neobundle#untap()
endif " }}}
" clang_complete {{{
if neobundle#tap('clang_complete')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:clang_use_library = 1
    let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
    let g:clang_complete_auto = 1
    let g:clang_auto_select = 0
    let g:clang_auto_user_options = 'path, .clang_complete'
  endfunction
  call neobundle#untap()
endif " }}}
" tap-vim {{{
if neobundle#tap('clang_complete')
  let g:tap#use_vimproc = 1
  call neobundle#untap()
endif " }}}
" vim-hier {{{
if neobundle#tap('vim-hier')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:hier_enabled = 1
  endfunction
  call neobundle#untap()
endif " }}}
" foldCC {{{
if neobundle#tap('foldCC')
  function! neobundle#tapped.hooks.on_source(bundle)
    set foldtext=FoldCCtext()
    set foldcolumn=4
  endfunction
  call neobundle#untap()
endif " }}}
" indentLine {{{
if neobundle#tap('indentLine')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:indentLine_char = '|'

    autocmd MyInit FileType * :IndentLinesReset
  endfunction
  call neobundle#untap()
endif " }}}
" lightline.vim {{{
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
" vim-anzu {{{
if neobundle#tap('vim-anzu')
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)
  nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
  call neobundle#untap()
endif " }}}
" vim-quickhl {{{
if neobundle#tap('vim-quickhl')
  nmap \m <Plug>(quickhl-manual-this)
  nmap \M <Plug>(quickhl-manual-reset)
  call neobundle#untap()
endif " }}}
" neosnippet {{{
if neobundle#tap('neosnippet')
  let g:neosnippet#disable_select_mode_mappings = 0
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  function! neobundle#tapped.hooks.on_source(bundle)
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  endfunction
  call neobundle#untap()
endif " }}}
" vim-smartinput {{{
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
" emmet-vim {{{
if neobundle#tap('emmet-vim')
  let g:user_emmet_leader_key = '<C-e>'
  call neobundle#untap()
endif " }}}
" vim-smartchr {{{
if neobundle#tap('vim-smartchr')
  inoremap <expr> = smartchr#loop(' = ', ' == ', '=')
  autocmd MyInit FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
  autocmd MyInit FileType ruby*      inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
  autocmd MyInit FileType ruby*      inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')
  autocmd MyInit FileType coffee     inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
  autocmd MyInit FileType coffee     inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')
  autocmd MyInit FileType typescript inoremap <buffer><expr> \ smartchr#one_of(' => ', '\')
  autocmd MyInit FileType javascript inoremap <buffer><expr> \ smartchr#one_of(' => ', '\')
  autocmd MyInit FileType haskell    inoremap <buffer><expr> = smartchr#loop(' = ', '=')
  autocmd MyInit FileType haskell    inoremap <buffer><expr> . smartchr#one_of('.', ' -> ', ' => ', '.')
  autocmd MyInit FileType haskell    inoremap <buffer><expr> , smartchr#one_of(', ', ' <- ', ',')
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
" vim-alignta {{{
if neobundle#tap('vim-alignta')
  function! neobundle#tapped.hooks.on_source(bundle)
    vmap ,a :Alignta
    vmap ,= :Alignta =<CR>
    vmap ,> :Alignta =><CR>
  endfunction
  call neobundle#untap()
endif " }}}
" eskk.vim {{{
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
" neomru.vim {{{
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
" incsearch.vim {{{
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
endif " }}}
" vim-fugitive {{{
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

call neobundle#end()

filetype plugin indent on

" vim:set foldmethod=marker:
