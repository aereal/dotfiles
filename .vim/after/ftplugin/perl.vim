let b:tap_run_command = expand('~/.vim/bin/prove-wrapper')

inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
