augroup MyInit
  autocmd!
augroup END

" screen title {{{
if ! has('gui_running')
  autocmd MyInit BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%:t\\"' | endif
endif " }}}
" Markdown {{{
autocmd MyInit FileType markdown setlocal et ts=4 sts=4 sw=4
" }}}
" Close window with `q` key {{{
autocmd MyInit FileType help,ref-*,tap-result nnoremap <buffer> q :q<CR>
" }}}
" Git config {{{
autocmd MyInit FileType gitconfig setlocal noexpandtab
" }}}

" function! ReloadConfig() abort
"   call dein#clear_state()
"   source $MYVIMRC
"   if has('gui_running')
"     source $MYGVIMRC
"   endif
" endfunction
" autocmd MyInit BufWritePost *vimrc,*gvimrc,*/rc/*.vim call ReloadConfig()

function! LooksLikePerlProject(project_root) abort
  let cpanfile = a:project_root . '/cpanfile'
  if filereadable(cpanfile)
    return 1
  else
    return 0
  endif
endfunction

function! ConfigureCartonPath() abort
  let project_root = getcwd()
  let is_perl = LooksLikePerlProject(project_root)
  let t:is_perl_project = is_perl
  let w:is_perl_project = is_perl
  if is_perl
    let paths = [
          \ project_root . '/lib',
          \ project_root . '/local/lib/perl5',
          \ project_root . '/templates',
          \ ]
    execute "setlocal path^=" . join(paths, ',')
  endif
endfunction
autocmd MyInit BufEnter,TabEnter * call ConfigureCartonPath()

autocmd MyInit WinEnter    * set cursorline
autocmd MyInit WinLeave    * set nocursorline
autocmd MyInit InsertEnter * set nocursorline
autocmd MyInit InsertLeave * set cursorline

" vim:set foldmethod=marker:
