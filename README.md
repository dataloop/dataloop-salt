dataloop-salt
=============

This will deploy the latest stable Dataloop agent to Debian or Redhat based systems

Install Agent
=============
```
salt 'server-name' state.sls linux.dataloop
```
This will launch the init.sls file and go through the state file performing each step of the deployment.

Uninstall Agent
===============
TODO
