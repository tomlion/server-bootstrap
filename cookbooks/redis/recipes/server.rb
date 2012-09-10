#
# Cookbook Name:: redis
# Recipe:: server
#
# Copyright 2012, Ian Selby
#

redis_version = node[:redis][:version]

redis_version_installed = `#{node[:redis][:prefix]}/bin/redis-server -v | awk '{print $4}'`.strip

redis_already_installed = lambda do
  Chef::Log.debug("redis version installed: #{redis_already_installed}")
  Chef::Log.debug("redis version: #{redis_version}")
  redis_version_installed == redis_version
end

remote_file "/src/redis-#{redis_version}.tar.gz" do
  source "http://redis.googlecode.com/files/redis-#{redis_version}.tar.gz"
  not_if { File.directory?("/src/redis-#{redis_version}") }
end

execute "tar -zxvf /src/redis-#{redis_version}.tar.gz" do
  cwd "/src"
  not_if &redis_already_installed
end

execute "make" do
  cwd "/src/redis-#{redis_version}"
  not_if &redis_already_installed
end

execute "make install" do
  cwd "/src/redis-#{redis_version}"
  not_if &redis_already_installed
end

directory node[:redis][:datadir] do
  owner     "root"
  group     "root"
  mode      "0755"
  recursive true
end

directory File.dirname(node[:redis][:log_file]) do
  action :create
  owner  "root"
  group  "root"
  mode   "0755"
end

template "/etc/init.d/redis_#{node[:redis][:port]}" do
  source "redis.init.erb"
  owner "root"
  group "root"
  mode  "0755"
end

include_recipe "redis::service"
include_recipe "redis::configure"