" exclude `--foo)` matches from within `$(cmd --foo)`
syntax match shOption "\s\zs--[^ \t$`'"|)]\+"
