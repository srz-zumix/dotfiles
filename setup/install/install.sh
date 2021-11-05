#!/bin/sh

if is_osx; then
  . $ROOT_DIR/setup/install/osx/install.sh
fi
if is_windows; then
  . $ROOT_DIR/setup/install/windows/install.sh
fi
