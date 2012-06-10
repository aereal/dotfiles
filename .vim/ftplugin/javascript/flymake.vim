setlocal errorformat="%ELine %l:%c,%Z\\s%#Reason: %m,%C%.%#,%f: line %l\, col %c\, %m,%-G%.%#"

compiler jshint
augroup javascriptsyntaxcheck
  autocmd! BufWritePost <buffer> silent make! '%' | redraw!
augroup END
