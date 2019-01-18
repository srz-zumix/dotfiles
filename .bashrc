# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# environments
export HISTCONTROL=ignoreboth

# aliases
alias docker-toolbox-env='eval "$("docker-machine" env --shell=bash --no-proxy "default")"'
