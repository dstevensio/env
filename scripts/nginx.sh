#!/bin/bash          
PID=/usr/local/nginx/logs/nginx.pid
NGINXEXEC=/usr/local/nginx/sbin/nginx

function start_nginx {
  echo Starting nginx....
  sudo $NGINXEXEC
  echo And so it begins....
}

function stop_nginx {
  echo Stopping nginx....
  NGINXPID=$(cat $PID)
  sudo kill $NGINXPID
  echo Stopped!
}

function message {
  if [ $1 = 'stop' ]; then
    PRED=not
  else
    PRED=already
  fi
  echo It seems nginx is $PRED running so I can\'t $1 it. Bye...
  exit
}

case $1 in
  restart)
    if [ ! -f $PID ]; then
      message restart
    else
      stop_nginx
      start_nginx
    fi
  ;;
  start)
    if [ -f $PID ]; then
      message start
    else
      start_nginx
    fi
    ;;
  stop)
    if [ ! -f $PID ]; then
      message stop
    else
      stop_nginx
    fi
    ;;
esac

