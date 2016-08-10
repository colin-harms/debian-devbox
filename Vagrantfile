# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "bento/debian-8.5"

  config.vm.provider "virtualbox" do |vb|
   vb.gui = true
   vb.customize ["modifyvm", :id, "--vram", "64"]
   vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
   vb.memory = "8192"
   vb.cpus = 4
  end

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.synced_folder "~/", "/home/vagrant/hosthome", owner: 'vagrant'
  config.vm.provision "chef_solo" do |chef|
    chef.nodes_path = 'nodes'
    chef.roles_path = 'roles'
    chef.add_recipe "devbox"
  end
end
