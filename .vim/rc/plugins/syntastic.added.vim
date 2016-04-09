let g:syntastic_mode_map = {
      \ 'mode' : 'passive',
      \ }

augroup auto-syntastic
  autocmd!
  autocmd BufWritePost *.rb, *.js, *.scala call s:syntastic()
augroup END

function! s:syntastic() abort
  SyntasticCheck
  call lightline#update()
endfunction
