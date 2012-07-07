#!/bin/bash

# フルキーボードアクセスを有効にする (Tabですべてのコントロールにフォーカスできるようになる)
defaults write -g AppleKeyboardUIMode -int 3

# Dockを自動的に隠す
defaults write com.apple.dock autohide -bool true

# Dockをすぐに表示する
defaults write com.apple.dock autohide-delay -float 0

# Dockを2D表示に
defaults write com.apple.dock no-glass -bool true

# 最小化されたアプリケーションのアイコンは透過させる
defaults write com.apple.dock showhidden -bool true

# Dockを拡大する
defaults write com.apple.dock magnification -bool true

# スタックをハイライト表示する
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# 実行中のアプリケーションにインジケータを表示しないように
defaults write com.apple.dock show-process-indicator -bool false

# アンチエイリアスを有効に
defaults -currentHost write -g AppleFontSmoothing -int 3

# メニューバーを透過させないように
defaults write -g AppleEnableMenuBarTransparency -bool false

# スクロールバーはデバイスに応じて自動的に
defaults write -g AppleShowScrollBars -string 'Automatic'

# Finder
# 拡張子を常に表示する
defaults write -g AppleShowAllExtensions -bool true

# Finderで検索するときは現在のディレクトリ以下から
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'

# ファイルに保存ダイアログは常に展開
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true

# インターネットからダウンロードしたアプリケーションに実行ダイアログを表示しない
defaults write com.apple.LaunchServices LSQuarantine -bool false

# 自動スペル訂正いらない
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# ディスクイメージの検証をスキップ
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# .DS_Storeをつくるな
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# 拡張子変更にうるさくいわれない
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true

# パスワードをすぐに求める
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# タップでクリック
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# ドラッグロック
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool true

# ウィンドウ状態の保存をしない
defaults write -g NSQuitAlwaysKeepsWindows -bool false

# ポインタを最大に
defaults write com.apple.universalaccess mouseDriverCursorSize -int 4

# Activity Monitor.app {{{
# Dockのアイコンをメモリ使用量に
defaults write com.apple.ActivityMonitor IconType -int 4
# }}}

# Alfred.app {{{
# ステータスバーのアイコンを隠す
defaults write com.alfredapp.Alfred appearance.hideStatusBarIcon -bool true

# 歯車アイコンを隠す
defaults write com.alfredapp.Alfred appearance.hidePreferencesCogIcon -bool true

# 帽子アイコンを隠す
defaults write com.alfredapp.Alfred appearance.hideHat -bool true

# Light theme
defaults write com.alfredapp.Alfred appearance.themeuid -string 'alfred.theme.light'

# enable eject command
defaults write com.alfredapp.Alfred system.eject -bool true
# }}}

# Divvy.app {{{
# hide menu-bar icon
defaults write com.mizage.divvy showMenuIcon -bool false

# ショートカットキーを押すたび複数ディスプレイ間を移動する
defaults write com.mizage.divvy useMonitorCycling -bool true

# 10 x 10
defaults write com.mizage.divvy defaultColumnCount -int 10
defaults write com.mizage.divvy defaultRowCount -int 10
# }}}

# Reeder.app {{{
# open links in background
defaults write com.reederapp.mac OpenLinksInBackground -bool true

# Disable services
defaults write com.reederapp.mac ServiceAlternateBrowserDisabled -bool true
defaults write com.reederapp.mac ServiceBlogDisabled -bool true
defaults write com.reederapp.mac ServiceDeliciousDisabled -bool true
defaults write com.reederapp.mac ServiceEvernoteDisabled -bool true
defaults write com.reederapp.mac ServiceGoogleMobilizerDisabled -bool true
defaults write com.reederapp.mac ServiceInstapaperDisabled -bool true
defaults write com.reederapp.mac ServiceInstapaperMobilizerDisabled -bool true
defaults write com.reederapp.mac ServiceMailLinkDisabled -bool true
defaults write com.reederapp.mac ServicePinboardDisabled -bool true
defaults write com.reederapp.mac ServiceReadabilityDisabled -bool true
defaults write com.reederapp.mac ServiceSafariReadingListDisabled -bool true
defaults write com.reederapp.mac ServiceTwitterDisabled -bool true
defaults write com.reederapp.mac ServiceZootoolDisabled -bool true

defaults write com.reederapp.mac ServiceReadItLaterShowInSiderbar -bool true
# }}}

for app in Finder Dock SystemUIServer; do killall $app >/dev/null 2>&1; done
