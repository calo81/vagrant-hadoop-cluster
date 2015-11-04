# The java implementation to use.
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

export HADOOP_HOME=<%= scope['hadoop::hadoop_home'] %>
export HADOOP_CONF_DIR=<%= scope['hadoop::hadoop_conf'] %>
export HADOOP_LOG_DIR=<%= scope['hadoop::hadoop_log'] %>

## Extra Java CLASSPATH elements.  Automatically insert capacity-scheduler.
#for f in $HADOOP_HOME/contrib/capacity-scheduler/*.jar; do
#  if [ "$HADOOP_CLASSPATH" ]; then
#    export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$f
#  else
#    export HADOOP_CLASSPATH=$f
#  fi
#done
#
## The maximum amount of heap to use, in MB. Default is 1000.
export HADOOP_HEAPSIZE="512"
#export HADOOP_NAMENODE_INIT_HEAPSIZE="512"
#
## Extra Java runtime options.  Empty by default.
#export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true"
#
## Command specific options appended to HADOOP_OPTS when specified
#export HADOOP_NAMENODE_OPTS="-Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_NAMENODE_OPTS"
#export HADOOP_DATANODE_OPTS="-Dhadoop.security.logger=ERROR,RFAS $HADOOP_DATANODE_OPTS"
#
#export HADOOP_SECONDARYNAMENODE_OPTS="-Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_SECONDARYNAMENODE_OPTS"
#
#export HADOOP_NFS3_OPTS="$HADOOP_NFS3_OPTS"
#export HADOOP_PORTMAP_OPTS="-Xmx256m $HADOOP_PORTMAP_OPTS"
#
## The following applies to multiple commands (fs, dfs, fsck, distcp etc)
#export HADOOP_CLIENT_OPTS="-Xmx256m $HADOOP_CLIENT_OPTS"
##HADOOP_JAVA_PLATFORM_OPTS="-XX:-UsePerfData $HADOOP_JAVA_PLATFORM_OPTS"
#
## On secure datanodes, user to run the datanode as after dropping privileges.
## This **MUST** be uncommented to enable secure HDFS if using privileged ports
## to provide authentication of data transfer protocol.  This **MUST NOT** be
## defined if SASL is configured for authentication of data transfer protocol
## using non-privileged ports.
#export HADOOP_SECURE_DN_USER=${HADOOP_SECURE_DN_USER}
#
## Where log files are stored in the secure data environment.
#export HADOOP_SECURE_DN_LOG_DIR=${HADOOP_LOG_DIR}/${HADOOP_HDFS_USER}
#
####
## HDFS Mover specific parameters
####
## Specify the JVM options to be used when starting the HDFS Mover.
## These options will be appended to the options specified as HADOOP_OPTS
## and therefore may override any similar flags set in HADOOP_OPTS
##
## export HADOOP_MOVER_OPTS=""
#
####
## Advanced Users Only!
####
#
## The directory where pid files are stored. /tmp by default.
## NOTE: this should be set to a directory that can only be written to by 
##       the user that will run the hadoop daemons.  Otherwise there is the
##       potential for a symlink attack.
#export HADOOP_PID_DIR=${HADOOP_PID_DIR}
#export HADOOP_SECURE_DN_PID_DIR=${HADOOP_PID_DIR}
#
## A string representing this instance of hadoop. $USER by default.
#export HADOOP_IDENT_STRING=$USER