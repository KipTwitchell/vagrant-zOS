# -*- mode: ruby -*-
# vi: set ft=ruby :

# (c) Copyright IBM Corporation. 2018
# SPDX-License-Identifier: Apache-2.0
# By Kip Twitchell

# This Vagrant configuration file begins with an CentOS Linux Distro Vagrant container
# It runs a local copy of z/OS
# the script directory contains an initenv.sh which will complete the scala development
#   set up in the environment

Vagrant.configure("2") do |config|

  # These statements are a patch for an issue with Vagrant and VirtualBox.  https://github.com/hashicorp/vagrant/issues/8878
class VagrantPlugins::ProviderVirtualBox::Action::Network
  def dhcp_server_matches_config?(dhcp_server, config)
    true
  end
end

  # These are the vbguest additions for syncing folders
  config.vbguest.auto_update = false
  config.vbguest.no_remote = true

  config.vm.define :zOSserver, primary: true do |zOSserver|
    zOSserver.vm.box = "geerlingguy/centos7"
  #  zOSserver.vm.network :private_network, ip: "192.168.10.200"
    zOSserver.vm.network :private_network, type: "dhcp"
    zOSserver.vm.hostname = "zOSserver"
    zOSserver.vm.synced_folder ".", # <--- this directory for code
        "/vagrant-zOS",
        id: "code", type: "virtualbox"
  ######  enabled for Hercules use
    zOSserver.vm.network "forwarded_port", guest: 3270, host: 3270, auto_correct: true
  ######  enabled for tk4- use as console
    zOSserver.vm.network "forwarded_port", guest: 8038, host: 8038, auto_correct: true
    config.vm.provision "shell", inline: <<-SHELL
    SHELL
  end
end