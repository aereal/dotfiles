#!/bin/bash

set -e

brew update-if-needed

export HOMEBREW_NO_INSTALL_CLEANUP=1

echo '-> install casks' >&2
brew install --cask \
  1password-cli \
  aquaskk \
  fantastical \
  font-cascadia-code \
  font-hackgen \
  google-cloud-sdk \
  ghostty \
  hammerspoon \
  karabiner-elements \
  kensingtonworks \
  rancher \
  slack \
  visual-studio-code \
  vivaldi \
  witch

echo '-> install formulae' >&2
brew install --formula \
  aqua \
  awscli \
  bat \
  coreutils \
  curl \
  direnv \
  eza \
  fzf \
  gh \
  ghq \
  git \
  gnu-sed \
  gnu-tar \
  go \
  jq \
  ko \
  mise \
  moreutils \
  mysql-client \
  openssh \
  pinact \
  postgresql@16 \
  proctools \
  readline \
  reattach-to-user-namespace \
  ripgrep \
  shared-mime-info \
  tig \
  tmux \
  tree \
  zsh \
  zsh-completions \
  zsh-history-syntax-highlight
