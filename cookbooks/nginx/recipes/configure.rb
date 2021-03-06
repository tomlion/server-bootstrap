#
# Cookbook Name:: nginx
# Recipe:: configure
#
# Copyright 2012, Ian Selby
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "nginx::service"

nginx_installed = `dpkg-query -W --showformat='${Status}\n' nginx-custom|grep "install ok installed"`.strip
nginx_already_installed = lambda do
  nginx_installed == "install ok installed"
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"

  notifies :restart, resources(:service => "nginx"), :immediately
  not_if &nginx_already_installed
end

cookbook_file "/usr/sbin/nginx_ensite" do
  source "nginx_ensite"
  owner  "root"
  group  "root"
  mode   "0755"
end

cookbook_file "/usr/sbin/nginx_dissite" do
  source "nginx_ensite"
  owner  "root"
  group  "root"
  mode   "0755"
end