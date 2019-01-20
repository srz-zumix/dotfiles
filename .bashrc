# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# user local settings
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi

# dotfiles config
if [ -f ~/.dotfiles_config ]; then
	. ~/.dotfiles_config
fi

# load utils
. ${DOTFILES_ROOT}/utils.sh

# environments
export HISTCONTROL=ignoreboth

# aliases
if [ is_windows ]; then
  . ${DOTFILES_ROOT}/windows/.bashrc
fi
