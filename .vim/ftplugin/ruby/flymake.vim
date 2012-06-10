function! s:ExecMake()
  if &filetype == 'ruby'
    silent make! -c '%' | redraw!
  endif
endfunction

compiler ruby
augroup rubysyntaxcheck
  autocmd! BufWritePost <buffer> call s:ExecMake()
augroup END
