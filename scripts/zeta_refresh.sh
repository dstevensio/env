#!/bin/bash

dir=$1
root_war=~/tomcat/$dir/ROOT.war

if [ ! -f $root_war ]; then
  echo "* No directory was found for $dir"
else
  echo "* Touching $dir"
  touch $root_war
fi

