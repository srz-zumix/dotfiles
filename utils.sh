#!/bin/sh

lower() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

ostype() {
    uname | lower
}

os_detect() {
    export OS_DETECT_PLATFORM
    case "$(ostype)" in
        *'linux'*)  OS_DETECT_PLATFORM='linux'   ;;
        *'darwin'*) OS_DETECT_PLATFORM='osx'     ;;
        *'bsd'*)    OS_DETECT_PLATFORM='bsd'     ;;
        *'msys'*)   OS_DETECT_PLATFORM='windows' ;;
        *'cygwin'*) OS_DETECT_PLATFORM='windows' ;;
        *'mingw'*)  OS_DETECT_PLATFORM='windows' ;;
        *)          OS_DETECT_PLATFORM='unknown' ;;
    esac
}

is_osx() {
    os_detect
    if [ "$OS_DETECT_PLATFORM" = "osx" ]; then
        return 0
    else
        return 1
    fi
}
alias is_mac=is_osx

is_linux() {
    os_detect
    if [ "$OS_DETECT_PLATFORM" = "linux" ]; then
        return 0
    else
        return 1
    fi
}

is_windows() {
    os_detect
    if [ "$OS_DETECT_PLATFORM" = "windows" ]; then
        return 0
    else
        return 1
    fi
}

sh_detect() {
  export SHELL_TYPE
  version=$(set | grep -ai version)
  case "$version" in
    *'BASH'*)  SHELL_TYPE='bash'   ;;
    *'ZSH'*)   SHELL_TYPE='zsh'    ;;
  esac
}

is_bash() {
  sh_detect
  if [ "$SHELL_TYPE" = "bash" ]; then
      return 0
  else
      return 1
  fi
}

is_zsh() {
  sh_detect
  if [ "$SHELL_TYPE" = "zsh" ]; then
      return 0
  else
      return 1
  fi
}

has_zsh() {
  if (type "zsh" > /dev/null 2>&1); then
    return 0
  else
    return 1
  fi
}
