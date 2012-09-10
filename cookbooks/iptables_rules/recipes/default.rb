#
# Cookbook Name:: iptables_rules
# Recipe:: default
#
# Copyright 2012, Ian Selby
#

template "/etc/iptables.up.rules" do
  source   "iptables.up.rules.erb"
  owner    "root"
  group    "root"
  mode     "0644"
end

execute "iptables -F"
execute "iptables-restore < /etc/iptables.up.rules"