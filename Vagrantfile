# Reference

# https://github.com/patrickdlee/vagrant-examples/blob/master/example7/Vagrantfile
# https://github.com/calo81/vagrant-hadoop-cluster

VAGRANTFILE_API_VERSION = "2"

nodes = [
  { :hostname => 'master',    :ip => '192.168.48.10', :box => 'ubuntu/trusty64',  :cpus => '1',  :ram => '1024' },
  { :hostname => 'backup',    :ip => '192.168.48.9',  :box => 'ubuntu/trusty64',  :cpus => '1',  :ram => '512' },
  { :hostname => 'hadoop1',   :ip => '192.168.48.11', :box => 'ubuntu/trusty64',  :cpus => '1',  :ram => '512' },
  { :hostname => 'hadoop2',   :ip => '192.168.48.12', :box => 'ubuntu/trusty64',  :cpus => '1',  :ram => '512' },
  { :hostname => 'hadoop3',   :ip => '192.168.48.13', :box => 'ubuntu/trusty64',  :cpus => '1',  :ram => '512' },
]



Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.host_name = node[:hostname]
      node_config.vm.network "private_network", ip: node[:ip]
      node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpus", node[:cpus]]
        vb.customize ["modifyvm", :id, "--memory", node[:ram]]
      end
    end
  end
      
      
  # Provisioning is outside-in, so first all provisioning mentioned here will be executed
  # then any machine specific provisioning is completed
  
  # Shell provisioning - bootstrap for puppet
  # install - git, ruby and librarian-puppet
  config.vm.provision :shell, :path => 'shell/main.sh'
  
  # Puppet provisioning
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "puppet/modules"
  end
  

end
