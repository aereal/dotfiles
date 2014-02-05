nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>
nmap : <SID>(command-line-enter)
xmap : <SID>(command-line-enter)

autocmd MyInit CmdwinEnter * call s:init_cmdwin()

function! s:init_cmdwin() " {{{
  nnoremap <silent><buffer> q :<C-u>quit<CR>
  nnoremap <silent><buffer> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR>  pumvisible() ? "\<C-y>\<CR>"  : "\<CR>"
  inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><BS>  pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  startinsert!
endfunction " }}}
