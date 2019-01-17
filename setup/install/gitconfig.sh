#!/bin/sh

if [ ! -f $BACKUP_DIR/.gitconfig ]; then
    cp ~/.gitconfig $BACKUP_DIR/.gitconfig
fi

for f in `find $ROOT_DIR/git/config -type f -name '*.config'`; do
    echo $f
    while read line; do
        if [[ $line =~ ^\[.*\]$ ]] ;
        then
            tag=`echo ${line%]} | cut -c 2-`
        else
            echo $tag
        fi
    done < $f
done
