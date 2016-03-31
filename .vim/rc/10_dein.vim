set runtimepath& runtimepath+=~/devel/src/github.com/Shougo/dein.vim

let s:dein_cache_dir = expand('~/.vim/cache/dein')

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let plugins_toml = expand('~/.vim/etc/plugins.toml')
  call dein#load_toml(plugins_toml)
  call dein#load_toml(expand('~/.vim/etc/lazy.toml'), { 'lazy': 1 })
  call dein#load_toml(expand('~/.vim/etc/operator.toml'), { 'lazy': 1, 'depends': ['kana/vim-operator-user'] })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

unlet s:dein_cache_dir
