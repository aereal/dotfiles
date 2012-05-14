#!/usr/bin/env sh

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

for app in Finder Dock SystemUIServer; do killall $app >/dev/null 2>&1; done
