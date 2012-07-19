ターミナルの配色設定を plist から読んで背景色の明るさに応じて $TERMINAL_BACKGROUND を設定すればよさそう

$HOME/.MacOSX/environment.plist (Lion以降は $HOME/.launchd.conf) で設定できる

## iTerm.app

    plist['New Bookmark'][0]['Background Color']

defaults コマンドで配列にどうやってアクセスしたらいいかわからない

## Terminal.app

    plist['Window Settings'][$setting_name]['Background Color']
    plist['Default Window Setting']

