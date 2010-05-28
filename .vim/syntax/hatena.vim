" HTML要素
if exists('g:hatena_syntax_html') && g:hatena_syntax_html
    syntax include @Html syntax/html.vim
    syn clear htmlError
    syn clear htmlTagError
    syn clear htmlCommentError
endif

syn match hatenaHeading         +^\*\{1,3}\(\w\+\*\)\=.\+$+         contains=hatenaHeadingName,hatenaLink
syn match hatenaHeadingName     +^\*\{1,3}[^*]\{-1,}\*\|^\*\{1,3}+  contained nextgroup=hatenaCategory
syn match hatenaCategory        +\(\[.\{-}\]\)\++                   contained

syn match hatenaList            +^[+-]\++

syn match hatenaDefinition      +^:.\{-1,}:.\+$+    contains=hatenaDefColon
syn match hatenaDefColon        +:+                 contained

syn match hatenaTable           +^|\(.\{-}|\)\++    contains=hatenaTableHeader,hatenaTableSeparator
syn match hatenaTableHeader     +\*[^|]\++          contained
syn match hatenaTableSeparator  +|+                 contained

syn match hatenaLink            +\[\(http\|google\(:news\|:image\)\=\|amazon\|rakuten\):.\{-}\]+    contains=hatenaLinkSpecial
syn match hatenaLinkURL         +https\=://[-!#$%&*+,./:;=?@0-9a-zA-Z_~]\++
syn match hatenaLinkSpecial     +:title\(=[^]]*\)\=\ze\]\|:barcode\|:image+

syn match hatenaKeyword         +\[\[.\{-}\]\]+
syn region hatenaCancelLink     matchgroup=hatenaBlockDelimiter start=+\[\]+ end=+\[\]+ oneline

syn match hatenaFootNote        +(\@<!(((\@!.\{-}))+
syn match hatenaCancelFootNote  +)((+   contains=hatenaCanceledParen
syn match hatenaCanceledParen   +(+     contained

syn match hatenaReadMore        +=====\?+
syn match hatenaTex             +\[tex:.\{-}\]+
syn match hatenaUkulele         +\[uke:.\{-}\]+

syn region hatenaCancelP        matchgroup=hatenaBlockDelimiter start=+>\ze<+ end=+<$+ contains=@Html

syn match hatenaHTMLTag         +<+ contains=@Html

syn cluster hatenaSpecials      contains=hatenaDefColon,hatenaTableSeparator,hatenaCanceledParen

" はてな内自動リンク
syn match hatenaAutoLinkDiary       +\(d:\)\=id:[A-Za-z]\w*\(:\d\{6}\|:\d\{8}\|:archive\(:\d\{6}\)\=\|:about\)\=+
syn match hatenaAutoLinkQuestion    +question:\d\{10}\(:title\|:detail\|:image\(:small\)\=\)\=+
syn match hatenaAutoLinkQuestion    +\[question:\d\{10}:title=.\{-}\]+
syn match hatenaAutoLinkSearch      +\[search:\(keyword:\|question:\|asin:\)\=.\{-}\]+
syn match hatenaAutoLinkAntenna     +a:id:[A-Za-z]\w*+
syn match hatenaAutoLinkBookmark    +b:id:[A-Za-z]\w*\(:\d\{8}\|:favorite\|:asin\)\=+
syn match hatenaAutoLinkBookmark    +\[b:id:[A-Za-z]\w*:t:.\{-}\]+
syn match hatenaAutoLinkBookmark    +\[b:\(keyword\|t\):.\{-}\]+
syn match hatenaAutoLinkFotolife    +f:id:[A-Za-z]\w*\(:favorite\|:.\{-}:image\(:small\|:[wh]\d\+\)\=\)\=+
syn match hatenaAutoLinkGroup       +g:[A-Za-z]\w*\(:id:[A-Za-z]\w*\(:\d\{6}\|:\d\{8}\|:archive\)\=\)\=+
syn match hatenaAutoLinkGroup       +\[g:[A-Za-z]\w*:keyword:.\{-}\]+
syn match hatenaAutoLinkIdea        +idea:\d\+\(:title\)\=+
syn match hatenaAutoLinkIdea        +i:id:[A-Za-z]\w*+
syn match hatenaAutoLinkIdea        +\[i:t:.\{-}\]+
syn match hatenaAutoLinkRSS         +r:id:[A-Za-z]\w*+
syn match hatenaAutoLinkGraph       +graph:id:[A-Za-z]\w*+
syn match hatenaAutoLinkGraph       +\[graph:id:[A-Za-z]\w*\(:.\{-}\(:image\)\=\)\=\]+
syn match hatenaAutoLinkGraph       +\[graph:t:.\{-}]+
syn match hatenaAutoLinkMap         +map:x[0-9.]\+y[0-9.]\++
syn match hatenaAutoLinkMap         +\[map:\(t:\)\=.\{-}\]+
syn match hatenaAutoLinkKeyword     +\[keyword:.\{-}\(:graph\(\(:refcount\|:refrank\|:accessrank\)\(:\d\+[dwmy]\)\=\)\=\)\=\]+
syn match hatenaAutoLinkISBN        +isbn:\d\{10}\(:title\|\(:image\|:detail\)\(:small\|:large\)\=\)\=+
syn match hatenaAutoLinkASIN        +asin:[0-9A-Z]\+\(:title\|\(:image\|:detail\)\(:small\|:large\)\=\)\=+
syn match hatenaAutoLinkJANEAN      +\(jan\|ean\):\d\+\(:title\|\(:image\|:detail\)\(:small\|:large\)\=\|:barcode\)\=+
syn match hatenaAutoLinkJANEAN      +\[\(jan\|ean\):\d\+:title=.\{-}\]+
syn cluster hatenaAutoLinks         contains=hatenaAutoLinkDiary,hatenaAutoLinkQuestion,hatenaAutoLinkSearch,hatenaAutoLinkAntenna,hatenaAutoLinkBookmark,hatenaAutoLinkFotolife,hatenaAutoLinkGroup,hatenaAutoLinkIdea,hatenaAutoLinkRSS,hatenaAutoLinkGraph,hatenaAutoLinkMap,hatenaAutoLinkKeyword,hatenaAutoLinkISBN,hatenaAutoLinkASIN,hatenaAutoLinkJANEAN

syn match hatenaBlockQuoteCite +>\@<=https\?:.\{-}>$+ contained contains=hatenaLinkURL

syn region hatenaBlockQuote matchgroup=hatenaBlockDelimiter start=+^>>$+  end=+^<<$+ contains=ALLBUT,@hatenaSpecials,hatenaBlockQuoteCite
syn region hatenaBlockQuote matchgroup=hatenaBlockDelimiter start=+^>\zehttps\?:.\{-}>$+ end=+^<<$+ contains=ALLBUT,@hatenaSpecials
syn region hatenaPre        matchgroup=hatenaBlockDelimiter start=+^>|$+  end=+^|<$+ contains=ALLBUT,@hatenaSpecials,hatenaBlockQuoteCite
syn region hatenaSuperPre   matchgroup=hatenaBlockDelimiter start=+^>|[^|]*|$+ end=+^||<$+

" コメント
syn region hatenaComment        start=+<!--+    end=+-->+

hi link hatenaHeading           Title
hi link hatenaCategory          Label
hi link hatenaHeadingName       Identifier
hi link hatenaList              Statement
hi link hatenaDefColon          Statement
hi link hatenaTableSeparator    Statement
hi link hatenaTableHeader       Title
hi link hatenaKeyword           Underlined
hi link hatenaLink              Underlined
hi link hatenaLinkURL           Underlined
hi link hatenaLinkSpecial       Special
hi link hatenaAutoLinkDiary     Underlined
hi link hatenaAutoLinkQuestion  Underlined
hi link hatenaAutoLinkSearch    Underlined
hi link hatenaAutoLinkAntenna   Underlined
hi link hatenaAutoLinkBookmark  Underlined
hi link hatenaAutoLinkFotolife  Underlined
hi link hatenaAutoLinkGroup     Underlined
hi link hatenaAutoLinkIdea      Underlined
hi link hatenaAutoLinkRSS       Underlined
hi link hatenaAutoLinkGraph     Underlined
hi link hatenaAutoLinkMap       Underlined
hi link hatenaAutoLinkKeyword   Underlined
hi link hatenaAutoLinkISBN      Underlined
hi link hatenaAutoLinkASIN      Underlined
hi link hatenaAutoLinkJANEAN    Underlined
hi link hatenaFootNote          Identifier
"hi link hatenaCanceledParen    Special
"hi link hatenaCancelLink        Special
hi link hatenaError             Error
"hi link hatenaBlockQuote       String
"hi link hatenaPre              String
"hi link hatenaSuperPre         String
hi link hatenaBlockQuoteCite    Delimiter
hi link hatenaBlockDelimiter    Delimiter
hi link hatenaReadMore          Special
hi link hatenaComment           Comment
hi link hatenaCancelP           Delimiter
