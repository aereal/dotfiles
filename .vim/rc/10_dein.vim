set runtimepath& runtimepath^=~/devel/src/github.com/Shougo/dein.vim

let s:dein_cache_dir = expand('~/.vim/cache/dein')
let s:plugins_toml = expand('~/.vim/etc/plugins.toml')
let s:lazy_plugins_toml = expand('~/.vim/etc/lazy.toml')
let s:operator_plugins_toml = expand('~/.vim/etc/operator.toml')

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir, [
        \ expand('<sfile>'),
        \ s:plugins_toml,
        \ s:lazy_plugins_toml,
        \ s:operator_plugins_toml,
        \ ])

  call dein#load_toml(s:plugins_toml)
  call dein#load_toml(s:lazy_plugins_toml, { 'lazy': 1 })
  call dein#load_toml(s:operator_plugins_toml, { 'lazy': 1, 'depends': ['vim-operator-user'] })
  call dein#local('~/devel/src/github.com/aereal', {
        \ 'frozen': 1,
        \ 'merged': 1,
        \ }, ['vim-*'])

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

unlet s:dein_cache_dir
