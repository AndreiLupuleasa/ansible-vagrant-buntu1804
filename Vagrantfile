# created by Andrei Lupuleasa, December 2018.
Vagrant.require_version ">= 2.2.2"

# Automatically installs required plugin on Windows
if Vagrant::Util::Platform.windows?
  plugin = 'vagrant-winnfsd'

  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin?(plugin)
end

Vagrant.configure(2) do |config|

  # config.vm.box = "ubuntu/trusty64" # VM OS version
  config.vm.box = "geerlingguy/ubuntu1804" # VM OS version
  config.vm.hostname = "vagrantdev"
  
  # set up ssh
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  # config.ssh.insert_key = "true"
  
  # ORACLE VORTUALBOX and hardware config
  config.vm.provider "virtualbox" do |v|
	  v.name = "vagrantdev" # VM name
    v.memory = 4096 # RAM
    v.cpus = 4 # CPU count
	  v.customize ["modifyvm", :id, "--vram", "64"] # video ram memory
	  v.customize ["modifyvm", :id, "--clipboard",   "bidirectional"] # copy/paste functionality
    v.customize ["modifyvm", :id, "--draganddrop", "bidirectional"] # draganddrop functionality
	  v.customize ["modifyvm", :id, "--vrde", "off"] # disable remote desktop
  end
  
 # set IP and ports
  # config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true # http
  # config.vm.network :forwarded_port, guest: 443, host: 443, auto_correct: true # ssl
  # config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true # mysql
  config.vm.network "private_network", ip: "192.168.44.10"
  
  # shared directories - config used for windows OS host
  config.vm.synced_folder "share", "/var/www/html", type: "nfs"
  # config.vm.provision "file", source: "~/ssh/private_git.ppk", destination: "/var/www/private_git.ppk"	
  
  # Run Ansible files
  config.vm.provision "ansible_local" do |ansible|
    ansible.verbose = "vv"
	  ansible.become = true # execute as root
    ansible.playbook = "ansible/playbook.yml"
  end    
end