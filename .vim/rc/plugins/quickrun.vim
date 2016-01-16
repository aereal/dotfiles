if !exists('g:quickrun_config')
  let g:quickrun_config = {}
endif
let g:quickrun_config['prove/carton'] = {
      \ 'exec'    : 'carton exec -- %c %o %s',
      \ 'command' : 'prove',
      \ }
let g:quickrun_config['prove/carton/contextual'] = extend(g:quickrun_config['prove/carton'], {
      \ 'exec' : 'TEST_METHOD=%a ' . g:quickrun_config['prove/carton'].exec,
      \ })
" let g:quickrun_config.vim = {
"       \ 'outputter' : 'error',
"       \ 'outputter/error/success' : 'null',
"       \ 'outputter/error/error' : 'buffer',
"       \ }

" vim:set foldmethod=marker:
