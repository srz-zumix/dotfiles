#!/bin/sh

# for bash

backup .bashrc
backup .bash_profile

make_link .bashrc
make_link .bash_profile

# for zsh
function zshconfig() {
    backup .zprofile
    backup .zshrc
    backup .zpreztorc

    make_link .zprofile
    make_link .zshrc
    make_link .zpreztorc
}
if has_zsh; then
    zshconfig
fi
