# Set path for exec
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

include vars
include base
include ssh
include java
include hadoop