inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
inoremap <buffer><expr> \ smartchr#one_of(' => ', '\')

nnoremap <silent><buffer> <Space>kj :<C-u>Unite -start-insert -default-action=split ref/javascript<CR>
nnoremap <silent><buffer> <Space>kq :<C-u>Unite -start-insert -default-action=split ref/jquery<CR>
