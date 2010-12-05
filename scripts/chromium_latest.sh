#!/bin/bash

URL=http://build.chromium.org/f/chromium/continuous/mac/LATEST/
DEST=~/Applications
CHROME=chrome-mac
FILE=chrome-mac.zip
ENABLE_MESSAGE=false

function fetch_chrome() {
  curl -O $URL$FILE
  unzip $FILE
  rm $FILE

  cd $CHROME
  curl -O "${URL}REVISION">>REVISION
  REVISION=`cat REVISION`

  echo ""
  echo "* Chromium has been updated to revision $REVISION."
}

if [ ! -d $DEST ]; then
  mkdir -p $DEST
fi

cd $DEST

if [ -d $DEST/$CHROME ]; then
  cd $CHROME
  REVISION=`cat REVISION`
  curl "${URL}REVISION">>NEW_REVISION
  NEW_REVISION=`cat NEW_REVISION`

  if [ $REVISION = $NEW_REVISION ]; then
    rm NEW_REVISION
    echo "* Your current version of Chromium ($REVISION) is up-to-date so we don't need to update."
    exit
  fi

  cd ..
  echo "* Deleting previous version of Chromium: $REVISION."
  rm -rf $CHROME
  echo "* Fetching latest version of Chromium: $NEW_REVISION."
  echo ""
  fetch_chrome
else
  fetch_chrome
fi

if $ENABLE_MESSAGE; then
  echo ""
  echo "**********************************************************************************************"
  echo "*"
  echo "* If you haven't already, add the following alias to start from the command line:"
  echo "*"
  echo "* alias chromium='~/src/chrome-mac/Chromium.app/Contents/MacOS/Chromium --enable-webgl &'"
  echo "*"
  echo "**********************************************************************************************"
fi
