#!/bin/bash

host="localhost"
user="iama"
password="moron"
database="myshop"
tp="myshop_"

/usr/local/mysql/bin/mysql -u$user -p$password << eof
use $database
delete from ${tp}users where uid != 1;
delete from ${tp}sessions where uid != 1;
delete from ${tp}sun_tzu_profile;
delete from ${tp}authmap;
eof

echo "I think its done?"
