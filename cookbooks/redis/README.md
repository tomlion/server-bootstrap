Description
===========

Installs redis via a compile from source... this is much more reliable than any PPA or apt-based installation.

Requirements
============

Assumes build-essential is on your system, other than that you're good

Attributes
==========

See the `attributes/default.rb` file for all the default values.

* `node[:redis][:bind_address]` What address to bind the server to
* `node[:redis][:port]` What port to bind to
* `node[:redis][:version]` What version to install
* `node[:redis][:datadir]` Where redis will keep its data
* `node[:redis][:prefix]` The prefix dir for redis
* `node[:redis][:log_leve]` Which log level to run redis at
* `node[:redis][:log_file]` The name and location of the log file
* `node[:redis][:pid_file]` The name and location of the server's pid file
* `node[:redis][:num_dbs]` The number of databases redis should run with

Usage
=====

Simply set whatever attributes you want, then add the `redis::server` recipe to your run list.