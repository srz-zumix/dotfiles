# .bash_profile

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
. "$HOME/.cargo/env"
