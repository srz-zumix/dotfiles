#!/bin/sh

gem_install() {
  gem list | grep $1 2>/dev/null || gem install $1
}
