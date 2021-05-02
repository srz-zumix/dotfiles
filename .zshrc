# .zshrc

if [ -f ~/.zprezto/runcoms/zshrc ]; then
  . ~/.zprezto/runcoms/zshrc
fi

# user .bashrc settings
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

HISTFILE=$HOME/.zsh-history
HISTSIZE=110000
SAVEHIST=100000

zstyle ':prezto:module:git:status:ignore' submodules dirty

# export LSCOLORS=exfxcxdxbxGxDxabagacad
export LSCOLORS=gxfxcxdxbxGxDxabagacad
