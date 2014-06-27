class mahout {

file {
  "${hadoop_home}-1.2.1/lib/mahout-examples-0.9-job.jar":
  source => "puppet:///modules/mahout/mahout-examples-0.9-job.jar",
  mode => 644,
  owner => $user,
  group => $user,
  require => Exec["unpack_hadoop"]
 }
}