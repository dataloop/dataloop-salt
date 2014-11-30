dataloop-salt
=============

This will deploy the latest dataloop package to Ubuntu environments.

I don't have a specific Debian release to check for that as well in the {% if %} conditional, but if we add that as well, it should work as well for any environment that uses aptage.

For our installation, I have the following in our /etc/salt/master file:

```
file_roots:
base:
- /srv/salt
```

Quick breakdown:
```
/etc/dataloop/agent.conf:
file.managed:
- source: salt://linux/dataloop/agent.conf
```
**/etc/dataloop/agent.conf** -- the location where we want the file to be pushed to on the remote host.  
**- source: salt://linux/dataloop/agent.conf** --  causes salt-master to look for an agent.conf file at /srv/salt/linux/dataloop/agent.conf as defined by the file_roots in my /etc/salt/master file

Install Agent
=============
```
salt 'server-name' state.sls linux.dataloop
```
This will launch the init.sls file and go through the state file performing each step of the deployment.

Uninstall Agent
===============

```
salt 'server-name' state.sls linux.dataloop.uninstall
```
This will launch the uninstall.sls file, which executes the unsetup.sh script on the remote host.
