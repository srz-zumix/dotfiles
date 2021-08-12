# .bashrc

# User specific aliases and functions

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
export HISTIGNORE=history:echo:'#*'

if is_windows; then
  . ${DOTFILES_ROOT}/windows/.bashrc
fi
if is_osx; then
  . ${DOTFILES_ROOT}/osx/.bashrc
fi

# aliases
alias github-ssh-keygen="ssh-keygen -t rsa -b 4096 -C `git config user.email`"
alias docker-cleanbuild="docker build --no-cache=true"
alias docker-nsenter="docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
export KENYA_REF_PARENT=/Users/takazumi.shirayanagi/usr/local/ddd/kenya

# Drone.io
export DRONE_SERVER=https://cloud.drone.io

# Dockerhub
export DOCKERHUB_USER_NAME=srzzumix
# export DOCKERHUB_USER_PASS=

alias sshls='grep "^Host " ~/.ssh/config | sed s/"^Host "//'
alias export_dotenv="set -a; source .env; set +a;"
