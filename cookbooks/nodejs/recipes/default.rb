#
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2012, Ian Selby
#

package "libssl-dev"
package "libexpat1-dev"

node_version           = node[:nodejs][:version]
node_version_installed = `node -v | awk '{print $1}'`.strip.gsub('v', '')

node_already_installed = lambda do
  Chef::Log.debug("node version installed: #{node_version_installed}")
  Chef::Log.debug("node version: #{node_version}")
  node_version_installed == node_version
end

remote_file "/src/node-v#{node_version}.tar.gz" do
  source "http://nodejs.org/dist/v#{node_version}/node-v#{node_version}.tar.gz"
  not_if { File.directory?("/src/node-v#{node_version}") }
end

execute "tar -zxvf /src/node-v#{node_version}.tar.gz" do
  cwd "/src"
  not_if &node_already_installed
end

execute "cd /src/node-v#{node_version} && ./configure" do
  not_if &node_already_installed
end

execute "cd /src/node-v#{node_version} && make" do
  not_if &node_already_installed
end

execute "cd /src/node-v#{node_version} && make install" do
  not_if &node_already_installed
end
