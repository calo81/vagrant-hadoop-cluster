class hadoop {
 $hadoop_home = "/opt/hadoop"

exec { "download_hadoop":
command => "wget -O /tmp/hadoop.tar.gz http://apache.mirrors.timporter.net/hadoop/common/hadoop-1.0.3/hadoop-1.0.3.tar.gz",
path => $path,
unless => "ls /opt | grep hadoop-1.0.3",
require => Package["openjdk-6-jdk"]
}

exec { "unpack_hadoop" :
  command => "tar -zxf /tmp/hadoop.tar.gz -C /opt",
  path => $path,
  creates => "${hadoop_home}-1.0.3",
  require => Exec["download_hadoop"]
}
file {
  "${hadoop_home}-1.0.3/conf/slaves":
  source => "puppet:///modules/hadoop/slaves",
  mode => 644,
  owner => root,
  group => root,
  require => Exec["unpack_hadoop"]
 }
 
file {
  "${hadoop_home}-1.0.3/conf/masters":
  source => "puppet:///modules/hadoop/masters",
  mode => 644,
  owner => root,
  group => root,
  require => Exec["unpack_hadoop"]
 }

file {
  "${hadoop_home}-1.0.3/conf/core-site.xml":
  source => "puppet:///modules/hadoop/core-site.xml",
  mode => 644,
  owner => root,
  group => root,
  require => Exec["unpack_hadoop"]
 }
 
file {
  "${hadoop_home}-1.0.3/conf/mapred-site.xml":
  source => "puppet:///modules/hadoop/mapred-site.xml",
  mode => 644,
  owner => root,
  group => root,
  require => Exec["unpack_hadoop"]
 }
 
 file {
  "${hadoop_home}-1.0.3/conf/hdfs-site.xml":
  source => "puppet:///modules/hadoop/hdfs-site.xml",
  mode => 644,
  owner => root,
  group => root,
  require => Exec["unpack_hadoop"]
 }
 
  file {
  "${hadoop_home}-1.0.3/conf/hadoop-env.sh":
  source => "puppet:///modules/hadoop/hadoop-env.sh",
  mode => 644,
  owner => root,
  group => root,
  require => Exec["unpack_hadoop"]
 }
 
 exec { "format_namenode" :
  command => "sudo ${hadoop_home}-1.0.3/bin/hadoop namenode -format",
  path => $path,
  require => File["${hadoop_home}-1.0.3/conf/hdfs-site.xml"]
}

 exec { "start_daemons" :
  command => "sudo ${hadoop_home}-1.0.3/bin/start-all.sh",
  path => $path,
  require => Exec["format_namenode"]
}
}
