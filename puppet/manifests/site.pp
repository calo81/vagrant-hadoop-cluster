# Some variables
$user = "hadoop"
$group = "hadoop"
$hadoop_master = '192.168.48.10'
$hadoop_1 = '192.168.48.11'
$hadoop_2 = '192.168.48.12'


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
  
  # Enable passwordless sudo for hadoop user
class { "sudo":
  purge => false,
  config_file_replace => false,
  }
  
  sudo::conf { 'hadoop': 
  priority => 10,
  content => "%hadoop ALL=(ALL) NOPASSWD: ALL",
  require =>  [ User["${user}"], Group["${group}"] , Class["sudo"] ],
}

  
# configure /etc/hosts in all nodes so that they can talk to each other
  host { 'hadoop1.hdpclust.home':
    ip => "${hadoop_1}",
}

host { 'hadoop2.hdpclust.home':
    ip => "${hadoop_2}",
}

host { 'master.hdpclust.home':
    ip => "${hadoop_master}",
}


include ssh
include java
#include hadoop

