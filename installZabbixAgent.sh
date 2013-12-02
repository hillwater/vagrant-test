#!/bin/bash

SERVER_IP=192.168.128.101
AGENT_NAME=$1
IP_KEY=__SERVER_IP__
NAME_KEY=__SERVER_NAME__
CONFIG_DEST=/etc/zabbix/zabbix_agentd.conf
CONFIG_SRC=/vagrant/zabbix_agentd.conf

#set hostname
hostname $AGENT_NAME

#install zabbix-release package
wget http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+precise_all.deb
dpkg -i zabbix-release_2.2-1+precise_all.deb

#install zabbix agent
apt-get update
apt-get install zabbix-agent

#config file
cp -f $CONFIG_SRC $CONFIG_DEST

#replace server ip
sed -i 's/'"$IP_KEY"'/'"$SERVER_IP"'/g' $CONFIG_DEST

#replace agent host name
sed -i 's/'"$NAME_KEY"'/'"$AGENT_NAME"'/g' $CONFIG_DEST

#start run
service zabbix-agent restart
