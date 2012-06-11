if exists('current_compiler')
  finish
endif

let current_compiler = 'perl'
let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=$HOME/.vim/bin/efm_perl.pl\ -c\ %\ $*
CompilerSet errorformat=%f:%l:%m

let &cpo = s:cpo_save
unlet s:cpo_save
