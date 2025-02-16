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
export _DOTNET_ROOT=/usr/local/share/dotnet/
export DOTNET_ROOT=$_DOTNET_ROOT
export DOTNET_ROOT_ARM64=$_DOTNET_ROOT
# export DOTNET_ROOT_X64=$_DOTNET_ROOT
export PATH=$PATH:$_DOTNET_ROOT:$_DOTNET_ROOT/tools

# powershell
export POWERSHELL_TELEMETRY_OPTOUT=1
# brew
export HOMEBREW_NO_ANALYTICS=1

# aqua
export PATH="$(aqua root-dir)/bin:$PATH"

# gh
if is_bash; then
  eval "$(gh completion -s bash)"
  eval "$(gh copilot alias -- bash)" || :
fi
if is_zsh; then
  eval "$(gh completion -s zsh)"
  eval "$(gh copilot alias -- zsh)" || :
fi

# user local settings
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi
