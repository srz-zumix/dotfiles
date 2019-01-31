#!/bin/sh

backup .gitconfig

function git_config_update() {
  for f in `find $ROOT_DIR/$1 -type f -name '*.config'`; do
      echo $f
      while read line; do
          if [[ $line =~ ^\[.*\] ]]; then
              tag=`echo ${line} | cut -d"[" -f2 | cut -d"]" -f1`
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
                value_=${raw#\"}
                value=${value_%\"}
                # comment=`echo ${line} | cut -d"=" -f2- | cut -d"#" -f2-`
                echo $tag.$command $value $comment
                git config --global --replace-all $tag.$command "${value}"
              fi
          fi
      done < $f
  done
}

git_config_update git/config

# if [ is_windows ]; then
#   git_config_update git/windows/config
# fi