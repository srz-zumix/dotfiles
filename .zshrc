# .zshrc

# user .bashrc settings
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

HISTFILE=$HOME/.zsh-history
HISTSIZE=110000
SAVEHIST=100000

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
