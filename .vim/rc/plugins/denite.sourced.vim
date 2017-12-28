call denite#custom#option('default', 'prompt', '>')
call denite#custom#option('files', 'prompt', '>')

if executable('rg')
  call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git', '--glob', '!*.{png,jpg,min.js,gif,svg,woff,woff2,eot,ttf,otf,ico}'])
  call denite#custom#var('grep', 'command', 'rg')
endif

call denite#custom#map('normal', '<C-w>h', '<denite:do_action:vsplitswitch>', 'noremap')
call denite#custom#map('normal', '<C-w>l', '<denite:do_action:vsplitswitch>', 'noremap')

call denite#custom#map('normal', '<C-w>j', '<denite:do_action:splitswitch>', 'noremap')
call denite#custom#map('normal', '<C-w>k', '<denite:do_action:splitswitch>', 'noremap')
