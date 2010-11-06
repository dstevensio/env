#!/bin/bash

FRONTEND=~/zeta/zeta-platform/zeta-web/src/main/frontend/
FILES=( css/* styles/* styles/z/* js/* js/z* )
SITE=zappos.com

if [ $1 != '' ]; then
  SITE=$1
fi

cd $FRONTEND$SITE

for file in ${FILES[@]}; do
  if [ -f $file ]; then
    touch $file
    echo "I touch $FRONTEND$SITE$file"
  fi
done

