#!/bin/bash

apt-get update > /dev/null

apt-get -y install make

mkdir /opt/redis

cd /opt/redis
# Use latest stable
wget -q http://download.redis.io/releases/redis-4.0.10.tar.gz
# Only update newer files
tar -xz --keep-newer-files -f redis-4.0.10.tar.gz

cd redis-4.0.10
make
make install
rm /etc/redis.conf
mkdir -p /etc/redis
mkdir /var/redis
chmod -R 777 /var/redis
useradd redis

cp -u /vagrant/redis.conf /etc/redis/6379.conf
cp -u /vagrant/redis.init.d /etc/init.d/redis_6379

update-rc.d redis_6379 defaults

chmod a+x /etc/init.d/redis_6379
/etc/init.d/redis_6379 start
