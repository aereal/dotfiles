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

function! SetupCustomHighlightLinks() abort
  highlight! link Noise Conceal

  " Perl
  highlight! link perlVarPlain Identifier
  highlight! link perlVarPlain2 Identifier
  highlight! link perlStatementStorage StorageClass
  highlight! link perlSharpBang Comment
  highlight! link perlStringStartEnd Conceal
  highlight! link perlMatchStartEnd Conceal
  highlight! link perlFunction Statement
  highlight! link perlSubName Function
  highlight! link perlOperator Operator
  highlight! link perlMethod Function
  highlight! link perlStatementInclude Include

  " JavaScript
  highlight! link jsObjectKey Type
  highlight! link jsFuncCall Function

  " HTML
  highlight! link htmlTag Conceal
  highlight! link htmlEndTag Conceal
  highlight! link htmlTagName Identifier

  " TT2
  highlight! link tt2_tag Conceal
  highlight! link tt2_bracket_r Conceal
  highlight! link tt2_operator Conceal

  " TypeScript
  highlight! link typescriptEndColons Conceal
  highlight! link typescriptParens Conceal
  highlight! link typescriptBraces Conceal

  " Git
  highlight! link gitcommitWarning WarningMsg

  " Fugitive
  highlight! link FugitiveblameDelimiter Delimiter

  " Ruby
  highlight! link rubyStringDelimiter Conceal

  " Vim
  highlight! link vimParenSep Conceal

  " Markdown
  highlight! link mkdDelimiter Statement

  " YAML
  highlight! link yamlKeyValueDelimiter Statement

  highlight! link SignColumn LineNr
endfunction

autocmd MyInit ColorScheme * call SetupCustomHighlightLinks()

" vim:set foldmethod=marker:
