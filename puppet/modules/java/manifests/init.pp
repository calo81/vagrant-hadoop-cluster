class java {

  # update apt database and install openjdk 7
  exec { 'apt-get update':
      command => 'apt-get update',
  }

  package { "openjdk-7-jdk" :
    ensure => present,
    require => [ Exec['apt-get update'], File["/home/${user}"] ]
  }

  file { "/etc/profile.d/java_envvars.sh":
    source => "puppet:///modules/java/java_envvars.sh",
    ensure => present,
    mode => 755,
    owner => "root",
    group => "root",
    require => Package["openjdk-7-jdk"]
  }

}

