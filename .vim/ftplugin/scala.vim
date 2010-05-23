compiler scalac

" Compile
map <F5> <ESC>:w<CR>:cd %:h<CR>:make -sourcepath . %:p<CR>:cd -<CR>
map! <F5> <ESC>:w<CR>:cd %:h<CR>:make -sourcepath . %:p<CR>:cd -<CR>

" Execute
map <F6> <ESC>:w<CR>:cd %:h<CR>:!scala %:r<CR>:cd -<CR>
map! <F6> <ESC>:w<CR>:cd %:h<CR>:!scala %:r<CR>:cd -<CR>

" Compile + Execute
map <F7> <ESC>:w<CR>:cd %:h<CR>:make -sourcepath . %:p<CR>:!scala %:r<CR>:cd -<CR>
map! <F7> <ESC>:w<CR>:cd %:h<CR>:make -sourcepath . %:p<CR>:!scala %:r<CR>:cd -<CR>

