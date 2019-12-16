# created by Andrei Lupuleasa, December 2018.
Vagrant.require_version ">= 2.2.2"

# Automatically installs required plugin on Windows
if Vagrant::Util::Platform.windows?
  plugin = 'vagrant-winnfsd'

  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin?(plugin)
end

Vagrant.configure(2) do |config|

  # config.vm.box = "ubuntu/trusty64" # VM OS version
  config.vm.box      = "geerlingguy/ubuntu1804" # VM OS version
  config.vm.hostname = "vagrantdev"
  # set IP and ports
  # config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true # http
  # config.vm.network :forwarded_port, guest: 443, host: 443, auto_correct: true # ssl
  # config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true # mysql
  config.vm.network "private_network", ip: "192.168.44.10"
  
  # Sync the sources folder with the machine
  # For Windows `nfs` is preferred due to poor performance of default settings.
  if Vagrant::Util::Platform.windows?
    # config.vm.synced_folder "share", "/var/www/html", type: 'nfs' #doesn't work for now 
    config.vm.synced_folder "share", "/var/www/html", mount_options: ["dmode=777","fmode=777"]
  else
    config.vm.synced_folder "share", "/var/www/html", mount_options: ["dmode=777","fmode=777"]
  end


  # Set to true if you want automatic checks
  config.vm.box_check_update = false

  # Copy personal private key with access to repository to machine
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa"  
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
 
  # set up ssh
  # config.ssh.username   = "vagrant"
  # config.ssh.password   = "vagrant"
  #config.ssh.insert_key = "true"    #true by default
  
  # ORACLE VORTUALBOX and hardware config
  config.vm.provider "virtualbox" do |vb|
	  vb.name   = "vagrantdev" # VM name
    vb.memory = 1096 # RAM
    vb.cpus   = 1 # CPU count
	  vb.customize ["modifyvm", :id, "--vram", "64"]                   # video ram memory
	  vb.customize ["modifyvm", :id, "--clipboard",   "bidirectional"] # copy/paste functionality
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"] # draganddrop functionality
	  vb.customize ["modifyvm", :id, "--vrde", "off"]                  # disable remote desktop

    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "on"]
    vb.customize ["usbfilter", "add", "0", 
      "--target", :id, 
      "--name", "Realtek 802.11n WLAN Adapter [0200]",
      "--manufacturer", "Realtek",
      "--product", "802.11n WLAN Adapter"]

  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.verbose   = "vv"
	  ansible.become    = true # execute as root
    ansible.playbook  = "ansible/playbook.yml"
    # ansible.skip_tags = "once"
  end   

end