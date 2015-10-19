# Variable declaration

# User running hadoop services and inter cluster communication
$user = "hadoop"
$group = "hadoop"

# Cluster IP and hostname information
$hadoop_master_ip = '192.168.48.10'
$hadoop_slave1_ip = '192.168.48.11'
$hadoop_slave2_ip = '192.168.48.12'
$hadoop_slave3_ip = '192.168.48.13'
$hadoop_master_hn = 'master.local'
$hadoop_slave1_hn = 'hadoop1.local'
$hadoop_slave2_hn = 'hadoop2.local'
$hadoop_slave3_hn = 'hadoop3.local'

# Set path for exec
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

# Set Timezone
# Change as needed to a value shown by the command 'timedatectl list-timezones' on Ubuntu.
class { 'timezone':
  timezone => 'America/Los_Angeles',
}
class { '::ntp':
  servers => ['0.us.pool.ntp.org', '1.us.pool.ntp.org0.us.pool.ntp.org0.us.pool.ntp.org', '2.us.pool.ntp.org0.us.pool.ntp.org', '3.us.pool.ntp.org'],
  service_ensure => "running",
  require => Class["timezone"],
}

# Create the hadoop user hdpusr and its home directory
group { "${group}":
  ensure => "present",
  require => Class["::ntp"],
}
user { "${user}":
  ensure => "present",
  home => "/home/${user}",
  name => "${user}",
  shell => "/bin/bash",
  managehome => true,
  gid => $group,
  require => Group["${group}"],  
}
file { "/home/${user}":
  ensure => "directory",
  owner  => "${user}",
  group  => "${group}",
  mode   => 700,
  require =>  [ User["${user}"], Group["${group}"] ],
}
  
## Enable password less sudo for hadoop user - do I need this ? 
#class { "sudo":
#  purge => false,
#  config_file_replace => false,
#}
#sudo::conf { 'hadoop': 
#  priority => 10,
#  content => "%hadoop ALL=(ALL) NOPASSWD: ALL",
#  require =>  [ User["${user}"], Group["${group}"] , Class["sudo"] ],
#}

  
# configure /etc/hosts in all nodes so that they can talk to each other
host { "${hadoop_master_hn}":
  ip => "${hadoop_master_ip}",
}
host { "${hadoop_slave1_hn}":
      ip => "${hadoop_slave1_ip}",
}  
host { "${hadoop_slave2_hn}":
  ip => "${hadoop_slave2_ip}",
}
host { "${hadoop_slave3_hn}":
  ip => "${hadoop_slave3_ip}",
}  


include ssh
include java
# include hadoop

