# .bashrc

# User specific aliases and functions

# dotfiles config
if [ -f ~/.dotfiles_config ]; then
  . ~/.dotfiles_config
fi

# load utils
. ${DOTFILES_ROOT}/utils.sh

# environments
export HISTCONTROL=ignoreboth
export HISTIGNORE=history:echo:'#*'

# dotnet optout
export DOTNET_CLI_TELEMETRY_OPTOUT=1

if is_windows; then
  . "${DOTFILES_ROOT}/windows/.bashrc"
fi
if is_osx; then
  . "${DOTFILES_ROOT}/osx/.bashrc"
fi

# aliases
alias github-ssh-keygen="ssh-keygen -t rsa -b 4096 -C `git config user.email`"
alias docker-cleanbuild="docker build --no-cache=true"
alias docker-nsenter="docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"

function docker-tags {
  curl -s https://registry.hub.docker.com/v1/repositories/$1/tags | jq -r '.[].name'
}
function docker-rmi-tags {
  docker images | grep $1 | awk '{print $2}' | xargs -I{} docker rmi $1:{}
}

# added by travis gem
[ ! -s ~/.travis/travis.sh ] || source ~/.travis/travis.sh

# Drone.io
export DRONE_SERVER=https://cloud.drone.io

# Dockerhub
export DOCKERHUB_USER_NAME=srzzumix
# export DOCKERHUB_USER_PASS=

alias sshls='grep "^Host " ~/.ssh/config | sed s/"^Host "//'
alias export_dotenv="set -a; source .env; set +a;"
. "$HOME/.cargo/env"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# user local settings
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi
