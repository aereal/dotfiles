nnoremap <SID>[denite] <Nop>
nmap gj <SID>[denite]

nmap <SID>[denite]p <SID>(project-files)
nmap <SID>[denite]f <SID>(files)
nmap <SID>[denite]F <SID>(files-from-buffer)
nmap <SID>[denite][ <SID>(outline)
nmap <SID>[denite]b <SID>(buffers)

nnoremap <silent> <SID>(project-files) :<C-u>Denite file_rec -buffer-name=files -source-names=hide<CR>
nnoremap <silent> <SID>(files) :<C-u>DeniteProjectDir file file:new -buffer-name=files -source-names=hide<CR>
nnoremap <silent> <SID>(files-from-buffer) :<C-u>DeniteBufferDir file file:new -buffer-name=files -source-names=hide<CR>
nnoremap <silent> <SID>(buffers) :<C-u>Denite buffer<CR>
nnoremap <silent> <SID>(outline) :<C-u>Denite outline<CR>
