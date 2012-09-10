#
# Cookbook Name:: redis
# Recipe:: configure
#
# Copyright 2012, Ian Selby
#

include_recipe "redis::service"

directory "/etc/redis" do
  owner     "root"
  group     "root"
  mode      "0755"
  recursive true
end

template "/etc/redis/#{node[:redis][:port]}.conf" do
  source   "redis.conf.erb"
  owner    "root"
  group    "root"
  mode     "0644"
  notifies :restart, resources(:service => "redis_#{node[:redis][:port]}"), :immediately
end

logrotate_app "redis-#{node[:redis][:port]}" do
  cookbook "logrotate"
  path "/var/log/redis/#{node[:redis][:port]}.log"
  frequency "daily"
  rotate 7
  create "644 root root"
end