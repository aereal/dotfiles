let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enables = {
      \ "typescript": 0,
      \ }
if !exists('g:quickrun_config')
  let g:quickrun_config = {}
endif
let g:quickrun_config['watchdogs_checker/_'] = {
      \   'outputter/quickfix/open_cmd' : '',
      \   'hook/hier_update/enable_exit' : 1,
      \   'runner/vimproc/updatetime' : 40,
      \ }
let g:quickrun_config['watchdogs_checker/efm_perl'] = {
      \   'command' : expand('~/.vim/tools/efm_perl.pl'),
      \   'exec' : '%c %o %s:p',
      \   'quickfix/errorformat' : '%f:%l:%m',
      \ }
let g:quickrun_config['watchdogs_checker/cpanfile'] = {
      \   'command' : 'perl',
      \   'exec' : '%c %o -w -MModule::CPANfile -e "Module::CPANfile->load(q|%S:p|)"',
      \   'quickfix/errorformat' : '%m\ at\ %f\ line\ %l%.%#',
      \ }
let g:quickrun_config['perl/watchdogs_checker'] = {
      \   'type' : 'watchdogs_checker/efm_perl',
      \ }
let g:quickrun_config['cpanfile/watchdogs_checker'] = {
      \   'type' : 'watchdogs_checker/cpanfile',
      \ }
call watchdogs#setup(g:quickrun_config)
