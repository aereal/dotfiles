set runtimepath& runtimepath+=~/devel/src/github.com/Shougo/dein.vim

let s:dein_cache_dir = expand('~/.vim/cache/dein')

call dein#begin(s:dein_cache_dir)

if dein#load_cache()
  let plugins_toml = expand('~/.vim/etc/plugins.toml')
  call dein#load_toml(plugins_toml)
  call dein#load_toml(expand('~/.vim/etc/lazy.toml'), { 'lazy': 1 })
  call dein#save_cache()
endif

call dein#end()

if dein#check_install()
  call dein#install()
endif

unlet s:dein_cache_dir
