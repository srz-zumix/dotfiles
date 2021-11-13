#!/bin/sh

# $ROOT_DIR/packages/install.sh

function install() {
  powershell -NoProfile -ExecutionPolicy unrestricted -Command "Start-Process PowerShell.exe -Verb runas -wait \"winget install --silent --id $1\""
}

install GitHub.cli
