# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :s1 do |v|
    v.vm.box = "centos65_64"
    v.vm.hostname = "s1" 
    v.vm.network :private_network, ip: "192.168.1.121"
    v.vm.network :private_network, ip: "192.168.9.121"
    v.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2122
    v.vm.provision :shell, :path => "heartbeat.sh"
  end

  config.vm.define :s2 do |v|
    v.vm.box = "centos65_64"
    v.vm.hostname = "s2"
    v.vm.network :private_network, ip: "192.168.1.122"
    v.vm.network :private_network, ip: "192.168.9.122"
    v.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2222
    v.vm.provision :shell, :path => "heartbeat.sh"
    v.vm.provision :shell, :path => "pacemaker.sh"
  end
end
