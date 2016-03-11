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

function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()
