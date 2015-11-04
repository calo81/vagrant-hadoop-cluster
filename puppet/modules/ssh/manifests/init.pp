class ssh {

  # create .ssh directory for hdpusr
  # and copy the public and private ssh keys for this user
  # in this directory
  
  require base

  file { "/home/${vars::user}/.ssh":
    ensure => "directory",
    owner  => "${vars::user}",
    group  => "${vars::group}",
    mode   => 750,
    require => File["/home/${vars::user}"] 
  }

  file { "/home/${vars::user}/.ssh/id_rsa":
    source => "puppet:///modules/ssh/id_rsa",
    ensure => present,
    mode => 600,
    owner  => "${vars::user}",
    group  => "${vars::group}",
    require => File["/home/${vars::user}/.ssh"]
  }

  file { "/home/${vars::user}/.ssh/id_rsa.pub":
    source => "puppet:///modules/ssh/id_rsa.pub",
    ensure => present,
    mode => 644,
    owner  => "${vars::user}",
    group  => "${vars::group}",
    require => File["/home/${vars::user}/.ssh"]
  }


  # add this key to the list of authorized keys in each node
  # this allows each node to communicate with each other
  # without a password. 

  ssh_authorized_key { "ssh_key":
    ensure => "present",
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAqrWiZxJuCIlSqemD/rdmanSXaEsqK8yF1NqBYnm5tavIu32UqO531pt1jua8wtDz+pNh1KtWPwUEWO4eKlmngTuZaTrOM/BOnChcT3y2VwG6UxB/+v7uscvT1HXTnXMpXt2YZzys11glYt7jPUOWynsV18lw7gbn8xPaKbB2yyJv1WdI4dipDeBuJj2oEdgE5T+GcFFEpB1ELt7DLTUDs/Lv/GmyttHNK7YxYpeuJpKQmXyAhAcrAFJVx7mqrz0a11jnTAnCrLIA6H8IF1yjXLMMUjQK3wuD5CjcKSvgm3YhgWB9yrIQfrDwtezVn/LLKIl/XuXa+FOsbx+otpqAYw==",
    type   => "ssh-rsa",
    user   => "${vars::user}",
    require => File["/home/${vars::user}/.ssh/id_rsa.pub"]
  }

  file{ "/home/${vars::user}/.ssh/config":
    owner => "${vars::user}",
    group => "${vars::group}",
    mode => 644,
    content => "StrictHostKeyChecking no",
    require => File["/home/${vars::user}/.ssh/id_rsa.pub"]
    }

  }