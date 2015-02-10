#!/bin/sh

### wait for being ready cluster
while [ 1 ]
do
  crm node status > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    break
  fi
  sleep 1
done

sleep 5

### setting option
crm configure property stonith-enabled="false"
crm configure property no-quorum-policy="ignore"

### setting resouce
crm configure primitive vip_httpd ocf:heartbeat:IPaddr2 params \
ip="192.168.1.101" nic="eth1" cidr_netmask="24" op monitor interval="10"

crm configure primitive httpd ocf:heartbeat:apache params \
configfile="/etc/httpd/conf/httpd.conf" statusurl="http://192.168.1.101/" \
op start interval="0" timeout="90" on-fail="restart" \
op monitor interval="10" timeout="60" on-fail="restart" \
op stop interval="0" timeout="300" on-fail="block"

### grouping
crm configure group web vip_httpd httpd
