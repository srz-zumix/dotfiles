#!/bin/sh

CURRENT=$(cd $(dirname $0) && pwd)
ln -sf ${CURRENT}/.omnisharp ~/.omnisharp
