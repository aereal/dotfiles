#!/bin/bash

set -e

brew_install() {
  brew install $@ || :
}

brew update

export HOMEBREW_NO_AUTO_UPDATE=1

brew_install --HEAD motemen/furoshiki2/furoshiki2
brew_install git --with-curl
brew_install zsh --without-etcdir
brew install \
  awscli \
  bat \
  colordiff \
  coreutils \
  curl \
  direnv \
  docker-completion \
  docker-compose-completion \
  envchain \
  exa \
  gnu-tar \
  go \
  hub \
  jq \
  mackerelio/mackerel-agent/mackerel-agent \
  mackerelio/mackerel-agent/mkr \
  neovim \
  peco \
  proctools \
  pstree \
  reattach-to-user-namespace \
  ripgrep \
  slackcat \
  sshuttle \
  telnet \
  tig \
  tmux \
  tree \
  zsh-completions \
  zsh-history-substring-search \
  zsh-syntax-highlighting \

# extra
brew_install graphviz
brew_install mysql-client
brew_install openssl
brew_install itchyny/rexdep/rexdep

# casks
brew install --cask alfred
brew install --cask docker
brew install --cask dropbox
brew install --cask homebrew/cask-versions/google-chrome-dev
brew install --cask gyazo
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask mattr-slate
brew install --cask slack
brew install --cask visual-studio-code

# JDK-related
brew install --cask homebrew/cask-versions/java8
brew_install sbt
