
if is_zsh; then
#  export PROMPT='%F{cyan}%n:%f%F{green}%d%f [%m] %%'
  export PS1="%10F%m%f:%11F%1~%f \$ "
fi

if is_bash; then
  . /usr/local/etc/bash_completion.d/git-prompt.sh
  . /usr/local/etc/bash_completion.d/git-completion.bash

  GIT_PS1_SHOWDIRTYSTATE=true
  export PS1='\h:\W \[\033[32m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
fi

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# pyenv
PATH="$HOME/.pyenv/shims:$PATH"
eval "$(pyenv init -)"

# nodebrew
# export PATH=${HOME}/.nodebrew/current/bin:${PATH}

if which nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi

# go
PATH="$(go env GOPATH)/bin:$PATH"
