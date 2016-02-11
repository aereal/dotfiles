filetype off

if has('vim_starting')
  set runtimepath& runtimepath+=~/.vim/bundle/neobundle.vim
  syntax enable
endif

call neobundle#begin(expand('~/.vim/bundle'))

if neobundle#load_cache(expand('<sfile>'), '~/.vim/rc/neobundle/plugins.toml', '~/.vim/rc/neobundle/lazy.toml')
  call neobundle#load_toml('~/.vim/rc/neobundle/plugins.toml')
  call neobundle#load_toml('~/.vim/rc/neobundle/lazy.toml', { 'lazy': 1 })
  call neobundle#load_toml('~/.vim/rc/neobundle/color.toml', { 'lazy': 1, 'on_unite': ['colorscheme'] })
  call neobundle#load_toml('~/.vim/rc/neobundle/operator.toml', { 'lazy': 1, 'depends': ['kana/vim-operator-user'] })
  NeoBundleSaveCache
endif

" vim-quickrun {{{
if neobundle#tap('vim-quickrun')
  let neobundle#tapped.hooks.on_source = '~/.vim/rc/plugins/quickrun.vim'
  call neobundle#untap()
endif " }}}
" vim-watchdogs {{{
if neobundle#tap('vim-watchdogs')
  let neobundle#tapped.hooks.on_source = '~/.vim/rc/plugins/watchdogs.vim'
  call neobundle#untap()
endif " }}}
" vim-operator-surround {{{
if neobundle#tap('vim-operator-surround')
  map <silent> sa <Plug>(operator-surround-append)
  map <silent> sd <Plug>(operator-surround-delete)
  map <silent> sr <Plug>(operator-surround-replace)
  call neobundle#untap()
endif " }}}
if neobundle#tap('vim-operator-flashy') " {{{
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
  call neobundle#untap()
endif " }}}
" vim-ref {{{
if neobundle#tap('vim-ref')
  let g:ref_cache_dir = $VIM_CACHE_DIR . '/ref'
  if !isdirectory(g:ref_cache_dir)
    call mkdir(g:ref_cache_dir, '-p')
  endif

  call neobundle#untap()
endif " }}}
" unite.vim {{{
if neobundle#tap('unite.vim')
  let neobundle#tapped.hooks.on_source = '~/.vim/rc/plugins/unite.vim'
  call neobundle#untap()
endif " }}}
" neocomplete.vim {{{
if neobundle#tap('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#data_directory = $VIM_CACHE_DIR . '/neocomplete'

  let neobundle#tapped.hooks.on_source = '~/.vim/rc/plugins/neocomplete.vim'

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
    let g:indentLine_showFirstIndentLevel = 1

    autocmd MyInit FileType * :IndentLinesReset
  endfunction
  call neobundle#untap()
endif " }}}
" lightline.vim {{{
if neobundle#tap('lightline.vim')
  let neobundle#tapped.hooks.on_source = '~/.vim/rc/plugins/lightline.vim'
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
    call smartinput#define_rule({
          \ 'at' : '\%#',
          \ 'char' : '[',
          \ 'input' : '[%%]<Left><Left>',
          \ 'filetype': ['tt2html'],
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
  vmap ,a :Alignta
  vmap ,= :Alignta =<CR>
  vmap ,> :Alignta =><CR>

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
" vim-signjk-motion {{{
if neobundle#tap('vim-signjk-motion')
  map ;j <Plug>(signjk-j)
  map ;k <Plug>(signjk-k)
endif
" }}}

call neobundle#end()

filetype plugin indent on

" vim:set foldmethod=marker:
