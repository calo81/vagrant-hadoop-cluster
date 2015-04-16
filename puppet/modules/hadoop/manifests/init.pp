class hadoop {
  
  $install_dir = "/opt"
  $hadoop_version = "2.6.0"
  $hadoop_home = "${install_dir}/hadoop-${hadoop_version}"
  $apache_mirror = "http://psg.mtu.edu/pub/apache/hadoop/common"
  
  
  exec { "download_hadoop":
    command => "wget -O /tmp/hadoop.tar.gz ${apache_mirror}/hadoop-${hadoop_version}/hadoop-${hadoop_version}.tar.gz",
    path => $path,
    unless => "ls ${install_dir} | grep hadoop-${hadoop_version}",
    require => Package["openjdk-7-jdk"]
  }

  exec { "unpack_hadoop" :
    command => "tar -zxf /tmp/hadoop.tar.gz -C ${install_dir}",
    path => $path,
    creates => "${hadoop_home}",
    require => Exec["download_hadoop"]
  }
    
  exec { "chown_hadoop":
    command => "chown -R hdpusr:hdpusr ${hadoop_home}",
    path => $path,
    require => Exec["unpack_hadoop"]    
  }
    
  file { "${hadoop_home}/conf":
    ensure => directory,
    mode => 755,
    group => $group,
    owner => $user,
    require => Exec["unpack_hadoop"]
  }
    
  file { "${hadoop_home}/conf/slaves":
    content => template('hadoop/slaves'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_home}/conf"]
  }

  file { "${hadoop_home}/conf/masters":
    content => template('hadoop/masters'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_home}/conf"]
  }

  file { "${hadoop_home}/conf/core-site.xml":
    content => template('hadoop/core-site.xml'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_home}/conf"]
  }

  file { "${hadoop_home}/conf/mapred-site.xml":
    content => template('hadoop/mapred-site.xml'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_home}/conf"]
  }

  file { "${hadoop_home}/conf/hdfs-site.xml":
    content => template('hadoop/hdfs-site.xml'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_home}/conf"]
  }

  file { "${hadoop_home}/conf/hadoop-env.sh":
    content => template('hadoop/hadoop-env.sh'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_home}/conf"]
  }
}
