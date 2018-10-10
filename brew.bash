#!/bin/bash

set -e

brew update

# essentials
brew install awscli
brew install colordiff
brew install coreutils
brew install curl
brew install direnv
brew install docker-completion
brew install docker-compose-completion
brew install envchain
brew install exa
brew install --HEAD motemen/furoshiki2/furoshiki2
brew install git --with-curl
brew install tar
brew install go
brew install hub
brew install jq
brew install mackerelio/mackerel-agent/mackerel-agent
brew install mackerelio/mackerel-agent/mkr
brew install neovim
brew install peco
brew install proctools
brew install pstree
brew install reattach-to-user-namespace
brew install ripgrep
brew install slackcat
brew install sshutltle
brew install telnet
brew install tig
brew install tmux
brew install tree
brew install zsh --without-etcdir
brew install zsh-completions
brew install zsh-history-substring-search
brew install zsh-syntax-highlighting

# extra
brew install graphviz
brew install mysql-client
brew install openssl
brew install itchyny/rexdep/rexdep
brew install sbt

# casks
brew cask install alfred
brew cask install docker
brew cask install dropbox
brew cask install google-chrome-dev
brew cask install gyazo
brew cask install iterm2
brew cask install karabiner-elements
brew cask install slack
brew cask install visual-studio-code
