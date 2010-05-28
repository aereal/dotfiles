scriptencoding utf-8
" hatena.vim
" Author:       motemen <motemen@gmail.com>
" Version:      20070830
" vim: set ts=4 sw=4:

" ===========================
"   インストール {{{

"  - hatena/plugin/hatena.vim
"  - hatena/syntax/hatena.vim
"  - hatena/cookies (空ディレクトリ)
"
" 以上のファイル/ディレクトリを適当な場所に置いて、パスを通して下さい。
"
" 例 (.vimrc):
" > set runtimepath+=$VIM/hatena

" }}}
" ===========================

" ===========================
"   使用方法 {{{

" > :HatenaUser [グループ名:]ユーザ名
" もしくは
" > :let g:hatena_user = '[グループ名:]ユーザ名'
" としてユーザ名を設定し、
" > :HatenaEdit [[[YYYY]MM]DD]
" で編集バッファが開きます。日記を書いたら :w で送信します。

" }}}
" ===========================

" ===========================
"   コマンド {{{

" はてなにログインし、日記を編集する
" Usage:
"   :HatenaEdit [[[YYYY]MM]DD]
" 日付の形式は YYYYMMDD, YYYY/MM/DD, YYYY-MM-DD
command! -nargs=? HatenaEdit            call <SID>HatenaEdit(<args>)

" :HatenaEdit で開いたバッファの内容をはてなに送信し、日記を更新する
" Usage:
"   :HatenaUpdate [title_of_the_day]
" title_of_the_day を指定しない場合は既に設定されているタイトルが使われる
"command! -nargs=? HatenaUpdate         call <SID>HatenaUpdate(<args>)

" :HatenaUpdate と一緒だけど、`ちょっとした更新' にする
"command! -nargs=? HatenaUpdateTrivial  let b:trivial=1 | call <SID>HatenaUpdate(<args>)

" はてなのユーザを切り換える
" 指定しなかった場合は表示する
" Usage:
"   :HatenaUser [username]
command! -nargs=? -complete=customlist,HatenaEnumUsers HatenaUser   if strlen('<args>') | let g:hatena_user='<args>' | else | echo g:hatena_user | endif

nnoremap <Leader>he :HatenaEdit<CR>
" }}}
" ===========================

" ===========================
"   スクリプト設定 {{{

" はてなのユーザID
if !exists('g:hatena_user')
    let g:hatena_user = ''
endif

" サブアカなども含めたIDのリスト
if !exists('g:hatena_users')
    if g:hatena_user != ''
        let g:hatena_users = [g:hatena_user]
    else
        let g:hatena_users = []
    endif
endif

" クッキーを保存しておくか？ (1: 保存しておく 0: Vim終了時に削除)
if !exists('g:hatena_hold_cookie')
    let g:hatena_hold_cookie = 1
endif

" スクリプトのベースディレクトリ (クッキーの保存に使われるだけ)
if !exists('g:hatena_base_dir')
    let g:hatena_base_dir = substitute(expand('<sfile>:p:h'), '[/\\]plugin$', '', '')
endif

" 常に `ちょっとした更新' にする？ (1: 常にちょっとした更新)
if !exists('g:hatena_always_trivial')
    let g:hatena_always_trivial = 0
endif

let g:hatena_syntax_html = 1

if !g:hatena_hold_cookie
    autocmd VimLeave * call delete(b:hatena_login_info[2])
endif

" :HatenaEdit で編集バッファを開くコマンド
let g:hatena_edit_command = 'edit!'

let s:curl_cmd = 'curl -k --silent'
if exists('g:chalice_curl_options') " http://d.hatena.ne.jp/smeghead/20070709/hatenavim
  let s:curl_cmd = s:curl_cmd . ' ' . g:chalice_curl_options
endif
let s:hatena_login_url      = 'https://www.hatena.ne.jp/login'
let s:hatena_base_url       = 'http://d.hatena.ne.jp/'
let s:hatena_group_base_url = 'http://%s.g.hatena.ne.jp/'

" }}}
" ===========================

" ===========================
"   スクリプト本体 {{{

" はてなにログインする
"   ユーザ名は g:hatena_user から取得。存在しなければユーザに尋ねる。
"   クッキーでログインを試み、ダメならパスワードでログインする。
"
"   ログインに成功: [ベースURL, ユーザID, クッキーファイル] を返す。
"   ログインに失敗: 空リストを返す。
function! s:HatenaLogin()
    if !strlen(g:hatena_user)
        let hatena_user = input('はてなユーザID(user/group:user): ', '', 'customlist,HatenaEnumUsers')
    else
        let hatena_user = g:hatena_user
    endif
    return HatenaLogin(hatena_user)
endfunction

"TODO: この関数をグローバルにするセキュリティリスクについて考察
function! HatenaLogin(user)
    let hatena_user=a:user
    let [base_url, user] = s:GetBaseURLAndUser(hatena_user)

    let tmpfile = tempname()

    " クッキーを保存するファイル
    if has('win32')
        let cookie_file = g:hatena_base_dir . '\cookies\' . user
    else
        let cookie_file = g:hatena_base_dir . '/cookies/' . user
    endif

    " クッキーがある場合はクッキーでログインを試みる
    if filereadable(cookie_file)
        let reply_header = system(s:curl_cmd . ' ' . base_url . user . '/edit -b "' . cookie_file . '" -D - -o ' . tmpfile)
        if reply_header =~? 'Location: https:'
            " httpsなグループへ
            let base_url = substitute(base_url, '^http', 'https', '')
            let reply_header = system(s:curl_cmd . ' ' . base_url . user . '/edit -b "' . cookie_file . '" -D - -o ' . tmpfile)
        endif
        if reply_header !~? 'Location:'
            echo 'ログインしてます'
            return [base_url, user, cookie_file]
        else
            call delete(cookie_file)
        endif
    endif

    " パスワードでログイン
    let password = inputsecret('Password: ')

    if !len(password)
        echo 'キャンセルしました'
        return []
    endif

    let content = system(s:curl_cmd . ' ' . s:hatena_login_url . ' -d name=' . user . ' -d password=' . password . ' -d mode=enter -c "' . cookie_file . '"')

    call delete(tmpfile)

    if content !~ '<div [^>]*class="error-message"'
        echo 'ログインしました'
        return [base_url, user, cookie_file]
    else
        echoerr 'ログインに失敗しました'
        return []
    endif
endfunction

function! s:HatenaEdit(...) " 編集する
    " ログイン
    if !exists('b:hatena_login_info')
        let hatena_login_info = s:HatenaLogin()
        if !len(hatena_login_info)
            return
        endif
    else
        let hatena_login_info = b:hatena_login_info
    endif

    let [base_url, user, cookie_file] = hatena_login_info

    " 編集する日付を取得
    if a:0 > 0
        let date = a:1
    else
        let date = input('Date: ', strftime('%Y%m%d'))
    endif

    if !len(date)
        echo 'キャンセルしました'
        return
    endif

    " 20051124, 2005-11-24, 11/24, 24 といった日付を認識
    let pat = '\%(\%(\(\d\d\d\d\)[/-]\=\)\=\(\d\d\)[/-]\=\)\=\(\d\d\)'
    let matches = matchlist(date, pat)
    if !len(matches)
        echoerr '日時のフォーマットが正しくありません！(YYYYMMDD)'
        return
    endif

    let [year, month, day] = matches[1:3]

    if !strlen(day)
        echoerr '日時のフォーマットが正しくありません！(YYYYMMDD)'
        return
    endif

    if !strlen(year)  | let year  = strftime('%Y') | endif
    if !strlen(month) | let month = strftime('%m') | endif

    let content = HatenaLoadContent(base_url,user,year,month,day,cookie_file)

    " セッション(編集バッファ)を作成
    let tmpfile = tempname()
    execute g:hatena_edit_command tmpfile
    set filetype=hatena
    setlocal noswapfile
    let &fileencoding = content['fenc']
    let b:rkm = content['rkm']

    if !strlen(b:rkm)
        echoerr 'ログインできませんでした'
        if exists('s:user')
            unlet s:user
        endif
        return
    endif

    let b:hatena_login_info = hatena_login_info
    let b:year  = year
    let b:month = month
    let b:day   = day
    let b:trivial   = g:hatena_always_trivial
    let b:diary_title   = content['diary_title']
    let b:day_title     = content['day_title']
    let b:timestamp     = content['timestamp']
    let b:prev_titlestring = &titlestring

    autocmd BufWritePost <buffer> call s:HatenaUpdate() | set readonly |let &titlestring = b:prev_titlestring | bdelete
    autocmd WinLeave <buffer> let &titlestring = b:prev_titlestring
    autocmd WinEnter <buffer> let &titlestring = b:diary_title . ' ' . b:year . '-' . b:month . '-' . b:day . ' [' . b:hatena_login_info[1] . ']'
    let &titlestring = b:diary_title . ' ' . b:year . '-' . b:month . '-' . b:day . ' [' . user . ']'

    let nopaste = !&paste   
    set paste
    execute 'normal i' . content['body']
    if nopaste
        set nopaste
    endif
    set nomodified
    call s:HatenaSuperPreSyntax()
endfunction

function! s:HatenaSuperPreSyntax()
  if !exists('b:super_pre_langs')
    let b:super_pre_langs = {}
    autocmd BufEnter <buffer> call s:HatenaSuperPreSyntax()
  endif
  let lnum = 1
  let lmax = line("$")
  let mx = '^>|\(.*\)|$'
  while lnum <= lmax
    let curline = getline(lnum)
    if curline =~ mx
      let lang = substitute(curline, mx, '\1', '')
      if len(lang) && !has_key(b:super_pre_langs, lang)
        exec 'runtime! syntax/'.lang.'.vim'
        unlet b:current_syntax
        let syntaxfile = fnameescape(substitute(globpath(&rtp, 'syntax/'.lang.'.vim'), '[\r\n].*$', '', ''))
        if len(syntaxfile)
          let b:super_pre_langs[lang] = syntaxfile
          exec 'syntax include @inline_'.lang.' '.syntaxfile
          exec 'syn region hatenaSuperPre matchgroup=hatenaBlockDelimiter start=+^>|'.lang.'|$+ end=+^||<$+ contains=@inline_'.lang
        endif
      endif
    end
    let lnum = lnum + 1
  endwhile
  " workaround for perl
  silent exec "syn cluster inline_perl remove=perlFunctionName"
endfunction

"指定先から一日分のエントリを取得。
"return: dictionary {
"    diary_title, day_title, timestamp, rkm, body, fenc
"}
function! HatenaLoadContent(base_url,user,year,month,day,cookie_file)
    " 編集ページを取得
    let content = system(s:curl_cmd . ' "' . a:base_url . a:user . '/edit?date=' . a:year.a:month.a:day . '" -b "' . a:cookie_file . '"')
    if a:base_url =~ 'g.hatena'
        let content = iconv(content, 'utf-8', &enc)
        let fenc = 'utf-8'
    else
        let content = iconv(content, 'euc-jp', &enc)
        let fenc = 'euc-jp'
    endif
    let result=s:HatenaParseContent(content)
    let result['fenc']=fenc
    let result['year']=a:year
    let result['month']=a:month
    let result['day']=a:day
    return result
endfunction

function! s:HatenaParseContent(content)
    let diary_title = matchstr(a:content, '<title>\zs.\{-}\ze</title>')
    let day_title   = matchstr(a:content, '<input .\{-}name="title" .\{-}value="\zs.\{-}\ze"')
    let timestamp   = matchstr(a:content, 'name="timestamp"\s*value="\zs[^"]*\ze"')
    let rkm         = matchstr(a:content, 'name="rkm"\s*value="\zs[^"]*\ze"')
    let body        = s:HtmlUnescape(matchstr(a:content, '<textarea.\{-}name="body"[^>]*>\zs.\{-}\ze</textarea>'))
    let result={}
    let result['diary_title']=diary_title
    let result['day_title']=day_title
    let result['timestamp']=timestamp
    let result['rkm']=rkm
    let result['body']=body
    return result
endfunction

function! s:HatenaUpdate(...) " 更新する
    " 日時を取得
    if !exists('b:hatena_login_info') || !exists('b:year') || !exists('b:month') || !exists('b:day') || !exists('b:day_title') || !exists('b:rkm')
        echoerr ':HatanaEdit してから :HatenaUpdate して下さい'
        return
    endif

    " ログイン
    if !exists('b:hatena_login_info')
        let b:hatena_login_info = s:HatenaLogin()
        if !len(b:hatena_login_info)
            return
        endif
    endif

    let [base_url, user, cookie_file] = b:hatena_login_info

    if a:0 > 0
        let b:day_title = a:1
    "else
    "   let b:day_title = input('タイトル: ', b:day_title)
    endif

    if &modified
        write
    endif

    let body_file = expand('%')
    let diary={'timestamp':b:timestamp, 'rkm':b:rkm, 'year':b:year, 'month':b:month, 'day':b:day, 'day_title':b:day_title}

    let result=HatenaPost(base_url,user,cookie_file,diary,body_file)

    echo '更新しました'
endfunction

function! HatenaPost(base_url,user,cookie_file,diary,body_file)
    if a:body_file == ""
        let body_file=tempname()
        execute 'new '.body_file
        call append(0,a:diary['body'])
        write
        let &modified=0
        bdelete
    else
        let body_file=a:body_file
    endif
    " まずは全消去
    let post_data = ' -F mode=enter'
                    \ . ' -F year=' . a:diary.year . ' -F month=' . a:diary.month . ' -F day=' . a:diary.day
                    \ . ' -F rkm=' . a:diary.rkm
                    \ . ' -F body= -F title='
    call system(s:curl_cmd . ' ' . a:base_url . a:user . '/edit -b "' . a:cookie_file . '"' . post_data)

    " ポスト
    let post_data = ' -F mode=enter'
                    \ . ' -F timestamp=' . a:diary['timestamp'] . ' -F rkm=' . a:diary['rkm']
                    \ . ' -F year=' . a:diary['year'] . ' -F month=' . a:diary['month'] . ' -F day=' . a:diary['day']
                    \ . ' -F date=' . a:diary['year'].a:diary['month'].a:diary['day']
                    \ . ' -F "body=<' . body_file . '"'
                    \ . ' -F image= -F title=' . a:diary['day_title']
    return system(s:curl_cmd . ' ' . a:base_url . a:user . '/edit -b "' . a:cookie_file . '"' . post_data . ' -D -')
endfunction

function! HatenaGetRKM(login_info)
    let [base_url, user, cookie_file] = a:login_info
    let json = system(s:curl_cmd . ' "' . base_url . user . '/?mode=json" -b "' . cookie_file . '"')
    return matchstr(json, "'rkm':'\\zs.*\\ze'")
endfunction

" はてなダイアリー/グループに新しいエントリを投稿する
" login_info: HatenaLogin() で得られるもの
" rkm: HatenaGetRKM() などで得られるもの
" entry: エントリの情報、以下のキーを持つ
"  * title
"  * body (body_file とどちらか一方)
"  * body_file (body とどちらか一方)
"  * date (optional)
"  * timestamp (optional)
function! HatenaPostEntry(login_info, rkm, entry)
    let [base_url, user, cookie_file] = a:login_info

    "if base_url =~ 'g[.]hatena'
    "    let fenc = 'utf-8'
    "else
    "    let fenc = 'utf-8'
    "endif
    let fenc = 'utf-8'

    let paste_save = &paste

    if has_key(a:entry, 'body_file')
        let body_file = a:entry.body_file
        execute 'split ' . body_file
        let &fileencoding = fenc
        write
        quit
    else
        let body_file = tempname()
        execute 'new ' . body_file
        set paste
        normal! C=a:entry.body
        let &fileencoding = fenc
        write
        bdelete
    endif

    let title_file = tempname()
    execute 'new ' . title_file
    set paste
    normal! C=a:entry.title
    let &fileencoding = fenc
    write
    bdelete

    let &paste = paste_save

    let post_url = base_url . user . '/'
    if has_key(a:entry, 'date') && has_key(a:entry, 'timestamp')
        let post_url .= a:entry.date . '/' . a:entry.timestamp
    endif

    let g:post_files = [title_file, body_file]

    let json = system(printf('%s %s -b "%s" -F "rkm=%s" -F "title=<%s" -F "body=<%s" -D -',
                \ s:curl_cmd,
                \ post_url,
                \ cookie_file,
                \ a:rkm,
                \ title_file,
                \ body_file
                \ ))

    let m = matchlist(json, '\v''path'':''/[^/]+/([^/]{-})/([^/]{-})''')
    return { 'date': m[1], 'timestamp': m[2] }
endfunction

" はてなダイアリー/グループに新しいエントリを投稿する
" login_info: HatenaLogin() で得られるもの
" rkm: HatenaGetRKM() などで得られるもの
" entry: エントリの情報、以下のキーを持つ
"  * date
"  * timestamp
function! HatenaGetEntry(login_info, rkm, entry)
    let [base_url, user, cookie_file] = a:login_info

    if base_url =~ 'g[.]hatena'
        let fenc = 'utf-8'
    else
        let fenc = 'euc-jp'
    endif

    let get_url = base_url . user . '/' . a:entry.date . '/' . a:entry.timestamp . '?mode=json'
    let json = system(printf('%s %s -b "%s"',
                \ s:curl_cmd,
                \ get_url,
                \ cookie_file,
                \ ))

    let json = iconv(json, fenc, &encoding)

    let m = matchlist(json, '\v.*''body'':''(.{-})''&.*''title'':''(.{-})''')

    if len(m)
        let [body, title] = m[1:2]
        let body = substitute(body, '\\n', "\n", 'g')
        return { 'date': a:entry.date, 'timestamp': a:entry.timestamp, 'body': body, 'title': title }
    else
        return { }
    endif
endfunction

function! HatenaEnumUsers(...) " ユーザ名を列挙
    if !exists('g:hatena_users')
        let g:hatena_users = []
    endif
    return g:hatena_users
endfunction

function! s:HtmlUnescape(string) " HTMLエスケープを解除
    let string = a:string
    while match(string, '&#\d\+;') != -1
        let num = matchstr(string, '&#\zs\d\+\ze;')
        let string = substitute(string, '&#\d\+;', nr2char(num), '')
    endwhile
    let string = substitute(string, '&gt;',   '>', 'g')
    let string = substitute(string, '&lt;',   '<', 'g')
    let string = substitute(string, '&quot;', '"', 'g')
    let string = substitute(string, '&amp;',  '\&', 'g')
    return string
endfunction

function! s:GetBaseURLAndUser(hatena_user) " a:hatena_user からグループ/ユーザを取得
    let pair = split(a:hatena_user, ':')
    if len(pair) > 1
        let base_url = printf(s:hatena_group_base_url, pair[0])
        let user = pair[1]
    else
        let base_url = s:hatena_base_url
        let user = a:hatena_user
    endif

    return [base_url, user]
endfunction

"returns array of dictionaries.
"[entry1,entry2,...]
"each item is
"{ 'eid':entry-id, 'title':title, 'body':body }
" TODO: タイトルのない冒頭部
function! HatenaParseEntries(body)
    new
    if type(a:body)==type('')
        let body=split(a:body,"\n",1)
    else "expect is list
        let body=a:body
    endif
    call append(0,body)
    call cursor(1,1)
    let l:es=[]
    let l:e=s:FindNextEntry()
    while l:e
        let l:next_e=s:FindNextEntry()
        call add(l:es,[l:e,next_e?next_e-1:line('$')])
        let l:e=l:next_e
    endwhile
    let l:result=[]
    for [l:st,l:ed] in l:es
        call add(result,HatenaParseEnrty(getline(l:st),getline(l:st+1,l:ed)))
    endfor
    let &modified=0
    close
    return l:result
endfunction    

function! HatenaParseEnrty(title,body)
    let [eid,title]=matchlist(a:title,'^\*\%(\(\%(\w\|-\)\+\)\*\)\?\(.*\)$')[1:2]
    let body=a:body
    return {'eid':eid, 'title':title, 'body':body}
endfunction

"エントリのリストを文字列に直す HatenaParseEntriesの逆
"諸般の事情(appendの仕様?)により、各行を要素に持つリストを返す。
function! HatenaExpandEntries(entries)
    new
    for e in a:entries
        call append(line('$'),'*'.e['eid'].'*'.e['title'])
        call append(line('$'),e['body'])
    endfor
    execute '1delete'
    let result=getline(1,'$')
    let &modified=0
    bdelete
    return result
endfunction

"カーソル位置以降のエントリを探す
function! s:FindNextEntry()
    while 1
        "skip super pre
        if search('^>|\w*|$','ce',line('.'))
            if !search('^||<$','ce') "broken spre
                return 0
            endif
        endif
        "find next entry
        let entry=search('^\*\(\%(\w\|-\)\+\)\*\(.*\)$','ce',line('.'))
        if entry || line('.') >= line('$')
            call cursor(line('.')+1,1)
            return entry
        endif
        call cursor(line('.')+1,1)
    endwhile
endfunction

" }}}
" ===========================
