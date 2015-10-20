class hadoop {

  $hadoop_version = "2.6.1"
  $install_dir = "/opt"
  $hadoop_home = "${install_dir}/hadoop-${hadoop_version}"                        # /opt/hadoop-2.6.1
  $hadoop_conf = "${hadoop_home}/etc/hadoop/conf"                                 # /opt/hadoop-2.6.1/etc/hadoop/conf
  $hadoop_log  = "/var/log/hadoop"
  $hadoop_data = "/home/hadoop/data"
  $apache_mirror = "http://apache.cs.utah.edu/hadoop/common"
  
  # Hadoop binary download and unpacking
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
    command => "chown -R ${user}:${group} ${hadoop_home}",
    path => $path,
    require => Exec["unpack_hadoop"]    
  }
    
  # Ensure the log directory is available
  file { "${hadoop_log}":
    ensure => directory,
    mode => 774,
    group => $group,
    owner => $user,
    require => Exec["chown_hadoop"]
  }
    
  # Ensure the config directory is available at /opt/hadoop-2.6.1/etc/hadoop/conf
  file { "${hadoop_conf}":
    ensure => directory,
    mode => 744,
    group => $group,
    owner => $user,
    require => Exec["unpack_hadoop"]
  }

  file { "${hadoop_conf}/slaves":
    content => template('hadoop/slaves'),
    ensure => present,
    mode => 744,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }
    
  file { "${hadoop_conf}/hadoop-env.sh":
    content => template('hadoop/hadoop-env.sh'),
    ensure => present,
    mode => 744,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }

  file { "${hadoop_conf}/yarn-env.sh":
    content => template('hadoop/yarn-env.sh'),
    ensure => present,
    mode => 744,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }
    
  file { "${hadoop_conf}/mapred-env.sh":
      content => template('hadoop/mapred-env.sh'),
    ensure => present,
    mode => 744,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }
    
  file { "${hadoop_conf}/core-site.xml":
    content => template('hadoop/core-site.xml'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }
    
  file { "${hadoop_conf}/hdfs-site.xml":
    content => template('hadoop/hdfs-site.xml'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }

  file { "${hadoop_conf}/mapred-site.xml":
    content => template('hadoop/mapred-site.xml'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }

  file { "${hadoop_conf}/yarn-site.xml":
    content => template('hadoop/yarn-site.xml'),
    ensure => present,
    mode => 644,
    group => $group,
    owner => $user,
    require => File["${hadoop_conf}"]
  }



    
}
