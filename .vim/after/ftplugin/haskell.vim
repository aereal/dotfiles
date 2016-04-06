inoremap <buffer><expr> = smartchr#loop(' = ', '=')
inoremap <buffer><expr> . smartchr#one_of('.', ' -> ', ' => ', '.')
inoremap <buffer><expr> , smartchr#one_of(', ', ' <- ', ',')

setlocal et
