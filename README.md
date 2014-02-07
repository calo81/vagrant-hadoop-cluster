vagrant-hadoop-cluster
======================

Deploying hadoop in a virtualized cluster in simple steps

These are the files that support the blogpost http://cscarioni.blogspot.co.uk/2012/09/setting-up-hadoop-virtual-cluster-with.html

For using them.

Simply clone the repository, then

gem install vagrant 

vagrant box add base-hadoop http://files.vagrantup.com/lucid64.box


Maybe generate your own ssh-keygen pair of keys.. and replace them in the files id_rsa and id_rsa.pub in the modules/hadoop/files directory


vagrant up

then 

vagrant ssh master

cd /opt/hadoop-xxx/bin

./start-all
