Description
===========

Manages very basic ip tables rules... you probably don't want to use this recipe unless you're only interested
in managing TCP port rules. This is because I have an incredibly limited amount of iptables knowledge, but my needs
are very basic. I know there are probably better ways of doing this, but I'm not interested in those for my needs :)

Requirements
============

None

Attributes
==========

By default, all servers have ports 22, 80, and 443 enabled, and allow pings.

* `node[:iptables_rules][:allow_ping]` True / false value
* `node[:iptables_rules][:tcp]` Hash containing tcp port rules
* `node[:iptables_rules][:tcp][:web]` - `{ :port => 80, :description => "HTTP Requests" }`
* `node[:iptables_rules][:tcp][:web_ssl]` - `{ :port => 443, :description => "HTTP Requests over SSL" }`
* `node[:iptables_rules][:tcp][:ssh]` - `{ :port => 22,  :description => "SSH Connections" }`

Usage
=====

Include the `iptables_rules` recipe in your run list. Then add any additional ports you want via the node's attributes.
Let's say you wanted to open up redis on port 6379 on a server. Your node's attributes json would look something like:

    {
      "iptables_rules":
      {
        "redis": { "port": 6379, "description": "Redis Connections" }
      }
    }

The description is used as a comment above the rule in the file.

The rules file is placed in `/etc/iptables.up.rules`. Whenever this recipe runs, it updates the config, then runs

    iptables -F
    iptables-restore < /etc/iptables.up.rules

It doesn't set these rules up to run on system boot. That's because this should be something you do yourself, and if
you're following my ubuntu server setup docs, this should have been done already.