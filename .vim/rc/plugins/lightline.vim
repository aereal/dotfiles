if ! exists('g:lightline')
  let g:lightline = {}
endif
if ! has_key(g:lightline, 'component')
  let g:lightline.component = {}
endif
if ! has_key(g:lightline, 'component_visible_condition')
  let g:lightline.component_visible_condition = {}
endif
let g:lightline.colorscheme = 'solarized_light'
let g:lightline.component.anzu     = '%{anzu#search_status()}'
let g:lightline.component.fugitive = '%{fugitive#head()}'
let g:lightline.component.unite    = '%{unite#get_status_string()}'
let g:lightline.component_visible_condition.fugitive = '(exists("*fugitive#head") && ""!=fugitive#head())'
let g:lightline.component_visible_condition.unite    = '(exists("*unite#get_status_string") && unite#get_status_string()!="")'
let g:lightline.active = {
      \ 'left' : [
      \   ['mode', 'paste'],
      \   ['fugitive'],
      \   ['readonly', 'filename', 'modified', 'unite'],
      \ ],
      \ }
