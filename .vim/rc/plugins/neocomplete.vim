if ! exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c      = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.objc   = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.cpp    = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:neocomplete#keyword_patterns                  = {}
let g:neocomplete#keyword_patterns.default          = '\h\w*'

let g:neocomplete#delimiter_patterns                = {}
let g:neocomplete#delimiter_patterns.vim            = ['#']
let g:neocomplete#delimiter_patterns.perl = []
let g:neocomplete#delimiter_patterns.ruby           = ['::']

imap <expr> <C-h> neocomplete#smart_close_popup() . "\<Plug>(smartinput_C-h)"
imap <expr> <BS>  neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
inoremap <expr> <C-g> neocomplete#undo_completion()

autocmd MyInit CmdwinEnter * let b:neocomplete_sources = ['vim']
