#!/bin/bash

# Environment variables
database=$1
dump_date=`TZ=EST26EDT date +%Y-%m-%d`
sql_dump="${database}_${dump_date}.sql"
user=`whoami`
local_filepath="/Users/${user}/tmp"

# Remote variables
remote_host=prelive.zappos.net
remote_filepath="/mnt/lfdb/${sql_dump}"

# Local variables
mysql_path="/usr/local/mysql/bin/mysql"
db_user="root"
db_password="19GdB*82"

function init_check {
  # Check to see if a database has been passed in
  if [ ! -n $database ]; then
    echo "* Hey stupid, specific a database in the first parameter"
    exit
  fi

  # Create tmp in home directory
  echo "* Creating tmp in home directory"
  if [ ! -d $local_filepath ]; then
    mkdir $local_filepath
  fi
}

function fetch_dump {
  # Pull down most recent SQL dump
  echo "* Fetching the SQL Dump"
  scp -C $user@$remote_host:$remote_filepath $local_filepath
}

function mysql_setup {
  # Log into mysql and source that sucker
  echo "* Preparing mysql to source the SQL Dump"
  $mysql_path -u$db_user -p$db_password << eof
set global max_allowed_packet=1000000000;
set global net_buffer_length=1000000;
create database if not exists $database;
use $database;
source $local_filepath/$sql_dump;
eof

  echo "* We all good?"
}

function main {
  init_check
  fetch_dump
  mysql_setup
}

main
