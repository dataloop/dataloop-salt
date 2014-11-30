dataloop-salt
=============

This will deploy the latest dataloop package to Ubuntu environments. 

I don't have a specific Debian release to check for that as well in the {% if %} conditional, but if we add that as well, it should work as well for any environment that uses aptage.

For our installation, I have the following in our /etc/salt/master file:

file_roots:
  base:
    - /srv/salt

In the - source: tag I have referenced in the file.*: sections, this is referencing path: /srv/salt/linux/dataloop/ for my particular configuration.

I run a push of the dataloop agent by doing: salt 'server-name' state.sls linux.dataloop
This will launch the init.sls file and go through the state file performing each step of the deployment.

If you want to uninstall, then run: salt 'server-name' state.sls linux.dataloop.uninstall
This will launch the uninstall.sls file, which executes the unsetup.sh script on the remote host




