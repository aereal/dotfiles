autocmd BufEnter */templates/*.html setf tt2html
autocmd BufEnter *.tt setf tt2html

autocmd BufEnter *.es6,*.es setf javascript

autocmd BufEnter */nginx/*.conf setf nginx
autocmd BufEnter */*.nginx.conf setf nginx

autocmd BufEnter cpanfile setf cpanfile
autocmd BufEnter cpanfile set syntax=perl.cpanfile
autocmd BufEnter *.t setf perl
autocmd BufEnter *.psgi setf perl

autocmd BufEnter *.podspec setf ruby
autocmd BufEnter Podfile   setf ruby

autocmd BufEnter *.hatena setf hatena

autocmd BufEnter *.scala setf scala

autocmd BufEnter *.toml setf toml
