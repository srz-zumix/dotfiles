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
# macOS Catalina default shell zsh
brew install bash

brew cask install karabiner-elements
