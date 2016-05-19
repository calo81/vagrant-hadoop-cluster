class java {

  package { "software-properties-common" :
    ensure => present,
  }

  apt::ppa { 'ppa:openjdk-r/ppa': }

  # update apt database and install openjdk 8
  exec { 'apt-get update':
      command => 'apt-get update',
  }

  Package['software-properties-common'] -> Apt::Ppa['ppa:openjdk-r/ppa'] -> Exec['apt-get update']

  package { "openjdk-8-jdk" :
    ensure => present,
    require => [ Exec['apt-get update'], File["/home/${vars::user}"] ]
  }

  file { "/etc/profile.d/java_envvars.sh":
    source => "puppet:///modules/java/java_envvars.sh",
    ensure => present,
    mode => "755",
    owner => "root",
    group => "root",
    require => Package["openjdk-8-jdk"]
  }

}
