source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\h:\W \[\033[32m\]$(__git_ps1 [%s])\[\033[00m\]\$ '

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"
