#!/usr/bin/env bash


###Updating the VM
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y

###Install and configure needed code
apt-get install wget unzip jq nginx redis-server redis python3-pip python-django-common virtualenv tree -y
ln -s /usr/bin/pip3 /usr/bin/pip
pip install Django==2.2.3
python3 -m pip install redis

####Creating config file for redis

cat >  /etc/redis/6379.conf << EOF
port              6379
daemonize         yes
save              60 1
bind              127.0.0.1
tcp-keepalive     300
dbfilename        dump.rdb
dir               ./
rdbcompression    yes

EOF

####Starting redis

redis-server /etc/redis/6379.conf

####Setting initional kv in redis needed for counting
redis-cli set number 0