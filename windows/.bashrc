# .bashrc for windows

# User specific aliases and functions

# aliases
alias docker-toolbox-env='eval "$("docker-machine" env --shell=bash --no-proxy "default")"'
alias pyvirtualenv='python -m virtualenv '

# search visual studio python path
VS_SHARED_ROOT="C:/Program Files (x86)/Microsoft Visual Studio/Shared"

if [ -d "$VS_SHARED_ROOT" ]; then
  if [ -f "$VS_SHARED_ROOT/Python36_64/python.exe" ]; then
    alias pyenv36='python -m virtualenv --python="$VS_SHARED_ROOT/Python36_64/python.exe"'
  fi
  if [ -f "$VS_SHARED_ROOT/Python37_64/python.exe" ]; then
    alias pyenv37='python -m virtualenv --python="$VS_SHARED_ROOT/Python37_64/python.exe"'
  fi
fi

if [ -f "c:/Python27amd64/python.exe" ]; then
  alias pyenv27='python -m virtualenv --python="c:/Python27amd64/python.exe"'
fi
