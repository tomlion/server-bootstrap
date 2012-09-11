Description
===========

Customized version of the official opscode mysql cookbook. Basically, I just stripped a lot of the extra
non-ubuntu cruft out of things and tweaked this to suit my needs.

Requirements
============

OpenSSL Cookbook

Attributes
==========

Check the `attributes/default.rb` file for all the default values, but here's what you've got available:

* `node[:mysql][:server_root_password]`
* `node[:mysql][:conf_dir]`
* `node[:mysql][:socket]`
* `node[:mysql][:bind_address]`
* `node[:mysql][:tunable]['back_log']`
* `node[:mysql][:tunable]['key_buffer']`
* `node[:mysql][:tunable]['max_allowed_packet']`
* `node[:mysql][:tunable]['max_connections']`
* `node[:mysql][:tunable]['max_heap_table_size']`
* `node[:mysql][:tunable]['myisam_recover']`
* `node[:mysql][:tunable]['net_read_timeout']`
* `node[:mysql][:tunable]['net_write_timeout']`
* `node[:mysql][:tunable]['table_cache']`
* `node[:mysql][:tunable]['table_open_cache']`
* `node[:mysql][:tunable]['thread_cache']`
* `node[:mysql][:tunable]['thread_cache_size']`
* `node[:mysql][:tunable]['thread_concurrency']`
* `node[:mysql][:tunable]['thread_stack']`
* `node[:mysql][:tunable]['wait_timeout']`
* `node[:mysql][:tunable]['query_cache_limit']`
* `node[:mysql][:tunable]['query_cache_size']`
* `node[:mysql][:tunable]['log_slow_queries']`
* `node[:mysql][:tunable]['long_query_time']`
* `node[:mysql][:tunable]['expire_logs_days']`
* `node[:mysql][:tunable]['max_binlog_size']`
* `node[:mysql][:tunable]['innodb_buffer_pool_size']`

Usage
=====

You can include either the `mysql::server` or `mysql::client` recipes as needed. The client is good to have on machines that need to talk to a mysql server, or
need to build something with native mysql extensions (such as the `mysql2` rubygem).