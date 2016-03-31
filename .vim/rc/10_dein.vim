set runtimepath& runtimepath+=~/devel/src/github.com/Shougo/dein.vim

let s:dein_cache_dir = expand('~/.vim/cache/dein')

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let plugins_toml = expand('~/.vim/etc/plugins.toml')
  call dein#load_toml(plugins_toml)
  call dein#load_toml(expand('~/.vim/etc/lazy.toml'), { 'lazy': 1 })
  call dein#load_toml(expand('~/.vim/etc/operator.toml'), { 'lazy': 1, 'depends': ['kana/vim-operator-user'] })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" vim-quickrun {{{
if dein#tap('vim-quickrun')
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'runtime rc/plugins/quickrun.vim'
endif " }}}
" vim-watchdogs {{{
if dein#tap('vim-watchdogs')
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'runtime rc/plugins/watchdogs.vim'
endif " }}}
" vim-operator-surround {{{
if dein#tap('vim-operator-surround')
  map <silent> sa <Plug>(operator-surround-append)
  map <silent> sd <Plug>(operator-surround-delete)
  map <silent> sr <Plug>(operator-surround-replace)
endif " }}}
if dein#tap('vim-operator-flashy') " {{{
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
endif " }}}
" vim-ref {{{
if dein#tap('vim-ref')
  let g:ref_cache_dir = $VIM_CACHE_DIR . '/ref'
  if !isdirectory(g:ref_cache_dir)
    call mkdir(g:ref_cache_dir, '-p')
  endif
endif " }}}
" unite.vim {{{
if dein#tap('unite.vim')
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'runtime rc/plugins/unite.vim'
endif " }}}
" neocomplete.vim {{{
if dein#tap('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#data_directory = $VIM_CACHE_DIR . '/neocomplete'

  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'runtime rc/plugins/neocomplete.vim'
endif " }}}
" perl-local-lib-path.vim {{{
if dein#tap('perl-local-lib-path.vim')
  function! s:perllocallibpath_on_source() abort
    let g:perl_local_lib_path = "t/lib"
    autocmd MyInit FileType perl PerlLocalLibPath
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:perllocallibpath_on_source()'
endif " }}}
" clang_complete {{{
if dein#tap('clang_complete')
  function! s:clang_complete_on_source() abort
    let g:clang_use_library = 1
    let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
    let g:clang_complete_auto = 1
    let g:clang_auto_select = 0
    let g:clang_auto_user_options = 'path, .clang_complete'
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:clang_complete_on_source()'
endif " }}}
" tap-vim {{{
if dein#tap('clang_complete')
  let g:tap#use_vimproc = 1
endif " }}}
" vim-hier {{{
if dein#tap('vim-hier')
  function! s:hier_on_source() abort
    let g:hier_enabled = 1
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:hier_on_source()'
endif " }}}
" foldCC {{{
if dein#tap('foldCC')
  function! s:foldCC_on_source() abort
    set foldtext=FoldCCtext()
    set foldcolumn=4
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:foldCC_on_source()'
endif " }}}
" indentLine {{{
if dein#tap('indentLine')
  function! s:indentLine_on_source() abort
    let g:indentLine_char = '|'
    let g:indentLine_showFirstIndentLevel = 1

    autocmd MyInit FileType * :IndentLinesReset
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:indentLine_on_source()'
endif " }}}
" lightline.vim {{{
if dein#tap('lightline.vim')
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'runtime rc/plugins/lightline.vim'
endif " }}}
" vim-anzu {{{
if dein#tap('vim-anzu')
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)
  nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
endif " }}}
" vim-quickhl {{{
if dein#tap('vim-quickhl')
  nmap \m <Plug>(quickhl-manual-this)
  nmap \M <Plug>(quickhl-manual-reset)
endif " }}}
" neosnippet {{{
if dein#tap('neosnippet')
  let g:neosnippet#disable_select_mode_mappings = 0
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  function! s:neosnippet_on_source() abort
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:neosnippet_on_source()'
endif " }}}
" vim-smartinput {{{
if dein#tap('vim-smartinput')
  function! s:smartinput_on_source() abort
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',  '<BS>',    '<BS>')
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)', '<BS>',    '<C-h>')
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',  '<Enter>', '<Enter>')
    call smartinput#define_rule({
          \   'at'    : '\s\+\%#',
          \   'char'  : '<CR>',
          \   'input' : "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
          \ })
    call smartinput#define_rule({
          \ 'at' : '\%#',
          \ 'char' : '[',
          \ 'input' : '[%%]<Left><Left>',
          \ 'filetype': ['tt2html'],
          \ })
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:smartinput_on_source()'
endif " }}}
" emmet-vim {{{
if dein#tap('emmet-vim')
  let g:user_emmet_leader_key = '<C-e>'
endif " }}}
" vim-smartchr {{{
if dein#tap('vim-smartchr')
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
endif " }}}
" vim-alignta {{{
if dein#tap('vim-alignta')
  vmap ,a :Alignta
  vmap ,= :Alignta =<CR>
  vmap ,> :Alignta =><CR>
endif " }}}
" eskk.vim {{{
if dein#tap('eskk.vim')
  function! s:eskk_on_source() abort
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
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:eskk_on_source()'
endif " }}}
" neomru.vim {{{
if dein#tap('neomru.vim')
  function! s:neomru_on_source() abort
    if neobundle#is_sourced('unite.vim')
      call unite#custom#source(
            \ 'file_mru', 'matchers',
            \ ['matcher_project_files', 'matcher_fuzzy'],
            \ )
    endif
  endfunction
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:neomru_on_source()'
endif " }}}
" incsearch.vim {{{
if dein#tap('incsearch.vim')
  let g:incsearch#auto_nohlsearch = 1
  function! s:incsearch_on_source() abort " {{{
    map / <Plug>(incsearch-forward)
    map ? <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)

    map n <Plug>(incsearch-nohl-n)
    map N <Plug>(incsearch-nohl-N)
    nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
    nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
  endfunction " }}}
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:incsearch_on_source()'
endif " }}}
" vim-fugitive {{{
if dein#tap('vim-fugitive')
  function! s:fugitive_on_source() abort
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
  execute 'autocmd MyInit User' 'dein#source#' . g:dein#name 'call s:fugitive_on_source()'
endif " }}}
" vim-signjk-motion {{{
if dein#tap('vim-signjk-motion')
  map ;j <Plug>(signjk-j)
  map ;k <Plug>(signjk-k)
endif
" }}}

unlet s:dein_cache_dir
