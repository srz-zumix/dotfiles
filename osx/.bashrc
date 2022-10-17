
# PS1
if is_bash; then
  . /usr/local/etc/bash_completion.d/git-prompt.sh
  . /usr/local/etc/bash_completion.d/git-completion.bash

  GIT_PS1_SHOWDIRTYSTATE=true
fi

function default_ps1() {
  if is_zsh; then
  #  export PROMPT='%F{cyan}%n:%f%F{green}%d%f [%m] %%'
    export PS1="%10F%m%f:%11F%1~%f \$ "
  fi

  if is_bash; then
    export PS1='\h:\W \[\033[32m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
  fi
}

function no_host_ps1() {
  if is_zsh; then
  #  export PROMPT='%F{cyan}%n:%f%F{green}%d%f [%m] %%'
    export PS1="%11F%1~%f \$ "
  fi

  if is_bash; then
    export PS1='\W \[\033[32m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
  fi  
}

default_ps1

# rbenv
[[ -d ~/.rbenv ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# pyenv
PATH="$HOME/.pyenv/shims:$PATH"
if which pyenv > /dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# nodebrew
# export PATH=${HOME}/.nodebrew/current/bin:${PATH}

if which nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi

# go
PATH="$(go env GOPATH)/bin:$PATH"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
if which goenv > /dev/null; then
  eval "$(goenv init -)";
fi

# ponyup
PATH="${HOME}/.local/share/ponyup/bin:$PATH"

# rust/cargo
. "$HOME/.cargo/env"

# direnv
if which direnv > /dev/null; then
  eval "$(direnv hook bash)"
fi

# binutils
# export PATH="/usr/local/opt/binutils/bin:$PATH"
