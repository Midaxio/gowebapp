VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.20"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provider :virtualbox do |vb|
    vb.name = "devel" 
  end
 
  config.vm.synced_folder "chef/", "/home/vagrant/project/chef",
    owner: "vagrant", group: "vagrant"

  config.vm.provision "file", source: "files/", destination: "/tmp/"
  config.vm.provision "shell", inline: <<-SHELL
    sudo dpkg -i /tmp/files/chefdk.deb
  SHELL
end 
