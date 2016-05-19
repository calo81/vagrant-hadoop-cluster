vagrant-hadoop-cluster
======================

Motivation
----------

  * Hassel free setup of a 4 node VM hadoop cluster
  * to understand the workings of hadoop in an actual cluster environment
  * to provide a platform to quickly evaluate projects in the Hadoop ecosystem
  * and to be able to do this on a single machine

System Requirements
-------------------

At a minimum you need a system with good processing power and minimum 8 GB of RAM, 16 GB or more is recommended. If you have sufficient RAM, then it is recommended you increase the RAM alloted to each node machine in the Vagrantfile.  

Installation
------------

### Step 1. System Set-up

Go ahead and get the following tools installed on your system (Referred to as `HOST` throughout the document)

1. [Git](http://git-scm.com/downloads)
2. [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
3. [Vagrant](https://www.vagrantup.com/downloads.html)


### Step 2. Clone the GitHub repository

Follow these commands to clone the vagrant-hadoop-cluster repository on the `HOST`

	git clone https://github.com/hemenkapadia/vagrant-hadoop-cluster

### Step 3. Start the cluster

Follow these commands to provision the hadoop cluster

	cd vagrant-hadoop-cluster
	vagrant up

This will take some time to provision 4 nodes.

### Step 4. Format namenode and start services

	vagrant ssh master.local

Once you are in the VM guest master.local, enter the following commands

    sudo su - hadoop
    hdfs namenode -format
    start-dfs.sh
    start-yarn.sh

### Step 5. Validate below services are running

    hekapadi@HEKAPADI-W7-3 ~/Workspaces/Personal/vagrant-hadoop-cluster (master)
    $ vagrant ssh master.local
    Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.13.0-32-generic x86_64)

     * Documentation:  https://help.ubuntu.com/
    New release '14.04.2 LTS' available.
    Run 'do-release-upgrade' to upgrade to it.

    Last login: Tue Nov  3 14:22:50 2015 from 10.0.2.2
    vagrant@master:~$ sudo su - hadoop
    hadoop@master:~$ jps
    18951 ResourceManager
    15454 Jps
    14634 SecondaryNameNode
    14447 NameNode
    hadoop@master:~$ ssh hadoop1.local jps
    12671 DataNode
    12773 NodeManager
    13206 Jps
    hadoop@master:~$ ssh hadoop2.local jps
    12778 NodeManager
    13211 Jps
    12676 DataNode
    hadoop@master:~$ ssh hadoop3.local jps
    12670 DataNode
    12772 NodeManager
    13206 Jps

Web Consoles
------------
Once the services are up and running on the master as well as the slave, as noted in the test mentioed in the above, the followin web consoles are available for login

  * HDFS - [http://192.168.48.10:50070/dfshealth.html#tab-overview]
  * YARN - http://192.168.48.10:8088/cluster/cluster

System Details
--------------

Note - Items not hyperlinked are not yet installed, but are in the plan

1. [Ubuntu 14.04 64 bit](https://atlas.hashicorp.com/puppetlabs/boxes/ubuntu-14.04-64-puppet)
2. [OpenJDK 8](http://openjdk.java.net/install/index.html)
3. [Hadoop 2.7.2](http://hadoop.apache.org/docs/r2.7.2/)
4. CRAN R and  RStudio Server Community Edition
5. Spark
6. Crunch/Cascading/CDAP Cask
7. Hbase
8. Pig
9. Flume and Kafka
10. Storm / Flink
11. Oozie
