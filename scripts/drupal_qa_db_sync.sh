#!/bin/bash

source drupal_db_sync.sh

mysqldump_exe=/usr/local/mysql/bin/mysqldump
remote_host=10.206.190.69
remote_user=fez
remote_password=zapp0s

tmp_dir=~/tmp

sql_dump=

database=drupal

function setup_tmp_dir {
  if [ ! -d $tmp_dir ]; then
    mkdir $tmp_dir
  fi
}

function fetch_qa_dump {
  cd $tmp_dir
  $mysqldump_exe -u$remote_host -u$remote_user -p $remote_password $remote_db > $remote_db.sql
}

function main {
  mysql_setup
}

main
