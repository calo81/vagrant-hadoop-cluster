$install_dir = "/tmp"
$hadoop_home = "${install_dir}/hadoop"
$user = "ubuntu"
$group = "ubuntu"
$hadoop_master = '10.10.0.52'
$hadoop_backup = '10.10.0.51'
$hadoop_1 = '10.10.0.53'
$hadoop_2 = '10.10.0.54'
$hadoop_3 = '10.10.0.55'

include hadoop
include mahout

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
	


exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
}

package { "openjdk-6-jdk" :
   ensure => present,
  require => [ Exec['apt-get update'], File["/home/${user}"] ]
}

file { 
	"/home/${user}/.ssh":
    ensure => "directory",
    owner  => "${user}",
    group  => "${user}",
    mode   => 750,
	require => [ Exec['apt-get update'], File["/home/${user}"] ]
}

file {
  "/home/${user}/.ssh/id_rsa":
  source => "puppet:///modules/hadoop/id_rsa",
  ensure => present,
  mode => 600,
  owner => $user,
  group => $user,
  require => File["/home/${user}/.ssh"]
 }
 
file {
  "/home/${user}/.ssh/id_rsa.pub":
  source => "puppet:///modules/hadoop/id_rsa.pub",
  ensure => present,
  mode => 644,
  owner => $user,
  group => $user,
  require => File["/home/${user}/.ssh"]
 }

ssh_authorized_key { "ssh_key":
    ensure => "present",
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCeHdBPVGuSPVOO+n94j/Y5f8VKGIAzjaDe30hu9BPetA+CGFpszw4nDkhyRtW5J9zhGKuzmcCqITTuM6BGpHax9ZKP7lRRjG8Lh380sCGA/691EjSVmR8krLvGZIQxeyHKpDBLEmcpJBB5yoSyuFpK+4RhmJLf7ImZA7mtxhgdPGhe6crUYRbLukNgv61utB/hbre9tgNX2giEurBsj9CI5yhPPNgq6iP8ZBOyCXgUNf37bAe7AjQUMV5G6JMZ1clEeNPN+Uy5Yrfojrx3wHfG40NuxuMrFIQo5qCYa3q9/SVOxsJILWt+hZ2bbxdGcQOd9AXYFNNowPayY0BdAkSr",
    type   => "ssh-rsa",
    user   => "${user}",
    require => File["/home/${user}/.ssh/id_rsa.pub"]
}

file{
  "/home/${user}/.ssh/config":
  owner => "${user}",
  group => "${group}",
  mode => 755,
  content => "StrictHostKeyChecking no",
  require => File["/home/${user}/.ssh/id_rsa.pub"]
}

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