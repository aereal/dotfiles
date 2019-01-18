#!/bin/bash

set -e

brew_install() {
  brew install $@ || :
}

brew update

export HOMEBREW_NO_AUTO_UPDATE=1

# essentials
brew_install awscli
brew_install colordiff
brew_install coreutils
brew_install curl
brew_install direnv
brew_install docker-completion
brew_install docker-compose-completion
brew_install envchain
brew_install exa
brew_install --HEAD motemen/furoshiki2/furoshiki2
brew_install git --with-curl
brew_install gnu-tar
brew_install go
brew_install hub
brew_install jq
brew_install mackerelio/mackerel-agent/mackerel-agent
brew_install mackerelio/mackerel-agent/mkr
brew_install neovim
brew_install peco
brew_install proctools
brew_install pstree
brew_install reattach-to-user-namespace
brew_install ripgrep
brew_install slackcat
brew_install sshuttle
brew_install telnet
brew_install tig
brew_install tmux
brew_install tree
brew_install zsh --without-etcdir
brew_install zsh-completions
brew_install zsh-history-substring-search
brew_install zsh-syntax-highlighting

# extra
brew_install graphviz
brew_install mysql-client
brew_install openssl
brew_install itchyny/rexdep/rexdep

# casks
brew cask install alfred
brew cask install docker
brew cask install dropbox
brew cask install homebrew/cask-versions/google-chrome-dev
brew cask install gyazo
brew cask install iterm2
brew cask install karabiner-elements
brew cask install mattr-slate
brew cask install slack
brew cask install visual-studio-code

# JDK-related
brew cask install homebrew/cask-versions/java8
brew_install sbt
