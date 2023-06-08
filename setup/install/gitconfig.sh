#!/bin/sh

backup .gitconfig

if [ -z $(git config --global user.name)]; then
  git config --global user.name dummy
fi
if [ -z $(git config --global user.email)]; then
  git config --global user.email dummy
fi

function git_config_update() {
  for f in `find $ROOT_DIR/$1 -type f -name '*.config'`; do
      echo $f
      while read line; do
          if [[ -z $line ]]; then
            continue
          fi
          if [[ $line =~ ^\[.*\] ]]; then
              tag_=`echo ${line} | cut -d"[" -f2 | cut -d"]" -f1`
              tag=`echo ${tag_} | cut -d" " -f1`
              if [[ $tag_ =~ \".*\" ]]; then
                subtag=`echo ${tag_} | cut -d" " -f2-`
                tag+=.`echo ${subtag//\"}`
              fi
          else
              if [[ $line =~ "^#" ]]; then
                # comment=`echo ${line} | cut -d"=" -f2- | cut -d"#" -f2-`
                echo $line
              else
                command=`echo ${line} | cut -d"=" -f1`
                raw__=`echo ${line} | cut -d"=" -f2-`
                # raw__=`echo ${line} | cut -d"=" -f2- | cut -d"#" -f1`
                raw_=${raw__## }
                raw=${raw_% }
                if [[ $raw =~ ^\".*\"$ ]]; then
                  value_=${raw#\"}
                  value=${value_%\"}
                else
                  value=$raw
                fi
                # comment=`echo ${line} | cut -d"=" -f2- | cut -d"#" -f2-`
                echo $tag.$command $value $comment
                git config --global --replace-all "$tag".$command "${value}"
              fi
          fi
      done < $f
  done
}

git_config_update git/config

if is_windows; then
  git_config_update git/windows/config
fi

if is_osx; then
  # brew tap jgavris/rs-git-fsmonitor https://github.com/jgavris/rs-git-fsmonitor.git && brew install rs-git-fsmonitor
  git_config_update git/osx/config
  ln -s $ROOT_DIR/osx/.gitconfig_for_homebrew_tap ~/.gitconfig_for_homebrew_tap 2>/dev/null || true
fi

# git-delete-squashed
# npm install --global git-delete-squashed

function zsh_gitconfig() {
  if [ ! -d ~/.zsh ]; then
    mkdir ~/.zsh
  fi
  if [ ! -d ~/.zsh/completion ]; then
    mkdir ~/.zsh/completion/
  fi
  curl -s -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
  curl -s -O https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
  mv git-completion.bash ~/.zsh/completion/git-completion.bash
  mv git-completion.zsh ~/.zsh/completion/_git

}
if has_zsh; then
    zsh_gitconfig
fi

git config --global lfs.storage ${HOME}/.lfs_cache

if [ -f ~/.mailmap ]; then
  git config --global mailmap.file ${HOME}/.mailmap
fi

PARENT_DIR=$(dirname "${ROOT_DIR}")
git config --global includeIf."gitdir:${PARENT_DIR}/**".path "~/.gitconfig_me"
ln -s $ROOT_DIR/git/.gitconfig_me ~/.gitconfig_me 2>/dev/null || true

ln -s ~/.gitconfig $ROOT_DIR/.gitconfig 2>/dev/null || true
