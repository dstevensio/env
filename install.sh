#!/bin/bash

ENV_DIR=/Users/gberger/env
ENV_FILES=`ls -a $ENV_DIR`
EXCLUDED_FILES=( . .. install.sh .bashrc .git )
ENDS_WITH=( swp )
TARGET_DIR=~/

for f in $ENV_FILES; do
  filename=$(basename $f)

  if [ -f $filename -o -d $filename ]; then
    create_symlink=true

    for ef in "${EXCLUDED_FILES[@]}"; do
      if [ $filename == $ef ]; then
        create_symlink=false
        break
      fi
    done

    if $create_symlink; then
      for ew in "${ENDS_WITH[@]}"; do
        if [ ${filename##*.} == $ew ]; then
          create_symlink=false
          break
        fi
      done
    fi

    if $create_symlink; then
      symlink=$TARGET_DIR$filename

      if [ ! -h $symlink ]; then
        ln -s $ENV_DIR/$f $symlink
        echo "Symlink created for $f"
      fi
    fi
  fi
done

