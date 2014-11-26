#!/bin/bash

# remove the package if it exists
yum uninstall -y  dataloop-agent
apt-get remove dataloop-agent

# kill the process and delete the user
pkill -9 -f dataloop
userdel -r dataloop

# delete any folder or file we may have created
rm -fr /opt/dataloop
rm -fr /etc/dataloop
rm /usr/local/bin/dataloop-lin-agent
rm /usr/bin/dataloop-agent
rm /etc/init/dataloop-agent.conf
rm /etc/init.d/dataloop-agent
rm /tmp/*dataloop*.lock
rm -fr /tmp/_MEI*
rm -fr /tmp/pip_*
