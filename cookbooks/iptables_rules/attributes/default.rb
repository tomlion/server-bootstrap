default[:iptables_rules] = { :tcp => {} }

default[:iptables_rules][:allow_ping]     = true
default[:iptables_rules][:tcp][:web]      = { :port => 80,  :description => "HTTP Requests" }
default[:iptables_rules][:tcp][:web_ssl]  = { :port => 443, :description => "HTTP Requests over SSL" }
default[:iptables_rules][:tcp][:ssh]      = { :port => 22,  :description => "SSH Connections" }