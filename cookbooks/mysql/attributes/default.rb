default[:mysql]                        = {}
default[:mysql][:server_root_password] = ""
default[:mysql][:conf_dir]             = "/etc/mysql"
default[:mysql][:socket]               = "/tmp/mysql.sock"
default[:mysql][:bind_address]         = "127.0.0.1"

default[:mysql][:tunable]['back_log']             = "128"
default[:mysql][:tunable]['key_buffer']           = "16M"
default[:mysql][:tunable]['max_allowed_packet']   = "16M"
default[:mysql][:tunable]['max_connections']      = "100"
default[:mysql][:tunable]['max_heap_table_size']  = "32M"
default[:mysql][:tunable]['myisam_recover']       = "BACKUP"
default[:mysql][:tunable]['net_read_timeout']     = "30"
default[:mysql][:tunable]['net_write_timeout']    = "30"
default[:mysql][:tunable]['table_cache']          = "64"
default[:mysql][:tunable]['table_open_cache']     = "128"
default[:mysql][:tunable]['thread_cache']         = "128"
default[:mysql][:tunable]['thread_cache_size']    = 8
default[:mysql][:tunable]['thread_concurrency']   = 10
default[:mysql][:tunable]['thread_stack']         = "192K"
default[:mysql][:tunable]['wait_timeout']         = "180"

default[:mysql][:tunable]['query_cache_limit']    = "1M"
default[:mysql][:tunable]['query_cache_size']     = "16M"

default[:mysql][:tunable]['log_slow_queries']     = "/var/log/mysql/slow.log"
default[:mysql][:tunable]['long_query_time']      = 2

default[:mysql][:tunable]['expire_logs_days']     = 10
default[:mysql][:tunable]['max_binlog_size']      = "100M"

default[:mysql][:tunable]['innodb_buffer_pool_size']  = "256M"