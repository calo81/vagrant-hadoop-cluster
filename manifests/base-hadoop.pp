include hadoop
group { "puppet":
  ensure => "present",
}
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
}

package { "openjdk-6-jdk" :
   ensure => present,
  require => Exec['apt-get update']
}

file { "/root/.ssh":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 750,
	require => Exec['apt-get update']
}

file {
  "/root/.ssh/id_rsa":
  source => "puppet:///modules/hadoop/id_rsa",
  ensure => present,
  mode => 600,
  owner => root,
  group => root,
  require => File['/root/.ssh']
 }
 
file {
  "/root/.ssh/id_rsa.pub":
  source => "puppet:///modules/hadoop/id_rsa.pub",
  ensure => present,
  mode => 644,
  owner => root,
  group => root,
  require => File['/root/.ssh']
 }

ssh_authorized_key { "ssh_key":
    ensure => "present",
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDkvEvvmbrAb+EMTPVdHSPdHcNxOxYZs/24p3ZjaEpKtivYIu/s8gUeC15VQb2T9v0mGLQEGgjiUKmeS7m4wumQTB4E7atnYze4LaXdLTmK2fHVckxbl4uide2rAOzEUAYI84fd+6JzldT8F+DsQ38214pnvaFHdXLvf3Xcz9ks3KlNVseqxBNRSiWXovE2MQttXHS8ZU6LGaJB7tyrtGrY+viEcbJBMASMjC2UYZtZP0C6b86z6BjUnQl/1xBdw3JGrG2OXrWriiHcf/ZXMnn1pTF0Hy/EFK44xC93BOrrf6szvRBo85ZwgDcmu6Y3yu+OYRe/scdKNznJy1WT+5e/",
    type   => "ssh-rsa",
    user   => "root",
    require => File['/root/.ssh/id_rsa.pub']
}