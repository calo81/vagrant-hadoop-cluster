# Reference

# https://github.com/patrickdlee/vagrant-examples/blob/master/example7/Vagrantfile
# https://github.com/calo81/vagrant-hadoop-cluster
# http://www.highlyscalablesystems.com/3597/hadoop-installation-tutorial-hadoop-2-x/
# http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.1.15/bk_cluster-planning-guide/content/typical-hadoop-cluster-hardware.html
# https://github.com/Cascading/vagrant-cascading-hadoop-cluster/blob/2.7/Vagrantfile
# https://github.com/apache/bigtop/tree/master/bigtop-deploy/vm/vagrant-puppet-vm


# Warning

# VT-x/AMD-V is required to be enabled in your bios to boot a 64 bit guest machine
# To check if your CPU supports virtualization refer https://www.grc.com/securable.htm
# If it does, enable the same in BIOS


VAGRANTFILE_API_VERSION = "2"

# master runs HDFS NameNode, YARN ResourceManager, HBase Master (optional)
# slaves run  HDFS DataNode, YARN NodeManager, HBase RegionServers (optional)

# increase ram as needed, add additional slave nodes if needed.

nodes = [
  { :type => 'master',  
    :hostname => 'master.local',    
    :ip => '192.168.48.10', 
    :box => 'puppetlabs/ubuntu-12.04-64-puppet',  
    :cpus => '1',  
    :ram => '2048' },
  
  { :type => 'slave',   
    :hostname => 'hadoop1.local',   
    :ip => '192.168.48.11', 
    :box => 'puppetlabs/ubuntu-12.04-64-puppet',  
    :cpus => '1',  
    :ram => '1024' },
  
  { :type => 'slave',   
    :hostname => 'hadoop2.local',   
    :ip => '192.168.48.12', 
    :box => 'puppetlabs/ubuntu-12.04-64-puppet',  
    :cpus => '1',  
    :ram => '1024' },
  
  { :type => 'slave',   
    :hostname => 'hadoop3.local',   
    :ip => '192.168.48.13', 
    :box => 'puppetlabs/ubuntu-12.04-64-puppet',  
    :cpus => '1',  
    :ram => '1024' },
  
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.box_version = "1.0.1"  		# optional, can be removed to default to latest version
      node_config.vm.box_check_update = false		# disabling for now 
      node_config.vm.host_name = node[:hostname]
      node_config.vm.network "private_network", ip: node[:ip]
      node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpus", node[:cpus]]
        vb.customize ["modifyvm", :id, "--memory", node[:ram]]
        # vb.gui = true                               # uncomment this line to debug virtual machine startup issues
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
