#!/bin/sh

SETUP_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
ROOT_DIR=$(dirname $SETUP_DIR)
BACKUP_DIR=$ROOT_DIR/backup

echo $ROOT_DIR

. $ROOT_DIR/utils.sh

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
    if [ is_windows ]; then
      export MSYS=winsymlinks:nativestrict
      ln -snf $ROOT_DIR/$1 ~/
      # (cd ~/ && mklink /H $1 $ROOT_DIR/$1)
    else
      ln -snf $ROOT_DIR/$1 ~/
    fi
}
