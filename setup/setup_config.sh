#!/bin/sh

SETUP_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
ROOT_DIR=$(dirname $SETUP_DIR)
BACKUP_DIR=$ROOT_DIR/backup
TMP_DIR=$ROOT_DIR/tmp

. $ROOT_DIR/utils.sh

if [[ "$SETUP_DIR" =~ ^/cygdrive ]]; then
  ROOT_DIR=$(cygpath -m $SETUP_DIR)
fi

if is_windows; then
  if [[ "$ROOT_DIR" =~ ^/[a-zA-Z]/ ]]; then
    ROOT_DIR=$(echo $ROOT_DIR | sed "s|/\([a-zA-Z]\)/|\\1:/|g")
  fi
fi

echo $ROOT_DIR

. $ROOT_DIR/setup/util/tools.sh

setup() {
  mkdir $TMP_DIR
}
teardown() {
  rm -rf $TMP_DIR
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
    if is_windows; then
      export MSYS=winsymlinks:nativestrict
      ln -snf $ROOT_DIR/$1 ~/
      # (cd ~/ && mklink /H $1 $ROOT_DIR/$1)
    else
      ln -snf $ROOT_DIR/$1 ~/
    fi
}
