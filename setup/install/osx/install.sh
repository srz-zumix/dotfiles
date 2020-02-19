#!/bin/sh

if !(type "brew" > /dev/null 2>&1); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

function install_ruby() {
  brew install rbenv ruby-build

  RUBY_LATEST_VERSION=$(rbenv install -l | grep -v - | tail -1)
  rbenv install ${RUBY_LATEST_VERSION}
  rbenv global ${RUBY_LATEST_VERSION}
}

brew update

install_ruby

brew install git
brew install git-lfs
# macOS Catalina default shell zsh
brew install bash
brew install ccache
brew install pyenv

brew cask install karabiner-elements

function install_for_zsh() {
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
}

if is_zsh; then
  install_for_zsh
fi
