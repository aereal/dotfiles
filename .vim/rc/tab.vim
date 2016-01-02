set showtabline=2
function! s:tabpage_label(n) " {{{
  let title = gettabvar(a:n, 'title')
  if title != ''
    return title
  endif

  let buffers = tabpagebuflist(a:n)
  let highlight_field = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
  let buffers_count = len(buffers)
  if buffers_count is 1
    let buffers_count = ''
  endif
  let modified_indicator = len(filter(copy(buffers), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let indicator = buffers_count . modified_indicator
  let separator = indicator ==# '' ? '' : ' '
  let current_buffer = buffers[tabpagewinnr(a:n) - 1]
  let fname = pathshorten(bufname(current_buffer))
  let label = indicator . separator . fname

  return '%' . a:n . 'T' . highlight_field . label . '%T%#TabLineFill#'
endfunction " }}}
function! MakeTabLine() " {{{
  let titles = map(range(1, tabpagenr('$')), '"|" . s:tabpage_label(v:val) . "|"')
  let separator = ' '
  let tabpages = join(titles, separator) . separator . '%#TabLineFill#%T'
  let extra = ''
  let extra .= cfi#format('[%s()]', '')
  let extra .= '[' . fnamemodify(getcwd(), ':~') . ']'
  return tabpages . '%=' . extra
endfunction " }}}
set tabline=%!MakeTabLine()
