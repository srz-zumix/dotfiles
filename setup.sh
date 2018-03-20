#!/bin/sh

CURRENT=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
ln -sf ${CURRENT}/.omnisharp ~/.omnisharp
