$install_dir = "/opt"
$hadoop_version = "2.6.0"
$hadoop_home = "${install_dir}/hadoop-${hadoop_version}"
$user = "hdpusr"
$group = "hdpusr"
$hadoop_backup = '192.168.48.9'
$hadoop_master = '192.168.48.10'
$hadoop_1 = '192.168.48.11'
$hadoop_2 = '192.168.48.12'
$hadoop_3 = '192.168.48.13'


# Create the hadoop user hdpusr and its home directory
file { 
	   "/home/${user}":
        ensure => "directory",
        owner  => "${user}",
        group  => "${group}",
        mode   => 700,
        require =>  [ User["${user}"], Group["${group}"] ],

}

group { "${group}":
  ensure => "present",
}

user { 
		"${user}":
        ensure => "present",
        home => "/home/${user}",
        name => "${user}",
        shell => "/bin/bash",
        managehome => true,
		gid => $group
}

# configure /etc/hosts in all nodes so that they can talk to each other
host { 'hadoop1':
    ip => "${hadoop_1}",
}

host { 'hadoop2':
    ip => "${hadoop_2}",
}

host { 'hadoop3':
    ip => "${hadoop_3}",
}

host { 'master':
    ip => "${hadoop_master}",
}

host { 'backup':
    ip => "${hadoop_backup}",
}



