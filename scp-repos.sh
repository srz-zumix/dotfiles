#!/bin/sh

set -euo pipefail

. setup/setup_config.sh

IPADDR=$1
PASSWORD=${2:-}

if [ -z "${PASSWORD}" ]; then
  read -p "password: " PASSWORD
fi


function on_exit() {
  true
}
trap 'on_exit' EXIT

sshpass -p "${PASSWORD}" ssh "${IPADDR}" ls "~/usr/local/zumix" \
  | grep -v Temp \
  | peco --prompt "Select Copy directory" --rcfile "${ROOT_DIR}/peco/config.json" \
  | xargs -I{} sshpass -p "${PASSWORD}" scp -r "${IPADDR}:~/usr/local/zumix/{}" "${HOME}/usr/local/zumix"

echo ok
