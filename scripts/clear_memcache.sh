#!/bin/bash

ARGS='--servers='
SERVERS=( drupal01.zappos.net drupal02.zappos.net drupal03.zappos.net )
SERVER_LENGTH=$((${#SERVERS[@]} - 1))

case "$1" in
  drupal)
    PORT=11211
    ;;
  zetadrupal)
    PORT=11212
    ;;
  vipdrupal2)
    PORT=11213
    ;;
  6pmdrupal)
    PORT=11214
    ;;
  *)
    echo "The site $1 does not exist. I go bye bye."
    exit
esac

for SERVER in "${SERVERS[@]}"; do
  PREFIX=''
  if [ $SERVER != ${SERVERS[$SERVER_LENGTH]} ]; then
    PREFIX=,
  fi

  ARGS="$ARGS$SERVER:$PORT$PREFIX"
done

memflush $ARGS
echo "The cache has been cleared on $1"
