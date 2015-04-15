class java {
  
  # update apt database and install openjdk 7
  exec { 'apt-get update':
      command => '/usr/bin/apt-get update',
    }

  package { "openjdk-7-jdk" :
      ensure => present,
    require => [ Exec['apt-get update'], File["/home/${user}"] ]
    } 

}

