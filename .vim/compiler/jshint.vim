if exists('current_compiler')
  finish
endif
let current_compiler = 'jshint'
let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=jshint\ $*
CompilerSet errorformat="%ELine %l:%c,%Z\\s%#Reason: %m,%C%.%#,%f: line %l\, col %c\, %m,%-G%.%#"

let &cpo = s:cpo_save
unlet s:cpo_save
