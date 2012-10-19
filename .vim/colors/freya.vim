" Vim colorscheme
" Author:  Gary Willoughby (originally by Georg Dahn)
" Version: 2.2
" Date:    13th October 2012

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
let colors_name = "Freya"

" GUI
hi Blank                           guibg=#2A2A2A guifg=#2A2A2A gui=none
hi Normal                          guibg=#2A2A2A guifg=#DCDCCC gui=none
hi Cursor                          guibg=fg      guifg=bg      gui=none
hi CursorLine                      guibg=#202020               gui=none
hi CursorLineNr                    guibg=#1F1F1F guifg=#595959 gui=none
hi Directory                       guibg=bg      guifg=#D4B064 gui=none
hi FoldColumn                      guibg=#1F1F1F guifg=#C2B680 gui=none
hi Folded                          guibg=bg      guifg=#E0AF91 gui=none
hi LineNr                          guibg=#1F1F1F guifg=#595959 gui=none
hi VertSplit                       guibg=#333333 guifg=#595959 gui=none
hi ErrorMsg                        guibg=bg      guifg=#F07070 gui=none
hi MatchParen                      guibg=#111111 guifg=#FFFF00 gui=none
hi StatusLine                      guibg=#333333 guifg=#999999 gui=none
hi StatusLineNC                    guibg=#333333 guifg=#777777 gui=none
hi Title                           guifg=#F7F7F1               gui=none
hi Visual                          guibg=#5F5F5F guifg=fg      gui=none
hi WarningMsg                      guibg=bg      guifg=#F07070 gui=none
hi! link SignColumn                LineNr

" Popup menus
hi Pmenu                           guibg=#585858 guifg=#BBBBBB gui=none
hi PmenuSbar                       guibg=#B99F86 guifg=fg      gui=none
hi PmenuSel                        guibg=#94DE9E guifg=#2A2A2A gui=none
hi PmenuThumb                      guibg=#F7F7F1 guifg=bg      gui=none
hi WildMenu                        guibg=#C0AA94 guifg=bg      gui=none

" Diff
hi DiffChange                      guibg=bg                    gui=none
hi DiffAdd                         guibg=#8AC38A guifg=white   gui=none
hi DiffDelete                      guibg=#b27272 guifg=white   gui=none
hi DiffText                        guibg=#008FFF guifg=white   gui=none 

" Search
hi Search                          guibg=#295E8E guifg=#FFFFFF gui=none
hi IncSearch                       guibg=#295E8E guifg=#FFFFFF gui=none

" Spelling
if has("spell")
    hi SpellBad                    guisp=#F07070               gui=undercurl
    hi SpellCap                    guisp=#7070F0               gui=undercurl
    hi SpellLocal                  guisp=#70F0F0               gui=undercurl
    hi SpellRare                   guisp=#F070F0               gui=undercurl
endif

" Syntax
hi Comment                         guibg=bg      guifg=#595959 gui=italic
hi ToDo                            guibg=bg      guifg=#595959 gui=italic
hi Constant                        guibg=bg      guifg=#AFE091 gui=none
hi Statement                       guibg=bg      guifg=#E0AF91 gui=none
hi StatementU                      guibg=bg      guifg=#E0AF91 gui=none
hi Keyword                         guibg=bg      guifg=#E0AF91 gui=none
hi Underlined                      guibg=bg      guifg=#D4B064 gui=underline
hi Error                           guibg=bg      guifg=#F07070 gui=none
hi String                          guibg=bg      guifg=#AFE091 gui=none
hi Character                       guibg=bg      guifg=#AFE091 gui=none
hi Number                          guibg=bg      guifg=#AFE091 gui=none
hi Boolean                         guibg=bg      guifg=#AFE091 gui=none
hi Float                           guibg=bg      guifg=#AFE091 gui=none
hi Identifier                      guibg=bg      guifg=#DABFA5 gui=none
hi Function                        guibg=bg      guifg=#C2AED0 gui=none
hi Operator                        guibg=bg      guifg=#E0AF91 gui=none
hi PreProc                         guibg=bg      guifg=#C2AED0 gui=none
hi Type                            guibg=bg      guifg=#DABFA5 gui=none
hi Special                         guibg=bg      guifg=#D4B064 gui=none
hi StorageClass                    guibg=bg      guifg=#C2AED0 gui=none
hi Question                        guibg=bg      guifg=#DABFA5 gui=none

" Whitespace
hi SpecialKey                      guibg=bg      guifg=#111111 gui=none
hi NonText                         guibg=bg      guifg=#111111 gui=none

" HTML
hi htmlnone                        guibg=bg      guifg=fg      gui=none
hi htmlItalic                      guibg=bg      guifg=fg      gui=italic
hi htmlUnderline                   guibg=bg      guifg=fg      gui=underline
hi htmlnoneItalic                  guibg=bg      guifg=fg      gui=none,italic
hi htmlnoneUnderline               guibg=bg      guifg=fg      gui=none,underline
hi htmlnoneUnderlineItalic         guibg=bg      guifg=fg      gui=none,underline,italic
hi htmlUnderlineItalic             guibg=bg      guifg=fg      gui=underline,italic
hi! link HTMLString                String
hi! link HTMLTag                   Keyword
hi! link HTMLEndTag                Keyword

" CSS
hi! link cssValueLength            Constant
hi! link cssValueInteger           Constant
hi! link cssValueNumber            Constant
hi! link cssValueAngle             Constant
hi! link cssValueTime              Constant
hi! link cssValueFrequency         Constant
hi! link cssColor                  Constant
hi! link cssFunctionName           Function
hi! link cssImportant              Function
hi! link cssComment                Comment
hi! link cssTagName                Normal
hi! link cssSelectorOp             Normal
hi! link cssSelectorOp2            Normal
hi! link cssFontProp               Keyword
hi! link cssColorProp              Keyword
hi! link cssTextProp               Keyword
hi! link cssBoxProp                Keyword
hi! link cssRenderProp             Keyword
hi! link cssAuralProp              Keyword
hi! link cssRenderProp             Keyword
hi! link cssGeneratedContentProp   Keyword
hi! link cssPagingProp             Keyword
hi! link cssTableProp              Keyword
hi! link cssUIProp                 Keyword
hi! link cssFontAttr               Type
hi! link cssColorAttr              Type
hi! link cssTextAttr               Type
hi! link cssBoxAttr                Type
hi! link cssRenderAttr             Type
hi! link cssAuralAttr              Type
hi! link cssGeneratedContentAttr   Type
hi! link cssPagingAttr             Type
hi! link cssTableAttr              Type
hi! link cssUIAttr                 Type
hi! link cssCommonAttr             Type
hi! link cssPseudoClassId          Normal
hi! link cssPseudoClassLang        Normal
hi! link cssFunction               Normal
hi! link cssURL                    String
hi! link cssIdentifier             Normal
hi! link cssInclude                Normal
hi! link cssBraces                 Normal
hi! link cssBraceError             Error
hi! link cssError                  Error
hi! link cssUnicodeEscape          String
hi! link cssStringQQ               String
hi! link cssStringQ                String
hi! link cssMedia                  Normal
hi! link cssMediaType              Normal
hi! link cssMediaComma             Normal
hi! link cssFontDescriptor         Normal
hi! link cssFontDescriptorFunction Normal
hi! link cssFontDescriptorProp     Keyword
hi! link cssFontDescriptorAttr     Normal
hi! link cssUnicodeRange           String
hi! link cssClassName              Normal

" Tlist
hi MyTagListComment                guibg=bg      guifg=#595959 gui=none
hi MyTagListFileName               guibg=#202020 guifg=#C2AED0 gui=none
hi MyTagListTitle                  guibg=bg      guifg=#D4B064 gui=none
hi MyTagListTagName                guibg=#202020 guifg=fg      gui=none
hi MyTagListTagScope               guibg=bg      guifg=#595959 gui=none

" NERDTree
hi! link NERDTreePart              NonText
hi! link NERDTreePartFile          NonText
hi! link NERDTreeFile              Normal
hi! link NERDTreeExecFile          Normal
hi! link NERDTreeDirSlash          Blank
hi! link NERDTreeClosable          NonText
hi! link NERDTreeBookmarksHeader   Statement
hi! link NERDTreeBookmarksLeader   Blank
hi! link NERDTreeBookmarkName      Normal
hi! link NERDTreeBookmark          Blank
hi! link NERDTreeHelp              Comment
hi! link NERDTreeHelpKey           Comment
hi! link NERDTreeHelpCommand       Identifier
hi! link NERDTreeHelpTitle         Normal
hi! link NERDTreeToggleOn          Type
hi! link NERDTreeToggleOff         Type
hi! link NERDTreeDir               Directory
hi! link NERDTreeUp                Type
hi! link NERDTreeCWD               Comment
hi! link NERDTreeLink              Normal
hi! link NERDTreeOpenable          NonText
hi! link NERDTreeFlag              Blank
hi! link NERDTreeRO                Normal
hi! link NERDTreeCurrentNode       Normal

" CtrlP
hi! link CtrlPNoEntries ErrorMsg
hi! link CtrlPMatch     IncSearch
hi! link CtrlPLinePre   Comment
hi! link CtrlPPrtBase   Comment
hi! link CtrlPPrtText   Function
hi! link CtrlPPrtCursor PmenuSel
hi! link CtrlPTabExtra  Comment
hi! link CtrlPBufName   Function
hi! link CtrlPTagKind   Type
hi! link CtrlPqfLineCol Comment
hi! link CtrlPUndoT     Normal
hi! link CtrlPUndoBr    Normal
hi! link CtrlPUndoNr    Normal
hi! link CtrlPUndoSv    Comment
hi! link CtrlPUndoPo    Comment
hi! link CtrlPBookmark  Identifier
hi! link CtrlPMode1     StatusLine
hi! link CtrlPMode2     StatusLine
hi! link CtrlPStats     Function
