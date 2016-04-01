let g:unite_configured  =  1

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

call unite#custom#default_action('source/ghq/*', 'tabnew_lcd')

" converter_relative_abbr: 候補を表示するときに相対パスに
" matcher_project_files: 候補はリポジトリのファイルからのみ
call unite#custom#source('file_mru', 'matchers', ['converter_relative_abbr', 'matcher_project_files', 'matcher_fuzzy'])

let s:unite_project_ignore_pattern = '\.\(gif\|jpe\?g\|png\|min\.js\|vendor\)'
call unite#custom#source('file_rec/git', 'ignore_pattern', s:unite_project_ignore_pattern)

" vim:set foldmethod=marker:
