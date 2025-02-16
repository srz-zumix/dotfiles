UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
  HOMEBREW_PREFIX_PATH=/opt/homebrew
else
  HOMEBREW_PREFIX_PATH=/usr/local
fi

eval "$(${HOMEBREW_PREFIX_PATH}/bin/brew shellenv)"

# PS1
if is_bash; then
  . "${HOMEBREW_PREFIX_PATH}/etc/bash_completion.d/git-prompt.sh"
  . "${HOMEBREW_PREFIX_PATH}/etc/bash_completion.d/git-completion.bash"

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
if [[ -d "~/.rbenv" ]]; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init -)"
fi

# pyenv
PATH="$HOME/.pyenv/shims:$PATH"
if which pyenv > /dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# nodebrew
# export PATH=${HOME}/.nodebrew/current/bin:${PATH}

PATH="$HOME/.nodenv/bin:$PATH"
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

# ocaml/opam
if [[ -r "${HOME}/.opam/opam-init/init.zsh" ]]; then
  source "${HOME}/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null
fi
if which opam > /dev/null; then
  eval $(opam env)
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

# vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# rider
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# java home
export JAVA_HOME="$(/usr/libexec/java_home)"

# Slack
alias slack-devtool="SLACK_DEVELOPER_MENU=true open -a /Applications/Slack.app"

# asdf
if which asdf > /dev/null; then
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  if is_bash; then
    eval "$(asdf completion bash)"
  fi
fi
