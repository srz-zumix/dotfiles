#!/bin/sh

CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
ROOT_DIR=$(dirname $CUR_DIR)

. ${ROOT_DIR}/utils.sh

is_windows && ${CUR_DIR}/windows/install.sh
