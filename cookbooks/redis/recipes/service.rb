#
# Cookbook Name:: redis
# Recipe:: service
#
# Copyright 2012, Ian Selby
#

service "redis_#{node[:redis][:port]}" do
  service_name "redis_#{node[:redis][:port]}"

  supports :status => false, :restart => true, :start => true, :stop => true, "force-reload" => true
  action :enable
end