#!/bin/sh

yum -y update --skip-broken
yum -y install wget

### install pacemaker
cd /tmp
tar xvzf /vagrant/pacemaker-1.0.13-2.1.el6.x86_64.repo.tar.gz
cd pacemaker-1.0.13-2.1.el6.x86_64.repo
yum -y -c pacemaker.repo install pacemaker-1.0.13-2.el6.x86_64 heartbeat-3.0.5-1.1.el6.x86_64 pm_extras-1.5-1.el6.x86_64

### install httpd(Apache)
yum -y install httpd
cp /vagrant/index.html /var/www/html

### add iptables
iptables -A INPUT -p udp -m udp --dport 694 -j ACCEPT
service iptables save

### add hosts
cat /vagrant/hosts_add >> /etc/hosts

### setting heartbeat
install /vagrant/ha.cf /etc/ha.d
install -m 0600 /vagrant/authkeys /etc/ha.d

# kayn's hack
sed -i '0,/^$/ s|^$|HA_BIN=/usr/lib64/heartbeat|' /etc/init.d/heartbeat

### start heartbeat
service heartbeat start

