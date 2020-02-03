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

    make_link .zprofile
    make_link .zshrc
}
if !(type "zsh" > /dev/null 2>&1); then
    zshconfig
fi
