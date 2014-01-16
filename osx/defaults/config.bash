#!/usr/bin/env bash

# Dock {{{
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock mineffect scale
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock no-glass -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mouse-over-hilite-stack -bool true
defaults write com.apple.dock show-process-indicator -bool false
defaults write com.apple.dock dashboard-in-overlay -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dashboard mcx-disabled -bool true
# }}}
# Time Machine {{{
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
sudo tmutil disablelocal
# }}}
# Appearance {{{
defaults write -g AppleAquaColorVariant -int 6 # Graphite
defaults write -g AppleEnableMenuBarTransparency -bool false
defaults write -g AppleShowScrollBars -string 'Automatic'
# }}}
# Finder {{{
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'
defaults write com.apple.finder QLEnableXRayFolders -bool true
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nslv"
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
# }}}
# Screen Saver {{{
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# }}}
# Trackpad {{{
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool true
# }}}
# Activity Monitor.app {{{
defaults write com.apple.ActivityMonitor IconType -int 4
# }}}
# App Store {{{
defaults write com.apple.appstore ShowDebugMenu -bool true
# }}}

defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable full-keyboard access (enable tab-key to focus all UI control items)
defaults write -g AppleKeyboardUIMode -int 3

defaults write -g com.apple.keyboard.fnState -bool true

defaults write -g NSQuitAlwaysKeepsWindows -bool false

# Huge moust pointer
defaults write com.apple.universalaccess mouseDriverCursorSize -int 4

# http://www.defaults-write.com/increase-the-speed-of-os-x-dialogs-boxes/#.UfSW3GSsgy4
defaults write -g NSWindowResizeTime -float 0.001

# Save to disk (not to iCloud)
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Disable standby mode
sudo pmset -a standbydelay 86400 # 24 hours
