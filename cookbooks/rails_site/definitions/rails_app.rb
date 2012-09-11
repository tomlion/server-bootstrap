#
# Cookbook Name:: rails_site
# Definition:: rails_app
#
# Copyright 2012, Ian Selby
#

define :rails_app, :enable => true do
  include_recipe "nginx::custom"
  include_recipe "nginx::service"

  app_name  = params[:name]

  if params[:enable]
    execute "nginx_ensite #{app_name}" do
      command "/usr/sbin/nginx_ensite #{app_name}"
      notifies :reload, resources(:service => "nginx")
      not_if do
        ::File.symlink?("/etc/nginx/sites-enabled/#{params[:name]}") || ::File.symlink?("/etc/nginx/sites-enabled/000-#{params[:name]}")
      end
      only_if do ::File.exists?("/etc/nginx/sites-available/#{params[:name]}") end
    end
  else
    execute "nginx_dissite #{app_name}" do
      command "/usr/sbin/nginx_dissite #{app_name}"
      notifies :reload, resources(:service => "nginx")
      only_if do ::File.symlink?("/etc/nginx/sites-enabled/#{app_name}") end
    end
  end
end