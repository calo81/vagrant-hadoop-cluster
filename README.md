vagrant-hadoop-cluster
======================

Motivation
----------

__vagrant-hadoop-cluster__ can be used to quickly setup a virtual hadoop cluster on your laptop. 

The motivation behind this project is to 

  * understand the workings of hadoop in an actual cluster environment, but to be able to do so on a single machine. 
  * to be able to setup the cluster quickly in an automated fashion.
  * to provide a platform to quickly evaluate projects in the Hadoop ecosystem.

Hadoop Ecosystem Projects
-------------------------








Install

Hadoop Core (HDFS, YARN)
Ambari
Hive
Oozie/Airflow
Zookeeper
Pig
Flume
Kafka
R Studio Server (Open Source)
HBASE (optional)
CASK
Spark - interactive data analysis + Machine learning
Shiny
Prediction.io/OpenCPU/Openscoring.io/DeployR - more important (hosted Yhat, Sense.io)


Configuration Files
===================

Reference - http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.1.15/bk_cluster-planning-guide/content/typical-hadoop-cluster-hardware.html

slaves - done
hadoop-env.sh
yarn-env.sh
mapred-env.sh

core-site.xml
hdfs-stie.xml
yarn-site.xml
mapred-site.xml

httpfs-*.* - check if this is enabled by default 
kms-*.* - check if this is enabled by default






