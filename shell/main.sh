#!/bin/sh

# Based on https://github.com/purple52/librarian-puppet-vagrant/blob/master/shell/main.sh

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR=/etc/puppet/

# librarian-puppet will need git installed. If it is not already installed
# in your basebox, this will manually install it at this point using apt or yum.

echo 'Check git installation .....'
$(which git > /dev/null 2>&1)
FOUND_GIT=$?
if [ "$FOUND_GIT" -ne '0' ]; then
  echo 'Git not found. Attempting to install .....'
  $(which apt-get > /dev/null 2>&1)
  FOUND_APT=$?
  $(which yum > /dev/null 2>&1)
  FOUND_YUM=$?

  if [ "${FOUND_YUM}" -eq '0' ]; then
    yum -q -y makecache
    yum -q -y install git
    echo 'Git installed.'
  elif [ "${FOUND_APT}" -eq '0' ]; then
    apt-get -q -y update
    apt-get -q -y install git
    echo 'Git installed.'
  else
    echo 'No package installer available. You may need to install git manually.'
  fi
else
  echo 'Git found .....'
fi

# The Trusty basebox does not have ruby-dev package installd by default. Install
# the same.

echo 'Check ruby1.9.1-dev installed' 
$(dpkg --get-selections | grep ruby1.9.1-dev  > /dev/null   2>&1)
FOUND_RUBY_DEV=$?
if [ "$FOUND_RUBY_DEV" -ne '0' ]; then
  echo 'ruby1.9.1-dev not found. Attempting to install .....'
  $(which apt-get > /dev/null 2>&1)
  FOUND_APT=$?
  $(which yum > /dev/null 2>&1)
  FOUND_YUM=$?

  if [ "${FOUND_YUM}" -eq '0' ]; then
    yum -q -y makecache
    yum -q -y install ruby1.9.1-dev
    echo 'ruby1.9.1-dev installed.'
  elif [ "${FOUND_APT}" -eq '0' ]; then
    apt-get -q -y update
    apt-get -q -y install ruby1.9.1-dev
    echo 'ruby1.9.1-dev installed.'
  else
    echo 'No package installer available. You may need to install git manually.'
  fi
else
  echo 'ruby1.9.1-dev found .....'
fi

echo 'Creating puppet directory .....'
if [ ! -d "$PUPPET_DIR" ]; then
	mkdir -p $PUPPET_DIR
	echo 'Puppetuppet directory created.'
fi

cp /vagrant/puppet/Puppetfile $PUPPET_DIR
echo 'Puppetfile copied to puppet directory.'


echo 'Installing librarian-puppet .....'
if [ "$(gem list -i '^librarian-puppet$')" = "false" ]; then
  gem install librarian-puppet --verbose
  echo 'librarian-puppet installed.'
  cd $PUPPET_DIR && librarian-puppet install --clean --verbose
else
	cd $PUPPET_DIR && librarian-puppet update --verbose
fi
echo 'librarian-puppet installed.'

echo 'Shell provision completed.'
