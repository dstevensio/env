#!/bin/bash

ps | grep 'tomcat' | awk '{print $1}' | xargs kill -9
cd ~/tomcat
rm -rf zappos/ROOT*
rm -rf zapi/ROOT*
rm -rf 6pm/ROOT*
rm -rf vip/ROOT*
cd ~/zeta/zapi
mvn clean install -DskipTests -DbuildZetaStack -Pzappos,vip,6pm
cd ~/tomcat
bin/startup.sh

