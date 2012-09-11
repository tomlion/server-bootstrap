#
# Cookbook Name:: mysql
# Recipe:: service
#
# Copyright 2012, Ian Selby
#

service "mysql" do
  service_name "mysql"
  restart_command "restart mysql"
  start_command   "start mysql"
  stop_command    "stop mysql"
  supports :status => true, :restart => true, :reload => true
  action :enable
end