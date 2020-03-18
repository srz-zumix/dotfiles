#!/bin/sh

if !(type "brew" > /dev/null 2>&1); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

function install_ruby() {
  brew install rbenv ruby-build

  RUBY_LATEST_VERSION=$(rbenv install -l | grep -v - | tail -1)
  rbenv install -s ${RUBY_LATEST_VERSION}
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
brew install npm

brew cask install karabiner-elements

function install_for_zsh() {
  if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi
  if is_zash; then
    setopt EXTENDED_GLOB
  fi
  for rcfile in `find "${ZDOTDIR:-$HOME}"/.zprezto/runcoms -maxdepth 1 -type f | grep -v README.md`; do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}" 2>/dev/null || true
  done

  zsh "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  ln -snf ${ZDOTDIR:-$HOME}/.zprezto $ROOT_DIR/.zprezto
}

if has_zsh; then
  install_for_zsh
fi

# font
pushd $TMP_DIR

# Source code pro
curl -sLO https://github.com/adobe-fonts/source-code-pro/archive/release.zip
unzip -q release.zip
cp -a source-code-pro-release/TTF/* ~/Library/Fonts

# Source han code jp
curl -sLO https://github.com/adobe-fonts/source-han-code-jp/archive/release.zip
unzip -q release.zip
cp -a source-han-code-jp-release/OTF/* ~/Library/Fonts
cp -a source-han-code-jp-release/OTC/* ~/Library/Fonts

popd
