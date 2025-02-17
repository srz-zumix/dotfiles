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
brew install coreutils
brew install pyenv
brew install go
brew install gh
brew install git-filter-repo
brew install grep
brew install jq
brew install peco
brew install git-filter-repo
brew install direnv
brew install aria2
brew install reviewdog/tap/reviewdog 
brew install pre-commit
brew install pwgen
brew install tfenv
brew install xcodes
brew install --cask docker
brew install --cask google-cloud-sdk
brew install aquaproj/aqua/aqua
brew install asdf

brew install "${ROOT_DIR}/packages/brew/sshpass.rb"

# dotnet
brew tap isen-ng/dotnet-sdk-versions
brew install --cask dotnet
# brew install --cask dotnet-sdk7-0-400
# brew install --cask dotnet-sdk6-0-400

# node-js
brew install nodenv

# karabiner-elements
brew install --cask karabiner-elements
rm -f ~/.config/karabiner/karabiner.json
ln -s "${ROOT_DIR}/osx/karabiner.json" ~/.config/karabiner/karabiner.json 2>/dev/null || true

function install_for_zsh() {
  if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi
  if is_zsh; then
    setopt EXTENDED_GLOB
  fi
  for rcfile in `find "${ZDOTDIR:-$HOME}"/.zprezto/runcoms -maxdepth 1 -type f | grep -v README.md`; do
    RCFILE_NAME=$(basename $rcfile)
    [ ! -f "${ZDOTDIR:-$HOME}/.${RCFILE_NAME}" ] && ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${RCFILE_NAME}"
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

# java
brew install --cask temurin
brew install jenv
jenv enable-plugin export
jenv add "$(/usr/libexec/java_home)"
jenv global "$(jenv versions | grep temurin | head -1 | awk '{print $1}')"

# goenv
git clone https://github.com/syndbg/goenv.git ~/.goenv

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

cargo install typos-cli
go install github.com/client9/misspell/cmd/misspell@latest

# disable spotlight
sudo mdutil -a -i off
