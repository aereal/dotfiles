nnoremap <SID>[unite] <Nop>
nmap gj <SID>[unite]

nmap <SID>[unite]p <SID>(project-files)
nmap <SID>[unite]f <SID>(files)
nmap <SID>[unite]F <SID>(files-from-buffer)
nmap <SID>[unite]w <SID>(windows)
nmap <SID>[unite][ <SID>(outline)
nmap <SID>[unite]: <SID>(history)
nmap <SID>[unite]q <SID>(quickfix)
nmap <SID>[unite]t <SID>(tabs)
nmap <SID>[unite]B <SID>(buffers)
nmap <SID>[unite]mv <SID>(rename)
nmap <SID>[unite]G <SID>(ghq-list)

if has('gui_running')
  nmap <SID>[unite]b <SID>(tab-buffers)
else
  nmap <SID>[unite]b <SID>(buffers)
endif

" definitions {{{
nnoremap <silent> <SID>(project-files) :<C-u>Unite file_rec/git -hide-source-names -buffer-name=files<CR>
nnoremap <silent> <SID>(files) :<C-u>UniteWithCurrentDir file file/new -hide-source-names -buffer-name=files<CR>
nnoremap <silent> <SID>(files-from-buffer) :<C-u>UniteWithBufferDir file file/new -hide-source-names -buffer-name=files<CR>
nnoremap <silent> <SID>(windows) :<C-u>Unite window:no-current -no-empty<CR>
nnoremap <silent> <SID>(outline) :<C-u>Unite outline -hide-source-names -winwidth=40 -buffer-name=outline<CR>
nnoremap <silent> <SID>(history) :<C-u>Unite history/command -start-insert<CR>
nnoremap <silent> <SID>(quickfix) :<C-u>Unite quickfix -no-quit -no-empty -auto-resize -buffer-name=quickfix<CR>
nnoremap <silent> <SID>(tabs) :<C-u>Unite tab:no-current -no-empty -immediately<CR>
nnoremap <silent> <SID>(tab-buffers) :<C-u>Unite buffer_tab -no-empty<CR>
nnoremap <silent> <SID>(buffers) :<C-u>Unite buffer -no-empty<CR>
nnoremap <silent><expr> <SID>(rename) ':<C-u>Unite file -input=' . expand('%:p') . ' -default-action=exrename -immediately<CR>'
nnoremap <silent> <SID>(ghq-list) :<C-u>Unite ghq<CR>
" }}}
