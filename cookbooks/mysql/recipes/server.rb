#
# Cookbook Name:: mysql
# Recipe:: server
#
# Copyright 2012, Ian Selby
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

node.set_unless[:mysql][:server_debian_password] = secure_password

directory "/var/cache/local/preseeding" do
  owner     "root"
  group     "root"
  mode      "0755"
  recursive true
end

execute "preseed mysql-server" do
  command "debconf-set-selections /var/cache/local/preseeding/mysql-server.seed"
  action  :nothing
end

template "/var/cache/local/preseeding/mysql-server.seed" do
  source   "mysql-server.seed.erb"
  owner    "root"
  group    "root"
  mode     "0600"
  notifies :run, resources(:execute => "preseed mysql-server"), :immediately
end

package "mysql-server"
package "libmysqlclient-dev"

include_recipe "mysql::service"

template "#{node[:mysql][:conf_dir]}/debian.cnf" do
  source "debian.cnf.erb"
  owner  "root"
  group  "root"
  mode   "0600"
end

template "#{node[:mysql][:conf_dir]}/my.cnf" do
  source   "my.cnf.erb"
  owner    "root"
  group    "root"
  mode     "0644"
  notifies :restart, resources(:service => "mysql"), :immediately
end


grants_path = "/etc/mysql_grants.sql"

begin
  t = resources("template[#{grants_path}]")
rescue
  Chef::Log.info("Could not find previously defined grants.sql resource")
  t = template grants_path do
    source "grants.sql.erb"
    owner "root"
    group "root"
    mode "0600"
    action :create
  end
end

execute "mysql-install-privileges" do
  command "/usr/bin/mysql -u root #{node[:mysql][:server_root_password].empty? ? '' : '-p'}\"#{node[:mysql][:server_root_password]}\" < #{grants_path}"
  action :nothing
  subscribes :run, resources("template[#{grants_path}]"), :immediately
end