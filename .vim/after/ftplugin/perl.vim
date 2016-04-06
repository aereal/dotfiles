let b:tap_run_command = expand('~/.vim/bin/prove-wrapper')

nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/perldoc<CR>
nnoremap <silent><buffer> <S-k> :<C-u>UniteWithCursorWord -default-action=split ref/perldoc<CR>

inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
