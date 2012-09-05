#!/usr/bin/env bash
iptables -F
wget https://raw.github.com/masterexploder/server-bootstrap/master/configs/iptables.up.rules.txt -O /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules
wget https://raw.github.com/masterexploder/server-bootstrap/master/configs/iptables.pre-up.txt -O /etc/network/if-pre-up.d/iptables
chmod +x /etc/network/if-pre-up.d/iptables
