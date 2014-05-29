# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    # Uncomment to show the vm gui, if you need to debug things
    # vb.gui = true

    # Uncomment if you want to change the specs on the machine
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  config.vm.synced_folder "code", "/opt/code",
    type: "rsync",
    rsync__auto: "true",
    # We ignore phabricator/bin/* and phd-daemon because symlinks don't work on windows
    rsync__exclude: [".git/", "phabricator/bin/*", "scripts/daemon/phd-daemon"]

  # Recreate the symlinks we skipped
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file  = "symlinks.pp"
    puppet.manifests_path = "puppet"
    puppet.facter = { "path" => "/opt/code/phabricator"}
  end

  # Provisioning that sets up the machine to a state for phabricator
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file  = "site.pp"
    puppet.manifests_path = "puppet"
    puppet.module_path = "puppet/modules"
    puppet.facter = { "path" => "/opt/code/phabricator", "host" => "phabricator.local"}
  end
end
