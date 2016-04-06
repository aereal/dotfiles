inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')

nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/refe<CR>
nnoremap <silent><buffer> <S-k>    :<C-u>UniteWithCursorWord -default-action=split ref/refe<CR>
