#
# Cookbook Name:: rails_site
# Recipe:: default
#
# Copyright 2012, Ian Selby
#
include_recipe "nginx::custom"
include_recipe "nginx::service"

rails_sites = data_bag('rails_sites')

execute "disable default site" do
  command "/usr/sbin/nginx_dissite default"
  action :run
  not_if { !File.symlink?("/etc/nginx/sites-enabled/000-default") }
  notifies :reload, resources(:service => :nginx), :immediately
end

execute "remove default site" do
  command "rm /etc/nginx/sites-enabled/default"
  action :run
  not_if { rails_sites.count == 0 || !File.symlink?("/etc/nginx/sites-enabled/default") }
  notifies :reload, resources(:service => :nginx), :immediately
end

node[:rails_sites].each do |k, v|
  data        = data_bag_item('rails_sites', v[:id])
  name        = data['name']
  enabled     = v[:enabled] || true

  local_vars  = {
    :name         => name,
    :is_default   => data['default']      || false,
    :app_path     => data['path']         || "/var/www/#{name}",
    :use_ssl      => data['use_ssl']      || false,
    :ssl_settings => data['ssl_settings'] || {},
    :capified     => data['capified']     || false,
    :http_port    => data['http_port']    || 80,
    :https_port   => data['https_port']   || 443,
    :rails_env    => v[:rails_env]        || 'production',
    :server_type  => data['web_server']   || 'puma',
    :server_name  => data['server_name']  || '127.0.0.1'
  }

  template "/etc/nginx/sites-available/#{name}" do
    source    "nginx.conf.erb"
    owner     "root"
    group     "root"
    variables local_vars
    notifies  :reload, resources(:service => 'nginx'), :immediately
    not_if    { File.exists?("/etc/nginx/sites-available/#{name}") }
  end

  rails_app "#{name}" do
    enable enabled
  end

end