augroup MyInit
  autocmd!
augroup END

" screen title {{{
if ! has('gui_running')
  autocmd MyInit BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%:t\\"' | endif
endif " }}}
" Haskell {{{
autocmd MyInit FileType haskell setlocal et
" }}}
" Perl {{{
autocmd MyInit BufEnter cpanfile setlocal filetype=cpanfile
autocmd MyInit BufEnter cpanfile setlocal syntax=perl.cpanfile
autocmd MyInit BufEnter *.tt            setlocal ft=tt2html
autocmd MyInit BufEnter *.t             setlocal ft=perl
autocmd MyInit FileType perl let b:tap_run_command = expand('~/.vim/bin/prove-wrapper')
" }}}
" Markdown {{{
autocmd MyInit FileType markdown setlocal et ts=4 sts=4 sw=4
" }}}
" Nginx {{{
autocmd MyInit BufEnter */nginx/*.conf setlocal ft=nginx
autocmd MyInit BufEnter */*.nginx.conf setlocal ft=nginx
" }}}
" Hatena {{{
autocmd MyInit BufNewFile,BufRead *.hatena setlocal filetype=hatena

autocmd MyInit BufEnter */Hatena/*          setlocal et ts=4 sts=4 sw=4
autocmd MyInit BufEnter */Hatena/*.html.erb setlocal ts=2 sts=2 sw=2
autocmd MyInit BufEnter */Hatena/*.html     setlocal ts=2 sts=2 sw=2
autocmd MyInit BufEnter */Hatena/*.html.tt  setlocal ts=2 sts=2 sw=2
" }}}
" Close window with `q` key {{{
autocmd MyInit FileType help,ref-*,tap-result nnoremap <buffer> q :q<CR>
" }}}
" Git config {{{
autocmd MyInit FileType gitconfig setlocal noexpandtab
" }}}
" Ruby {{{
autocmd MyInit BufEnter *.podspec set ft=ruby
autocmd MyInit BufEnter Podfile set ft=ruby
" }}}
" JavaScript, ES {{{
autocmd MyInit BufEnter *.es6,*.es set ft=javascript
" }}}
" Mustache, Handlebars {{{
autocmd MyInit BufEnter *.mustache set ft=html.mustache
autocmd MyInit BufEnter *.handlebars set ft=html.handlebars
" }}}

autocmd MyInit BufWritePost *vimrc,*gvimrc,*/rc/*.vim echomsg '---> Reload vimrc ...' | NeoBundleClearCache | source $MYVIMRC | if has('gui_running') | source $MYGVIMRC | endif

" vim:set foldmethod=marker:
