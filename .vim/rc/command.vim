command! Sketch call s:sketch() " {{{
function! s:sketch() " {{{
  if !exists('g:sketch_dir')
    let g:sketch_dir = expand('~/sketches')
  endif

  if !isdirectory(g:sketch_dir)
    call mkdir(g:sketch_dir, 'p')
  endif

  let basename = strftime('%Y%m%d%H%M%S')
  let filename = g:sketch_dir . '/' . basename
  execute ':edit ' . filename
endfunction " }}}
" }}}

command! Prove call s:prove()
function! s:prove()
  let func_name = cfi#format('%s', '')
  if func_name != ''
    let $TEST_METHOD = func_name
  endif
  call tap#prove()
endfunction " }}}

command! Memo call s:memo()
function! s:memo()
  let memo_root = expand('~/memo')
  let dt = strftime('%Y%m%d-%H%M%S')
  let suffix = '.md'
  let filename = memo_root . '/' . dt . suffix

  execute ":edit " . filename
endfunction
