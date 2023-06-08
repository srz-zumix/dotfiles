#!/bin/sh

set -euo pipefail

. setup/setup_config.sh

IPADDR=$1
PASSWORD=${2:-}

if [ -z "${PASSWORD}" ]; then
  read -p "password: " PASSWORD
fi


function scp_sshkey() {
  PUB=$1
  IPADDR=$2
  PASSWORD=$3
  PRV=${PUB%.pub}
  if [ ! -f "${HOME}/.ssh/${PUB}" ]; then
    sshpass -p "${PASSWORD}" scp "${IPADDR}:~/.ssh/${PUB}" "${HOME}/.ssh"
    echo "copied ~/.ssh/${PUB}"
  fi
  if [ ! -f "${HOME}/.ssh/${PRV}" ]; then
    sshpass -p "${PASSWORD}" scp "${IPADDR}:~/.ssh/${PRV}" "${HOME}/.ssh"
    echo "copied ~/.ssh/${PRV}"
  fi
}

export -f scp_sshkey

function on_exit() {
  true
}
trap 'on_exit' EXIT

SRC_HOSTNAME=$(sshpass -p "${PASSWORD}" ssh "${IPADDR}" hostname)

COPIED_MARKER="# dotfiles: Copied from ${SRC_HOSTNAME}"
COPIED_MARKER_BEGIN="${COPIED_MARKER} :: begin"
COPIED_MARKER_END="${COPIED_MARKER} :: end"

sshpass -p "${PASSWORD}" ssh "${IPADDR}" git config user.name | xargs -I{} git config --global user.name {} 
sshpass -p "${PASSWORD}" ssh "${IPADDR}" git config user.email | xargs -I{} git config --global user.email {} 

function home_config() {
  FILENAME=$1
  if [ ! -f "~/${FILENAME}" ]; then
    sshpass -p "${PASSWORD}" scp "${IPADDR}:~/${FILENAME}" "${HOME}"
  fi
}

home_config .mailmap
home_config .gitconfig_local
home_config .bashrc_local
home_config .actrc


if ! grep "${COPIED_MARKER}" ~/.ssh/config >/dev/null 2>/dev/null; then
  echo "${COPIED_MARKER_BEGIN}" >> ~/.ssh/config
  sshpass -p "${PASSWORD}" ssh "${IPADDR}" cat ~/.ssh/config >> ~/.ssh/config
  echo "${COPIED_MARKER_END}" >> ~/.ssh/config
fi

sshpass -p "${PASSWORD}" ssh "${IPADDR}" ls ~/.ssh \
  | grep .pub \
  | peco --prompt "Select Copy sshkey" --rcfile "${ROOT_DIR}/peco/config.json" \
  | xargs -I{} bash -c "scp_sshkey {} \"${IPADDR}\" \"${PASSWORD}\""

echo ok
