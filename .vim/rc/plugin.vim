filetype off
syntax enable

call plug#begin('~/.vim/plugged')

Plug 'thinca/vim-quickrun' " {{{
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
" }}}
Plug 'osyo-manga/vim-watchdogs' " {{{
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
" }}}
Plug 'osyo-manga/shabadou.vim'

Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-textobj-delimited'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'

Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-operator-surround' " {{{
  map <silent> sa <Plug>(operator-surround-append)
  map <silent> sd <Plug>(operator-surround-delete)
  map <silent> sr <Plug>(operator-surround-replace)
" }}}

Plug 'vim-jp/vimdoc-ja'
Plug 'thinca/vim-ref' " {{{
  let g:ref_cache_dir = $VIM_CACHE_DIR . '/ref'
  if !isdirectory(g:ref_cache_dir)
    call mkdir(g:ref_cache_dir, '-p')
  endif
" }}}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'slim-template/vim-slim', { 'for': ['slim'] }
Plug 'groenewege/vim-less', { 'for': ['less'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'less'] }
Plug 'hallison/vim-markdown', { 'for': ['markdown'] }
Plug 'motemen/hatena-vim', { 'for': ['hatena'] }
Plug 'othree/html5.vim', { 'for': ['html'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }
Plug 'vim-perl/vim-perl', { 'for': ['perl'] }
Plug 'y-uuki/perl-local-lib-path.vim', { 'for': ['perl'], 'on': ['PerlLocalLibPath'] } " {{{
  let g:perl_local_lib_path = "t/lib"
  autocmd MyInit FileType perl PerlLocalLibPath
" }}}
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi', { 'for': ['typescript'] }
Plug 'keith/swift.vim', { 'for': ['swift'] }
Plug 'motemen/tap-vim', { 'for': ['perl'] } " {{{
  let g:tap#use_vimproc = 1
" }}}
Plug 'derekwyatt/vim-scala', { 'for': ['scala'] }

Plug 'altercation/vim-colors-solarized'

Plug 'jceb/vim-hier' " {{{
  let g:hier_enabled = 1
" }}}
Plug 'LeafCage/foldCC'
Plug 'tyru/current-func-info.vim'
Plug 'Yggdroot/indentLine' " {{{
  let g:indentLine_char = '|'

  autocmd MyInit FileType * IndentLinesReset
" }}}
Plug 'itchyny/lightline.vim' " {{{
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
  let g:lightline.component_visible_condition.fugitive = '(exists("*fugitive#head") && ""!=fugitive#head())'
  let g:lightline.component_visible_condition.unite    = '(exists("*unite#get_status_string") && unite#get_status_string()!="")'
  let g:lightline.active = {
        \ 'left' : [
        \   ['mode', 'paste'],
        \   ['fugitive'],
        \   ['readonly', 'filename', 'modified'],
        \ ],
        \ }
" }}}
Plug 'osyo-manga/vim-anzu' " {{{
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)
  nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" }}}

Plug 'kana/vim-smartinput'
Plug 'kana/vim-smartchr'
Plug 'sickill/vim-pasta'
Plug 'tyru/eskk.vim' " {{{
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
" }}}

Plug 'Shougo/vimproc', { 'do': 'make -f make_mac.mak' }
Plug 'sudo.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'haya14busa/incsearch.vim' " {{{
  let g:incsearch#auto_nohlsearch = 1
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  map n <Plug>(incsearch-nohl-n)
  map N <Plug>(incsearch-nohl-N)
  nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
  nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
" }}}
Plug 'thinca/vim-localrc'

Plug 'tpope/vim-fugitive' " {{{
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
" }}}
" Plug 'rhysd/conflict-marker.vim'

call plug#end()

" watchdogs {{{
call watchdogs#setup(g:quickrun_config)
" }}}

" foldCC {{{
set foldtext=FoldCCtext()
set foldcolumn=4
" }}}

" smartinput {{{
call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',  '<BS>',    '<BS>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)', '<BS>',    '<C-h>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',  '<Enter>', '<Enter>')
call smartinput#define_rule({
      \   'at'    : '\s\+\%#',
      \   'char'  : '<CR>',
      \   'input' : "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
      \ })
" }}}

" smartchr {{{
inoremap <expr> = smartchr#loop(' = ', ' == ', '=')
autocmd MyInit FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
autocmd MyInit FileType ruby*      inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
autocmd MyInit FileType ruby*      inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')
autocmd MyInit FileType coffee     inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
autocmd MyInit FileType coffee     inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')
autocmd MyInit FileType typescript inoremap <buffer><expr> \ smartchr#one_of(' => ', '\')
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
" }}}

filetype plugin indent on

" vim:set foldmethod=marker:
