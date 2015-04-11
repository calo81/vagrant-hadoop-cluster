VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # common across all vms
  config.vm.box = "ubuntu/trusty64"
  
  
  # master
  config.vm.define "master", primary: true do |master|
    
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
    
    master.vm.network "private_network", ip: "192.168.48.10"
    master.vm.host_name = "master"
  end
  
  
  # backup
  config.vm.define :backup do |backup|

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
    
    backup.vm.network "private_network", ip: "192.168.48.9"
    backup.vm.host_name = "backup"
  end
  
  
  # hadoop1
  config.vm.define :hadoop1 do |hadoop1|
    
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
    
    hadoop1.vm.network "private_network", ip: "192.168.48.11"
    hadoop1.vm.host_name = "hadoop1"    
  end
  
  
  # hadoop2
  config.vm.define :hadoop2 do |hadoop2|
    
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
    
    hadoop2.vm.network "private_network", ip: "192.168.48.12"
    hadoop2.vm.host_name = "hadoop2"
  end
  
  # hadoop3
  config.vm.define :hadoop3 do |hadoop3|
    
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
    
    hadoop3.vm.network "private_network", ip: "192.168.48.13"
    hadoop3.vm.host_name = "hadoop3"
  end
  
  # Provisioning is outside-in, so first all provisioning mentioned here will be executed
  # then any machine specific provisioning is completed
  
  # Shell provisioning
  # config.vm.provision :shell, :path => 'shell/main.sh'
  
  # Puppet provisioning
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "main.pp"
  end
  

end
