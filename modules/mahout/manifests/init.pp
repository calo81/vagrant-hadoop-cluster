class mahout {
  $hadoop_home = "/opt/hadoop"

file {
  "${hadoop_home}-1.2.1/lib/mahout-examples-0.9-job.jar":
  source => "puppet:///modules/mahout/mahout-examples-0.9-job.jar",
  mode => 644,
  owner => root,
  group => root,
  require => Exec["unpack_hadoop"]
 }
}