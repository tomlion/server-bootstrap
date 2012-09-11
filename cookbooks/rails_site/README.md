Description
===========

Sets up the groundwork for a rails site on the system. This usually involves:

* Setting up an nginx config for the site
* Installing init scripts
* Updating other configs

Currently, this cookbook supports rails sites run with [puma](http://puma.io) or [unicorn](http://unicorn.bogomips.org/). It's also only
set up to run if a nginx config is not present for the site. This is to prevent `chef-client` check-ins from triggering nginx reloads... even
though they're not a big deal, we don't want this kinda thing happening on a regular basis in our environments.

That means if you want to update your configs, simply remove the config from `/etc/nginx/sites-available`, and the config will update on the
next `chef-client` run.

Requirements
============

Assumes you've got the `nginx::custom` recipe applied to your system, and the appropriate ports opened in your iptables configs.

Attributes
==========

There's only one attribute used:

* `node[:rails_sites]` - A hash of rails sites

The values of this node look like:

    node[:rails_sites][:my_app] = { :id => "myapp", :enabled => true }


Usage
=====

First, you'll want to define a data bag for your application. Create a `rails_sites` data bag if you haven't, then add a new entry. You can name it
whatever you want, and use the following json with the appropriate changes for your app:

    {
      "id":       "myapp",            # the ID of this data bag item
      "name":     "myapp",            # this is what the name of the nginx config will be
      "default":  true,               # whether or not this app should be the default nginx site
      "path":     "/var/www/myapp",   # the folder your app will be placed in, will be automatically created
      "use_ssl":  true,               # whether or not an SSL section should be created in the nginx config
      "ssl_settings":
      {
        "certificate":     "/etc/ssl/server.crt",
        "certificate_key": "/etc/ssl/server.key"
      },
      "capified":     true,                     # whether or not you'll use capistrano for deploys
      "server_name":  "hostname.com 127.0.0.1", # this will be placed in the nginx config's server_name attribute
      "rails_env":    "production",             # the environment to set in the various configs, wherever appropriate
      "web_server":   "puma",                   # the web server to assume, either "puma" or "unicorn"
      "http_port":    80,
      "https_port":   443
    }

For the sake of easy copy/paste, here's the above uncommented:

    {
      "id":       "myapp",
      "name":     "myapp",
      "default":  true,
      "path":     "/var/www/myapp",
      "use_ssl":  true,
      "ssl_settings":
      {
        "certificate":     "/etc/ssl/server.crt",
        "certificate_key": "/etc/ssl/server.key"
      },
      "capified":     true,
      "server_name":  "hostname.com 127.0.0.1",
      "rails_env":    "production",
      "web_server":   "puma",
      "http_port":    80,
      "https_port":   443
    }

Obviously, if you don't plan on using SSL, then the ssl_settings section is not necessary.

Once you've got the data bag item set up, you add attributes to your node for that app, as well as the recipe itself to the run
list.

After this runs, and everything is good to go, you can run your capistrano stuff.