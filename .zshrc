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
