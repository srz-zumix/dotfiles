#!/bin/sh

cmd /c start exec_ps1.bat

# CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
# cd "${CUR_DIR}/ps1"
# powershell -NoProfile -ExecutionPolicy unrestricted -Command "Start-Process PowerShell.exe -Verb runas setup.ps1"
