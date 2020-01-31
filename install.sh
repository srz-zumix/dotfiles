#!/bin/sh

. setup/setup_config.sh

# make dotfiles config
echo export DOTFILES_ROOT=${ROOT_DIR} > ~/.dotfiles_config

. setup/install/install.sh
. setup/install/omnisharp.sh
. setup/install/gitconfig.sh
. setup/install/bashconfig.sh
