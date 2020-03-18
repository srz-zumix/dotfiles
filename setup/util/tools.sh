#!/bin/sh

gem_install() {
  gem list | grep $1 2>/dev/null || gem install ${@:2:($#-1)} $1
}

brew_install() {
  brew list $1 &>/dev/null || brew install ${@:2:($#-1)} $1
}
