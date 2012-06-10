function! s:ExecMake()
  silent make! -c '%' | redraw!
endfunction

compiler perl
augroup perlsyntaxcheck
  autocmd! BufWritePost <buffer> silent make! -c '%' | redraw!
augroup END
