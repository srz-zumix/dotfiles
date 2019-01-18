#!/bin/sh

SETUP_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
ROOT_DIR=$(dirname $SETUP_DIR)
BACKUP_DIR=$ROOT_DIR/backup

echo $ROOT_DIR

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
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  PLATFORM='linux'   ;;
        *'darwin'*) PLATFORM='osx'     ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *'msys'*)   PLATFORM='windows' ;;
        *'cygwin'*) PLATFORM='windows' ;;
        *)          PLATFORM='unknown' ;;
    esac
}

is_osx() {
    os_detect
    if [ "$PLATFORM" = "osx" ]; then
        return 0
    else
        return 1
    fi
}
alias is_mac=is_osx

is_linux() {
    os_detect
    if [ "$PLATFORM" = "linux" ]; then
        return 0
    else
        return 1
    fi
}

is_windows() {
    os_detect
    if [ "$PLATFORM" = "windows" ]; then
        return 0
    else
        return 1
    fi
}

backup() {
    if [ ! -f $BACKUP_DIR/$1 ]; then
        if [ -f ~/$1 ]; then
            mv ~/$1 $BACKUP_DIR/$1
        else
            touch $BACKUP_DIR/$1
        fi
    fi
}

make_link() {
    ln -sf $ROOT_DIR/$1 ~/
    # if [ is_windows ]; then
    #     mklink 
    # else
    #     ln -sf $ROOT_DIR/$1 ~/
    # fi
}