" Setup neobundle.vim {{{
set nocompatible
filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  syntax enable
endif

call neobundle#rc(expand('~/.vim/bundle'))
" }}}
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
NeoBundleLazy 'rhysd/vim-operator-surround' " {{{
call neobundle#config('vim-operator-surround', {
      \ 'depends' : 'kana/vim-operator-user',
      \ 'autoload' : {
      \     'mappings' : '<Plug>(operator-surround-',
      \   },
      \ }) " }}}
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
NeoBundle 'osyo-manga/unite-quickfix'
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
NeoBundle 'Shougo/neocomplete.vim', {
      \   'vim_version' : '7.3.885',
      \   'disabled' : !has('lua'),
      \ }
NeoBundle 'Shougo/neocomplcache.vim' " {{{
call neobundle#config('neocomplcache.vim', {
      \   'disabled' : neobundle#is_sourced('neocomplete.vim'),
      \ }) " }}}
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
NeoBundleLazy 'slim-template/vim-slim' " {{{
call neobundle#config('vim-slim', {
      \   'autoload' : {
      \     'filetypes' : ['slim'],
      \   },
      \ }) " }}}
NeoBundleLazy 'groenewege/vim-less' " {{{
call neobundle#config('vim-less', {
      \   'autoload' : {
      \     'filetypes' : ['less'],
      \   },
      \ }) " }}}
NeoBundleLazy 'hail2u/vim-css3-syntax' " {{{
call neobundle#config('vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['css', 'scss', 'sass', 'less'],
      \ },
      \ }) " }}}
NeoBundleLazy 'hallison/vim-markdown' " {{{
call neobundle#config('vim-markdown', {
      \   'autoload' : {
      \     'filetypes' : ['markdown'],
      \   },
      \ }) " }}}
NeoBundleLazy 'kchmck/vim-coffee-script' " {{{
call neobundle#config('vim-coffee-script', {
      \   'autoload' : {
      \     'filetypes' : ['coffee'],
      \   },
      \ }) " }}}
NeoBundleLazy 'motemen/hatena-vim' " {{{
call neobundle#config('hatena-vim', {
      \   'autoload' : {
      \     'filetypes' : ['hatena'],
      \   },
      \ }) " }}}
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
NeoBundleLazy 'vim-ruby/vim-ruby' " {{{
call neobundle#config('vim-ruby', {
      \   'autoload' : {
      \     'filetypes' : ['ruby'],
      \   },
      \ }) " }}}
NeoBundleLazy 'davidoc/taskpaper.vim' " {{{
call neobundle#config('taskpaper.vim', {
      \   'autoload' : {
      \     'filetypes' : ['taskpaper'],
      \   },
      \ }) " }}}
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
NeoBundleLazy 'jnwhiteh/vim-golang' " {{{
call neobundle#config('vim-golang', {
      \   'autoload' : {
      \     'filetypes' : ['go'],
      \   },
      \ }) " }}}
NeoBundleLazy 'eagletmt/ghcmod-vim' " {{{
call neobundle#config('ghcmod-vim', {
      \   'autoload' : {
      \     'filetypes' : ['haskell'],
      \   }
      \ }) " }}}
NeoBundleLazy 'Rip-Rip/clang_complete' " {{{
call neobundle#config('clang_complete', {
      \   'autoload' : {
      \     'filetypes' : ['objc'],
      \   },
      \   'build' : {
      \     'mac' : 'make',
      \   },
      \ }) " }}}
NeoBundleLazy 'mustache/vim-mustache-handlebars' " {{{
call neobundle#config('vim-mustache-handlebars', {
      \   'autoload' : {
      \     'filetypes' : ['mustache', 'handlebars'],
      \   },
      \ }) " }}}
NeoBundleLazy 'dag/vim-fish' " {{{
call neobundle#config('vim-fish', {
      \   'autoload' : {
      \     'filetypes' : ['fish'],
      \   },
      \ }) " }}}
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
NeoBundle 'svjunic/RadicalGoodSpeed.vim'
NeoBundle 'reedes/vim-colors-pencil'
" }}}
" Visualize {{{
NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'osyo-manga/vim-anzu'
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
NeoBundle 'Shougo/neomru.vim'
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
" vim: set foldmethod=marker:
