" Setup neobundle.vim {{{
set nocompatible
filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  syntax enable
endif

call neobundle#rc(expand('~/.vim/bundle'))
" }}}
function! s:meet_neocomplete_requirements() " {{{
  " http://rhysd.hatenablog.com/entry/2013/08/24/223438
  return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction " }}}
" Plugins {{{
" Quickrun {{{
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'osyo-manga/shabadou.vim'
" }}}
" Text Object {{{
NeoBundle 'h1mesuke/textobj-wiw'                   , { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-indent'                , { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-line'                  , { 'depends' : 'kana/vim-textobj-user' }
" }}}
" Operator {{{
NeoBundleFetch 'kana/vim-operator-user'
NeoBundleFetch 'emonkak/vim-operator-sort'     , { 'depends' : 'kana/vim-operator-user' }
" }}}
" Help {{{
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-ref'
NeoBundleLazy 'ujihisa/ref-hoogle' " {{{
call neobundle#config('ref-hoogle', {
      \   'autoload' : {
      \     'filetypes' : ['haskell'],
      \   }
      \ }) " }}}
" }}}
" Unite {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'sgur/unite-qf'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'osyo-manga/unite-fold'
NeoBundle 'tsukkee/unite-tag'
NeoBundleLazy 'ujihisa/unite-haskellimport' " {{{
call neobundle#config('unite-haskellimport', {
      \   'autoload' : {
      \     'filetypes' : ['haskell'],
      \   }
      \ }) " }}}
" }}}
" Completion {{{
if s:meet_neocomplete_requirements() " {{{
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundleFetch 'Shougo/neocomplcache'
else
  NeoBundleFetch 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neocomplcache'
endif " }}}
NeoBundleLazy 'ujihisa/neco-look' " {{{
call neobundle#config('neco-look', {
      \   'autoload' : {
      \     'filetypes' : ['markdown', 'hatena'],
      \   },
      \ }) " }}}
NeoBundleLazy 'eagletmt/neco-ghc' " {{{
call neobundle#config('neco-ghc', {
      \   'autoload' : {
      \     'filetypes' : ['haskell'],
      \   }
      \ }) " }}}
" }}}
" Language, Format {{{
NeoBundle 'slim-template/vim-slim'
NeoBundle 'groenewege/vim-less'
NeoBundleLazy 'hail2u/vim-css3-syntax' " {{{
call neobundle#config('vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['css', 'scss', 'sass', 'less'],
      \ },
      \ }) " }}}
NeoBundle 'hallison/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'motemen/hatena-vim'
NeoBundleLazy 'othree/html5.vim' " {{{
call neobundle#config('html5.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['html'],
      \ }
      \ }) " }}}
NeoBundleLazy 'pangloss/vim-javascript' " {{{
call neobundle#config('vim-javascript', {
      \   'autoload' : {
      \     'filetypes' : ['javascript'],
      \   },
      \ }) " }}}
NeoBundleLazy 'vim-perl/vim-perl' " {{{
call neobundle#config('vim-perl', {
      \   'autoload' : {
      \     'filetypes' : ['perl'],
      \   },
      \ }) " }}}
NeoBundle 'vim-ruby/vim-ruby'
NeoBundleLazy 'davidoc/taskpaper.vim'
NeoBundleLazy 'moznion/vim-cpanfile' " {{{
call neobundle#config('vim-cpanfile', {
      \   'autoload' : {
      \     'filetypes' : ['cpanfile'],
      \   },
      \ }) " }}}
NeoBundleLazy 'y-uuki/perl-local-lib-path.vim' " {{{
call neobundle#config('perl-local-lib-path.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['perl'],
      \ },
      \ }) " }}}
NeoBundle 'jnwhiteh/vim-golang'
NeoBundleLazy 'eagletmt/ghcmod-vim' " {{{
call neobundle#config('ghcmod-vim', {
      \   'autoload' : {
      \     'filetypes' : ['haskell'],
      \   }
      \ }) " }}}
NeoBundle 'Rip-Rip/clang_complete', {
      \   'build' : {
      \     'mac'  : 'make',
      \     'unix' : 'make',
      \   },
      \ }
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'dag/vim-fish'
" }}}
" Color {{{
NeoBundleLazy 'cocopon/colorswatch.vim'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'git@github.com:aereal/vim-magica-colors.git',
      \ { 'base' : '~/repos/@aereal' }
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'git://gist.github.com/187578.git', { 'name' : 'h2u_colors' }
NeoBundle 'sickill/vim-monokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'noahfrederick/vim-noctu'
NeoBundle 'uu59/vim-herokudoc-theme'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'trapd00r/neverland-vim-theme'
NeoBundle 'bluntpeak/bluntpeak-vim-colors'
NeoBundle 'svjunic/RadicalGoodSpped.vim'
" }}}
" Visualize {{{
NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'itchyny/lightline.vim'
" }}}
" Input & Edit {{{
NeoBundle 'Shougo/neosnippet'
NeoBundle 'tpope/vim-surround'
NeoBundle 't9md/vim-surround_custom_mapping', { 'depends' : 'tpope/vim-surround' }
NeoBundle 'kana/vim-smartinput'
NeoBundleLazy 'mattn/emmet-vim' " {{{
call neobundle#config('emmet-vim', {
      \ 'autoload' : {
      \   'filetypes' : [
      \     'html',
      \     'haml',
      \     'slim',
      \     'css',
      \   ],
      \ },
      \ }) " }}}
NeoBundle 'kana/vim-smartchr'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'tyru/eskk.vim'
NeoBundle 'Shougo/neosnippet-snippets'
" }}}
" Organize {{{
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'glidenote/memolist.vim'
" }}}
" Utility {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \   },
      \ }
NeoBundle 'sudo.vim'
NeoBundle 'tpope/vim-fugitive'
" }}}

filetype plugin indent on
" }}}
