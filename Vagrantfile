# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "base-hadoop"
  config.vm.customize [
                          "modifyvm", :id,
                          "--memory", "1024"
                        ]
  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base-hadoop.pp"
     puppet.module_path = "modules"
  end
  
  config.vm.define :backup do |box|
    box.vm.network :private_network, ip: "10.10.0.51"
    box.vm.host_name = "backup"  
  end
  
  config.vm.define :hadoop1 do |hadoop1_config|
    hadoop1_config.vm.network :private_network, ip: "10.10.0.53"
    hadoop1_config.vm.host_name = "hadoop1"
  end
  
  config.vm.define :hadoop2 do |hadoop2_config|
    hadoop2_config.vm.network :private_network, ip: "10.10.0.54"
    hadoop2_config.vm.host_name = "hadoop2"
  end
  
  config.vm.define :hadoop3 do |hadoop3_config|
    hadoop3_config.vm.network :private_network, ip: "10.10.0.55"
    hadoop3_config.vm.host_name = "hadoop3"
  end
  
   config.vm.define :master do |master_config|
    master_config.vm.network :private_network, ip: "10.10.0.52"
    master_config.vm.host_name = "master"
  end

end
