class base {

  require vars

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

  # Create the hadoop user hadoop and its home directory
  group { "${vars::group}":
    ensure => "present",
    require => Class["::ntp"],
  }
  user { "${vars::user}":
    ensure => "present",
    home => "/home/${vars::user}",
    name => "${vars::user}",
    shell => "/bin/bash",
    managehome => true,
    gid => $group,
    require => Group["${vars::group}"],
  }
  file { "/home/${vars::user}":
    ensure => "directory",
    owner  => "${vars::user}",
    group  => "${vars::group}",
    mode   => "700",
    require =>  [ User["${vars::user}"], Group["${vars::group}"] ],
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
  host { "${vars::hadoop_master_hn}":
    ip => "${vars::hadoop_master_ip}",
  }
  host { "${vars::hadoop_slave1_hn}":
        ip => "${vars::hadoop_slave1_ip}",
  }
  host { "${vars::hadoop_slave2_hn}":
    ip => "${vars::hadoop_slave2_ip}",
  }
  host { "${vars::hadoop_slave3_hn}":
    ip => "${vars::hadoop_slave3_ip}",
  }

}
