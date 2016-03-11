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
autocmd MyInit FileType perl let b:tap_run_command = expand('~/.vim/bin/prove-wrapper')
" }}}
" Markdown {{{
autocmd MyInit FileType markdown setlocal et ts=4 sts=4 sw=4
" }}}
" Close window with `q` key {{{
autocmd MyInit FileType help,ref-*,tap-result nnoremap <buffer> q :q<CR>
" }}}
" Git config {{{
autocmd MyInit FileType gitconfig setlocal noexpandtab
" }}}

autocmd MyInit BufWritePost *vimrc,*gvimrc,*/rc/*.vim echomsg '---> Reload vimrc ...' | NeoBundleClearCache | source $MYVIMRC | if has('gui_running') | source $MYGVIMRC | endif

autocmd MyInit WinEnter    * set cursorline
autocmd MyInit WinLeave    * set nocursorline
autocmd MyInit InsertEnter * set nocursorline
autocmd MyInit InsertLeave * set cursorline

" vim:set foldmethod=marker:
