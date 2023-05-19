# dotfiles

## Getting Started

* create ssh key

```sh
cd ~/.ssh && ssh-keygen -t ed25519 -C "$(hostname)" -f id_github_com_srz_zumix
```

* open [SSH Keys](https://github.com/settings/keys)
* New SSH Key
* copy public key and paste

```sh
cat ~/.ssh/id_github_com_srz_zumix.pub | pbcopy
```

* set ~/.ssh/config

```sh
echo "Host github.com\n   IdentityFile ~/.ssh/id_github_com_srz_zumix" >> ~/.ssh/config && chmod 600 ~/.ssh/config
```

* clone

```sh
mkdir -p ~/usr/local/zumix && cd ~/usr/local/zumix && git clone git@github.com:srz-zumix/dotfiles.git
```

* install

```sh
cd dotfiles && ./install.sh
```
