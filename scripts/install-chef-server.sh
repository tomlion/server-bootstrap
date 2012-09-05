#!/usr/bin/env bash

echo "deb http://www.rabbitmq.com/debian/ testing main" | tee /etc/apt/sources.list.d/rabbitmq.list
echo "deb http://apt.opscode.com/ `lsb_release -cs`-0.10 main" | tee /etc/apt/sources.list.d/opscode.list

cd /tmp && wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc

mkdir -p /etc/apt/trusted.gpg.d
gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
gpg --export packages@opscode.com | sudo tee /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null

apt-get update
apt-get install rabbitmq-server couchdb default-jdk opscode-keyring libgecode-dev -y
rabbitmqctl add_vhost /chef
rabbitmqctl add_user chef testing
rabbitmqctl set_permissions -p /chef chef ".*" ".*" ".*"

gem install chef-server chef-server-api chef-server chef-solr chef-server-webui --no-ri --no-rdoc

mkdir -p /etc/chef
wget https://raw.github.com/masterexploder/server-bootstrap/master/configs/chef-server-default.rb -O /etc/chef/server.rb