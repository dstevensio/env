#!/bin/bash

BIN_DIR=/usr/local/bin/
BIN_FILES=~/scripts/bin/*

for f in $BIN_FILES; do
  fullpath=$(basename $f)
  filename=${fullpath%.*}
  symlink=$BIN_DIR$filename
  file_found=false

  if [ ! -h $symlink ]; then
    sudo ln -s $f $symlink
    echo "Symlink has been created for $filename"
    file_found=true
  fi
done

if ! $file_found; then
  echo "No files were added to the bin directory"
fi

